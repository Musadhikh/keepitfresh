# # Codex Prompt — Phase 0: Importer Project Setup + Safety Guardrails (NO UPLOADS)

You are working in the KeepItFresh repo. We have a huge file:
- `openfoodfacts-products.jsonl` (~67GB) inside the `openfoodfacts/` folder (same level where you will create the importer).

## Goal (Phase 0)
Create a new importer project scaffold inside:
- `openfoodfacts/importer/`

This phase is ONLY:
1) project structure + tooling
2) safety locks (dry-run by default, explicit execute flag)
3) config + logging + placeholder docs

Do NOT upload anything to Firestore. Do NOT add any cron/launchd scheduling yet.

---

## 0.1 Create folder structure
Create the following structure (create missing folders):

openfoodfacts/
  importer/
    docs/
      README.md
      README_HANDOFF.md
    src/
      cli/
        index.ts
        commands/
          sample.ts
          buildCategories.ts
          importCategories.ts
          importProducts.ts
      core/
        config.ts
        logger.ts
        paths.ts
        types.ts
        errors.ts
        constants.ts
      firestore/
        README.md
        client.ts
        batching.ts
        checkpoints.ts
        budget.ts
      utils/
        jsonl.ts
        hash.ts
        time.ts
        validate.ts
    output/
      .gitkeep
    scripts/
      run-sample.sh
      run-build-categories.sh
    tests/
      .gitkeep
    package.json
    tsconfig.json
    .gitignore
    .env.example

Notes:
- Use TypeScript + Node.js.
- Use streaming for JSONL (no loading full file).
- Ensure output files go to `openfoodfacts/importer/output/`.

---

## 0.2 Tooling choices (use these)
Use:
- Node 20+
- TypeScript
- `tsx` for running TS scripts (or `ts-node` if you prefer, but pick one)
- `pino` for logging (or a simple console logger if avoiding deps)
- `yargs` (or `commander`) for CLI parsing
- `dotenv` for env config

Add scripts in `package.json`:
- `lint` (optional)
- `typecheck`
- `sample` -> runs sample command
- `build:categories` -> runs category builder command
- `import:categories` -> runs category importer command (dry-run only, locked)
- `import:products` -> runs product importer command (dry-run only, locked)

All import scripts MUST default to dry-run and refuse to write unless `--execute` is provided.

---

## 0.3 Safety guardrails (must implement now)
Implement these guardrails in `src/core/config.ts` + shared helpers:

1) DRY RUN DEFAULT
- Every command accepts `--dry-run` (default true)
- `--execute` sets dryRun=false
- If both provided, `--execute` wins

2) HARD BLOCK UPLOADS UNTIL MANUAL ENABLE
Add a global env flag:
- `IMPORTER_UPLOADS_ENABLED=false` by default
- Even if `--execute` is passed, if `IMPORTER_UPLOADS_ENABLED` is not `true`, the importer MUST:
  - print a clear error message
  - exit with non-zero code
This ensures we can’t accidentally run uploads.

3) DAILY WRITE BUDGET (placeholder enforcement)
Create `src/firestore/budget.ts` that implements:
- config `MAX_WRITES_PER_RUN` default 10000
- counters for planned writes
- `checkBudgetOrThrow()` utility
For Phase 0 this can be a stub used by the import commands (no Firestore calls yet).

4) CHECKPOINTS (placeholder)
Create `src/firestore/checkpoints.ts` with an interface:
- `loadCheckpoint()` and `saveCheckpoint()`
For Phase 0, implement a local JSON checkpoint file:
- `openfoodfacts/importer/output/checkpoint.json`
No Firestore checkpointing yet.

5) BATCHING + CLIENT (stubs only)
Create `src/firestore/client.ts` and `src/firestore/batching.ts` as stubs:
- The code compiles
- Has clear TODOs
- No real Firestore admin SDK initialization in Phase 0
(We will add real Firestore later in Phase 5.)

---

## 0.4 JSONL utilities (real streaming)
Implement `src/utils/jsonl.ts` with:
- `createJsonlReader(filePath)` that yields parsed objects via async generator
- tolerant mode: skip invalid JSON lines and count errors
- include lineNumber and rawLine (optional) in error logs
- must be memory safe for huge files

Also implement `src/utils/hash.ts`:
- stable hash of JSON object (canonical stringify + sha256) for “changed-only writes” later

Implement `src/utils/time.ts`:
- helpers for timestamps and formatting (ISO)

---

## 0.5 CLI commands (Phase 0 behavior)
Implement CLI entry `src/cli/index.ts` with commands (yargs/commander):

### `sample`
- Arguments:
  - `--file` default `../openfoodfacts-products.jsonl` (resolve properly)
  - `--count` default 100
  - `--out` default `output/off_sample_100.json`
- Behavior:
  - reads JSONL stream
  - collects first N valid JSON objects
  - writes JSON array to output
  - writes stats to `output/off_sample_stats.json`:
    - totalLinesRead
    - validObjects
    - invalidLines
    - avgLineBytes
    - maxLineBytes

### `buildCategories`
- For Phase 0, implement as placeholder that:
  - reads sample file output
  - extracts any obvious “category-like” strings if present
  - writes `output/categories_preview.json` (can be empty now)
  - logs TODO for Phase 3

### `importCategories` and `importProducts`
- MUST exist but MUST NOT write.
- They should:
  - parse flags `--dry-run/--execute`
  - require `IMPORTER_UPLOADS_ENABLED=true` to proceed (even though no writes occur yet)
  - print: “Uploads are disabled. This command is locked in Phase 0.”
  - exit with non-zero if `--execute` is attempted

This ensures safety from day 0.

---

## 0.6 Docs + env template
Create `docs/README.md` describing:
- what importer is
- phases overview
- how to run sample command
- explicit statement: uploads disabled by default

Create `docs/README_HANDOFF.md` as a skeleton runbook with placeholders:
- prerequisites
- commands
- scheduling (TBD)
- troubleshooting (TBD)
- daily operation (TBD)

Create `.env.example` with:
- IMPORTER_UPLOADS_ENABLED=false
- MAX_WRITES_PER_RUN=10000
- IMPORT_FILE_PATH=../openfoodfacts-products.jsonl
- FIREBASE_PROJECT_ID= (blank)
- FIREBASE_SERVICE_ACCOUNT_JSON= (blank)

Create `.gitignore` to ignore:
- output/*.json (except .gitkeep)
- .env
- any service account files

---

## 0.7 Scripts (optional convenience)
Create:
- `scripts/run-sample.sh`
- `scripts/run-build-categories.sh`
These should call npm scripts with sane defaults.

---

## Acceptance criteria
- `npm install` works
- `npm run typecheck` passes
- `npm run sample` runs and generates the two output files (even if file path must be provided)
- `npm run import:products -- --execute` MUST fail with a clear message unless IMPORTER_UPLOADS_ENABLED=true (and still fail in Phase 0 because uploads are locked)
- Everything is committed-ready and safe-by-default

When done, list the created files and show example commands to run Phase 0 tasks.
#kif/ios/brain