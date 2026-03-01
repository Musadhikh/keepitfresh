import { readFile, writeFile } from "node:fs/promises";
import {
  DEFAULT_SAMPLE_OUTPUT
} from "../../core/constants.js";
import { logger } from "../../core/logger.js";
import { ensureOutputDir, resolveFromImporterRoot } from "../../core/paths.js";
import { nowISO } from "../../utils/time.js";

const MAX_DEPTH = 6;
const EXAMPLE_LIMIT = 2;
const PREVIEW_LIMIT = 120;

type ObservedType = "string" | "number" | "object" | "array" | "boolean" | "null";

interface PathStat {
  path: string;
  observedCount: number;
  types: Map<ObservedType, number>;
  examples: string[];
  maxBytes: number;
  totalBytes: number;
  arrayElementTypes: Map<ObservedType, number>;
}

interface FieldSummary {
  path: string;
  observedCount: number;
  presenceCount?: number;
  presenceRate?: number;
  types: Record<string, number>;
  examples: string[];
  maxBytes: number;
  avgBytes: number;
  arrayElementTypes?: Record<string, number>;
}

interface SchemaSummary {
  generatedAt: string;
  samplePath: string;
  sampleSize: number;
  maxDepth: number;
  topLevelFields: FieldSummary[];
  nestedFields: FieldSummary[];
  mostCommonKeys: Array<{ key: string; count: number; rate: number }>;
  heuristics: {
    largeFieldsLikelyExpensiveToStore: Array<{ path: string; maxBytes: number; avgBytes: number }>;
    candidateCategoryRelatedFields: string[];
    candidateNutritionFields: string[];
    candidateImageFields: string[];
  };
}

export interface SchemaProbeArgs {
  sample?: string;
  outJson?: string;
  outMd?: string;
}

function detectType(value: unknown): ObservedType {
  if (value === null) return "null";
  if (Array.isArray(value)) return "array";
  switch (typeof value) {
    case "string":
      return "string";
    case "number":
      return "number";
    case "boolean":
      return "boolean";
    case "object":
      return "object";
    default:
      return "string";
  }
}

function preview(value: unknown): string {
  const raw = typeof value === "string" ? value : JSON.stringify(value);
  if (!raw) return "";
  return raw.length > PREVIEW_LIMIT ? `${raw.slice(0, PREVIEW_LIMIT)}...` : raw;
}

function addUniqueExample(list: string[], value: unknown): void {
  const next = preview(value);
  if (!next) return;
  if (list.includes(next)) return;
  if (list.length >= EXAMPLE_LIMIT) return;
  list.push(next);
}

function ensurePathStat(map: Map<string, PathStat>, path: string): PathStat {
  const existing = map.get(path);
  if (existing) return existing;

  const created: PathStat = {
    path,
    observedCount: 0,
    types: new Map(),
    examples: [],
    maxBytes: 0,
    totalBytes: 0,
    arrayElementTypes: new Map()
  };

  map.set(path, created);
  return created;
}

function recordValue(
  map: Map<string, PathStat>,
  path: string,
  value: unknown,
  depth: number
): void {
  if (depth > MAX_DEPTH) return;

  const stat = ensurePathStat(map, path);
  stat.observedCount += 1;

  const valueType = detectType(value);
  stat.types.set(valueType, (stat.types.get(valueType) ?? 0) + 1);

  const raw = JSON.stringify(value);
  const bytes = raw ? Buffer.byteLength(raw, "utf8") : 0;
  stat.totalBytes += bytes;
  stat.maxBytes = Math.max(stat.maxBytes, bytes);
  addUniqueExample(stat.examples, value);

  if (Array.isArray(value)) {
    for (const item of value) {
      const itemType = detectType(item);
      stat.arrayElementTypes.set(itemType, (stat.arrayElementTypes.get(itemType) ?? 0) + 1);
      recordValue(map, `${path}[]`, item, depth + 1);
    }

    return;
  }

  if (value && typeof value === "object") {
    const entries = Object.entries(value as Record<string, unknown>).sort(([a], [b]) =>
      a.localeCompare(b)
    );

    for (const [key, nestedValue] of entries) {
      const nestedPath = path === "" ? key : `${path}.${key}`;
      recordValue(map, nestedPath, nestedValue, depth + 1);
    }
  }
}

