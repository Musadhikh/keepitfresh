import { readFile, writeFile } from "node:fs/promises";
import { checkpointFilePath } from "../core/paths.js";
import type { ImportCheckpoint, ImporterConfig } from "../core/types.js";
import { getFirestore } from "./client.js";

const CHECKPOINT_COLLECTION = "ImportCheckpoints";

export async function loadCheckpoint(config: ImporterConfig): Promise<ImportCheckpoint | null> {
  if (config.checkpointMode === "firestore") {
    const firestore = await getFirestore(config);
    const doc = await firestore.collection(CHECKPOINT_COLLECTION).doc(config.checkpointDocId).get();
    if (!doc.exists) return null;
    return doc.data() as ImportCheckpoint;
  }

  const filePath = checkpointFilePath();
  try {
    const raw = await readFile(filePath, "utf8");
    return JSON.parse(raw) as ImportCheckpoint;
  } catch {
    return null;
  }
}

export async function saveCheckpoint(
  config: ImporterConfig,
  checkpoint: ImportCheckpoint
): Promise<void> {
  if (config.checkpointMode === "firestore") {
    const firestore = await getFirestore(config);
    await firestore.collection(CHECKPOINT_COLLECTION).doc(config.checkpointDocId).set(checkpoint, {
      merge: true
    });
    return;
  }

  const filePath = checkpointFilePath();
  await writeFile(filePath, `${JSON.stringify(checkpoint, null, 2)}\n`, "utf8");
}
