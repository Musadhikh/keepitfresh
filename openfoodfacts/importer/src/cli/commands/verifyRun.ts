import { mkdir, readFile, writeFile } from "node:fs/promises";
import path from "node:path";
import { loadImporterConfig } from "../../core/config.js";
import { logger } from "../../core/logger.js";
import { getSingaporeTodayISO } from "../../core/rollout.js";
import { resolveFromImporterRoot } from "../../core/paths.js";
import { getFirestore } from "../../firestore/client.js";

interface RunReport {
  dryRun: boolean;
  metrics?: Record<string, unknown>;
}

export interface VerifyRunArgs {
  report?: string;
  out?: string;
  sampleSize?: number;
}

function toStringArray(value: unknown): string[] {
  if (!Array.isArray(value)) return [];
  return value.filter((x): x is string => typeof x === "string");
}

function readOnlyChecksMarkdown(lines: string[]): string {
  return `${lines.join("\n")}\n`;
}

export async function runVerifyRunCommand(args: VerifyRunArgs): Promise<void> {
  const day = getSingaporeTodayISO();
  const reportPath = resolveFromImporterRoot(
    args.report ?? `output/run_reports/${day}/run_report.json`
  );
  const outPath = resolveFromImporterRoot(
    args.out ?? `output/run_reports/${day}/verify_report.md`
  );
  const sampleSize = Math.max(1, args.sampleSize ?? 10);

  const raw = await readFile(reportPath, "utf8");
  const report = JSON.parse(raw) as RunReport;
  const metrics = report.metrics ?? {};
  const sampledIds = toStringArray(metrics.writtenProductIdsSample).slice(0, sampleSize);
  const executedWrites = Number(metrics.executedWrites ?? 0);

  const lines: string[] = [];
  lines.push("# Verify Run Report");
  lines.push("");
  lines.push(`- Source report: ${reportPath}`);
  lines.push(`- Dry-run: ${String(report.dryRun)}`);
  lines.push(`- Executed writes: ${executedWrites}`);
  lines.push(`- Sample size requested: ${sampleSize}`);
  lines.push("");

  if (report.dryRun || executedWrites <= 0) {
    lines.push("No remote writes to verify (dry-run or zero writes).");
    await mkdir(path.dirname(outPath), { recursive: true });
    await writeFile(outPath, readOnlyChecksMarkdown(lines), "utf8");
    logger.info({ outPath }, "Verify run completed (dry-run/no writes)");
    return;
  }

  if (sampledIds.length === 0) {
    lines.push("No sampled product IDs found in run report; unable to verify documents.");
    await mkdir(path.dirname(outPath), { recursive: true });
    await writeFile(outPath, readOnlyChecksMarkdown(lines), "utf8");
    logger.warn({ outPath }, "Verify run completed with missing sampled IDs");
    return;
  }

  const config = loadImporterConfig({ dryRun: true });
  let firestore;
  try {
    firestore = await getFirestore(config);
  } catch (error) {
    lines.push("Firestore verification skipped: missing/invalid Firebase read configuration.");
    lines.push(`- Error: ${String((error as Error).message ?? error)}`);
    await mkdir(path.dirname(outPath), { recursive: true });
    await writeFile(outPath, readOnlyChecksMarkdown(lines), "utf8");
    logger.warn({ outPath }, "Verify run completed without Firestore access");
    return;
  }

  let verified = 0;
  let missing = 0;
  const failures: string[] = [];

  for (const id of sampledIds) {
    const doc = await firestore.collection("ProductCatalog").doc(id).get();
    if (!doc.exists) {
      missing += 1;
      failures.push(`${id}: missing doc`);
      continue;
    }
    const data = (doc.data() ?? {}) as Record<string, unknown>;
    const productId = data.productId;
    const source = data.source;
    const attributes = (data.attributes ?? {}) as Record<string, unknown>;
    if (productId !== id) failures.push(`${id}: productId mismatch`);
    if (source !== "importedFeed") failures.push(`${id}: source not importedFeed`);
    if (attributes.importSource !== "open_food_facts") {
      failures.push(`${id}: attributes.importSource not open_food_facts`);
    }
    verified += 1;
  }

  lines.push(`- Sampled IDs: ${sampledIds.length}`);
  lines.push(`- Verified docs found: ${verified}`);
  lines.push(`- Missing docs: ${missing}`);
  lines.push(`- Failures: ${failures.length}`);
  lines.push("");
  lines.push("## Failures");
  lines.push("");
  if (failures.length === 0) {
    lines.push("- none");
  } else {
    failures.forEach((f) => lines.push(`- ${f}`));
  }

  await mkdir(path.dirname(outPath), { recursive: true });
  await writeFile(outPath, readOnlyChecksMarkdown(lines), "utf8");
  logger.info({ outPath, verified, missing, failures: failures.length }, "Verify run completed");
}
