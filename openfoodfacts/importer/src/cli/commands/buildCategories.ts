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
  {
    main: "food",
    keywords: [
      "food",
      "foods",
      "snack",
      "snacks",
      "meal",
      "meals",
      "dish",
      "dairy",
      "milk",
      "cheese",
      "yogurt",
      "yoghurt",
      "meat",
      "fish",
      "seafood",
      "egg",
      "eggs",
      "fruit",
      "fruits",
      "vegetable",
      "vegetables",
      "cereal",
      "potato",
      "bread",
      "pasta",
      "rice",
      "sauce",
      "sauces",
      "condiment",
      "condiments",
      "soup",
      "soups",
      "pizza",
      "pizzas",
      "salsa",
      "dip",
      "dips",
      "marinade",
      "marinades",
      "beans",
      "canned",
      "cream",
      "creams",
      "honey",
      "honeys",
      "sugar",
      "sugars",
      "crackers",
      "dessert",
      "desserts",
      "ice cream",
      "chips",
      "tortilla chips",
      "cold cuts",
      "cooking helpers",
      "syrup",
      "syrups",
      "frozen dinners",
      "entrees",
      "peanut butter",
      "butter",
      "spread",
      "spice",
      "spices",
      "herb",
      "herbs",
      "chili",
      "stew",
      "sausages",
      "ribs",
      "pastries",
      "olive oil",
      "pastry",
      "baking",
      "mayonnaise",
      "relish",
      "dinner mixes",
      "frozen foods",
      "processed meat",
      "composite foods",
      "confectioneries",
      "biscuits",
      "cakes"
    ]
  },
  {
    main: "beverage",
    keywords: [
      "beverage",
      "beverages",
      "drink",
      "drinks",
      "tea",
      "coffee",
      "juice",
      "nectar",
      "smoothie",
      "soda",
      "cola",
      "carbonated",
      "sparkling water",
      "mineral water",
      "flavored water",
      "energy drink",
      "sports drink"
    ]
  },
  { main: "household", keywords: ["cleaning", "detergent", "laundry", "home-care"] },
  { main: "personalCare", keywords: ["cosmetics", "skin-care", "shampoo", "toothpaste"] },
  { main: "pet", keywords: ["pet", "cat", "dog"] },
  { main: "medicine", keywords: ["supplement", "vitamin", "medicine"] },
  { main: "electronics", keywords: ["battery", "charger"] }
];

const SUB_CATEGORY_OVERRIDES: Array<{ offTag?: string; offPath?: string; sub: string }> = [
  { offPath: "cereals and potatoes", sub: "cereals and potatoes" },
  { offPath: "biscuits and cakes", sub: "biscuits and cakes" },
  { offPath: "fat and sauces", sub: "fats and sauces" },
  { offPath: "dressings and sauces", sub: "dressings and sauces" },
  { offPath: "condiments, sauces, groceries", sub: "condiments and sauces" },
  { offPath: "groceries, sauces", sub: "condiments and sauces" },
  { offPath: "fish and seafood", sub: "fish and seafood" },
  { offPath: "milk and dairy products", sub: "milk and dairy products" },
  { offPath: "one-dish meals", sub: "prepared meals" },
  { offPath: "composite foods", sub: "prepared meals" },
  { offPath: "processed meat", sub: "processed meat" },
  { offPath: "salty snacks", sub: "salty snacks" },
  { offPath: "salted snacks", sub: "salty snacks" }
];

const SYNONYM_RULES: Array<{ value: string; synonyms: string[] }> = [
  { value: "salty snacks", synonyms: ["salted snacks"] },
  { value: "condiments and sauces", synonyms: ["groceries, sauces", "condiments, sauces, groceries"] },
  { value: "prepared meals", synonyms: ["one-dish meals", "composite foods"] }
];

const FOOD_CANONICAL_SUBS = [
  "produce",
  "dairy-and-eggs",
  "meat-and-poultry",
  "fish-and-seafood",
  "bakery",
  "grains-pasta-and-rice",
  "breakfast-and-cereal",
  "snacks-sweet",
  "snacks-salty",
  "confectionery",
  "frozen-foods",
  "prepared-meals",
  "soups-and-broths",
  "sauces-dressings-and-condiments",
  "spreads-and-nut-butters",
  "canned-and-jarred",
  "baking-and-dessert-mixes",
  "oils-and-fats",
  "sweeteners-and-syrups",
  "baby-food",
  "special-diet-food",
  "other-food"
] as const;

