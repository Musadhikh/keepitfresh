import { readFile, writeFile } from "node:fs/promises";
import { logger } from "../../core/logger.js";
import { ensureOutputDir, resolveFromImporterRoot } from "../../core/paths.js";
import { nowISO } from "../../utils/time.js";

interface CategorySignalItem {
  value: string;
  count: number;
}

interface CategorySignalsInput {
  scannedLines: number;
  recordsWithCategoryData: number;
  signals: {
    tags: CategorySignalItem[];
    paths: CategorySignalItem[];
  };
}

interface ContractInput {
  enums?: {
    mainCategory?: string[];
  };
}

interface CategoryDoc {
  id: string;
  main: string;
  sub: string;
  tags: string[];
  synonyms: string[];
  hierarchyPath: string[];
  sourceHints: {
    openFoodFacts: {
      tags: string[];
      paths: string[];
    };
  };
  version: number;
  createdAt: string;
  updatedAt: string;
}

export interface BuildCategoriesArgs {
  signals?: string;
  contract?: string;
  minCount?: number;
  out?: string;
}

const DEFAULT_MIN_COUNT = 50;

const MAIN_KEYWORDS: Array<{ main: string; keywords: string[] }> = [
  { main: "beverage", keywords: ["beverages", "drinks", "tea", "coffee", "juice", "soda", "water"] },
  { main: "food", keywords: ["foods", "snacks", "meals", "bread", "dairy", "meat", "fruits", "vegetables"] },
  { main: "household", keywords: ["cleaning", "detergent", "laundry", "home-care"] },
  { main: "personalCare", keywords: ["cosmetics", "skin-care", "shampoo", "toothpaste"] },
  { main: "pet", keywords: ["pet", "cat", "dog"] },
  { main: "medicine", keywords: ["supplement", "vitamin", "medicine"] },
  { main: "electronics", keywords: ["battery", "charger"] }
];

function toAscii(value: string): string {
  return value.normalize("NFKD").replace(/[^\x00-\x7F]/g, "");
}

function slugify(value: string): string {
  return toAscii(value)
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "")
    .replace(/--+/g, "-");
}

function cleanSegment(value: string): string {
  return value
    .replace(/^([a-z]{2}):/i, "")
    .replace(/_/g, " ")
    .trim();
}

function parseHierarchy(signal: string): string[] {
  return signal
    .split("/")
    .map(cleanSegment)
    .filter((part) => part.length > 0);
}

function classifyMain(signal: string, allowedMain: Set<string>): string {
  const lower = signal.toLowerCase();
  for (const rule of MAIN_KEYWORDS) {
    if (!allowedMain.has(rule.main)) continue;
    if (rule.keywords.some((keyword) => lower.includes(keyword))) {
      return rule.main;
    }
  }
  return "other";
}

function deriveSub(signal: string): { sub: string; hierarchyPath: string[] } {
  const path = parseHierarchy(signal);
  if (path.length > 0) {
    return { sub: path[path.length - 1], hierarchyPath: path };
  }
  const cleaned = cleanSegment(signal);
  return { sub: cleaned || "unknown", hierarchyPath: cleaned ? [cleaned] : [] };
}

function makeDocId(main: string, sub: string): string {
  const subSlug = slugify(sub) || "unknown";
  return `${main}/${subSlug}`;
}

function coverageEstimatePercent(mappedSignalCount: number, recordsWithCategoryData: number): number {
  if (recordsWithCategoryData <= 0) return 0;
  const raw = (mappedSignalCount / recordsWithCategoryData) * 100;
  return Math.min(100, Number(raw.toFixed(2)));
}

