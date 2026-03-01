import { mkdir } from "node:fs/promises";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { CHECKPOINT_FILE_NAME } from "./constants.js";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

export const importerRoot = path.resolve(__dirname, "../../");
export const outputRoot = path.resolve(importerRoot, "output");
export const docsRoot = path.resolve(importerRoot, "docs");

export function resolveFromImporterRoot(candidate: string): string {
  return path.isAbsolute(candidate)
    ? candidate
    : path.resolve(importerRoot, candidate);
}

export async function ensureOutputDir(): Promise<void> {
  await mkdir(outputRoot, { recursive: true });
}

export function checkpointFilePath(): string {
  return path.resolve(outputRoot, CHECKPOINT_FILE_NAME);
}
