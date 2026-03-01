import { readFile, writeFile } from "node:fs/promises";
import { loadCategoryMatcherContext } from "../../mapping/category_matcher.js";
import { deriveOffFieldPaths } from "../../mapping/off_paths.js";
import { loadStoragePredictionRules } from "../../mapping/storage_predictor.js";
import {
  transformOffToProduct,
  type ProductJson,
  type TransformErrorCode,
  type TransformWarning
} from "../../mapping/off_to_product.js";
import { logger } from "../../core/logger.js";
import { ensureOutputDir, resolveFromImporterRoot } from "../../core/paths.js";
import { nowISO } from "../../utils/time.js";

export interface TransformSampleArgs {
  in?: string;
  out?: string;
  schema?: string;
  contract?: string;
  mappingRules?: string;
  categoriesPreview?: string;
}

interface InvalidProductEntry {
  index: number;
  productId?: string;
  reasons: TransformErrorCode[];
  offSnippet?: Record<string, unknown>;
}

function snippet(off: unknown): Record<string, unknown> {
  if (!off || typeof off !== "object" || Array.isArray(off)) return {};
  const row = off as Record<string, unknown>;
  const keys = ["code", "product_name", "brands", "categories", "categories_tags"];
  const out: Record<string, unknown> = {};
  for (const key of keys) {
    if (row[key] !== undefined) out[key] = row[key];
  }
  return out;
}

function warningCodeCounts(warnings: TransformWarning[]): Record<string, number> {
  return warnings.reduce<Record<string, number>>((acc, warning) => {
    acc[warning.code] = (acc[warning.code] ?? 0) + 1;
    return acc;
  }, {});
}

