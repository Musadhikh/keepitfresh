import dotenv from "dotenv";
import {
  DEFAULT_BATCH_SIZE,
  DEFAULT_CHECKPOINT_DOC_ID,
  DEFAULT_CHECKPOINT_MODE,
  DEFAULT_IMPORT_FILE_PATH,
  DEFAULT_MAX_WRITES_PER_RUN
} from "./constants.js";
import { ConfigError } from "./errors.js";
import type { CommandRuntimeOptions, ImporterConfig } from "./types.js";
import { resolveFromImporterRoot } from "./paths.js";

dotenv.config();

function parseBoolean(value: string | undefined, fallback: boolean): boolean {
  if (value == null || value.trim() === "") return fallback;
  return value.trim().toLowerCase() === "true";
}

function parsePositiveInt(value: string | undefined, fallback: number): number {
  if (value == null || value.trim() === "") return fallback;
  const parsed = Number.parseInt(value, 10);
  if (!Number.isFinite(parsed) || parsed <= 0) return fallback;
  return parsed;
}

export function resolveDryRun(options: CommandRuntimeOptions): boolean {
  if (options.execute === true) return false;
  if (typeof options.dryRun === "boolean") return options.dryRun;
  return true;
}

export function loadImporterConfig(options: CommandRuntimeOptions): ImporterConfig {
  const dryRun = resolveDryRun(options);
  const uploadsEnabled = parseBoolean(process.env.IMPORTER_UPLOADS_ENABLED, false);
  const maxWritesPerRun = parsePositiveInt(
    process.env.MAX_WRITES_PER_RUN,
    DEFAULT_MAX_WRITES_PER_RUN
  );
  const batchSize = parsePositiveInt(process.env.BATCH_SIZE, DEFAULT_BATCH_SIZE);
  const importFilePath = resolveFromImporterRoot(
    process.env.IMPORT_FILE_PATH ?? DEFAULT_IMPORT_FILE_PATH
  );
  const maxLinesPerRun = process.env.MAX_LINES_PER_RUN
    ? parsePositiveInt(process.env.MAX_LINES_PER_RUN, Number.MAX_SAFE_INTEGER)
    : undefined;

  const checkpointMode =
    process.env.CHECKPOINT_MODE === "firestore" ? "firestore" : DEFAULT_CHECKPOINT_MODE;
  const checkpointDocId = process.env.CHECKPOINT_DOC_ID?.trim() || DEFAULT_CHECKPOINT_DOC_ID;
  const runReportsEnabled = parseBoolean(process.env.RUN_REPORTS_ENABLED, true);

  const firebaseProjectId = process.env.FIREBASE_PROJECT_ID?.trim() || undefined;
  const firebaseServiceAccountJson =
    process.env.FIREBASE_SERVICE_ACCOUNT_JSON?.trim() || undefined;
  const firebaseServiceAccountPath = process.env.FIREBASE_SERVICE_ACCOUNT_PATH?.trim()
    ? resolveFromImporterRoot(process.env.FIREBASE_SERVICE_ACCOUNT_PATH)
    : undefined;

  return {
    dryRun,
    uploadsEnabled,
    maxWritesPerRun,
    batchSize,
    importFilePath,
    maxLinesPerRun,
    checkpointMode,
    checkpointDocId,
    runReportsEnabled,
    firebaseProjectId,
    firebaseServiceAccountJson,
    firebaseServiceAccountPath
  };
}

export function assertUploadsEnabled(config: ImporterConfig): void {
  if (!config.uploadsEnabled) {
    throw new ConfigError(
      "Uploads are disabled. Set IMPORTER_UPLOADS_ENABLED=true to allow execute mode."
    );
  }
}

export function assertExecuteCredentials(config: ImporterConfig): void {
  if (!config.firebaseProjectId) {
    throw new ConfigError("FIREBASE_PROJECT_ID is required for execute mode.");
  }

  if (!config.firebaseServiceAccountJson && !config.firebaseServiceAccountPath) {
    throw new ConfigError(
      "FIREBASE_SERVICE_ACCOUNT_JSON or FIREBASE_SERVICE_ACCOUNT_PATH is required for execute mode."
    );
  }
}
