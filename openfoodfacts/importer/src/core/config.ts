import dotenv from "dotenv";
import {
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
  const importFilePath = resolveFromImporterRoot(
    process.env.IMPORT_FILE_PATH ?? DEFAULT_IMPORT_FILE_PATH
  );

  return {
    dryRun,
    uploadsEnabled,
    maxWritesPerRun,
    importFilePath
  };
}

export function assertUploadsEnabled(config: ImporterConfig): void {
  if (!config.uploadsEnabled) {
    throw new ConfigError(
      "Uploads are disabled. Set IMPORTER_UPLOADS_ENABLED=true to allow execute mode."
    );
  }
}
