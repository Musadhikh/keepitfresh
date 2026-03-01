import { createHash } from "node:crypto";
import {
  extractNutrition,
  getFirstNumber,
  getFirstString,
  getStringArray,
  normalizeString,
  parseAllergens,
  parseBarcodeSymbology,
  parseIngredients,
  parseQuantityToPackaging
} from "./off_extractors.js";
import type { OffFieldPaths } from "./off_paths.js";
import {
  matchCategory,
  type CategoryMatcherContext,
  type ProductCategoryJson
} from "./category_matcher.js";
import {
  predictStorageType,
  type StorageRules
} from "./storage_predictor.js";

export interface TransformWarning {
  code: string;
  message: string;
}

export type TransformErrorCode =
  | "missing_identity"
  | "invalid_barcode"
  | "missing_title_and_brand"
  | "invalid_enum_value"
  | "invalid_nutrition"
  | "invalid_payload_shape";

export interface ProductJson {
  productId: string;
  barcode?: {
    value: string;
    symbology: "ean13" | "ean8" | "upc_a" | "unknown";
  };
  title?: string;
  brand?: string;
  shortDescription?: string;
  storageInstructions?: string;
  category?: ProductCategoryJson;
  productDetails?: {
    kind: "food" | "beverage" | "household" | "personalCare" | "other";
    value: Record<string, unknown> | null;
  };
  packaging?: {
    quantity?: number;
    unit: "g" | "kg" | "ml" | "l" | "oz" | "lb" | "count" | "unknown";
    count?: number;
    displayText?: string;
  };
  size?: string;
  images: Array<{
    id: string;
    urlString?: string;
    localAssetId?: string;
    kind: "front" | "back" | "label" | "nutrition" | "ingredients" | "other";
    width?: number;
    height?: number;
  }>;
  attributes: Record<string, string>;
  extractionMetadata?: {
    extractedAt: string;
    extractorVersion: string;
    fieldConfidence: Record<string, number>;
    rawSnippets: string[];
  };
  qualitySignals: {
    completenessScore?: number;
    needsManualReview: boolean;
    hasFrontImage: boolean;
    hasIngredientImage: boolean;
    hasNutritionImage: boolean;
  };
  compliance?: {
    marketCountries: string[];
    restrictedFlags: string[];
    certifications: string[];
  };
  source: "importedFeed";
  status: "active" | "draft" | "archived" | "blocked";
  createdAt: string;
  updatedAt: string;
  version: number;
}

export interface TransformContext {
  paths: OffFieldPaths;
  categoryMatcher: CategoryMatcherContext;
  storageRules: StorageRules;
  nowISO: string;
  importerVersion: string;
}

function clampAttribute(value: string, maxLength = 300): string {
  return value.length > maxLength ? `${value.slice(0, maxLength)}...` : value;
}

function normalizeBarcode(value?: string): string | undefined {
  if (!value) return undefined;
  const normalized = value.trim().toUpperCase().replace(/[^A-Z0-9]/g, "");
  return normalized.length > 0 ? normalized : undefined;
}

function stableHashString(input: string): string {
  return createHash("sha256").update(input).digest("hex");
}

function parseUpdatedAt(off: unknown, paths: OffFieldPaths, fallbackNowISO: string): string {
  const timestampNumber = getFirstNumber(off, paths.updatedTimestamp);
  if (timestampNumber !== undefined) {
    const millis = timestampNumber < 10_000_000_000 ? timestampNumber * 1000 : timestampNumber;
    const date = new Date(millis);
    if (!Number.isNaN(date.valueOf())) {
      const iso = date.toISOString();
      return iso > fallbackNowISO ? iso : fallbackNowISO;
    }
  }

  const timestampString = getFirstString(off, paths.updatedTimestamp);
  if (timestampString) {
    const parsed = new Date(timestampString);
    if (!Number.isNaN(parsed.valueOf())) {
      const iso = parsed.toISOString();
      return iso > fallbackNowISO ? iso : fallbackNowISO;
    }
  }

  return fallbackNowISO;
}

