export interface DocumentSnapshotLike {
  exists: boolean;
  data(): unknown;
}

export interface DocumentRefLike {
  get(): Promise<DocumentSnapshotLike>;
  set(payload: unknown, options?: { merge?: boolean }): Promise<unknown>;
}

export interface CollectionRefLike {
  doc(id: string): DocumentRefLike;
}

export interface WriteBatchLike {
  set(docRef: DocumentRefLike, payload: unknown, options?: { merge?: boolean }): void;
  commit(): Promise<unknown>;
}

export interface FirestoreLike {
  batch(): WriteBatchLike;
  collection(path: string): CollectionRefLike;
}
