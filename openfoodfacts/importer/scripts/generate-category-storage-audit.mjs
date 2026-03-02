import fs from "node:fs";
import path from "node:path";
import readline from "node:readline";

const repoRoot = process.cwd();
const importerRoot = path.join(repoRoot, "keepitfresh", "openfoodfacts", "importer");
const inputPath = path.join(repoRoot, "openfoodfacts-products.jsonl");
const previewPath = path.join(importerRoot, "output", "categories_preview.json");
const storageRulesPath = path.join(importerRoot, "docs", "storage_prediction_rules_v1.json");
const outJsonPath = path.join(importerRoot, "output", "category_storage_audit_full.json");
const outMdPath = path.join(importerRoot, "output", "category_storage_audit_full.md");

function normalizeSignal(value) {
  return String(value ?? "")
    .toLowerCase()
    .trim()
    .replace(/[|>\\]/g, "/")
    .replace(/\s*\/\s*/g, "/")
    .replace(/\s+/g, " ")
    .replace(/\/+/g, "/")
    .replace(/^\/+|\/+$/g, "");
}

function normalizeText(value) {
  return String(value ?? "")
    .toLowerCase()
    .replace(/[_-]+/g, " ")
    .replace(/[^\p{L}\p{N}\s.]/gu, " ")
    .replace(/\s+/g, " ")
    .trim();
}

function toArray(value) {
  if (!value) return [];
  if (Array.isArray(value)) return value;
  if (typeof value === "string") return value.split(",");
  return [];
}

function extractRowSignals(row) {
  const raw = [
    ...toArray(row.categories_tags),
    ...toArray(row.categories_hierarchy),
    ...toArray(row.categories),
    ...toArray(row.labels_tags),
    ...toArray(row.product_type)
  ];

  const out = new Set();
  for (const value of raw) {
    const n = normalizeSignal(value);
    if (!n) continue;
    out.add(n);
    if (n.includes("/")) {
      for (const seg of n.split("/").map((s) => s.trim()).filter(Boolean)) {
        out.add(seg);
      }
    }
    if (n.includes(":")) {
      out.add(n.split(":").slice(1).join(":"));
    }
  }
  return out;
}

function buildCategoryIndex(categories) {
  const signalToCategory = new Map();

  categories.forEach((cat, idx) => {
    const hints = new Set();
    const hintBag = [
      ...(cat.tags ?? []),
      ...(cat.synonyms ?? []),
      ...(cat.hierarchyPath ?? []),
      ...(cat?.sourceHints?.openFoodFacts?.tags ?? []),
      ...(cat?.sourceHints?.openFoodFacts?.paths ?? []),
      cat.sub,
      cat.id
    ];

    for (const h of hintBag) {
      const n = normalizeSignal(h);
      if (!n) continue;
      hints.add(n);
      if (n.includes(":")) hints.add(n.split(":").slice(1).join(":"));
      if (n.includes("/")) {
        n.split("/").map((s) => s.trim()).filter(Boolean).forEach((seg) => hints.add(seg));
      }
    }

    for (const s of hints) {
      if (!signalToCategory.has(s)) signalToCategory.set(s, []);
      signalToCategory.get(s).push(idx);
    }
  });

  return signalToCategory;
}

function pickCategory(signals, categories, signalToCategory) {
  const scores = new Map();
  for (const s of signals) {
    const matches = signalToCategory.get(s);
    if (!matches) continue;
    for (const idx of matches) {
      scores.set(idx, (scores.get(idx) ?? 0) + 1);
    }
  }

  let best = null;
  let bestScore = 0;
  for (const [idx, score] of scores.entries()) {
    if (score > bestScore) {
      best = idx;
      bestScore = score;
      continue;
    }
    if (score === bestScore && best !== null) {
      const a = categories[idx];
      const b = categories[best];
      if ((a?.sourceHints?.openFoodFacts?.paths?.length ?? 0) > (b?.sourceHints?.openFoodFacts?.paths?.length ?? 0)) {
        best = idx;
      }
    }
  }

  if (best === null || bestScore <= 0) return null;
  return categories[best];
}

function normalizeSubForRule(sub) {
  return normalizeText(sub).replace(/-/g, " ");
}

function predictStorage(row, category, rules) {
  const corpus = normalizeText([
    row.storage,
    row.conservation,
    row.storage_instructions,
    row.product_name,
    row.generic_name,
    row.categories,
    row.categories_hierarchy,
    row.categories_tags,
    category?.main,
    category?.sub
  ].flat().filter(Boolean).join(" "));

  for (const storageType of rules.storageTypes ?? []) {
    const high = rules?.textRules?.[storageType]?.high ?? [];
    for (const phrase of high) {
      if (corpus.includes(normalizeText(phrase))) return storageType;
    }
  }

  const sub = normalizeSubForRule(category?.sub ?? "");
  if (sub) {
    for (const rule of rules.categoryRules ?? []) {
      const hasContains = (rule.matchSubContains ?? []).some((token) => sub.includes(normalizeSubForRule(token)));
      const hasAny = (rule.matchSubAny ?? []).some((token) => sub === normalizeSubForRule(token) || sub.includes(normalizeSubForRule(token)));
      if (hasContains || hasAny) return rule.storageType;
    }
  }

  for (const storageType of rules.storageTypes ?? []) {
    const medium = rules?.textRules?.[storageType]?.medium ?? [];
    for (const phrase of medium) {
      if (corpus.includes(normalizeText(phrase))) return storageType;
    }
  }

  return null;
}

function sortEntries(map) {
  return [...map.entries()].sort((a, b) => b[1] - a[1] || a[0].localeCompare(b[0]));
}

