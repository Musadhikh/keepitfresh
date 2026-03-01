import { BudgetExceededError } from "../core/errors.js";

export interface WriteBudget {
  readonly maxWritesPerRun: number;
  plannedWrites: number;
}

export function createWriteBudget(maxWritesPerRun: number): WriteBudget {
  return {
    maxWritesPerRun,
    plannedWrites: 0
  };
}

export function planWrites(budget: WriteBudget, count: number): void {
  budget.plannedWrites += count;
}

export function checkBudgetOrThrow(budget: WriteBudget): void {
  if (budget.plannedWrites > budget.maxWritesPerRun) {
    throw new BudgetExceededError(
      `Planned writes (${budget.plannedWrites}) exceed MAX_WRITES_PER_RUN (${budget.maxWritesPerRun}).`
    );
  }
}
