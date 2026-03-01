import { writeFile } from "node:fs/promises";
import { nowISO } from "../../utils/time.js";
import { logger } from "../../core/logger.js";
import {
  DEFAULT_SAMPLE_COUNT,
  DEFAULT_SAMPLE_OUTPUT,
  DEFAULT_SAMPLE_STATS_OUTPUT
} from "../../core/constants.js";
import { ensureOutputDir, resolveFromImporterRoot } from "../../core/paths.js";
import { createJsonlReader } from "../../utils/jsonl.js";

export interface SampleCommandArgs {
  file?: string;
  count?: number;
  maxLines?: number;
  out?: string;
}

interface SampleStats {
  filePath: string;
  totalLinesRead: number;
  validObjects: number;
  invalidLines: number;
  emptyLines: number;
  avgLineBytes: number;
  maxLineBytes: number;
  firstValidLineNumber: number | null;
  lastValidLineNumber: number | null;
  startedAt: string;
  finishedAt: string;
  durationMs: number;
}

export async function runSampleCommand(args: SampleCommandArgs): Promise<void> {
  const inputFile = resolveFromImporterRoot(
    args.file ?? process.env.IMPORT_FILE_PATH ?? "../openfoodfacts-products.jsonl"
  );
  const count = args.count ?? DEFAULT_SAMPLE_COUNT;
  const maxLines = args.maxLines;
  const sampleOutPath = resolveFromImporterRoot(args.out ?? DEFAULT_SAMPLE_OUTPUT);
  const statsOutPath = resolveFromImporterRoot(DEFAULT_SAMPLE_STATS_OUTPUT);

  await ensureOutputDir();

  const startedAt = nowISO();
  const startedAtMs = Date.now();

  const sampleRows: unknown[] = [];
  let totalLinesRead = 0;
  let invalidLines = 0;
  let emptyLines = 0;
  let totalLineBytes = 0;
  let maxLineBytes = 0;
  let firstValidLineNumber: number | null = null;
  let lastValidLineNumber: number | null = null;

  for await (const row of createJsonlReader(inputFile, {
    includeRawLineInErrors: false,
    onLine: ({ lineNumber, lineBytes, isEmpty }) => {
      totalLinesRead = lineNumber;
      totalLineBytes += lineBytes;
      maxLineBytes = Math.max(maxLineBytes, lineBytes);
      if (isEmpty) {
        emptyLines += 1;
      }
    },
    onParseError: ({ lineNumber, error }) => {
      invalidLines += 1;
      logger.warn({ lineNumber, error }, "Skipping invalid JSONL line");
    },
    shouldStop: ({ lineNumber }) =>
      typeof maxLines === "number" ? lineNumber > maxLines : false
  })) {
    if (firstValidLineNumber == null) {
      firstValidLineNumber = row.lineNumber;
    }

    lastValidLineNumber = row.lineNumber;

    if (sampleRows.length < count) {
      sampleRows.push(row.value);
    }

    if (sampleRows.length >= count) {
      break;
    }
  }

  const finishedAt = nowISO();
  const durationMs = Date.now() - startedAtMs;

  const stats: SampleStats = {
    filePath: inputFile,
    totalLinesRead,
    validObjects: sampleRows.length,
    invalidLines,
    emptyLines,
    avgLineBytes: totalLinesRead > 0 ? totalLineBytes / totalLinesRead : 0,
    maxLineBytes,
    firstValidLineNumber,
    lastValidLineNumber,
    startedAt,
    finishedAt,
    durationMs
  };

  await writeFile(sampleOutPath, `${JSON.stringify(sampleRows, null, 2)}\n`, "utf8");
  await writeFile(statsOutPath, `${JSON.stringify(stats, null, 2)}\n`, "utf8");

  logger.info(
    {
      inputFile,
      sampleOutPath,
      statsOutPath,
      countRequested: count,
      maxLines,
      validObjects: sampleRows.length,
      invalidLines,
      emptyLines,
      totalLinesRead
    },
    "Sample extraction completed"
  );
}
