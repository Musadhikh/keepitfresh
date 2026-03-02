import { readFile } from "node:fs/promises";
import {
  assertExecuteCredentials,
  assertExecutionAck,
  assertUploadsEnabled,
  loadImporterConfig
} from "../../core/config.js";
import { DEFAULT_LOCK_STALE_MINUTES } from "../../core/constants.js";
import { acquireLock, isLockStale, readLockMetadata, releaseLock } from "../../core/lock.js";
import { logger } from "../../core/logger.js";
import { lockFilePath } from "../../core/paths.js";
import { writeRunReport } from "../../core/runReports.js";
import type { CommandRuntimeOptions } from "../../core/types.js";
import { nowISO } from "../../utils/time.js";
import { BatchWriter } from "../../firestore/batching.js";
import { WriteBudget } from "../../firestore/budget.js";
import { getFirestore } from "../../firestore/client.js";
import { loadCheckpoint, saveCheckpoint } from "../../firestore/checkpoints.js";
import { resolveFromImporterRoot } from "../../core/paths.js";

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

interface CategoriesPreview {
  categories: CategoryDoc[];
}

interface ContractField {
  name: string;
}

interface Contract {
  collections?: {
    ProductCategories?: {
      fields?: ContractField[];
    };
  };
}

export interface ImportCategoriesArgs extends CommandRuntimeOptions {
  in?: string;
  maxWrites?: number;
  iKnowWhatImDoing?: boolean;
}

function categoryFirestoreDocumentId(categoryId: string): string {
  return categoryId.replaceAll("/", "__");
}

function validateCategoryShape(doc: CategoryDoc, requiredFields: string[]): string[] {
  const errors: string[] = [];
  for (const field of requiredFields) {
    if ((doc as unknown as Record<string, unknown>)[field] === undefined) {
      errors.push(`missing_${field}`);
    }
  }
  if (!doc.id || !doc.main || !doc.sub) {
    errors.push("invalid_identity");
  }
  return errors;
}

export async function runImportCategoriesCommand(args: ImportCategoriesArgs): Promise<void> {
  const config = loadImporterConfig(args);
  const startedAt = nowISO();
  const importLockPath = lockFilePath(config.lockFilePath);
  let acquiredLock = false;

  try {
    if (isLockStale(importLockPath, DEFAULT_LOCK_STALE_MINUTES)) {
      logger.warn({ importLockPath }, "Stale import lock detected; removing it before proceeding");
      await releaseLock(importLockPath);
    }

    try {
      await acquireLock(importLockPath);
      acquiredLock = true;
    } catch {
      const existing = await readLockMetadata(importLockPath);
      throw new Error(
        `Another import run is active. Lock file exists at ${importLockPath}.` +
          (existing ? ` Metadata: ${existing.trim()}` : "")
      );
    }

    if (!config.dryRun) {
      if (!args.iKnowWhatImDoing) {
        throw new Error(
          "Category execute mode requires --i-know-what-im-doing. Categories should be imported rarely."
        );
      }
      assertUploadsEnabled(config);
      assertExecutionAck(config);
      assertExecuteCredentials(config);
    }

    const inPath = resolveFromImporterRoot(args.in ?? "output/categories_preview.json");
    const contractPath = resolveFromImporterRoot("docs/product_storage_contract_v1.json");

    const preview = JSON.parse(await readFile(inPath, "utf8")) as CategoriesPreview;
    const contract = JSON.parse(await readFile(contractPath, "utf8")) as Contract;

    const requiredFields =
      contract.collections?.ProductCategories?.fields
        ?.map((field) => field.name)
        .filter((name) => ["id", "main", "sub", "version", "createdAt", "updatedAt"].includes(name)) ??
      ["id", "main", "sub", "version", "createdAt", "updatedAt"];

    const maxWrites = args.maxWrites ?? config.maxWritesPerRun;
    const budget = new WriteBudget(maxWrites);

    const firestore = config.dryRun ? null : await getFirestore(config);
    const writer = new BatchWriter(firestore, config);

    const warnings: Array<{ categoryId?: string; reason: string }> = [];
    let scanned = 0;
    let written = 0;
    let skipped = 0;
    let rejected = 0;

    for (const category of preview.categories ?? []) {
      scanned += 1;

      const errors = validateCategoryShape(category, requiredFields);
      if (errors.length > 0) {
        rejected += 1;
        warnings.push({ categoryId: category.id, reason: errors.join(",") });
        continue;
      }

      try {
        budget.reserve(1);
      } catch {
        skipped += 1;
        warnings.push({ categoryId: category.id, reason: "budget_reached" });
        break;
      }

      await writer.add({
        collectionPath: "ProductCategories",
        documentId: categoryFirestoreDocumentId(category.id),
        payload: category,
        merge: true
      });
      written += 1;
    }

    const commit = await writer.close();
    budget.markExecuted(commit.executedWrites);

    const checkpoint = {
      filePath: inPath,
      updatedAt: nowISO(),
      mode: "categories" as const,
      lineNumber: scanned,
      totals: {
        scanned,
        written,
        skipped,
        rejected
      }
    };

    await saveCheckpoint(config, checkpoint);
    const loaded = await loadCheckpoint(config);

    const finishedAt = nowISO();

    if (config.runReportsEnabled) {
      await writeRunReport({
        mode: "categories",
        dryRun: config.dryRun,
        startedAt,
        finishedAt,
        stopReason: skipped > 0 ? "budget_reached" : "completed",
        metrics: {
          scanned,
          written,
          skipped,
          rejected,
          plannedWrites: budget.plannedWrites,
          executedWrites: budget.executedWrites,
          warnings
        },
        checkpoint: loaded ?? checkpoint
      });
    }

    logger.info(
      {
        dryRun: config.dryRun,
        inPath,
        scanned,
        written,
        skipped,
        rejected,
        plannedWrites: budget.plannedWrites,
        executedWrites: budget.executedWrites
      },
      "Import categories completed"
    );
  } finally {
    if (acquiredLock) {
      await releaseLock(importLockPath);
    }
  }
}
