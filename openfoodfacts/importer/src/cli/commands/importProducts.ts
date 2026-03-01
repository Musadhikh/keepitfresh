import { readFile, writeFile } from "node:fs/promises";
import {
  assertExecuteCredentials,
  assertUploadsEnabled,
  loadImporterConfig
} from "../../core/config.js";
import { CHECKPOINT_SAVE_EVERY } from "../../core/constants.js";
import { logger } from "../../core/logger.js";
import { resolveFromImporterRoot } from "../../core/paths.js";
import { writeRunReport } from "../../core/runReports.js";
import type { CommandRuntimeOptions, ImportCheckpoint } from "../../core/types.js";
import { nowISO } from "../../utils/time.js";
import { BatchWriter } from "../../firestore/batching.js";
import { WriteBudget } from "../../firestore/budget.js";
import { loadCheckpoint, saveCheckpoint } from "../../firestore/checkpoints.js";
import { getFirestore } from "../../firestore/client.js";
import { createJsonlReader } from "../../utils/jsonl.js";
import { loadCategoryMatcherContext } from "../../mapping/category_matcher.js";
import { deriveOffFieldPaths } from "../../mapping/off_paths.js";
import { loadStoragePredictionRules } from "../../mapping/storage_predictor.js";
import { transformOffToProduct } from "../../mapping/off_to_product.js";
import { validateProductAgainstContract, type ContractSnapshot } from "../../validation/productValidator.js";
import { stableHashObject } from "../../utils/hash.js";

export interface ImportProductsArgs extends CommandRuntimeOptions {
  file?: string;
  maxWrites?: number;
  maxLines?: number;
  resume?: boolean;
  checkpointMode?: "file" | "firestore";
  skipUnchanged?: boolean;
  sinceDate?: string;
}

interface RejectEntry {
  lineNumber: number;
  productId?: string;
  reasons: string[];
}

function shouldUseResume(args: ImportProductsArgs): boolean {
  if (typeof args.resume === "boolean") return args.resume;
  return true;
}

