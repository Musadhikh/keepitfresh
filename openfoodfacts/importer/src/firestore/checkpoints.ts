import { readFile, writeFile } from "node:fs/promises";
import { checkpointFilePath } from "../core/paths.js";
import type { CheckpointState } from "../core/types.js";

export async function loadCheckpoint(): Promise<CheckpointState | null> {
  const filePath = checkpointFilePath();
  try {
    const raw = await readFile(filePath, "utf8");
    return JSON.parse(raw) as CheckpointState;
  } catch {
    return null;
  }
}

export async function saveCheckpoint(state: CheckpointState): Promise<void> {
  const filePath = checkpointFilePath();
  await writeFile(filePath, `${JSON.stringify(state, null, 2)}\n`, "utf8");
}