export async function runBuildCategoriesCommand(args: BuildCategoriesArgs): Promise<void> {
  await ensureOutputDir();

  const signalsPath = resolveFromImporterRoot(args.signals ?? "output/category_signals.json");
  const contractPath = resolveFromImporterRoot(args.contract ?? "docs/product_storage_contract_v1.json");
  const outPath = resolveFromImporterRoot(args.out ?? "output/categories_preview.json");
  const outMdPath = resolveFromImporterRoot("output/categories_preview.md");
  const mappingRulesPath = resolveFromImporterRoot("docs/category_mapping_rules_v1.json");
  const taxonomyDocPath = resolveFromImporterRoot("docs/category_taxonomy_v1.md");
  const minCount = args.minCount ?? DEFAULT_MIN_COUNT;

  const signals = JSON.parse(await readFile(signalsPath, "utf8")) as CategorySignalsInput;
  const contract = JSON.parse(await readFile(contractPath, "utf8")) as ContractInput;
  const allowedMain = new Set(
    contract.enums?.mainCategory ?? ["food", "beverage", "household", "personalCare", "medicine", "electronics", "pet", "other"]
  );

  const now = nowISO();
  const bucket = new Map<string, CategoryDoc>();
  const candidates: Array<{ signal: string; count: number; suggestedMain: string; suggestedSub: string }> = [];

  const sourceSignals = [
    ...signals.signals.paths.map((item) => ({ ...item, source: "path" as const })),
    ...signals.signals.tags.map((item) => ({ ...item, source: "tag" as const }))
  ];

  let mappedSignalCount = 0;

  for (const item of sourceSignals) {
    const main = classifyMain(item.value, allowedMain);
    const { sub, hierarchyPath } = deriveSub(item.value);
    const id = makeDocId(main, sub);
    const subValid = sub.length > 0;

    if (item.count < minCount || !subValid) {
      candidates.push({ signal: item.value, count: item.count, suggestedMain: main, suggestedSub: sub || "unknown" });
      continue;
    }

    const existing = bucket.get(id);
    if (!existing) {
      bucket.set(id, {
        id,
        main,
        sub,
        tags: item.source === "tag" ? [item.value] : [],
        synonyms: [],
        hierarchyPath,
        sourceHints: {
          openFoodFacts: {
            tags: item.source === "tag" ? [item.value] : [],
            paths: item.source === "path" ? [item.value] : []
          }
        },
        version: 1,
        createdAt: now,
        updatedAt: now
      });
    } else {
      if (item.source === "tag") {
        if (!existing.tags.includes(item.value)) existing.tags.push(item.value);
        if (!existing.sourceHints.openFoodFacts.tags.includes(item.value)) {
          existing.sourceHints.openFoodFacts.tags.push(item.value);
        }
      } else {
        if (!existing.sourceHints.openFoodFacts.paths.includes(item.value)) {
          existing.sourceHints.openFoodFacts.paths.push(item.value);
        }
      }
    }

    mappedSignalCount += item.count;
  }

  const categories = [...bucket.values()]
    .map((doc) => ({
      ...doc,
      tags: [...doc.tags].sort((a, b) => a.localeCompare(b)),
      synonyms: [...doc.synonyms].sort((a, b) => a.localeCompare(b)),
      hierarchyPath: [...doc.hierarchyPath],
      sourceHints: {
        openFoodFacts: {
          tags: [...doc.sourceHints.openFoodFacts.tags].sort((a, b) => a.localeCompare(b)),
          paths: [...doc.sourceHints.openFoodFacts.paths].sort((a, b) => a.localeCompare(b))
        }
      }
    }))
    .sort((a, b) => a.id.localeCompare(b.id));

  const coverage = coverageEstimatePercent(mappedSignalCount, signals.recordsWithCategoryData);

  const preview = {
    generatedAt: now,
    source: {
      scannedLines: signals.scannedLines,
      recordsWithCategoryData: signals.recordsWithCategoryData,
      minCount
    },
    categories,
    candidates: candidates
      .sort((a, b) => b.count - a.count || a.signal.localeCompare(b.signal))
      .slice(0, 500),
    coverageEstimate: {
      mappedRecordsPercent: coverage,
      note: "signal-weighted estimate derived from category signal frequencies"
    }
  };

  const mappingRules = {
    version: 1,
    mainCategoryRules: MAIN_KEYWORDS.filter((rule) => allowedMain.has(rule.main)).map((rule) => ({
      matchAny: rule.keywords,
      main: rule.main
    })),
    subCategoryOverrides: [] as Array<{ offTag?: string; offPath?: string; sub: string }>,
    synonyms: [] as Array<{ value: string; synonyms: string[] }>,
    fallback: { main: "other", sub: null as string | null }
  };

  const taxonomyLines: string[] = [];
  taxonomyLines.push("# Category Taxonomy v1");
  taxonomyLines.push("");
  taxonomyLines.push("This taxonomy is generated from OFF category signals and is intentionally editable.");
  taxonomyLines.push("");
  taxonomyLines.push("## Slug rules");
  taxonomyLines.push("");
  taxonomyLines.push("- Category id format: `<main>/<sub-slug>`");
  taxonomyLines.push("- `sub-slug` is ASCII kebab-case.");
  taxonomyLines.push("- No random IDs; deterministic from main+sub.");
  taxonomyLines.push("");
  taxonomyLines.push("## How categories_preview is generated");
  taxonomyLines.push("");
  taxonomyLines.push("1. Read `output/category_signals.json`.");
  taxonomyLines.push("2. Classify `main` with keyword rules from `category_mapping_rules_v1.json`.");
  taxonomyLines.push("3. Derive `sub` from path leaf when available, else from tag.");
  taxonomyLines.push("4. Keep entries with `count >= min-count` as curated categories.");
  taxonomyLines.push("5. Keep lower-frequency entries under candidates for manual curation.");
  taxonomyLines.push("");
  taxonomyLines.push("## How importer will use curated categories + mapping rules");
  taxonomyLines.push("");
  taxonomyLines.push("- Apply `mainCategoryRules` in order.");
  taxonomyLines.push("- Apply `subCategoryOverrides` first for exact offTag/offPath matches.");
  taxonomyLines.push("- Apply `synonyms` normalization.");
  taxonomyLines.push("- Fallback to `other` when no deterministic match exists.");

  const previewLines: string[] = [];
  previewLines.push("# Categories Preview");
  previewLines.push("");
  previewLines.push(`- Generated at: ${now}`);
  previewLines.push(`- Scanned lines: ${signals.scannedLines}`);
  previewLines.push(`- Records with category data: ${signals.recordsWithCategoryData}`);
  previewLines.push(`- Min count threshold: ${minCount}`);
  previewLines.push(`- Coverage estimate: ${coverage}%`);
  previewLines.push("");

  const grouped = new Map<string, CategoryDoc[]>();
  for (const category of categories) {
    if (!grouped.has(category.main)) grouped.set(category.main, []);
    grouped.get(category.main)?.push(category);
  }
  for (const main of [...grouped.keys()].sort((a, b) => a.localeCompare(b))) {
    previewLines.push(`## ${main}`);
    previewLines.push("");
    previewLines.push("| id | sub | tags | paths |");
    previewLines.push("|---|---|---:|---:|");
    for (const category of grouped.get(main) ?? []) {
      previewLines.push(`| ${category.id} | ${category.sub} | ${category.tags.length} | ${category.sourceHints.openFoodFacts.paths.length} |`);
    }
    previewLines.push("");
  }

  previewLines.push("## Unmapped/messy candidates");
  previewLines.push("");
  previewLines.push("| signal | count | suggestedMain | suggestedSub |");
  previewLines.push("|---|---:|---|---|");
  for (const row of preview.candidates.slice(0, 100)) {
    previewLines.push(`| ${row.signal} | ${row.count} | ${row.suggestedMain} | ${row.suggestedSub} |`);
  }
  if (preview.candidates.length === 0) {
    previewLines.push("| (none) | 0 | - | - |");
  }
  previewLines.push("");
  previewLines.push("## Recommended manual edits");
  previewLines.push("");
  previewLines.push("- Add overrides for high-frequency ambiguous signals.");
  previewLines.push("- Merge duplicate subs that differ only by language prefix.");
  previewLines.push("- Promote stable candidates by lowering/adjusting min-count only if needed.");
  previewLines.push("");

  await writeFile(outPath, `${JSON.stringify(preview, null, 2)}\n`, "utf8");
  await writeFile(outMdPath, `${previewLines.join("\n")}\n`, "utf8");
  await writeFile(mappingRulesPath, `${JSON.stringify(mappingRules, null, 2)}\n`, "utf8");
  await writeFile(taxonomyDocPath, `${taxonomyLines.join("\n")}\n`, "utf8");

  logger.info(
    {
      signalsPath,
      contractPath,
      outPath,
      outMdPath,
      mappingRulesPath,
      taxonomyDocPath,
      categories: categories.length
    },
    "Category preview + mapping rules generated"
  );
}
