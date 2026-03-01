import { readFile } from "node:fs/promises";
import { resolveFromImporterRoot } from "../core/paths.js";

const CATEGORY_HINTS = [
  "category",
  "categories",
  "tags",
  "hierarchy",
  "group",
  "label",
  "department",
  "aisle"
];

interface SchemaField {
  path: string;
  presenceCount?: number;
  observedCount?: number;
}

interface SchemaSummary {
  topLevelFields?: SchemaField[];
  nestedFields?: SchemaField[];
  heuristics?: {
    candidateCategoryRelatedFields?: string[];
  };
}

function scoreField(field: SchemaField): number {
  const lower = field.path.toLowerCase();
  const keywordScore = CATEGORY_HINTS.reduce((acc, hint) => {
    if (lower.includes(hint)) return acc + 5;
    return acc;
  }, 0);

  const presenceScore = field.presenceCount ?? field.observedCount ?? 0;
  return keywordScore + Math.min(presenceScore, 1_000_000) / 1000;
}

export async function discoverCategoryFieldPaths(
  schemaPathArg?: string
): Promise<string[]> {
  const schemaPath = resolveFromImporterRoot(
    schemaPathArg ?? "output/off_schema_summary.json"
  );
  const schemaRaw = await readFile(schemaPath, "utf8");
  const schema = JSON.parse(schemaRaw) as SchemaSummary;

  const fields = [
    ...(schema.topLevelFields ?? []),
    ...(schema.nestedFields ?? [])
  ];

  const heuristicPaths = schema.heuristics?.candidateCategoryRelatedFields ?? [];

  const fromFields = fields
    .filter((field) => CATEGORY_HINTS.some((hint) => field.path.toLowerCase().includes(hint)))
    .map((field) => ({ path: field.path, score: scoreField(field) }));

  const all = [
    ...fromFields,
    ...heuristicPaths.map((path) => ({ path, score: 1 }))
  ];

  const unique = new Map<string, number>();
  for (const entry of all) {
    unique.set(entry.path, Math.max(unique.get(entry.path) ?? 0, entry.score));
  }

  return [...unique.entries()]
    .sort((a, b) => b[1] - a[1] || a[0].localeCompare(b[0]))
    .map(([path]) => path);
}
