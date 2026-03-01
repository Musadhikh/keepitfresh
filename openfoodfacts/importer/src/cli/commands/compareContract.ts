import { readFile, writeFile } from "node:fs/promises";
import { logger } from "../../core/logger.js";
import { ensureOutputDir, resolveFromImporterRoot } from "../../core/paths.js";
import { nowISO } from "../../utils/time.js";

const SNIPPET_LIMIT = 160;
const EXAMPLE_LIMIT = 2;

interface SchemaSummaryInput {
  sampleSize: number;
  topLevelFields: Array<{ path: string }>;
  nestedFields: Array<{ path: string }>;
  heuristics: {
    candidateCategoryRelatedFields: string[];
    candidateNutritionFields: string[];
    candidateImageFields: string[];
  };
}

interface CanonicalContractInput {
  requiredFields?: string[];
  collections?: {
    ProductCatalog?: {
      fields?: Array<{
        name: string;
        optional?: boolean;
      }>;
    };
  };
}

interface MappingFieldSpec {
  canonicalField: string;
  keywords: string[];
  transform: string;
  fallback: string;
}

export interface CompareContractArgs {
  schema?: string;
  contract?: string;
  sample?: string;
  outDiff?: string;
  outMapping?: string;
}

function tokenizePath(path: string): string[] {
  return path
    .replace(/\[\]/g, " ")
    .replace(/[._]/g, " ")
    .split(/\s+/)
    .map((part) => part.trim().toLowerCase())
    .filter((part) => part.length > 0);
}

function scorePath(path: string, keywords: string[]): number {
  const tokens = tokenizePath(path);
  let score = 0;
  for (const keyword of keywords) {
    const lower = keyword.toLowerCase();
    if (path.toLowerCase().includes(lower)) {
      score += 2;
    }
    if (tokens.includes(lower)) {
      score += 3;
    }
    if (tokens.some((token) => token.includes(lower) || lower.includes(token))) {
      score += 1;
    }
  }
  return score;
}

function findCandidatePaths(paths: string[], keywords: string[], limit = 8): string[] {
  return [...paths]
    .map((path) => ({ path, score: scorePath(path, keywords) }))
    .filter((row) => row.score > 0)
    .sort((a, b) => b.score - a.score || a.path.localeCompare(b.path))
    .slice(0, limit)
    .map((row) => row.path);
}

function extractPathValues(root: unknown, path: string): unknown[] {
  const segments = path.split(".");

  function walk(current: unknown, index: number): unknown[] {
    if (index >= segments.length) {
      return [current];
    }

    const rawSegment = segments[index];
    const isArray = rawSegment.endsWith("[]");
    const key = isArray ? rawSegment.slice(0, -2) : rawSegment;

    if (!current || typeof current !== "object" || Array.isArray(current)) {
      return [];
    }

    const next = (current as Record<string, unknown>)[key];

    if (isArray) {
      if (!Array.isArray(next)) return [];
      const acc: unknown[] = [];
      for (const item of next) {
        acc.push(...walk(item, index + 1));
      }
      return acc;
    }

    return walk(next, index + 1);
  }

  return walk(root, 0);
}

function toSnippet(value: unknown): string {
  const raw = typeof value === "string" ? value : JSON.stringify(value);
  if (!raw) return "";
  return raw.length > SNIPPET_LIMIT ? `${raw.slice(0, SNIPPET_LIMIT)}...` : raw;
}

function collectSnippets(sample: unknown[], paths: string[]): string[] {
  const snippets: string[] = [];

  for (const row of sample) {
    for (const path of paths) {
      const values = extractPathValues(row, path);
      for (const value of values) {
        const snippet = toSnippet(value);
        if (!snippet) continue;
        if (snippets.includes(snippet)) continue;
        snippets.push(snippet);
        if (snippets.length >= EXAMPLE_LIMIT) {
          return snippets;
        }
      }
    }
  }

  return snippets;
}

function recommendationForOffOnlyField(path: string): string {
  const lower = path.toLowerCase();

  if (lower.includes("lang") || lower.includes("translations") || lower.includes("labels")) {
    return "consider contract update (multilingual strategy)";
  }

  if (lower.includes("image") || lower.includes("nutrition") || lower.includes("category") || lower.includes("brand")) {
    return "map to canonical field when stable; otherwise attributes";
  }

  if (lower.includes("debug") || lower.includes("meta") || lower.includes("trace")) {
    return "ignore";
  }

  return "attributes";
}