function writeMarkdown(report) {
  const lines = [];
  lines.push("# Full JSONL Category + Storage Audit");
  lines.push("");
  lines.push(`- Generated at: ${report.generatedAt}`);
  lines.push(`- Source file: ${report.sourceFile}`);
  lines.push(`- Total rows: ${report.totalRows}`);
  lines.push(`- Rows iterated: ${report.rowsIterated}`);
  lines.push(`- Rows pending: ${report.rowsPending}`);
  lines.push(`- Parse errors: ${report.parseErrors}`);
  lines.push(`- Rows with category data: ${report.rowsWithCategoryData}`);
  lines.push(`- Rows matched to curated category: ${report.rowsMatchedCategory}`);
  lines.push(`- Rows with predicted storage type: ${report.rowsWithStoragePrediction}`);
  lines.push("");
  lines.push("## Category Distribution (Top 50)");
  lines.push("");
  lines.push("| Category ID | Main | Sub | Count | % of Iterated |");
  lines.push("|---|---|---|---:|---:|");
  for (const row of report.topCategories) {
    lines.push(`| ${row.id} | ${row.main} | ${row.sub} | ${row.count} | ${row.percent.toFixed(2)}% |`);
  }
  lines.push("");

  lines.push("## Storage Type Distribution");
  lines.push("");
  lines.push("| Storage Type | Count | % of Iterated |");
  lines.push("|---|---:|---:|");
  for (const row of report.storageDistribution) {
    lines.push(`| ${row.storageType} | ${row.count} | ${row.percent.toFixed(2)}% |`);
  }
  lines.push("");

  lines.push("## Top Category + Storage Combinations (Top 50)");
  lines.push("");
  lines.push("| Category ID | Storage Type | Count |");
  lines.push("|---|---|---:|");
  for (const row of report.topCategoryStorageCombos) {
    lines.push(`| ${row.categoryId} | ${row.storageType} | ${row.count} |`);
  }
  lines.push("");

  lines.push("## Notes");
  lines.push("");
  lines.push("- This is an offline audit only. No Firestore writes are performed.");
  lines.push("- Storage type is predicted from deterministic text + category rules from docs/storage_prediction_rules_v1.json.");
  lines.push("- Rows without clear rules are left without storage prediction (no unknown/other fallback).");
  lines.push("");

  return `${lines.join("\n")}\n`;
}

async function main() {
  const categoriesPreview = JSON.parse(fs.readFileSync(previewPath, "utf8"));
  const categories = categoriesPreview.categories ?? [];
  const storageRules = JSON.parse(fs.readFileSync(storageRulesPath, "utf8"));

  const totalRows = Number(fs.readFileSync("/tmp/off_total_rows.txt", "utf8").trim());

  const signalToCategory = buildCategoryIndex(categories);
  const categoryCounts = new Map();
  const storageCounts = new Map();
  const comboCounts = new Map();

  let rowsIterated = 0;
  let parseErrors = 0;
  let rowsWithCategoryData = 0;
  let rowsMatchedCategory = 0;
  let rowsWithStoragePrediction = 0;

  const rl = readline.createInterface({
    input: fs.createReadStream(inputPath, { encoding: "utf8" }),
    crlfDelay: Infinity
  });

  for await (const line of rl) {
    rowsIterated += 1;
    if (!line || !line.trim()) continue;

    let row;
    try {
      row = JSON.parse(line);
    } catch {
      parseErrors += 1;
      continue;
    }

    const signals = extractRowSignals(row);
    if (signals.size > 0) rowsWithCategoryData += 1;

    const category = pickCategory(signals, categories, signalToCategory);
    if (category) {
      rowsMatchedCategory += 1;
      categoryCounts.set(category.id, (categoryCounts.get(category.id) ?? 0) + 1);
    }

    const storageType = predictStorage(row, category, storageRules);
    if (storageType) {
      rowsWithStoragePrediction += 1;
      storageCounts.set(storageType, (storageCounts.get(storageType) ?? 0) + 1);
      if (category) {
        const comboKey = `${category.id}||${storageType}`;
        comboCounts.set(comboKey, (comboCounts.get(comboKey) ?? 0) + 1);
      }
    }

    if (rowsIterated % 200000 === 0) {
      const pending = Math.max(0, totalRows - rowsIterated);
      console.log(JSON.stringify({ rowsIterated, pending }));
    }
  }

  const rowsPending = Math.max(0, totalRows - rowsIterated);

  const topCategories = sortEntries(categoryCounts).slice(0, 50).map(([id, count]) => {
    const cat = categories.find((c) => c.id === id) ?? { main: "", sub: "" };
    return {
      id,
      main: cat.main,
      sub: cat.sub,
      count,
      percent: rowsIterated > 0 ? (count / rowsIterated) * 100 : 0
    };
  });

  const storageDistribution = sortEntries(storageCounts).map(([storageType, count]) => ({
    storageType,
    count,
    percent: rowsIterated > 0 ? (count / rowsIterated) * 100 : 0
  }));

  const topCategoryStorageCombos = sortEntries(comboCounts).slice(0, 50).map(([key, count]) => {
    const [categoryId, storageType] = key.split("||");
    return { categoryId, storageType, count };
  });

  const report = {
    generatedAt: new Date().toISOString(),
    sourceFile: inputPath,
    totalRows,
    rowsIterated,
    rowsPending,
    parseErrors,
    rowsWithCategoryData,
    rowsMatchedCategory,
    rowsWithStoragePrediction,
    topCategories,
    storageDistribution,
    topCategoryStorageCombos
  };

  fs.writeFileSync(outJsonPath, JSON.stringify(report, null, 2));
  fs.writeFileSync(outMdPath, writeMarkdown(report));
  console.log(JSON.stringify({ done: true, outJsonPath, outMdPath, rowsIterated, rowsPending }));
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
