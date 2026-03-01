import { mkdir, readFile, writeFile } from "node:fs/promises";
import path from "node:path";
import { getSingaporeTodayISO } from "./rollout.js";
import { resolveFromImporterRoot } from "./paths.js";

interface DailyProgress {
  date: string;
  scanned: number;
  written: number;
  rejected: number;
  skipped: number;
}

interface ProgressState {
  version: 1;
  updatedAt: string;
  filePath: string;
  totalRowsTarget?: number;
  latestScannedLine: number;
  latestWrittenRows: number;
  pendingRows?: number;
  estimatedDaysRemaining?: number;
  estimationBasis?: string;
  daily: DailyProgress[];
}

interface ProgressUpdateInput {
  filePath: string;
  scanned: number;
  written: number;
  rejected: number;
  skipped: number;
  totalRowsTarget?: number;
}

function progressDirPath(): string {
  return resolveFromImporterRoot("output/progress");
}

function progressStatePath(): string {
  return resolveFromImporterRoot("output/progress/progress_state.json");
}

function progressCardPath(): string {
  return resolveFromImporterRoot("output/progress/progress_card.md");
}

async function readProgressState(): Promise<ProgressState | null> {
  try {
    const raw = await readFile(progressStatePath(), "utf8");
    return JSON.parse(raw) as ProgressState;
  } catch {
    return null;
  }
}

function pendingRows(totalRowsTarget: number | undefined, scanned: number): number | undefined {
  if (typeof totalRowsTarget !== "number" || !Number.isFinite(totalRowsTarget)) return undefined;
  return Math.max(0, totalRowsTarget - scanned);
}

function mergeDaily(existing: DailyProgress[], today: DailyProgress): DailyProgress[] {
  const byDate = new Map(existing.map((d) => [d.date, d]));
  byDate.set(today.date, today);
  return [...byDate.values()]
    .sort((a, b) => a.date.localeCompare(b.date))
    .slice(-30);
}

function estimateDaysRemaining(state: {
  pendingRows?: number;
  daily: DailyProgress[];
}): { days?: number; basis: string } {
  if (typeof state.pendingRows !== "number") {
    return { basis: "TOTAL_ROWS_TARGET not set" };
  }

  if (state.pendingRows <= 0) {
    return { days: 0, basis: "no pending rows" };
  }

  const recentWritten = state.daily
    .map((d) => d.written)
    .filter((v) => Number.isFinite(v) && v > 0);

  if (recentWritten.length === 0) {
    return { basis: "insufficient daily write history" };
  }

  const avgWrittenPerDay =
    recentWritten.reduce((sum, value) => sum + value, 0) / recentWritten.length;
  if (avgWrittenPerDay <= 0) {
    return { basis: "daily write average is zero" };
  }

  const days = Math.ceil(state.pendingRows / avgWrittenPerDay);
  return {
    days,
    basis: `avg ${Math.round(avgWrittenPerDay)} rows/day over ${recentWritten.length} day(s), assuming one run/day`
  };
}

function renderProgressCard(state: ProgressState): string {
  const lines: string[] = [];
  lines.push("# Import Progress Card");
  lines.push("");
  lines.push(`- Updated: ${state.updatedAt}`);
  lines.push(`- Source file: ${state.filePath}`);
  lines.push(`- Total rows target: ${state.totalRowsTarget ?? "not set"}`);
  lines.push(`- Rows written: ${state.latestWrittenRows}`);
  lines.push(`- Rows pending: ${state.pendingRows ?? "unknown (set TOTAL_ROWS_TARGET)"}`);
  lines.push(
    `- Estimated days remaining: ${
      state.estimatedDaysRemaining !== undefined ? state.estimatedDaysRemaining : "unknown"
    }`
  );
  lines.push(`- Estimation basis: ${state.estimationBasis ?? "n/a"}`);
  lines.push(`- Latest scanned line: ${state.latestScannedLine}`);
  lines.push("");
  lines.push("## Daily report (last 30 days)");
  lines.push("");
  lines.push("| Date | Scanned | Written | Rejected | Skipped |");
  lines.push("|---|---:|---:|---:|---:|");
  if (state.daily.length === 0) {
    lines.push("| - | 0 | 0 | 0 | 0 |");
  } else {
    state.daily.forEach((d) => {
      lines.push(`| ${d.date} | ${d.scanned} | ${d.written} | ${d.rejected} | ${d.skipped} |`);
    });
  }
  lines.push("");
  return `${lines.join("\n")}\n`;
}

export async function updateProgressCard(input: ProgressUpdateInput): Promise<void> {
  await mkdir(progressDirPath(), { recursive: true });

  const previous = await readProgressState();
  const todayISO = getSingaporeTodayISO();
  const totalRowsTarget = input.totalRowsTarget ?? previous?.totalRowsTarget;

  const latestScannedLine = Math.max(previous?.latestScannedLine ?? 0, input.scanned);
  const latestWrittenRows = latestScannedLine;

  const state: ProgressState = {
    version: 1,
    updatedAt: new Date().toISOString(),
    filePath: input.filePath,
    totalRowsTarget,
    latestScannedLine,
    latestWrittenRows,
    pendingRows: pendingRows(totalRowsTarget, latestScannedLine),
    estimatedDaysRemaining: undefined,
    estimationBasis: undefined,
    daily: mergeDaily(previous?.daily ?? [], {
      date: todayISO,
      scanned: input.scanned,
      written: input.written,
      rejected: input.rejected,
      skipped: input.skipped
    })
  };

  const estimate = estimateDaysRemaining({
    pendingRows: state.pendingRows,
    daily: state.daily
  });
  state.estimatedDaysRemaining = estimate.days;
  state.estimationBasis = estimate.basis;

  await writeFile(progressStatePath(), `${JSON.stringify(state, null, 2)}\n`, "utf8");
  await writeFile(progressCardPath(), renderProgressCard(state), "utf8");
}