const BEVERAGE_CANONICAL_SUBS = [
  "water",
  "sparkling-and-soft-drinks",
  "juice-and-nectar",
  "tea",
  "coffee",
  "plant-based-drinks",
  "sports-and-energy-drinks",
  "powdered-and-concentrates",
  "alcoholic",
  "other-beverage"
] as const;

const NOISE_PATTERNS: RegExp[] = [
  /\bunknown\b/i,
  /\bto-be-completed\b/i,
  /\bno nova group\b/i,
  /\bpoint vert\b/i,
  /\bopenfoodfacts\b/i,
  /\b(?:characteristics|origins|packaging|ingredients|nutrition-facts)-to-be-completed\b/i,
  /-average-/i,
  /\baliment moyen\b/i,
  /\b(?:no gluten|sans gluten|sans conservateurs|sans colorants)\b/i,
  /\b(?:bio|organic|non gmo|agriculture biologique)\b/i,
  /(?:^|,\s*)xx:/i
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
    .flatMap((segment) => segment.split(","))
    .map(cleanSegment)
    .filter((part) => part.length > 0);
}

function classifyMain(signal: string, allowedMain: Set<string>): string {
  const lower = normalizeForCategoryMapping(signal);
  for (const rule of MAIN_KEYWORDS) {
    if (!allowedMain.has(rule.main)) continue;
    if (rule.keywords.some((keyword) => lower.includes(keyword))) {
      return rule.main;
    }
  }
  return "other";
}

function isNoisySignal(signal: string): boolean {
  return NOISE_PATTERNS.some((pattern) => pattern.test(signal));
}

function deriveSub(signal: string): { sub: string; hierarchyPath: string[] } {
  const path = parseHierarchy(signal);
  if (path.length > 0) {
    return { sub: path[path.length - 1], hierarchyPath: path };
  }
  const cleaned = cleanSegment(signal);
  return { sub: cleaned || "unknown", hierarchyPath: cleaned ? [cleaned] : [] };
}

function canonicalSubLabel(slug: string): string {
  return slug.replace(/-/g, " ");
}

function normalizeForCategoryMapping(input: string): string {
  let value = toAscii(input.toLowerCase());
  value = value.replace(/[_-]+/g, " ");

  const replacements: Array<[RegExp, string]> = [
    [/\bbeurre de cacahuete ou pate d arachide\b/g, "peanut butter"],
    [/\bbeurre de cacahuete\b/g, "peanut butter"],
    [/\bpate d arachide\b/g, "peanut butter"],
    [/\bhuile d olive vierge extra\b/g, "extra virgin olive oil"],
    [/\bhuile d olive\b/g, "olive oil"],
    [/\bcompote de pomme\b/g, "apple compote"],
    [/\bsirop d erable\b/g, "maple syrup"],
    [/\bsirop\b/g, "syrup"],
    [/\bchips de mais ou tortilla chips\b/g, "tortilla chips"],
    [/\bvolaille francaise\b/g, "poultry"],
    [/\bviande porcine francaise\b/g, "pork"],
    [/\bviande bovine francaise\b/g, "beef"],
    [/\bjambons blancs\b/g, "ham"],
    [/\bfilets de poulet\b/g, "chicken breast"],
    [/\bsoupe\b/g, "soup"],
    [/\bfromage\b/g, "cheese"],
    [/\byaourt\b/g, "yogurt"],
    [/\bsans conservateurs\b/g, "no preservatives"],
    [/\bsans colorants\b/g, "no artificial colors"],
    [/\bsans gluten\b/g, "no gluten"],
    [/\btout type\b/g, "all types"],
    [/\bnature\b/g, "plain"]
  ];

  for (const [pattern, replacement] of replacements) {
    value = value.replace(pattern, replacement);
  }

  return value;
}

