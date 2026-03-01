import { readFile } from "node:fs/promises";
import { resolveFromImporterRoot } from "../core/paths.js";

interface SchemaField {
  path: string;
  presenceCount?: number;
  observedCount?: number;
}

interface SchemaSummary {
  topLevelFields?: SchemaField[];
  nestedFields?: SchemaField[];
}

export interface OffFieldPaths {
  barcode: string[];
  title: string[];
  brands: string[];
  description: string[];
  storageInstructions: string[];
  ingredientsText: string[];
  allergens: string[];
  nutritionObject: string[];
  nutritionPer100: string[];
  servingSize: string[];
  quantity: string[];
  images: string[];
  imageFront: string[];
  imageIngredients: string[];
  imageNutrition: string[];
  categoryTags: string[];
  categoryHierarchy: string[];
  countries: string[];
  labels: string[];
  certifications: string[];
  updatedTimestamp: string[];
  code: string[];
  url: string[];
}

const KEYWORDS: Record<keyof OffFieldPaths, string[]> = {
  barcode: ["barcode", "code", "ean", "upc"],
  title: ["product_name", "name", "title", "display_name"],
  brands: ["brands", "brand", "manufacturer"],
  description: ["description", "generic_name", "summary"],
  storageInstructions: ["storage", "conservation", "instruction"],
  ingredientsText: ["ingredients_text", "ingredients"],
  allergens: ["allergen", "allergens", "allergens_tags"],
  nutritionObject: ["nutriments", "nutrition_data"],
  nutritionPer100: ["100g", "100ml", "per_100"],
  servingSize: ["serving_size", "serving"],
  quantity: ["quantity", "net_weight", "weight", "volume"],
  images: ["image", "images", "img", "photos"],
  imageFront: ["image_front", "front_image", "front"],
  imageIngredients: ["image_ingredients", "ingredients_image"],
  imageNutrition: ["image_nutrition", "nutrition_image"],
  categoryTags: ["categories_tags", "category_tags", "categories"],
  categoryHierarchy: ["categories_hierarchy", "category_hierarchy", "hierarchy"],
  countries: ["countries", "countries_tags", "market"],
  labels: ["labels", "labels_tags", "certification"],
  certifications: ["certification", "certifications", "label"],
  updatedTimestamp: ["last_modified", "updated", "last_updated", "modified_t", "last_modified_t"],
  code: ["code", "id"],
  url: ["url", "product_url", "link"]
};

function fieldScore(field: SchemaField): number {
  return field.presenceCount ?? field.observedCount ?? 0;
}

function choosePaths(fields: SchemaField[], hints: string[]): string[] {
  const rows = fields
    .map((field) => {
      const lower = field.path.toLowerCase();
      let score = fieldScore(field);
      for (const hint of hints) {
        if (lower.includes(hint.toLowerCase())) {
          score += 1_000_000;
        }
      }
      return { path: field.path, score };
    })
    .filter((row) => row.score > 0 && hints.some((hint) => row.path.toLowerCase().includes(hint.toLowerCase())))
    .sort((a, b) => b.score - a.score || a.path.localeCompare(b.path));

  return [...new Set(rows.map((row) => row.path))];
}

export async function deriveOffFieldPaths(schemaPathArg?: string): Promise<OffFieldPaths> {
  const schemaPath = resolveFromImporterRoot(schemaPathArg ?? "output/off_schema_summary.json");
  const raw = await readFile(schemaPath, "utf8");
  const summary = JSON.parse(raw) as SchemaSummary;

  const fields = [
    ...(summary.topLevelFields ?? []),
    ...(summary.nestedFields ?? [])
  ];

  const result = {} as OffFieldPaths;
  (Object.keys(KEYWORDS) as Array<keyof OffFieldPaths>).forEach((key) => {
    result[key] = choosePaths(fields, KEYWORDS[key]);
  });

  return result;
}
