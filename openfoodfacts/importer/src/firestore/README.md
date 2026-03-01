# Firestore Layer

This folder contains the active Firestore integration used by importer commands.

## Current status
- Firebase Admin SDK client initialization is implemented.
- Batched writes + retry/backoff are implemented.
- Budget enforcement is active.
- Checkpointing supports file mode and optional Firestore mode.
- Safety guardrails remain active:
  - dry-run default
  - execute requires explicit gates
  - lock prevents overlapping runs

## Files
- `client.ts`: Firebase Admin setup and Firestore access.
- `batching.ts`: buffered batch writer with retry/backoff.
- `budget.ts`: strict per-run write budget helpers.
- `checkpoints.ts`: checkpoint load/save (file/firestore modes).
- `types.ts`: Firestore-like interfaces used by importer code.