function selectCanonicalFoodSub(lower: string): string {
  if (/(fresh|fruit|vegetable|produce|compote)/.test(lower)) return "produce";
  if (/(dairy|milk|cheese|yogurt|yoghurt|egg)/.test(lower)) return "dairy-and-eggs";
  if (/(beef|pork|lamb|chicken|turkey|meat|poultry|ham|sausage|cold cuts|charcuterie)/.test(lower)) return "meat-and-poultry";
  if (/(fish|seafood|salmon|tuna|shrimp)/.test(lower)) return "fish-and-seafood";
  if (/(bread|bakery|bun|pastry|muffin|cake mix|cookie mix|cupcake mix)/.test(lower)) return "bakery";
  if (/(pasta|rice|grain|cereal.*potato|potato|noodle|flour)/.test(lower)) return "grains-pasta-and-rice";
  if (/(breakfast|cereal)/.test(lower)) return "breakfast-and-cereal";
  if (/(confection|candy|chocolate)/.test(lower)) return "confectionery";
  if (/(sweet snack|sugary snack|biscuit|cookies?)/.test(lower)) return "snacks-sweet";
  if (/(salty snack|salted snack|chips|crackers|popcorn|pretzel|nuts?)/.test(lower)) return "snacks-salty";
  if (/(frozen)/.test(lower)) return "frozen-foods";
  if (/(prepared|one dish|composite|entree|dinner mix|pizza|quiche)/.test(lower)) return "prepared-meals";
  if (/(soup|broth)/.test(lower)) return "soups-and-broths";
  if (/(sauce|dressing|condiment|mayonnaise|relish|salsa|dip|marinade)/.test(lower)) return "sauces-dressings-and-condiments";
  if (/(peanut butter|nut butter|seed butter|spread)/.test(lower)) return "spreads-and-nut-butters";
  if (/(canned|jarred|pickles?|olives?|beans?)/.test(lower)) return "canned-and-jarred";
  if (/(baking|dessert mix|baking decoration)/.test(lower)) return "baking-and-dessert-mixes";
  if (/(olive oil|oil|fat)/.test(lower)) return "oils-and-fats";
  if (/(sugar|sweetener|syrup|maple syrup|honey)/.test(lower)) return "sweeteners-and-syrups";
  if (/(baby)/.test(lower)) return "baby-food";
  if (/(gluten|diet|keto|vegan|vegetarian|organic|non gmo)/.test(lower)) return "special-diet-food";
  return "other-food";
}

function selectCanonicalBeverageSub(lower: string): string {
  if (/(water|mineral water|sparkling water|flavored water)/.test(lower)) return "water";
  if (/(soda|cola|soft drink|carbonated)/.test(lower)) return "sparkling-and-soft-drinks";
  if (/(juice|nectar)/.test(lower)) return "juice-and-nectar";
  if (/(tea|iced tea)/.test(lower)) return "tea";
  if (/(coffee)/.test(lower)) return "coffee";
  if (/(plant-based|milk alternative|plant milk)/.test(lower)) return "plant-based-drinks";
  if (/(energy drink|sports drink)/.test(lower)) return "sports-and-energy-drinks";
  if (/(powdered|concentrate)/.test(lower)) return "powdered-and-concentrates";
  if (/(alcohol|beer|wine|spirits)/.test(lower)) return "alcoholic";
  return "other-beverage";
}

function mapToCanonicalSub(main: string, signal: string, currentSub: string): string {
  const lower = normalizeForCategoryMapping(`${signal} ${currentSub}`);
  if (main === "food") return canonicalSubLabel(selectCanonicalFoodSub(lower));
  if (main === "beverage") return canonicalSubLabel(selectCanonicalBeverageSub(lower));
  return currentSub;
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
    if (isNoisySignal(item.value)) {
      candidates.push({ signal: item.value, count: item.count, suggestedMain: "other", suggestedSub: "ignored-noise" });
      continue;
    }

    const main = classifyMain(item.value, allowedMain);
    const { sub: rawSub, hierarchyPath } = deriveSub(item.value);
    const sub = mapToCanonicalSub(main, item.value, rawSub);
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
    canonicalSubcategories: {
      food: [...FOOD_CANONICAL_SUBS],
      beverage: [...BEVERAGE_CANONICAL_SUBS]
    },
    subCategoryOverrides: SUB_CATEGORY_OVERRIDES,
    synonyms: SYNONYM_RULES,
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
