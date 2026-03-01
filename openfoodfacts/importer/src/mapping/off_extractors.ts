import type { OffFieldPaths } from "./off_paths.js";

export interface PackagingResult {
  quantity?: number;
  unit?: "g" | "kg" | "ml" | "l" | "oz" | "lb" | "count" | "unknown";
  count?: number;
  displayText?: string;
}

export interface NutritionFacts {
  energyKcal?: number;
  proteinG?: number;
  fatG?: number;
  saturatedFatG?: number;
  carbsG?: number;
  sugarsG?: number;
  sodiumMg?: number;
}

const PACKAGING_UNIT_MAP: Array<{ regex: RegExp; unit: PackagingResult["unit"] }> = [
  { regex: /\bkg\b/i, unit: "kg" },
  { regex: /\bg\b/i, unit: "g" },
  { regex: /\bml\b/i, unit: "ml" },
  { regex: /\bl\b/i, unit: "l" },
  { regex: /\boz\b/i, unit: "oz" },
  { regex: /\blb\b/i, unit: "lb" },
  { regex: /\bpcs?\b|\bpieces?\b|\bcount\b|\bpack\b/i, unit: "count" }
];

function valuesAtPath(root: unknown, path: string): unknown[] {
  const segments = path.split(".");

  function walk(current: unknown, index: number): unknown[] {
    if (index >= segments.length) return [current];

    const segment = segments[index];
    const isArray = segment.endsWith("[]");
    const key = isArray ? segment.slice(0, -2) : segment;

    if (Array.isArray(current)) {
      return current.flatMap((item) => walk(item, index));
    }

    if (!current || typeof current !== "object") return [];

    const next = (current as Record<string, unknown>)[key];
    if (next === undefined) return [];

    if (isArray) {
      if (!Array.isArray(next)) return [];
      return next.flatMap((item) => walk(item, index + 1));
    }

    return walk(next, index + 1);
  }

  return walk(root, 0);
}

export function getAtPath(off: unknown, path: string): unknown {
  const values = valuesAtPath(off, path);
  return values.length > 0 ? values[0] : undefined;
}

export function normalizeString(input: string): string {
  return input.trim().replace(/\s+/g, " ");
}

export function getFirstString(off: unknown, paths: string[]): string | undefined {
  for (const path of paths) {
    const values = valuesAtPath(off, path);
    for (const value of values) {
      if (typeof value === "string") {
        const normalized = normalizeString(value);
        if (normalized) return normalized;
      }
    }
  }
  return undefined;
}

export function getFirstNumber(off: unknown, paths: string[]): number | undefined {
  for (const path of paths) {
    const values = valuesAtPath(off, path);
    for (const value of values) {
      if (typeof value === "number" && Number.isFinite(value)) return value;
      if (typeof value === "string") {
        const parsed = Number.parseFloat(value);
        if (Number.isFinite(parsed)) return parsed;
      }
    }
  }
  return undefined;
}

function flattenStrings(value: unknown): string[] {
  if (typeof value === "string") return [normalizeString(value)].filter(Boolean);
  if (Array.isArray(value)) return value.flatMap(flattenStrings);
  return [];
}

export function getStringArray(off: unknown, paths: string[]): string[] | undefined {
  const result: string[] = [];
  for (const path of paths) {
    const values = valuesAtPath(off, path);
    for (const value of values) {
      for (const str of flattenStrings(value)) {
        if (!result.includes(str)) result.push(str);
      }
    }
  }
  return result.length > 0 ? result : undefined;
}

export function getNestedObject(off: unknown, paths: string[]): Record<string, unknown> | undefined {
  for (const path of paths) {
    const values = valuesAtPath(off, path);
    for (const value of values) {
      if (value && typeof value === "object" && !Array.isArray(value)) {
        return value as Record<string, unknown>;
      }
    }
  }
  return undefined;
}

export function parseBarcodeSymbology(value?: string): "ean13" | "ean8" | "upc_a" | "unknown" {
  if (!value) return "unknown";
  const digits = value.replace(/\D+/g, "");
  if (digits.length === 13) return "ean13";
  if (digits.length === 12) return "upc_a";
  if (digits.length === 8) return "ean8";
  return "unknown";
}

