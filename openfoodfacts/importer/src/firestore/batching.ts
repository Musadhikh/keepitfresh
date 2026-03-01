/**
 * Phase 0 stub. No remote batching/commits are allowed yet.
 * TODO(Phase 5): implement Firestore batched writes and retry strategy.
 */

export interface PendingWrite {
  collectionPath: string;
  documentId: string;
  payload: Record<string, unknown>;
}

export function createWriteBatches(_writes: PendingWrite[]): never {
  throw new Error("Batching is locked in Phase 0.");
}
