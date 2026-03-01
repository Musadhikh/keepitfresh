import { logger } from "../../core/logger.js";
import {
  getSingaporeTodayISO,
  loadRolloutPlan,
  writeRolloutPlanPreview
} from "../../core/rollout.js";

export interface RolloutPlanArgs {
  out?: string;
  activateFrom?: string;
  planFile?: string;
}

export async function runRolloutPlanCommand(args: RolloutPlanArgs): Promise<void> {
  const out = args.out ?? "output/rollout/rollout_plan.json";
  const activateFrom = args.activateFrom ?? getSingaporeTodayISO();
  const plan = await loadRolloutPlan(args.planFile);
  const written = await writeRolloutPlanPreview({
    outPath: out,
    activateFromISO: activateFrom,
    plan
  });

  logger.info(
    {
      outJson: written.jsonPath,
      outMd: written.mdPath,
      activateFrom,
      timezone: plan.timezone
    },
    "Rollout plan preview generated"
  );
}

