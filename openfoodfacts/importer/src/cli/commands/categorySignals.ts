import { writeFile } from "node:fs/promises";
import { discoverCategoryFieldPaths } from "../../categories/discovery.js";
import {
  extractValuesByPath,
  flattenStringSignals,
  isLikelyPathSignal,
  normalizeCategorySignal
} from "../../categories/signals.js";
import { logger } from "../../core/logger.js";
import { ensureOutputDir, resolveFromImporterRoot } from "../../core/paths.js";
import { nowISO } from "../../utils/time.js";
import { createJsonlReader } from "../../utils/jsonl.js";

const DEFAULT_MAX_LINES = 200_000;
const DEFAULT_MIN_COUNT = 10;
const MAX_LIST_ITEMS = 500;
const MAX_CO_OCCURRENCE = 200;
const MAX_TAG_KEYS = 500_000;
const MAX_PATH_KEYS = 250_000;
const MAX_PAIR_KEYS = 300_000;
const MAX_SIGNALS_PER_RECORD_FOR_PAIRS = 20;

export interface CategorySignalsArgs {
  file?: string;
  maxLines?: number;
  minCount?: number;
  out?: string;
  schema?: string;
}

interface SignalItem {
  value: string;
  count: number;
}

interface CoOccurrenceItem {
  pair: [string, string];
  count: number;
}

interface CategorySignalsOutput {
  generatedAt: string;
  scannedLines: number;
  recordsWithCategoryData: number;
  discoveredFieldPaths: string[];
  signals: {
    tags: SignalItem[];
    paths: SignalItem[];
    coOccurrence: CoOccurrenceItem[];
  };
  notes: {
    truncated: boolean;
    minCount: number;
    maxLines: number;
    droppedTagKeys: number;
    droppedPathKeys: number;
    droppedPairKeys: number;
  };
}

function incrementWithCap(counter: Map<string, number>, key: string, cap: number): boolean {
  const existing = counter.get(key);
  if (existing !== undefined) {
    counter.set(key, existing + 1);
    return true;
  }

  if (counter.size >= cap) {
    return false;
  }

  counter.set(key, 1);
  return true;
}

function sortedSignalItems(counter: Map<string, number>, minCount: number): SignalItem[] {
  return [...counter.entries()]
    .filter(([, count]) => count >= minCount)
    .sort((a, b) => b[1] - a[1] || a[0].localeCompare(b[0]))
    .slice(0, MAX_LIST_ITEMS)
    .map(([value, count]) => ({ value, count }));
}

function sortedPairs(counter: Map<string, number>, minCount: number): CoOccurrenceItem[] {
  return [...counter.entries()]
    .filter(([, count]) => count >= minCount)
    .sort((a, b) => b[1] - a[1] || a[0].localeCompare(b[0]))
    .slice(0, MAX_CO_OCCURRENCE)
    .map(([pairKey, count]) => {
      const [a, b] = pairKey.split("||");
      return { pair: [a, b] as [string, string], count };
    });
}

function pairKey(a: string, b: string): string {
  return a <= b ? `${a}||${b}` : `${b}||${a}`;
}

function toMarkdown(payload: CategorySignalsOutput): string {
  const lines: string[] = [];
  lines.push("# Category Signals (Phase 3)");
  lines.push("");
  lines.push(`- Generated at: ${payload.generatedAt}`);
  lines.push(`- Scanned lines: ${payload.scannedLines}`);
  lines.push(`- Records with category data: ${payload.recordsWithCategoryData}`);
  lines.push(`- Min count filter: ${payload.notes.minCount}`);
  lines.push(`- Max lines cap: ${payload.notes.maxLines}`);
  lines.push("");

  lines.push("## Discovered field paths");
  lines.push("");
  for (const path of payload.discoveredFieldPaths) {
    lines.push(`- ${path}`);
  }
  if (payload.discoveredFieldPaths.length === 0) {
    lines.push("- (none)");
  }
  lines.push("");

  lines.push("## Top tags");
  lines.push("");
  lines.push("| Value | Count |");
  lines.push("|---|---:|");
  for (const row of payload.signals.tags.slice(0, 50)) {
    lines.push(`| ${row.value} | ${row.count} |`);
  }
  if (payload.signals.tags.length === 0) {
    lines.push("| (none) | 0 |");
  }
  lines.push("");

  lines.push("## Top paths");
  lines.push("");
  lines.push("| Value | Count |");
  lines.push("|---|---:|");
  for (const row of payload.signals.paths.slice(0, 50)) {
    lines.push(`| ${row.value} | ${row.count} |`);
  }
  if (payload.signals.paths.length === 0) {
    lines.push("| (none) | 0 |");
  }
  lines.push("");

  lines.push("## Co-occurrence pairs");
  lines.push("");
  lines.push("| Pair | Count |");
  lines.push("|---|---:|");
  for (const row of payload.signals.coOccurrence) {
    lines.push(`| ${row.pair[0]} + ${row.pair[1]} | ${row.count} |`);
  }
  if (payload.signals.coOccurrence.length === 0) {
    lines.push("| (none) | 0 |");
  }
  lines.push("");

  const messySignals = payload.signals.tags
    .filter((row) => row.value.length > 80 || row.value.includes(":") || /[^\x00-\x7F]/.test(row.value))
    .slice(0, 30);
  lines.push("## Messy signals");
  lines.push("");
  lines.push("| Value | Count | Why messy |\n|---|---:|---|");
  for (const row of messySignals) {
    const reasons: string[] = [];
    if (row.value.length > 80) reasons.push("very long");
    if (row.value.includes(":")) reasons.push("language/prefix variant");
    if (/[^\x00-\x7F]/.test(row.value)) reasons.push("non-ascii variant");
    lines.push(`| ${row.value} | ${row.count} | ${reasons.join(", ")} |`);
  }
  if (messySignals.length === 0) {
    lines.push("| (none) | 0 | - |");
  }
  lines.push("");

  lines.push("## Recommended next steps");
  lines.push("");
  lines.push("- Review top paths and define manual subcategory overrides for ambiguous leaves.");
  lines.push("- Normalize language-specific variants into canonical synonyms.");
  lines.push("- Promote stable high-frequency candidates into curated taxonomy.");
  lines.push("- Re-run signals after rule updates to measure drift and coverage changes.");
  lines.push("");

  return `${lines.join("\n")}\n`;
}

