import type { ImporterConfig } from "../core/types.js";
import type { FirestoreLike } from "./types.js";

export interface PendingWrite {
  collectionPath: string;
  documentId: string;
  payload: unknown;
  merge?: boolean;
}

export interface BatchCommitResult {
  plannedWrites: number;
  executedWrites: number;
}

function sanitizeUndefinedDeep(value: unknown): unknown {
  if (Array.isArray(value)) {
    return value
      .map((item) => sanitizeUndefinedDeep(item))
      .filter((item) => item !== undefined);
  }

  if (value && typeof value === "object") {
    const entries = Object.entries(value as Record<string, unknown>)
      .map(([key, nested]) => [key, sanitizeUndefinedDeep(nested)] as const)
      .filter(([, nested]) => nested !== undefined);

    return Object.fromEntries(entries);
  }

  return value === undefined ? undefined : value;
}

function sleep(ms: number): Promise<void> {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

function isRetryableFirestoreError(error: unknown): boolean {
  const message = String((error as Error)?.message ?? "").toUpperCase();
  return (
    message.includes("RESOURCE_EXHAUSTED") ||
    message.includes("DEADLINE_EXCEEDED") ||
    message.includes("UNAVAILABLE") ||
    message.includes("429") ||
    message.includes("503")
  );
}

async function commitWithRetry(
  commit: () => Promise<unknown>,
  maxAttempts = 8
): Promise<void> {
  let attempt = 0;
  let backoffMs = 300;

  while (attempt < maxAttempts) {
    attempt += 1;
    try {
      await commit();
      return;
    } catch (error) {
      if (!isRetryableFirestoreError(error) || attempt >= maxAttempts) {
        throw error;
      }

      const jitter = Math.floor(Math.random() * 200);
      await sleep(backoffMs + jitter);
      backoffMs = Math.min(8000, backoffMs * 2);
    }
  }
}

export class BatchWriter {
  private buffer: PendingWrite[] = [];
  private plannedWrites = 0;
  private executedWrites = 0;

  constructor(
    private readonly firestore: FirestoreLike | null,
    private readonly config: ImporterConfig
  ) {}

  async add(write: PendingWrite): Promise<void> {
    this.buffer.push(write);
    this.plannedWrites += 1;

    if (this.buffer.length >= this.config.batchSize) {
      await this.flush();
    }
  }

  async flush(): Promise<void> {
    if (this.buffer.length === 0) return;

    if (this.config.dryRun) {
      this.executedWrites += this.buffer.length;
      this.buffer = [];
      return;
    }

    if (!this.firestore) {
      throw new Error("Firestore instance is required for execute mode.");
    }

    const toCommit = this.buffer;
    this.buffer = [];

    const batch = this.firestore.batch();
    for (const write of toCommit) {
      const docRef = this.firestore.collection(write.collectionPath).doc(write.documentId);
      const sanitizedPayload = sanitizeUndefinedDeep(write.payload);
      batch.set(docRef, sanitizedPayload, { merge: write.merge ?? true });
    }

    await commitWithRetry(() => batch.commit());
    this.executedWrites += toCommit.length;
  }

  async close(): Promise<BatchCommitResult> {
    await this.flush();
    return {
      plannedWrites: this.plannedWrites,
      executedWrites: this.executedWrites
    };
  }
}
