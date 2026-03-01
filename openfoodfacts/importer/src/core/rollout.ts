import { mkdir, readFile, writeFile } from "node:fs/promises";
import path from "node:path";
import { resolveFromImporterRoot } from "./paths.js";

export interface RolloutStage {
  dayIndex: number;
  maxWrites: number;
  note?: string;
}

export interface RolloutPlan {
  version: 1;
  timezone: "Asia/Singapore";
  stages: RolloutStage[];
  steadyStateMaxWrites: number;
}

export interface RolloutResolvedCap {
  dayIndex: number;
  maxWrites: number;
  source: "stage" | "steady_state";
}

const DEFAULT_ROLLOUT_PLAN: RolloutPlan = {
  version: 1,
  timezone: "Asia/Singapore",
  stages: [
    { dayIndex: 1, maxWrites: 200, note: "Initial safety run" },
    { dayIndex: 2, maxWrites: 1000, note: "Ramp step 2" },
    { dayIndex: 3, maxWrites: 3000, note: "Ramp step 3" }
  ],
  steadyStateMaxWrites: 10000
};

function toDateISO(value: Date): string {
  return new Intl.DateTimeFormat("en-CA", {
    timeZone: "Asia/Singapore",
    year: "numeric",
    month: "2-digit",
    day: "2-digit"
  }).format(value);
}

function parseDateISO(dateISO: string): Date {
  const match = /^(\d{4})-(\d{2})-(\d{2})$/.exec(dateISO);
  if (!match) {
    throw new Error(`Invalid date format: ${dateISO}. Expected YYYY-MM-DD`);
  }
  const [, y, m, d] = match;
  return new Date(Date.UTC(Number(y), Number(m) - 1, Number(d)));
}

function dayDiff(activationDateISO: string, dateISO: string): number {
  const activation = parseDateISO(activationDateISO);
  const date = parseDateISO(dateISO);
  const diffMs = date.getTime() - activation.getTime();
  return Math.floor(diffMs / 86_400_000);
}

export function getSingaporeTodayISO(now = new Date()): string {
  return toDateISO(now);
}

export function getMaxWritesForDate(
  plan: RolloutPlan,
  dateISO: string,
  activationDateISO: string
): RolloutResolvedCap {
  const diff = dayDiff(activationDateISO, dateISO);
  const dayIndex = Math.max(1, diff + 1);
  const stage = plan.stages.find((s) => s.dayIndex === dayIndex);
  if (stage) {
    return { dayIndex, maxWrites: stage.maxWrites, source: "stage" };
  }
  return { dayIndex, maxWrites: plan.steadyStateMaxWrites, source: "steady_state" };
}

export async function loadRolloutPlan(filePath?: string): Promise<RolloutPlan> {
  if (!filePath) return DEFAULT_ROLLOUT_PLAN;
  const resolved = resolveFromImporterRoot(filePath);
  const raw = await readFile(resolved, "utf8");
  return JSON.parse(raw) as RolloutPlan;
}

export async function writeRolloutPlanPreview(options: {
  outPath: string;
  activateFromISO: string;
  plan: RolloutPlan;
}): Promise<{ jsonPath: string; mdPath: string }> {
  const jsonPath = resolveFromImporterRoot(options.outPath);
  const mdPath = jsonPath.endsWith(".json")
    ? jsonPath.replace(/\.json$/i, ".md")
    : `${jsonPath}.md`;

  await mkdir(path.dirname(jsonPath), { recursive: true });

  const rows = Array.from({ length: 14 }).map((_, idx) => {
    const date = parseDateISO(options.activateFromISO);
    const next = new Date(date.getTime() + idx * 86_400_000);
    const dateISO = toDateISO(next);
    const cap = getMaxWritesForDate(options.plan, dateISO, options.activateFromISO);
    return { dateISO, ...cap };
  });

  const payload = {
    generatedAt: new Date().toISOString(),
    activateFrom: options.activateFromISO,
    plan: options.plan,
    preview: rows
  };

  const md: string[] = [];
  md.push("# Rollout Plan Preview");
  md.push("");
  md.push(`- Timezone: ${options.plan.timezone}`);
  md.push(`- Activate from: ${options.activateFromISO}`);
  md.push(`- Steady state max writes: ${options.plan.steadyStateMaxWrites}`);
  md.push("");
  md.push("| Date | Day Index | Max Writes | Source |");
  md.push("|---|---:|---:|---|");
  rows.forEach((row) => {
    md.push(`| ${row.dateISO} | ${row.dayIndex} | ${row.maxWrites} | ${row.source} |`);
  });

  await writeFile(jsonPath, `${JSON.stringify(payload, null, 2)}\n`, "utf8");
  await writeFile(mdPath, `${md.join("\n")}\n`, "utf8");
  return { jsonPath, mdPath };
}

