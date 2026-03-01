/**
 * Phase 0 stub. Firestore Admin SDK is intentionally not initialized yet.
 * TODO(Phase 5): add real Firestore client wiring.
 */
export interface FirestoreClient {
  readonly projectId?: string;
}

export function createFirestoreClient(): never {
  throw new Error("Firestore client is not available in Phase 0.");
}
