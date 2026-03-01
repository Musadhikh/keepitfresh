import os from "node:os";
import { open, readFile, unlink } from "node:fs/promises";
import { existsSync, statSync } from "node:fs";

interface LockMetadata {
  pid: number;
  startedAt: string;
  command?: string;
  hostname: string;
}

export async function acquireLock(lockPath: string): Promise<void> {
  const handle = await open(lockPath, "wx");
  try {
    const metadata: LockMetadata = {
      pid: process.pid,
      startedAt: new Date().toISOString(),
      command: process.argv.join(" "),
      hostname: os.hostname()
    };
    await handle.writeFile(`${JSON.stringify(metadata, null, 2)}\n`, "utf8");
  } finally {
    await handle.close();
  }
}

export async function releaseLock(lockPath: string): Promise<void> {
  try {
    await unlink(lockPath);
  } catch (error) {
    const code = (error as NodeJS.ErrnoException).code;
    if (code !== "ENOENT") {
      throw error;
    }
  }
}

export function isLockStale(lockPath: string, maxAgeMinutes: number): boolean {
  if (!existsSync(lockPath)) return false;
  try {
    const stat = statSync(lockPath);
    const ageMs = Date.now() - stat.mtimeMs;
    return ageMs > maxAgeMinutes * 60_000;
  } catch {
    return false;
  }
}

export async function readLockMetadata(lockPath: string): Promise<string | null> {
  try {
    return await readFile(lockPath, "utf8");
  } catch {
    return null;
  }
}

