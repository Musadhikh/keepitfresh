import { BudgetExceededError } from "../core/errors.js";

export class WriteBudget {
  public plannedWrites = 0;
  public executedWrites = 0;

  constructor(public readonly maxWritesPerRun: number) {}

  reserve(count: number): void {
    if (count <= 0) return;
    if (this.plannedWrites + count > this.maxWritesPerRun) {
      throw new BudgetExceededError(
        `Write budget exceeded: trying to reserve ${count} with ${this.remaining()} remaining.`
      );
    }
    this.plannedWrites += count;
  }

  markExecuted(count: number): void {
    if (count <= 0) return;
    this.executedWrites += count;
  }

  remaining(): number {
    return this.maxWritesPerRun - this.plannedWrites;
  }
}