function toFieldSummary(
  stat: PathStat,
  sampleSize: number,
  presenceCount?: number
): FieldSummary {
  const types = Object.fromEntries([...stat.types.entries()].sort(([a], [b]) => a.localeCompare(b)));
  const arrayElementTypes = stat.arrayElementTypes.size
    ? Object.fromEntries([...stat.arrayElementTypes.entries()].sort(([a], [b]) => a.localeCompare(b)))
    : undefined;

  const result: FieldSummary = {
    path: stat.path,
    observedCount: stat.observedCount,
    types,
    examples: [...stat.examples],
    maxBytes: stat.maxBytes,
    avgBytes: stat.observedCount > 0 ? stat.totalBytes / stat.observedCount : 0
  };

  if (typeof presenceCount === "number") {
    result.presenceCount = presenceCount;
    result.presenceRate = sampleSize > 0 ? presenceCount / sampleSize : 0;
  }

  if (arrayElementTypes) {
    result.arrayElementTypes = arrayElementTypes;
  }

  return result;
}

function looksLike(path: string, patterns: string[]): boolean {
  const lower = path.toLowerCase();
  return patterns.some((pattern) => lower.includes(pattern));
}

export async function runSchemaProbeCommand(args: SchemaProbeArgs): Promise<void> {
  await ensureOutputDir();

  const samplePath = resolveFromImporterRoot(args.sample ?? DEFAULT_SAMPLE_OUTPUT);
  const outJsonPath = resolveFromImporterRoot(args.outJson ?? "output/off_schema_summary.json");
  const outMdPath = resolveFromImporterRoot(args.outMd ?? "output/off_schema_summary.md");

  const raw = await readFile(samplePath, "utf8");
  const sample = JSON.parse(raw) as unknown;

  if (!Array.isArray(sample)) {
    throw new Error(`Expected array in sample file: ${samplePath}`);
  }

  const topLevelPresence = new Map<string, number>();
  const pathStats = new Map<string, PathStat>();

  for (const row of sample) {
    if (!row || typeof row !== "object" || Array.isArray(row)) {
      continue;
    }

    const record = row as Record<string, unknown>;
    const keys = Object.keys(record).sort((a, b) => a.localeCompare(b));

    for (const key of keys) {
      topLevelPresence.set(key, (topLevelPresence.get(key) ?? 0) + 1);
      recordValue(pathStats, key, record[key], 1);
    }
  }

  const sampleSize = sample.length;

  const topLevelFields = [...topLevelPresence.entries()]
    .sort(([a], [b]) => a.localeCompare(b))
    .map(([key, count]) => {
      const stat = pathStats.get(key);
      if (!stat) {
        return {
          path: key,
          observedCount: count,
          presenceCount: count,
          presenceRate: sampleSize > 0 ? count / sampleSize : 0,
          types: {},
          examples: [],
          maxBytes: 0,
          avgBytes: 0
        } satisfies FieldSummary;
      }

      return toFieldSummary(stat, sampleSize, count);
    });

  const nestedFields = [...pathStats.values()]
    .filter((stat) => stat.path.includes(".") || stat.path.includes("[]"))
    .sort((a, b) => a.path.localeCompare(b.path))
    .map((stat) => toFieldSummary(stat, sampleSize));

  const mostCommonKeys = [...topLevelPresence.entries()]
    .sort((a, b) => b[1] - a[1] || a[0].localeCompare(b[0]))
    .slice(0, 30)
    .map(([key, count]) => ({
      key,
      count,
      rate: sampleSize > 0 ? count / sampleSize : 0
    }));

  const allPaths = [...pathStats.keys()].sort((a, b) => a.localeCompare(b));

  const largeFieldsLikelyExpensiveToStore = [...pathStats.values()]
    .filter((stat) => stat.maxBytes > 256)
    .sort((a, b) => b.maxBytes - a.maxBytes || a.path.localeCompare(b.path))
    .slice(0, 20)
    .map((stat) => ({
      path: stat.path,
      maxBytes: stat.maxBytes,
      avgBytes: stat.observedCount > 0 ? stat.totalBytes / stat.observedCount : 0
    }));

  const summary: SchemaSummary = {
    generatedAt: nowISO(),
    samplePath,
    sampleSize,
    maxDepth: MAX_DEPTH,
    topLevelFields,
    nestedFields,
    mostCommonKeys,
    heuristics: {
      largeFieldsLikelyExpensiveToStore,
      candidateCategoryRelatedFields: allPaths.filter((path) =>
        looksLike(path, ["category", "categories", "tags", "hierarchy"])
      ),
      candidateNutritionFields: allPaths.filter((path) => looksLike(path, ["nutri", "nutrition", "nutriments"])),
      candidateImageFields: allPaths.filter((path) => looksLike(path, ["image", "images", "img"]))
    }
  };

  const mdLines: string[] = [];
  mdLines.push("# OFF Schema Summary (Phase 2)");
  mdLines.push("");
  mdLines.push(`- Generated at: ${summary.generatedAt}`);
  mdLines.push(`- Sample path: ${summary.samplePath}`);
  mdLines.push(`- Sample size: ${summary.sampleSize}`);
  mdLines.push(`- Probe max depth: ${summary.maxDepth}`);
  mdLines.push("");

  mdLines.push("## Most common keys");
  mdLines.push("");
  mdLines.push("| Key | Presence | Rate |");
  mdLines.push("|---|---:|---:|");
  for (const row of summary.mostCommonKeys) {
    mdLines.push(`| ${row.key} | ${row.count} | ${(row.rate * 100).toFixed(1)}% |`);
  }
  mdLines.push("");

  mdLines.push("## Top-level key summary");
  mdLines.push("");
  mdLines.push("| Path | Presence | Types | Examples |");
  mdLines.push("|---|---:|---|---|");
  for (const field of summary.topLevelFields) {
    const presence = `${field.presenceCount ?? 0}/${summary.sampleSize}`;
    const types = Object.keys(field.types).join(", ");
    const examples = field.examples.join("<br>");
    mdLines.push(`| ${field.path} | ${presence} | ${types || "-"} | ${examples || "-"} |`);
  }
  mdLines.push("");

  mdLines.push("## Nested field summary (depth <= 6)");
  mdLines.push("");
  mdLines.push("| Path | Observed | Types | Array element types | Examples |");
  mdLines.push("|---|---:|---|---|---|");
  for (const field of summary.nestedFields) {
    const types = Object.keys(field.types).join(", ");
    const arrayElementTypes = field.arrayElementTypes ? Object.keys(field.arrayElementTypes).join(", ") : "-";
    const examples = field.examples.join("<br>");
    mdLines.push(`| ${field.path} | ${field.observedCount} | ${types || "-"} | ${arrayElementTypes} | ${examples || "-"} |`);
  }
  mdLines.push("");

  mdLines.push("## Large fields likely expensive to store");
  mdLines.push("");
  mdLines.push("| Path | Max bytes | Avg bytes |");
  mdLines.push("|---|---:|---:|");
  for (const row of summary.heuristics.largeFieldsLikelyExpensiveToStore) {
    mdLines.push(`| ${row.path} | ${row.maxBytes} | ${row.avgBytes.toFixed(1)} |`);
  }
  mdLines.push("");

  mdLines.push("## Candidate category-related fields");
  mdLines.push("");
  for (const path of summary.heuristics.candidateCategoryRelatedFields) {
    mdLines.push(`- ${path}`);
  }
  if (summary.heuristics.candidateCategoryRelatedFields.length === 0) {
    mdLines.push("- (none observed)");
  }
  mdLines.push("");

  mdLines.push("## Candidate nutrition fields");
  mdLines.push("");
  for (const path of summary.heuristics.candidateNutritionFields) {
    mdLines.push(`- ${path}`);
  }
  if (summary.heuristics.candidateNutritionFields.length === 0) {
    mdLines.push("- (none observed)");
  }
  mdLines.push("");

  mdLines.push("## Candidate image fields");
  mdLines.push("");
  for (const path of summary.heuristics.candidateImageFields) {
    mdLines.push(`- ${path}`);
  }
  if (summary.heuristics.candidateImageFields.length === 0) {
    mdLines.push("- (none observed)");
  }
  mdLines.push("");

  await writeFile(outJsonPath, `${JSON.stringify(summary, null, 2)}\n`, "utf8");
  await writeFile(outMdPath, `${mdLines.join("\n")}\n`, "utf8");

  logger.info({ samplePath, outJsonPath, outMdPath }, "Schema probe completed");
}
