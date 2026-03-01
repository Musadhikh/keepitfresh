import { writeFile } from "node:fs/promises";
import { logger } from "../../core/logger.js";
import {
  DEFAULT_SAMPLE_COUNT,
  DEFAULT_SAMPLE_OUTPUT,
  DEFAULT_SAMPLE_STATS_OUTPUT
} from "../../core/constants.js";
import { ensureOutputDir, resolveFromImporterRoot } from "../../core/paths.js";
import type { JsonlStats } from "../../core/types.js";
import { createJsonlReader } from "../../utils/jsonl.js";

export interface SampleCommandArgs {
  file?: string;
  count?: number;
  out?: string;
}

export async function runSampleCommand(args: SampleCommandArgs): Promise<void> {
  const inputFile = resolveFromImporterRoot(args.file ?? process.env.IMPORT_FILE_PATH ?? "../openfoodfacts-products.jsonl");
  const count = args.count ?? DEFAULT_SAMPLE_COUNT;
  const sampleOutPath = resolveFromImporterRoot(args.out ?? DEFAULT_SAMPLE_OUTPUT);
  const statsOutPath = resolveFromImporterRoot(DEFAULT_SAMPLE_STATS_OUTPUT);

  await ensureOutputDir();

  const sampleRows: unknown[] = [];
  let totalLinesRead = 0;
  let invalidLines = 0;
  let totalLineBytes = 0;
  let maxLineBytes = 0;

  for await (const row of createJsonlReader(inputFile, {
    includeRawLineInErrors: false,
    onParseError: ({ lineNumber, error }) => {
      invalidLines += 1;
      logger.warn({ lineNumber, error }, "Skipping invalid JSONL line");
    }
  })) {
    totalLinesRead = row.lineNumber;
    totalLineBytes += row.lineBytes;
    maxLineBytes = Math.max(maxLineBytes, row.lineBytes);

    if (sampleRows.length < count) {
      sampleRows.push(row.value);
    }

    if (sampleRows.length >= count) {
      break;
    }
  }

  const stats: JsonlStats = {
    totalLinesRead,
    validObjects: sampleRows.length,
    invalidLines,
    avgLineBytes: totalLinesRead > 0 ? totalLineBytes / totalLinesRead : 0,
    maxLineBytes
  };

  await writeFile(sampleOutPath, `${JSON.stringify(sampleRows, null, 2)}\n`, "utf8");
  await writeFile(statsOutPath, `${JSON.stringify(stats, null, 2)}\n`, "utf8");

  logger.info(
    {
      inputFile,
      sampleOutPath,
      statsOutPath,
      countRequested: count,
      validObjects: sampleRows.length,
      invalidLines
    },
    "Sample extraction completed"
  );
}