export function parseQuantityToPackaging(text?: string): PackagingResult | undefined {
  if (!text) return undefined;
  const normalized = normalizeString(text);
  if (!normalized) return undefined;

  const result: PackagingResult = {
    displayText: normalized
  };

  const countMatch = normalized.match(/^(\d+)\s*[xX]/);
  if (countMatch) {
    const count = Number.parseInt(countMatch[1], 10);
    if (Number.isFinite(count) && count > 0) result.count = count;
  }

  const qtyMatch = normalized.match(/(\d+(?:[\.,]\d+)?)\s*(kg|g|ml|l|oz|lb|pcs?|pieces?|count|pack)\b/i);
  if (qtyMatch) {
    const quantity = Number.parseFloat(qtyMatch[1].replace(",", "."));
    if (Number.isFinite(quantity) && quantity >= 0) {
      result.quantity = quantity;
    }

    const unitToken = qtyMatch[2];
    for (const entry of PACKAGING_UNIT_MAP) {
      if (entry.regex.test(unitToken)) {
        result.unit = entry.unit;
        break;
      }
    }
  }

  if (!result.unit && result.count) {
    result.unit = "count";
  }

  return Object.keys(result).length > 0 ? result : undefined;
}

export function parseIngredients(text?: string): string[] | undefined {
  if (!text) return undefined;
  const normalized = normalizeString(text);
  if (!normalized) return undefined;

  const items = normalized
    .split(/[;,]/)
    .map((part) => normalizeString(part))
    .filter((part) => part.length > 0);

  return items.length > 0 ? items : [normalized];
}

export function parseAllergens(input?: string | string[]): string[] | undefined {
  if (!input) return undefined;
  const raw = Array.isArray(input) ? input.join(",") : input;
  const normalized = normalizeString(raw);
  if (!normalized) return undefined;

  const items = normalized
    .split(/[;,]/)
    .map((part) => part.replace(/^contains\s*/i, ""))
    .map((part) => normalizeString(part.toLowerCase()))
    .filter(Boolean);

  return items.length > 0 ? [...new Set(items)] : undefined;
}

function toNumber(value: unknown): number | undefined {
  if (typeof value === "number" && Number.isFinite(value)) return value;
  if (typeof value === "string") {
    const parsed = Number.parseFloat(value);
    if (Number.isFinite(parsed)) return parsed;
  }
  return undefined;
}

function pickNutritionValue(obj: Record<string, unknown>, keys: string[]): number | undefined {
  for (const key of keys) {
    const direct = toNumber(obj[key]);
    if (direct !== undefined) return direct;

    const per100 = toNumber(obj[`${key}_100g`]);
    if (per100 !== undefined) return per100;

    const per100ml = toNumber(obj[`${key}_100ml`]);
    if (per100ml !== undefined) return per100ml;
  }
  return undefined;
}

export function extractNutrition(off: unknown, paths?: OffFieldPaths): NutritionFacts | undefined {
  const objectPaths = paths?.nutritionObject ?? ["nutriments"];
  const nutriments = getNestedObject(off, objectPaths);
  if (!nutriments) return undefined;

  const energyKcal = pickNutritionValue(nutriments, ["energy-kcal", "energy_kcal", "energy-kcal_value"]);
  const proteinG = pickNutritionValue(nutriments, ["proteins", "protein"]);
  const fatG = pickNutritionValue(nutriments, ["fat"]);
  const saturatedFatG = pickNutritionValue(nutriments, ["saturated-fat", "saturated_fat"]);
  const carbsG = pickNutritionValue(nutriments, ["carbohydrates", "carbs"]);
  const sugarsG = pickNutritionValue(nutriments, ["sugars", "sugar"]);

  let sodiumMg: number | undefined;
  const sodium = pickNutritionValue(nutriments, ["sodium"]);
  if (sodium !== undefined) {
    const sodiumUnit = String(nutriments.sodium_unit ?? "g").toLowerCase();
    if (sodiumUnit === "g") sodiumMg = sodium * 1000;
    else if (sodiumUnit === "mg") sodiumMg = sodium;
  }

  const result: NutritionFacts = {};
  if (energyKcal !== undefined) result.energyKcal = energyKcal;
  if (proteinG !== undefined) result.proteinG = proteinG;
  if (fatG !== undefined) result.fatG = fatG;
  if (saturatedFatG !== undefined) result.saturatedFatG = saturatedFatG;
  if (carbsG !== undefined) result.carbsG = carbsG;
  if (sugarsG !== undefined) result.sugarsG = sugarsG;
  if (sodiumMg !== undefined) result.sodiumMg = sodiumMg;

  return Object.keys(result).length > 0 ? result : undefined;
}
