# Firestore Layer (Phase 0)

This folder contains placeholders only for Firestore integration.

## Phase 0 status
- No Firebase Admin SDK initialization.
- No remote writes.
- Safety guardrails are active (dry-run default, execute lock, upload env lock).

## Files
- `client.ts`: client stub for future Admin SDK wiring.
- `batching.ts`: batch planner/committer stubs.
- `checkpoints.ts`: local checkpoint file implementation.
- `budget.ts`: write-budget enforcement helpers.

Real Firestore implementation will be added in later phases.