export async function runCompareContractCommand(args: CompareContractArgs): Promise<void> {
  await ensureOutputDir();

  const schemaPath = resolveFromImporterRoot(args.schema ?? "output/off_schema_summary.json");
  const contractPath = resolveFromImporterRoot(
    args.contract ?? "docs/product_storage_contract_v1.json"
  );
  const samplePath = resolveFromImporterRoot(args.sample ?? "output/off_sample_100.json");
  const outDiffPath = resolveFromImporterRoot(args.outDiff ?? "output/model_diff.md");
  const outMappingPath = resolveFromImporterRoot(
    args.outMapping ?? "output/off_to_product_mapping.md"
  );

  const schema = JSON.parse(await readFile(schemaPath, "utf8")) as SchemaSummaryInput;
  const contract = JSON.parse(await readFile(contractPath, "utf8")) as CanonicalContractInput;
  const sample = JSON.parse(await readFile(samplePath, "utf8")) as unknown[];
  const requiredFromCollections =
    contract.collections?.ProductCatalog?.fields
      ?.filter((field) => field.optional !== true)
      .map((field) => field.name) ?? [];
  const requiredFields =
    contract.requiredFields && contract.requiredFields.length > 0
      ? contract.requiredFields
      : requiredFromCollections;

  if (!Array.isArray(sample)) {
    throw new Error(`Expected sample array: ${samplePath}`);
  }

  const observedPaths = [
    ...schema.topLevelFields.map((field) => field.path),
    ...schema.nestedFields.map((field) => field.path)
  ].sort((a, b) => a.localeCompare(b));

  const mappingSpecs: MappingFieldSpec[] = [
    {
      canonicalField: "Product.productId",
      keywords: ["code", "id", "barcode"],
      transform: "Prefer canonical external product key; trim; if barcode-like normalize to uppercase alphanumeric.",
      fallback: "Skip record if stable identifier cannot be derived."
    },
    {
      canonicalField: "Product.barcode",
      keywords: ["barcode", "code", "ean", "upc"],
      transform: "Normalize value (trim + uppercase + alphanumeric); map symbology if observable.",
      fallback: "Set nil if not confidently present."
    },
    {
      canonicalField: "Product.title",
      keywords: ["title", "name", "product_name", "label"],
      transform: "Use best user-facing product name, trimmed.",
      fallback: "Leave nil and allow draft status if barcode exists."
    },
    {
      canonicalField: "Product.brand",
      keywords: ["brand", "brands", "manufacturer"],
      transform: "Choose primary brand string; collapse arrays to first stable value.",
      fallback: "Nil."
    },
    {
      canonicalField: "Product.shortDescription",
      keywords: ["description", "summary", "generic_name"],
      transform: "Trim and keep concise text only.",
      fallback: "Nil."
    },
    {
      canonicalField: "Product.storageInstructions",
      keywords: ["storage", "instruction", "conservation"],
      transform: "Map free-form storage text verbatim after trim.",
      fallback: "Nil."
    },
    {
      canonicalField: "Product.category.main/sub",
      keywords: ["category", "categories", "tags", "hierarchy"],
      transform: "Map via curated taxonomy (`ProductCategories`) to canonical main/sub.",
      fallback: "main=other, sub=nil; keep raw hints in attributes/provenance."
    },
    {
      canonicalField: "Product.productDetails",
      keywords: ["ingredient", "allergen", "nutrition", "nutri", "usage", "warning"],
      transform: "Use tagged union `{kind, value}` with payload matching canonical detail structs.",
      fallback: "Set nil or `other` with unknown details payload."
    },
    {
      canonicalField: "Product.packaging",
      keywords: ["quantity", "pack", "size", "weight", "volume", "serving"],
      transform: "Parse numeric amount + canonical unit; preserve display text.",
      fallback: "unit=unknown if packaging exists; otherwise nil."
    },
    {
      canonicalField: "Product.images",
      keywords: ["image", "img", "photo"],
      transform: "Map image URLs/assets to canonical image objects with stable id + kind.",
      fallback: "[]"
    },
    {
      canonicalField: "Product.attributes",
      keywords: ["tag", "labels", "states", "misc"],
      transform: "Store non-canonical but useful fields under allowlist prefix strategy (`off_*`, `import_*`).",
      fallback: "{}"
    },
    {
      canonicalField: "Product.extractionMetadata",
      keywords: ["confidence", "extract", "raw", "source", "scan"],
      transform: "Capture extraction-time metadata and confidence maps where available.",
      fallback: "Nil."
    },
    {
      canonicalField: "Product.qualitySignals",
      keywords: ["quality", "completeness", "image", "nutrition", "ingredient", "review"],
      transform: "Compute booleans and score at import-time from observed data.",
      fallback: "Nil or default booleans false if object is created."
    },
    {
      canonicalField: "Product.compliance",
      keywords: ["country", "market", "restricted", "certification", "allergen", "warning"],
      transform: "Map market/restriction/certification arrays when explicitly available.",
      fallback: "Nil."
    },
    {
      canonicalField: "Product.source/status/createdAt/updatedAt/version",
      keywords: ["source", "status", "created", "updated", "timestamp"],
      transform: "Set importer-controlled metadata: source=importedFeed, status per validation, createdAt/updatedAt ISO, version monotonic.",
      fallback: "source=importedFeed, status=draft/active, version=1."
    }
  ];

  const mappingRows = mappingSpecs.map((spec) => {
    const candidates = findCandidatePaths(observedPaths, spec.keywords, 10);
    const examples = collectSnippets(sample, candidates);
    return {
      ...spec,
      candidates,
      examples
    };
  });

  const matchedObservedPaths = new Set(mappingRows.flatMap((row) => row.candidates));
  const canonicalMissingInOff = mappingRows.filter((row) => row.candidates.length === 0);
  const offOnlyFields = observedPaths.filter((path) => !matchedObservedPaths.has(path));

  const conceptualSimilarities = mappingRows
    .filter((row) => row.candidates.length > 0)
    .map((row) => `- ${row.canonicalField} <- ${row.candidates.slice(0, 3).join(", ")}`);

  const diffLines: string[] = [];
  diffLines.push("# OFF vs Canonical Product Model Diff (Phase 2)");
  diffLines.push("");
  diffLines.push("## 1) Overview");
  diffLines.push("");
  diffLines.push(`- Generated at: ${nowISO()}`);
  diffLines.push(`- Sample size analyzed: ${schema.sampleSize}`);
  diffLines.push(`- Observed OFF paths: ${observedPaths.length}`);
  diffLines.push(`- Canonical required fields (contract): ${requiredFields.join(", ")}`);
  diffLines.push("");

  diffLines.push("## 2) Similarities (conceptual matches)");
  diffLines.push("");
  diffLines.push(...(conceptualSimilarities.length ? conceptualSimilarities : ["- No conceptual matches found in current sample."]));
  diffLines.push("");

  diffLines.push("## 3) Differences / gaps");
  diffLines.push("");
  for (const row of mappingRows) {
    if (row.candidates.length === 0) {
      diffLines.push(`- ${row.canonicalField}: no direct OFF candidate observed in sample.`);
    }
  }
  diffLines.push("");

  diffLines.push("## 4) Canonical fields missing in OFF (defaults or nil)");
  diffLines.push("");
  for (const row of canonicalMissingInOff) {
    diffLines.push(`- ${row.canonicalField}: ${row.fallback}`);
  }
  if (canonicalMissingInOff.length === 0) {
    diffLines.push("- None in this sample window.");
  }
  diffLines.push("");

  diffLines.push("## 5) OFF fields not represented canonically");
  diffLines.push("");
  for (const path of offOnlyFields.slice(0, 80)) {
    diffLines.push(`- ${path}: ${recommendationForOffOnlyField(path)}`);
  }
  if (offOnlyFields.length > 80) {
    diffLines.push(`- ... and ${offOnlyFields.length - 80} more`);
  }
  if (offOnlyFields.length === 0) {
    diffLines.push("- None.");
  }
  diffLines.push("");

  diffLines.push("## 6) Risk areas");
  diffLines.push("");
  diffLines.push("- Large blobs and image-related payloads can inflate document size and write costs.");
  diffLines.push("- Category/tag fields are often noisy; curation-first mapping is required.");
  diffLines.push("- Nutrition structures can vary in shape and units across records.");
  diffLines.push("- Multilingual text fields may require explicit locale strategy in future contract versions.");
  diffLines.push("");

  const mappingLines: string[] = [];
  mappingLines.push("# OFF to Product Mapping Spec (Phase 2)");
  mappingLines.push("");
  mappingLines.push(`- Generated at: ${nowISO()}`);
  mappingLines.push(`- Source sample size: ${schema.sampleSize}`);
  mappingLines.push("- Candidate OFF paths are derived from observed schema keys only.");
  mappingLines.push("");

  for (const row of mappingRows) {
    mappingLines.push(`## ${row.canonicalField}`);
    mappingLines.push("");
    mappingLines.push("- Candidate OFF field paths:");
    if (row.candidates.length === 0) {
      mappingLines.push("- (none observed in current sample)");
    } else {
      for (const candidate of row.candidates) {
        mappingLines.push(`- ${candidate}`);
      }
    }
    mappingLines.push("- Transformation / normalization rules:");
    mappingLines.push(`- ${row.transform}`);
    mappingLines.push("- Fallback behavior:");
    mappingLines.push(`- ${row.fallback}`);
    mappingLines.push("- Example sample snippets:");
    if (row.examples.length === 0) {
      mappingLines.push("- (no example available)");
    } else {
      for (const snippet of row.examples) {
        mappingLines.push(`- ${snippet}`);
      }
    }
    mappingLines.push("");
  }

  await writeFile(outDiffPath, `${diffLines.join("\n")}\n`, "utf8");
  await writeFile(outMappingPath, `${mappingLines.join("\n")}\n`, "utf8");

  logger.info(
    {
      schemaPath,
      contractPath,
      samplePath,
      outDiffPath,
      outMappingPath,
      observedPaths: observedPaths.length
    },
    "Contract comparison completed"
  );
}