export async function runImportProductsCommand(args: ImportProductsArgs): Promise<void> {
  const config = loadImporterConfig(args);
  const startedAt = nowISO();

  if (args.checkpointMode) {
    config.checkpointMode = args.checkpointMode;
  }

  if (!config.dryRun) {
    assertUploadsEnabled(config);
    assertExecuteCredentials(config);
  }

  const filePath = resolveFromImporterRoot(args.file ?? config.importFilePath);
  const maxWrites = args.maxWrites ?? config.maxWritesPerRun;
  const maxLines = args.maxLines ?? config.maxLinesPerRun;
  const skipUnchanged = args.skipUnchanged ?? false;

  const budget = new WriteBudget(maxWrites);
  const firestore = config.dryRun ? null : await getFirestore(config);
  const writer = new BatchWriter(firestore, config);

  const categoryMatcher = await loadCategoryMatcherContext();
  const storageRules = await loadStoragePredictionRules();
  const paths = await deriveOffFieldPaths();
  const contract = JSON.parse(
    await readFile(resolveFromImporterRoot("docs/product_storage_contract_v1.json"), "utf8")
  ) as ContractSnapshot;

  const resumeEnabled = shouldUseResume(args);
  const checkpoint = resumeEnabled ? await loadCheckpoint(config) : null;
  const resumeLine = checkpoint?.mode === "products" && checkpoint.filePath === filePath ? checkpoint.lineNumber : 0;

  let scanned = 0;
  let parsed = 0;
  let transformed = 0;
  let written = 0;
  let skipped = 0;
  let rejected = 0;
  let drafts = 0;
  let actives = 0;
  let stopReason = "completed";
  const warningCounts: Record<string, number> = {};
  const rejectReasonCounts: Record<string, number> = {};
  const rejects: RejectEntry[] = [];

  const now = nowISO();

  for await (const row of createJsonlReader(filePath, {
    shouldStop: ({ lineNumber }) =>
      typeof maxLines === "number" ? lineNumber > maxLines : false
  })) {
    scanned = row.lineNumber;

    if (row.lineNumber <= resumeLine) {
      continue;
    }

    parsed += 1;

    const mapped = transformOffToProduct(row.value, {
      paths,
      categoryMatcher,
      storageRules,
      nowISO: now,
      importerVersion: "off-importer-v1"
    });

    mapped.warnings.forEach((w) => {
      warningCounts[w.code] = (warningCounts[w.code] ?? 0) + 1;
    });

    if (!mapped.product) {
      rejected += 1;
      mapped.errors.forEach((code) => {
        rejectReasonCounts[code] = (rejectReasonCounts[code] ?? 0) + 1;
      });
      rejects.push({
        lineNumber: row.lineNumber,
        reasons: mapped.errors
      });
      continue;
    }

    const validation = validateProductAgainstContract(mapped.product, contract);
    if (validation.length > 0) {
      rejected += 1;
      validation.forEach((issue) => {
        rejectReasonCounts[issue.reason] = (rejectReasonCounts[issue.reason] ?? 0) + 1;
      });
      rejects.push({
        lineNumber: row.lineNumber,
        productId: mapped.product.productId,
        reasons: validation.map((v) => `${v.field}:${v.reason}`)
      });
      continue;
    }

    transformed += 1;
    if (mapped.product.status === "active") actives += 1;
    if (mapped.product.status === "draft") drafts += 1;

    const importHash = stableHashObject(mapped.product);
    mapped.product.attributes.import_hash = importHash;

    if (!config.dryRun && skipUnchanged && firestore) {
      const existing = await firestore.collection("ProductCatalog").doc(mapped.product.productId).get();
      if (existing.exists) {
        const data = existing.data() as Record<string, unknown>;
        const attributes = (data.attributes ?? {}) as Record<string, unknown>;
        if (attributes.import_hash === importHash) {
          skipped += 1;
          continue;
        }
      }
    }

    try {
      budget.reserve(1);
    } catch {
      stopReason = "budget_reached";
      skipped += 1;
      break;
    }

    await writer.add({
      collectionPath: "ProductCatalog",
      documentId: mapped.product.productId,
      payload: mapped.product,
      merge: true
    });
    written += 1;

    if (parsed % CHECKPOINT_SAVE_EVERY === 0) {
      const cp: ImportCheckpoint = {
        filePath,
        updatedAt: nowISO(),
        mode: "products",
        lineNumber: row.lineNumber,
        lastProductId: mapped.product.productId,
        totals: {
          scanned,
          written,
          skipped,
          rejected
        }
      };
      await saveCheckpoint(config, cp);
    }
  }

  const commit = await writer.close();
  budget.markExecuted(commit.executedWrites);

  if (typeof maxLines === "number" && scanned >= maxLines && stopReason === "completed") {
    stopReason = "max_lines_reached";
  }

  const finalCheckpoint: ImportCheckpoint = {
    filePath,
    updatedAt: nowISO(),
    mode: "products",
    lineNumber: scanned,
    totals: {
      scanned,
      written,
      skipped,
      rejected
    }
  };
  await saveCheckpoint(config, finalCheckpoint);

  await writeFile(
    resolveFromImporterRoot("output/invalid_products.json"),
    `${JSON.stringify(rejects.slice(0, 5000), null, 2)}\n`,
    "utf8"
  );

  const finishedAt = nowISO();

  if (config.runReportsEnabled) {
    await writeRunReport({
      mode: "products",
      dryRun: config.dryRun,
      startedAt,
      finishedAt,
      stopReason,
      metrics: {
        filePath,
        parsed,
        transformed,
        rejected,
        drafts,
        actives,
        scanned,
        written,
        skipped,
        plannedWrites: budget.plannedWrites,
        executedWrites: budget.executedWrites,
        warningCounts,
        rejectReasonCounts,
        maxWrites,
        maxLines,
        skipUnchanged,
        sinceDate: args.sinceDate ?? null,
        warnings: warningCounts
      },
      checkpoint: finalCheckpoint
    });
  }

  logger.info(
    {
      dryRun: config.dryRun,
      filePath,
      scanned,
      parsed,
      transformed,
      rejected,
      drafts,
      actives,
      written,
      skipped,
      plannedWrites: budget.plannedWrites,
      executedWrites: budget.executedWrites,
      stopReason
    },
    "Import products completed"
  );
}