export async function runCategorySignalsCommand(
  args: CategorySignalsArgs
): Promise<void> {
  await ensureOutputDir();

  const inputFile = resolveFromImporterRoot(
    args.file ?? process.env.IMPORT_FILE_PATH ?? "../openfoodfacts-products.jsonl"
  );
  const maxLines = args.maxLines ?? DEFAULT_MAX_LINES;
  const minCount = args.minCount ?? DEFAULT_MIN_COUNT;
  const outJson = resolveFromImporterRoot(args.out ?? "output/category_signals.json");
  const outMd = resolveFromImporterRoot("output/category_signals.md");

  const discoveredFieldPaths = await discoverCategoryFieldPaths(args.schema);

  const tagsCounter = new Map<string, number>();
  const pathsCounter = new Map<string, number>();
  const coOccurrenceCounter = new Map<string, number>();

  let scannedLines = 0;
  let recordsWithCategoryData = 0;
  let droppedTagKeys = 0;
  let droppedPathKeys = 0;
  let droppedPairKeys = 0;

  for await (const row of createJsonlReader(inputFile, {
    onLine: ({ lineNumber }) => {
      scannedLines = lineNumber;
    },
    shouldStop: ({ lineNumber }) => lineNumber > maxLines
  })) {
    const normalizedSignals = new Set<string>();

    for (const path of discoveredFieldPaths) {
      const extracted = extractValuesByPath(row.value, path).flatMap(flattenStringSignals);
      for (const candidate of extracted) {
        const normalized = normalizeCategorySignal(candidate);
        if (!normalized) continue;

        normalizedSignals.add(normalized);
        if (!incrementWithCap(tagsCounter, normalized, MAX_TAG_KEYS)) {
          droppedTagKeys += 1;
        }
        if (isLikelyPathSignal(normalized)) {
          if (!incrementWithCap(pathsCounter, normalized, MAX_PATH_KEYS)) {
            droppedPathKeys += 1;
          }
        }
      }
    }

    const values = [...normalizedSignals]
      .sort((a, b) => a.localeCompare(b))
      .slice(0, MAX_SIGNALS_PER_RECORD_FOR_PAIRS);
    if (values.length > 0) {
      recordsWithCategoryData += 1;
    }

    for (let i = 0; i < values.length; i += 1) {
      for (let j = i + 1; j < values.length; j += 1) {
        if (!incrementWithCap(coOccurrenceCounter, pairKey(values[i], values[j]), MAX_PAIR_KEYS)) {
          droppedPairKeys += 1;
        }
      }
    }
  }

  const output: CategorySignalsOutput = {
    generatedAt: nowISO(),
    scannedLines,
    recordsWithCategoryData,
    discoveredFieldPaths,
    signals: {
      tags: sortedSignalItems(tagsCounter, minCount),
      paths: sortedSignalItems(pathsCounter, minCount),
      coOccurrence: sortedPairs(coOccurrenceCounter, minCount)
    },
    notes: {
      truncated: scannedLines >= maxLines,
      minCount,
      maxLines,
      droppedTagKeys,
      droppedPathKeys,
      droppedPairKeys
    }
  };

  await writeFile(outJson, `${JSON.stringify(output, null, 2)}\n`, "utf8");
  await writeFile(outMd, toMarkdown(output), "utf8");

  logger.info(
    {
      inputFile,
      scannedLines,
      recordsWithCategoryData,
      discoveredFieldPaths: discoveredFieldPaths.length,
      outJson,
      outMd
    },
    "Category signals generated"
  );
}