export async function runTransformSampleCommand(args: TransformSampleArgs): Promise<void> {
  await ensureOutputDir();

  const inPath = resolveFromImporterRoot(args.in ?? "output/off_sample_100.json");
  const outPath = resolveFromImporterRoot(args.out ?? "output/product_sample_100.json");
  const schemaPath = resolveFromImporterRoot(args.schema ?? "output/off_schema_summary.json");
  const mappingRulesPath = resolveFromImporterRoot(args.mappingRules ?? "docs/category_mapping_rules_v1.json");
  const categoriesPreviewPath = resolveFromImporterRoot(args.categoriesPreview ?? "output/categories_preview.json");

  const offSample = JSON.parse(await readFile(inPath, "utf8")) as unknown[];
  if (!Array.isArray(offSample)) {
    throw new Error(`Expected array for OFF sample: ${inPath}`);
  }

  const paths = await deriveOffFieldPaths(schemaPath);
  const categoryMatcher = await loadCategoryMatcherContext(mappingRulesPath, categoriesPreviewPath);
  const storageRules = await loadStoragePredictionRules();
  const runNow = nowISO();

  const products: ProductJson[] = [];
  const allWarnings: Array<{ index: number; productId?: string; warning: TransformWarning }> = [];
  const invalidProducts: InvalidProductEntry[] = [];

  let drafts = 0;
  let actives = 0;

  for (let index = 0; index < offSample.length; index += 1) {
    const row = offSample[index];
    const result = transformOffToProduct(row, {
      paths,
      categoryMatcher,
      storageRules,
      nowISO: runNow,
      importerVersion: "off-importer-v1"
    });

    if (result.product) {
      products.push(result.product);
      if (result.product.status === "active") actives += 1;
      if (result.product.status === "draft") drafts += 1;
    }

    result.warnings.forEach((warning) => {
      allWarnings.push({ index, productId: result.product?.productId, warning });
    });

    if (result.errors.length > 0) {
      invalidProducts.push({
        index,
        productId: result.product?.productId,
        reasons: result.errors,
        offSnippet: snippet(row)
      });
    }
  }

  const warningCounts = warningCodeCounts(allWarnings.map((item) => item.warning));
  const storageTypeCounts: Record<string, number> = {};
  const storageConfidenceCounts: Record<string, number> = {};

  const missingFieldCounts: Record<string, number> = {};
  products.forEach((product) => {
    if (!product.title) missingFieldCounts.title = (missingFieldCounts.title ?? 0) + 1;
    if (!product.brand) missingFieldCounts.brand = (missingFieldCounts.brand ?? 0) + 1;
    if (!product.category?.sub) missingFieldCounts.categorySub = (missingFieldCounts.categorySub ?? 0) + 1;
    if (!product.barcode?.value) missingFieldCounts.barcode = (missingFieldCounts.barcode ?? 0) + 1;
    const storageType = product.attributes.storageType;
    if (storageType) {
      storageTypeCounts[storageType] = (storageTypeCounts[storageType] ?? 0) + 1;
    }
    const storageConfidence = product.attributes.storageTypeConfidence;
    if (storageConfidence) {
      storageConfidenceCounts[storageConfidence] = (storageConfidenceCounts[storageConfidence] ?? 0) + 1;
    }
  });

  const stats = {
    generatedAt: runNow,
    totalOffRecords: offSample.length,
    transformedProducts: products.length,
    rejectedProducts: invalidProducts.length,
    drafts,
    actives,
    warningCounts,
    storageTypeCounts,
    storageConfidenceCounts,
    storageUnpredictedCount: products.length - Object.values(storageTypeCounts).reduce((a, b) => a + b, 0),
    mostCommonMissingFields: Object.entries(missingFieldCounts)
      .sort((a, b) => b[1] - a[1] || a[0].localeCompare(b[0]))
      .slice(0, 20)
      .map(([field, count]) => ({ field, count }))
  };

  const warningMdLines: string[] = [];
  warningMdLines.push("# Mapping Warnings");
  warningMdLines.push("");
  warningMdLines.push("## Storage prediction");
  warningMdLines.push("");
  warningMdLines.push(`- Predicted: ${Object.values(storageTypeCounts).reduce((a, b) => a + b, 0)} / ${products.length}`);
  warningMdLines.push(`- Unpredicted: ${products.length - Object.values(storageTypeCounts).reduce((a, b) => a + b, 0)}`);
  warningMdLines.push("");
  warningMdLines.push("| Storage Type | Count |");
  warningMdLines.push("|---|---:|");
  Object.entries(storageTypeCounts)
    .sort((a, b) => b[1] - a[1] || a[0].localeCompare(b[0]))
    .forEach(([storageType, count]) => warningMdLines.push(`| ${storageType} | ${count} |`));
  if (Object.keys(storageTypeCounts).length === 0) {
    warningMdLines.push("| (none) | 0 |");
  }
  warningMdLines.push("");
  warningMdLines.push(`- Generated at: ${runNow}`);
  warningMdLines.push(`- Total warnings: ${allWarnings.length}`);
  warningMdLines.push("");
  warningMdLines.push("## Warning counts");
  warningMdLines.push("");
  warningMdLines.push("| Code | Count |");
  warningMdLines.push("|---|---:|");
  Object.entries(warningCounts)
    .sort((a, b) => b[1] - a[1] || a[0].localeCompare(b[0]))
    .forEach(([code, count]) => warningMdLines.push(`| ${code} | ${count} |`));
  if (Object.keys(warningCounts).length === 0) {
    warningMdLines.push("| (none) | 0 |");
  }
  warningMdLines.push("");

  warningMdLines.push("## Example warnings");
  warningMdLines.push("");
  warningMdLines.push("| Index | Product ID | Code | Message |");
  warningMdLines.push("|---:|---|---|---|");
  allWarnings.slice(0, 200).forEach((entry) => {
    warningMdLines.push(`| ${entry.index} | ${entry.productId ?? "-"} | ${entry.warning.code} | ${entry.warning.message} |`);
  });
  if (allWarnings.length === 0) {
    warningMdLines.push("| - | - | - | - |");
  }
  warningMdLines.push("");

  await writeFile(outPath, `${JSON.stringify(products, null, 2)}\n`, "utf8");
  await writeFile(resolveFromImporterRoot("output/mapping_warnings.md"), `${warningMdLines.join("\n")}\n`, "utf8");
  await writeFile(resolveFromImporterRoot("output/invalid_products.json"), `${JSON.stringify(invalidProducts, null, 2)}\n`, "utf8");
  await writeFile(resolveFromImporterRoot("output/product_transform_stats.json"), `${JSON.stringify(stats, null, 2)}\n`, "utf8");

  logger.info(
    {
      inPath,
      outPath,
      totalOffRecords: offSample.length,
      transformedProducts: products.length,
      rejectedProducts: invalidProducts.length,
      warnings: allWarnings.length
    },
    "OFF sample transformed to canonical product JSON"
  );
}
