export interface CommandRuntimeOptions {
  dryRun?: boolean;
  execute?: boolean;
}

export interface ImporterConfig {
  dryRun: boolean;
  uploadsEnabled: boolean;
  maxWritesPerRun: number;
  batchSize: number;
  importFilePath: string;
  maxLinesPerRun?: number;
  checkpointMode: "file" | "firestore";
  checkpointDocId: string;
  lockFilePath: string;
  runReportsEnabled: boolean;
  firebaseProjectId?: string;
  firebaseServiceAccountJson?: string;
  firebaseServiceAccountPath?: string;
}

export interface ImportCheckpoint {
  filePath: string;
  lineNumber: number;
  updatedAt: string;
  mode: "products" | "categories";
  bytesOffset?: number;
  lastProductId?: string;
  totals: {
    scanned: number;
    written: number;
    skipped: number;
    rejected: number;
  };
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
