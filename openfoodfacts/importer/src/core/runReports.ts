import { mkdir, writeFile } from "node:fs/promises";
import path from "node:path";
import type { ImportCheckpoint } from "./types.js";
import { runReportDayPath } from "./paths.js";

export interface RunReportData {
  mode: "products" | "categories";
  dryRun: boolean;
  startedAt: string;
  finishedAt: string;
  stopReason: string;
  metrics: Record<string, unknown>;
  checkpoint?: ImportCheckpoint;
}

function dayStamp(isoDate: string): string {
  return isoDate.slice(0, 10);
}

export async function writeRunReport(report: RunReportData): Promise<{ dir: string }> {
  const day = dayStamp(report.startedAt);
  const dir = runReportDayPath(day);
  await mkdir(dir, { recursive: true });

  const jsonPath = path.resolve(dir, "run_report.json");
  const mdPath = path.resolve(dir, "run_report.md");
  const warningsPath = path.resolve(dir, "warnings.json");

  await writeFile(jsonPath, `${JSON.stringify(report, null, 2)}\n`, "utf8");

  const mdLines: string[] = [];
  mdLines.push("# Import Run Report");
  mdLines.push("");
  mdLines.push(`- Mode: ${report.mode}`);
  mdLines.push(`- Dry-run: ${String(report.dryRun)}`);
  mdLines.push(`- Started: ${report.startedAt}`);
  mdLines.push(`- Finished: ${report.finishedAt}`);
  mdLines.push(`- Stop reason: ${report.stopReason}`);
  mdLines.push("");
  mdLines.push("## Metrics");
  mdLines.push("");
  mdLines.push("| Key | Value |");
  mdLines.push("|---|---|");
  Object.entries(report.metrics)
    .sort((a, b) => a[0].localeCompare(b[0]))
    .forEach(([key, value]) => mdLines.push(`| ${key} | ${JSON.stringify(value)} |`));

  if (report.checkpoint) {
    mdLines.push("");
    mdLines.push("## Resume");
    mdLines.push("");
    mdLines.push(`- Next resume checkpoint line: ${report.checkpoint.lineNumber ?? "n/a"}`);
  }

  await writeFile(mdPath, `${mdLines.join("\n")}\n`, "utf8");

  const warnings = report.metrics.warnings;
  if (warnings !== undefined) {
    await writeFile(warningsPath, `${JSON.stringify(warnings, null, 2)}\n`, "utf8");
  }

  return { dir };
}