function buildImages(off: unknown, paths: OffFieldPaths): ProductJson["images"] {
  const urlsByKind: Array<{ kind: ProductJson["images"][number]["kind"]; values: string[] }> = [
    { kind: "front", values: getStringArray(off, paths.imageFront) ?? [] },
    { kind: "ingredients", values: getStringArray(off, paths.imageIngredients) ?? [] },
    { kind: "nutrition", values: getStringArray(off, paths.imageNutrition) ?? [] },
    { kind: "other", values: getStringArray(off, paths.images) ?? [] }
  ];

  const seen = new Set<string>();
  const images: ProductJson["images"] = [];

  for (const group of urlsByKind) {
    for (const value of group.values) {
      const url = normalizeString(value);
      if (!url || seen.has(url)) continue;
      seen.add(url);
      images.push({
        id: `${group.kind}_${images.length + 1}`,
        urlString: clampAttribute(url, 512),
        kind: group.kind
      });
    }
  }

  return images;
}

function computeCompleteness(product: ProductJson): number {
  let score = 0;
  if (product.barcode?.value) score += 0.2;
  if (product.title) score += 0.2;
  if (product.brand) score += 0.1;
  if (product.category?.main) score += 0.2;
  if (product.productDetails?.kind === "food" || product.productDetails?.kind === "beverage") score += 0.1;
  if (product.images.length > 0) score += 0.2;
  return Math.min(1, Number(score.toFixed(3)));
}

function pickCategorySignals(off: unknown, paths: OffFieldPaths): string[] {
  const tags = getStringArray(off, paths.categoryTags) ?? [];
  const hierarchy = getStringArray(off, paths.categoryHierarchy) ?? [];
  return [...new Set([...tags, ...hierarchy])];
}

function safeKind(main?: string): NonNullable<ProductJson["productDetails"]>["kind"] {
  if (main === "food") return "food";
  if (main === "beverage") return "beverage";
  if (main === "household") return "household";
  if (main === "personalCare") return "personalCare";
  return "other";
}

