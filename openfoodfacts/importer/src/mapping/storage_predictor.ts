import { readFile } from "node:fs/promises";
import { resolveFromImporterRoot } from "../core/paths.js";
import type { ProductJson } from "./off_to_product.js";

export type StorageType = "fridge" | "freezer" | "shelf" | "pantry" | "room_temp";
export type StorageConfidence = "high" | "medium" | "low";

interface CategoryRule {
  matchSubContains?: string[];
  matchSubAny?: string[];
  storageType: StorageType;
  confidence: StorageConfidence;
  reason: string;
}

interface TextRuleBand {
  high?: string[];
  medium?: string[];
}

export interface StorageRules {
  version: number;
  storageTypes: StorageType[];
  confidenceLevels: StorageConfidence[];
  categoryRules: CategoryRule[];
  textRules: Partial<Record<StorageType, TextRuleBand>>;
  fallback?: {
    confidence?: StorageConfidence;
    reason?: string;
  };
  limits?: {
    reasonMaxLength?: number;
  };
}

export interface StoragePredictionResult {
  storageType?: StorageType;
  confidence?: StorageConfidence;
  reason?: string;
}

export interface StoragePredictionInput {
  product: ProductJson;
  off?: unknown;
  normalizedText?: string;
}

function normalizeText(value: string): string {
  return value
    .toLowerCase()
    .replace(/[_-]+/g, " ")
    .replace(/[^\p{L}\p{N}\s.]/gu, " ")
    .replace(/\s+/g, " ")
    .trim();
}

function truncReason(value: string, maxLength = 120): string {
  return value.length > maxLength ? value.slice(0, maxLength) : value;
}

function anyPhraseMatch(haystack: string, phrases: string[]): string | undefined {
  for (const phrase of phrases) {
    const normalized = normalizeText(phrase);
    if (normalized.length > 0 && haystack.includes(normalized)) {
      return phrase;
    }
  }
  return undefined;
}

function textCorpus(input: StoragePredictionInput): string {
  const parts: string[] = [];
  if (input.product.storageInstructions) parts.push(input.product.storageInstructions);
  if (input.product.title) parts.push(input.product.title);
  if (input.product.brand) parts.push(input.product.brand);
  if (input.product.category?.main) parts.push(input.product.category.main);
  if (input.product.category?.sub) parts.push(input.product.category.sub);
  if (input.normalizedText) parts.push(input.normalizedText);

  if (input.off && typeof input.off === "object" && !Array.isArray(input.off)) {
    const row = input.off as Record<string, unknown>;
    for (const key of ["categories", "categories_hierarchy", "categories_tags", "storage", "conservation"]) {
      const value = row[key];
      if (typeof value === "string") {
        parts.push(value);
      } else if (Array.isArray(value)) {
        value.filter((x): x is string => typeof x === "string").forEach((x) => parts.push(x));
      }
    }
  }

  return normalizeText(parts.join(" "));
}

function matchTextRules(
  corpus: string,
  rules: StorageRules,
  level: "high" | "medium"
): StoragePredictionResult {
  for (const storageType of rules.storageTypes) {
    const phrases = rules.textRules?.[storageType]?.[level] ?? [];
    const matched = anyPhraseMatch(corpus, phrases);
    if (matched) {
      return {
        storageType,
        confidence: level,
        reason: `text ${level} match: ${matched}`
      };
    }
  }
  return {};
}

function matchCategoryRules(product: ProductJson, rules: StorageRules): StoragePredictionResult {
  const sub = normalizeText(product.category?.sub ?? "");
  if (!sub) return {};

  for (const rule of rules.categoryRules ?? []) {
    const subContains = (rule.matchSubContains ?? []).some((token) =>
      sub.includes(normalizeText(token))
    );
    const subAny = (rule.matchSubAny ?? []).some(
      (token) => sub === normalizeText(token) || sub.includes(normalizeText(token))
    );
    if (subContains || subAny) {
      return {
        storageType: rule.storageType,
        confidence: rule.confidence,
        reason: rule.reason
      };
    }
  }
  return {};
}

export function predictStorageType(
  input: StoragePredictionInput,
  rules: StorageRules
): StoragePredictionResult {
  const maxReason = rules.limits?.reasonMaxLength ?? 120;
  const corpus = textCorpus(input);

  const highText = matchTextRules(corpus, rules, "high");
  if (highText.storageType) {
    return {
      ...highText,
      reason: highText.reason ? truncReason(highText.reason, maxReason) : undefined
    };
  }

  const categoryMatch = matchCategoryRules(input.product, rules);
  if (categoryMatch.storageType) {
    return {
      ...categoryMatch,
      reason: categoryMatch.reason ? truncReason(categoryMatch.reason, maxReason) : undefined
    };
  }

  const mediumText = matchTextRules(corpus, rules, "medium");
  if (mediumText.storageType) {
    return {
      ...mediumText,
      reason: mediumText.reason ? truncReason(mediumText.reason, maxReason) : undefined
    };
  }

  return {};
}

export async function loadStoragePredictionRules(
  pathArg?: string
): Promise<StorageRules> {
  const rulesPath = resolveFromImporterRoot(pathArg ?? "docs/storage_prediction_rules_v1.json");
  const raw = await readFile(rulesPath, "utf8");
  return JSON.parse(raw) as StorageRules;
}

