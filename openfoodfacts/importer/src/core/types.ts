export interface CommandRuntimeOptions {
  dryRun?: boolean;
  execute?: boolean;
}

export interface ImporterConfig {
  dryRun: boolean;
  uploadsEnabled: boolean;
  maxWritesPerRun: number;
  importFilePath: string;
}

export interface CheckpointState {
  lineNumber: number;
  updatedAtISO: string;
  meta?: Record<string, unknown>;
}

export interface JsonlParseError {
  lineNumber: number;
  rawLine?: string;
  error: unknown;
}

export interface JsonlStats {
  totalLinesRead: number;
  validObjects: number;
  invalidLines: number;
  avgLineBytes: number;
  maxLineBytes: number;
}