export function transformOffToProduct(
  off: unknown,
  ctx: TransformContext
): { product?: ProductJson; warnings: TransformWarning[]; errors: TransformErrorCode[] } {
  const warnings: TransformWarning[] = [];
  const errors: TransformErrorCode[] = [];

  const rawCode = getFirstString(off, ctx.paths.code.length > 0 ? ctx.paths.code : ctx.paths.barcode);
  const barcodeValue = normalizeBarcode(rawCode ?? getFirstString(off, ctx.paths.barcode));

  const title = getFirstString(off, ctx.paths.title);
  const brand = getFirstString(off, ctx.paths.brands);

  let productId: string | undefined;
  if (barcodeValue) {
    productId = barcodeValue;
  } else {
    const identitySeed = [rawCode, title, brand].filter(Boolean).join("|");
    if (identitySeed) {
      productId = `off:${stableHashString(identitySeed).slice(0, 24)}`;
      warnings.push({ code: "identity_fallback_hash", message: "productId generated from fallback hash" });
    }
  }

  if (!productId) {
    errors.push("missing_identity");
    return { warnings, errors };
  }

  if (rawCode && !barcodeValue) {
    errors.push("invalid_barcode");
  }

  const shortDescription = getFirstString(off, ctx.paths.description);
  const storageInstructions = getFirstString(off, ctx.paths.storageInstructions);

  const categorySignals = pickCategorySignals(off, ctx.paths);
  const categoryMatch = matchCategory(categorySignals, ctx.categoryMatcher);
  categoryMatch.warnings.forEach((code) => warnings.push({ code, message: code }));

  const ingredientsText = getFirstString(off, ctx.paths.ingredientsText);
  const ingredients = parseIngredients(ingredientsText);

  const allergenText = getFirstString(off, ctx.paths.allergens);
  const allergens = parseAllergens(allergenText ?? getStringArray(off, ctx.paths.allergens));

  const servingSize = getFirstString(off, ctx.paths.servingSize);
  const nutrition = extractNutrition(off, ctx.paths);
  if (!nutrition && categoryMatch.category.main === "food") {
    warnings.push({ code: "nutrition_missing", message: "No deterministic nutrition data extracted" });
  }

  const quantityText = getFirstString(off, ctx.paths.quantity) ?? servingSize;
  const packaging = parseQuantityToPackaging(quantityText);

  const images = buildImages(off, ctx.paths);
  const hasFrontImage = images.some((img) => img.kind === "front");
  const hasIngredientImage = images.some((img) => img.kind === "ingredients");
  const hasNutritionImage = images.some((img) => img.kind === "nutrition");

  const attributes: Record<string, string> = {
    importSource: "open_food_facts",
    importerVersion: ctx.importerVersion,
    importedAt: ctx.nowISO
  };

  if (rawCode) attributes.off_code = clampAttribute(rawCode);
  const offUrl = getFirstString(off, ctx.paths.url);
  if (offUrl) attributes.off_url = clampAttribute(offUrl, 512);

  if (categorySignals.length > 0) {
    attributes.off_categorySignal = clampAttribute(categorySignals[0]);
  }

  const rawSnippetParts = [title, brand, ...categorySignals.slice(0, 2)]
    .filter((value): value is string => Boolean(value))
    .map((value) => clampAttribute(value, 100));

  const productDetailsKind = safeKind(categoryMatch.category.main);
  let productDetails: ProductJson["productDetails"] | undefined;

  if (productDetailsKind === "food" || productDetailsKind === "beverage") {
    productDetails = {
      kind: productDetailsKind,
      value: {
        ingredients,
        allergens,
        servingSize,
        nutritionPer100gOrMl: nutrition,
        quantityText: quantityText ?? undefined,
        numberOfItemsText: packaging?.count ? String(packaging.count) : undefined
      }
    };
  } else {
    productDetails = {
      kind: productDetailsKind,
      value: { keyValue: {}, inferredCategory: categoryMatch.category.main }
    };
  }

  const createdAt = ctx.nowISO;
  const updatedAt = parseUpdatedAt(off, ctx.paths, ctx.nowISO);

  const product: ProductJson = {
    productId,
    barcode: barcodeValue
      ? {
          value: barcodeValue,
          symbology: parseBarcodeSymbology(barcodeValue)
        }
      : undefined,
    title,
    brand,
    shortDescription,
    storageInstructions,
    category: categoryMatch.category,
    productDetails,
    packaging: packaging
      ? {
          quantity: packaging.quantity,
          unit: packaging.unit ?? "unknown",
          count: packaging.count,
          displayText: packaging.displayText
        }
      : undefined,
    size: quantityText,
    images,
    attributes,
    extractionMetadata: {
      extractedAt: ctx.nowISO,
      extractorVersion: ctx.importerVersion,
      fieldConfidence: {},
      rawSnippets: rawSnippetParts
    },
    qualitySignals: {
      completenessScore: 0,
      needsManualReview: false,
      hasFrontImage,
      hasIngredientImage,
      hasNutritionImage
    },
    compliance: {
      marketCountries: getStringArray(off, ctx.paths.countries) ?? [],
      restrictedFlags: [],
      certifications: getStringArray(off, [...ctx.paths.certifications, ...ctx.paths.labels]) ?? []
    },
    source: "importedFeed",
    status: "draft",
    createdAt,
    updatedAt,
    version: 1
  };

  if (!product.attributes.storageType) {
    const prediction = predictStorageType(
      {
        product,
        off,
        normalizedText: categorySignals.join(" ")
      },
      ctx.storageRules
    );

    if (prediction.storageType) {
      product.attributes.storageType = prediction.storageType;
      if (prediction.confidence) {
        product.attributes.storageTypeConfidence = prediction.confidence;
      }
      if (prediction.reason) {
        product.attributes.storageTypeReason = clampAttribute(prediction.reason, 120);
      }
    } else {
      warnings.push({
        code: "storage_type_unpredicted",
        message: "No deterministic storage type prediction"
      });
    }
  }

  product.qualitySignals.completenessScore = computeCompleteness(product);

  const hasIdentity = Boolean(product.productId);
  const hasTitleOrBrand = Boolean(product.title || product.brand);
  const hasCategoryMain = Boolean(product.category?.main);

  if (hasIdentity && hasTitleOrBrand && hasCategoryMain) {
    product.status = "active";
  } else {
    product.status = "draft";
    product.qualitySignals.needsManualReview = true;
    warnings.push({ code: "manual_review_required", message: "Draft due to incomplete minimum fields" });
  }

  if (!title && !brand) {
    warnings.push({ code: "missing_title_and_brand", message: "Both title and brand are missing" });
    if (!rawCode) {
      errors.push("missing_title_and_brand");
    }
  }

  if (errors.length > 0) {
    return { warnings, errors };
  }

  return { product, warnings, errors };
}
