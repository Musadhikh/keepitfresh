import { readFile, writeFile } from "node:fs/promises";
import { logger } from "../../core/logger.js";
import {
  DEFAULT_CATEGORIES_PREVIEW_OUTPUT,
  DEFAULT_SAMPLE_OUTPUT
} from "../../core/constants.js";
import { ensureOutputDir, resolveFromImporterRoot } from "../../core/paths.js";
import { isRecord } from "../../utils/validate.js";

export interface BuildCategoriesArgs {
  sample?: string;
  out?: string;
}

export async function runBuildCategoriesCommand(args: BuildCategoriesArgs): Promise<void> {
  await ensureOutputDir();

  const samplePath = resolveFromImporterRoot(args.sample ?? DEFAULT_SAMPLE_OUTPUT);
  const outPath = resolveFromImporterRoot(args.out ?? DEFAULT_CATEGORIES_PREVIEW_OUTPUT);

  let rows: unknown[] = [];
  try {
    const raw = await readFile(samplePath, "utf8");
    rows = JSON.parse(raw) as unknown[];
  } catch {
    logger.warn({ samplePath }, "Sample file not found or invalid JSON; writing empty preview");
  }

  const categoriesCount = new Map<string, number>();
  for (const row of rows) {
    if (!isRecord(row)) continue;

    const candidates = [row.categories, row.category, row.categories_tags]
      .flatMap((value) => (Array.isArray(value) ? value : [value]))
      .filter((value): value is string => typeof value === "string" && value.trim() !== "");

    for (const category of candidates) {
      categoriesCount.set(category, (categoriesCount.get(category) ?? 0) + 1);
    }
  }

  const payload = {
    generatedAt: new Date().toISOString(),
    categories: [...categoriesCount.entries()]
      .sort((a, b) => b[1] - a[1])
      .map(([name, count]) => ({ name, count })),
    notes: [
      "Phase 0 placeholder output.",
      "Phase 3 will add category normalization and taxonomy mapping."
    ]
  };

  await writeFile(outPath, `${JSON.stringify(payload, null, 2)}\n`, "utf8");
  logger.info({ samplePath, outPath }, "Category preview generated (placeholder)");
}
