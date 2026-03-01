import { loadImporterConfig, assertUploadsEnabled } from "../../core/config.js";
import { logger } from "../../core/logger.js";
import { ConfigError } from "../../core/errors.js";
import { checkBudgetOrThrow, createWriteBudget, planWrites } from "../../firestore/budget.js";
import { loadCheckpoint } from "../../firestore/checkpoints.js";

export interface ImportCategoriesArgs {
  dryRun?: boolean;
  execute?: boolean;
}

export async function runImportCategoriesCommand(args: ImportCategoriesArgs): Promise<void> {
  const config = loadImporterConfig(args);
  const budget = createWriteBudget(config.maxWritesPerRun);
  planWrites(budget, 0);
  checkBudgetOrThrow(budget);
  const checkpoint = await loadCheckpoint();

  logger.info(
    {
      dryRun: config.dryRun,
      uploadsEnabled: config.uploadsEnabled,
      checkpoint
    },
    "Phase 0 importCategories invoked"
  );

  if (!config.dryRun) {
    assertUploadsEnabled(config);
    throw new ConfigError("Uploads are disabled. This command is locked in Phase 0.");
  }

  logger.warn("Uploads are disabled. This command is locked in Phase 0.");
}
