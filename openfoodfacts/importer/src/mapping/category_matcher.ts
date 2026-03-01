import { readFile } from "node:fs/promises";
import { resolveFromImporterRoot } from "../core/paths.js";

export interface ProductCategoryJson {
  main: string;
  sub?: string;
}

export interface CategoryMatchResult {
  category: ProductCategoryJson;
  metadata: {
    matchedRule?: string;
    matchedCategoryId?: string;
    matchedOverride?: string;
  };
  warnings: string[];
}

interface CategoryRuleFile {
  version: number;
  mainCategoryRules: Array<{ matchAny: string[]; main: string }>;
  subCategoryOverrides: Array<{ offTag?: string; offPath?: string; sub: string }>;
  synonyms: Array<{ value: string; synonyms: string[] }>;
  fallback: { main: string; sub: string | null };
}

interface CategoryDoc {
  id: string;
  main: string;
  sub: string;
  synonyms?: string[];
  hierarchyPath?: string[];
  sourceHints?: {
    openFoodFacts?: {
      tags?: string[];
      paths?: string[];
    };
  };
}

interface CategoriesPreview {
  categories: CategoryDoc[];
}

export interface CategoryMatcherContext {
  rules: CategoryRuleFile;
  preview: CategoriesPreview;
}

function normalizeSignal(value: string): string {
  return value
    .toLowerCase()
    .trim()
    .replace(/^([a-z]{2}):/i, "")
    .replace(/[|>\\]/g, "/")
    .replace(/\s+/g, " ")
    .replace(/\/+/, "/")
    .replace(/\/+$/g, "");
}

function tokenSet(signals: string[]): Set<string> {
  const set = new Set<string>();
  for (const signal of signals) {
    const normalized = normalizeSignal(signal);
    set.add(normalized);
    normalized.split(/[\/\s,_-]+/).filter(Boolean).forEach((token) => set.add(token));
  }
  return set;
}

function leaf(signal: string): string {
  const normalized = normalizeSignal(signal);
  const parts = normalized.split("/").filter(Boolean);
  return parts.length > 0 ? parts[parts.length - 1] : normalized;
}

export async function loadCategoryMatcherContext(
  rulesPathArg?: string,
  previewPathArg?: string
): Promise<CategoryMatcherContext> {
  const rulesPath = resolveFromImporterRoot(rulesPathArg ?? "docs/category_mapping_rules_v1.json");
  const previewPath = resolveFromImporterRoot(previewPathArg ?? "output/categories_preview.json");

  const rules = JSON.parse(await readFile(rulesPath, "utf8")) as CategoryRuleFile;
  const preview = JSON.parse(await readFile(previewPath, "utf8")) as CategoriesPreview;

  return { rules, preview };
}

export function matchCategory(
  rawSignals: string[],
  ctx: CategoryMatcherContext
): CategoryMatchResult {
  const warnings: string[] = [];
  const normalizedSignals = rawSignals.map(normalizeSignal).filter(Boolean);
  const tokens = tokenSet(normalizedSignals);

  let main = ctx.rules.fallback.main;
  let matchedRule: string | undefined;

  for (const rule of ctx.rules.mainCategoryRules) {
    const matched = rule.matchAny.find((value) => tokens.has(normalizeSignal(value)) || [...tokens].some((token) => token.includes(normalizeSignal(value))));
    if (matched) {
      main = rule.main;
      matchedRule = `${rule.main}:${matched}`;
      break;
    }
  }

  for (const override of ctx.rules.subCategoryOverrides) {
    if (override.offTag && normalizedSignals.includes(normalizeSignal(override.offTag))) {
      return {
        category: { main, sub: override.sub },
        metadata: { matchedRule, matchedOverride: `offTag:${override.offTag}` },
        warnings
      };
    }
    if (override.offPath && normalizedSignals.includes(normalizeSignal(override.offPath))) {
      return {
        category: { main, sub: override.sub },
        metadata: { matchedRule, matchedOverride: `offPath:${override.offPath}` },
        warnings
      };
    }
  }

  const synonymMap = new Map<string, string>();
  for (const group of ctx.rules.synonyms) {
    synonymMap.set(normalizeSignal(group.value), group.value);
    group.synonyms.forEach((s) => synonymMap.set(normalizeSignal(s), group.value));
  }

  const categoryLookup = ctx.preview.categories
    .filter((category) => category.main === main)
    .map((category) => {
      const keys = new Set<string>();
      keys.add(normalizeSignal(category.sub));
      (category.synonyms ?? []).forEach((s) => keys.add(normalizeSignal(s)));
      (category.sourceHints?.openFoodFacts?.tags ?? []).forEach((s) => keys.add(normalizeSignal(s)));
      (category.sourceHints?.openFoodFacts?.paths ?? []).forEach((s) => keys.add(normalizeSignal(leaf(s))));
      (category.hierarchyPath ?? []).forEach((s) => keys.add(normalizeSignal(s)));
      return { category, keys };
    });

  for (const signal of normalizedSignals) {
    const mappedSignal = synonymMap.get(signal) ?? signal;
    const candidateLeaf = normalizeSignal(leaf(mappedSignal));

    const match = categoryLookup.find((row) => row.keys.has(mappedSignal) || row.keys.has(candidateLeaf));
    if (match) {
      return {
        category: { main, sub: match.category.sub },
        metadata: { matchedRule, matchedCategoryId: match.category.id },
        warnings
      };
    }
  }

  warnings.push("category_unmapped");

  return {
    category: ctx.rules.fallback.sub ? { main, sub: ctx.rules.fallback.sub } : { main },
    metadata: { matchedRule },
    warnings
  };
}
