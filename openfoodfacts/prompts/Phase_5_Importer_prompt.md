# # Codex Prompt — Phase 5: Firestore Writer + Checkpointing + Budget Enforcement (DRY-RUN DEFAULT)

You are working in the KeepItFresh repo under:
- `openfoodfacts/importer/`

Previous phases exist:
- Phase 1 contract: `docs/product_storage_contract_v1.json`
- Phase 3 category mapping: `docs/category_mapping_rules_v1.json` + `output/categories_preview.json`
- Phase 4 transformer: `src/mapping/off_to_product.ts` and commands `transform:sample`, `validate:products`

Now implement Phase 5:
Add real Firestore integration for importing **categories and products** with:
- idempotent upserts
- checkpoint/resume
- strict per-run write budget (default 10,000)
- batching + retry/backoff
- run reporting
- DRY-RUN by default + global uploads gate

Do NOT schedule daily runs yet (that is Phase 6).
Do NOT start any uploads automatically.
All writes must be explicitly enabled.

---

## Hard constraints
1) DRY-RUN must be the default for all import commands.
2) Uploads must be blocked unless BOTH conditions are met:
   - CLI flag `--execute` is provided
   - env `IMPORTER_UPLOADS_ENABLED=true`
3) Enforce `MAX_WRITES_PER_RUN` (default 10000) strictly.
4) Must be resumable via checkpoints.
5) Must be memory safe (stream JSONL).
6) Must be robust: retry with exponential backoff on quota/429/RESOURCE_EXHAUSTED.

---

## Firestore target collections
- Products: `ProductCatalog` (docId = productId)
- Categories: `ProductCategories` (docId = category id slug)

---

## Environment + config
Update `.env.example` and `src/core/config.ts` to include:

Required for execute mode:
- `FIREBASE_PROJECT_ID`
- `FIREBASE_SERVICE_ACCOUNT_JSON` (JSON string) OR `FIREBASE_SERVICE_ACCOUNT_PATH`

Other config:
- `IMPORTER_UPLOADS_ENABLED=false`
- `MAX_WRITES_PER_RUN=10000`
- `BATCH_SIZE=300` (configurable; keep conservative)
- `MAX_LINES_PER_RUN=` (optional cap, default unlimited)
- `CHECKPOINT_MODE=firestore|file` (default file for now)
- `CHECKPOINT_DOC_ID=off_import_checkpoint` (if firestore)
- `RUN_REPORTS_ENABLED=true`

IMPORTANT:
- Never commit service account creds.
- Support both JSON string and file path.

---

## Output files (local)
Write these per run:
- `output/checkpoint.json` (if file checkpoint mode)
- `output/run_reports/YYYY-MM-DD/run_report.json`
- `output/run_reports/YYYY-MM-DD/run_report.md`
- `output/run_reports/YYYY-MM-DD/warnings.json` (optional)
Ensure `output/run_reports/` is gitignored.

Also define Firestore run report doc schema for later (optional):
- `ImportRuns/{yyyy-mm-dd}`

---

## 5.1 Add Firestore Admin SDK client
Implement `src/firestore/client.ts`:
- Initialize Firebase Admin using service account and projectId.
- Export:
  - `getFirestore(): FirebaseFirestore.Firestore`
  - `isFirestoreReady(): boolean`
- Ensure no init happens in dry-run unless needed for reads (for checkpoint mode firestore, reads are allowed; writes still blocked).

Add dependency:
- `firebase-admin`

---

## 5.2 Implement batching writer with retry/backoff
Implement `src/firestore/batching.ts`:
- Provide `BatchWriter` that accepts operations and commits in batches.
- Use configurable `BATCH_SIZE`.
- Add `commitWithRetry(batch, attempt)`:
  - exponential backoff + jitter
  - retry on known transient errors: 429, 503, RESOURCE_EXHAUSTED, DEADLINE_EXCEEDED
  - max attempts (e.g., 8)
- Log progress every N writes.

Note: Use `WriteBatch` and commit.

---

## 5.3 Implement budget enforcement
Implement/upgrade `src/firestore/budget.ts`:
- `WriteBudget` class:
  - configured maxWritesPerRun
  - counters: plannedWrites, executedWrites
  - `reserve(n)` throws if exceeding budget
  - `markExecuted(n)`
- Commands must call `reserve()` BEFORE queuing writes.

---

## 5.4 Implement checkpoints (file + firestore)
Implement `src/firestore/checkpoints.ts`:
- Define type:
```ts
export type ImportCheckpoint = {
  filePath: string
  updatedAt: string
  mode: "products" | "categories"
  lineNumber: number
  bytesOffset?: number
  lastProductId?: string
  totals: { scanned: number; written: number; skipped: number; rejected: number }
}
```

Support:
* File checkpoint (default): output/checkpoint.json
* Firestore checkpoint (optional):
  * collection: ImportCheckpoints
  * docId from config CHECKPOINT_DOC_ID

⠀Export:
* loadCheckpoint(): Promise<ImportCheckpoint | null>
* saveCheckpoint(cp: ImportCheckpoint): Promise<void>

⠀Checkpoint behavior:
* Save periodically (e.g., every 500 processed records) and at end.
* On resume, skip lines up to lineNumber efficiently (stream and discard).
* Prefer lineNumber checkpoint (bytesOffset is optional; if you can do bytes offset safely, include it).

⠀
# 5.5 Implement import categories command (real)
Create src/cli/commands/importCategories.ts (replace Phase 0 placeholder):
* Inputs:
  * --in default output/categories_preview.json
  * --dry-run default true
  * --execute to enable writes (still requires env gate)
* Behavior:
  * Load categories array
  * Validate basic shape against contract fields for ProductCategories (from contract JSON)
  * Upsert to Firestore:
    * collection ProductCategories
    * docId = category.id
    * set document (merge true)
  * Budget:
    * each category upsert counts as 1 write
  * Output run report files

⠀Even in execute mode, if uploads disabled by env, fail fast with message.

# 5.6 Implement import products command (stream JSONL + transform + validate + write)
Create src/cli/commands/importProducts.ts (replace Phase 0 placeholder): Args:
* --file (default env IMPORT_FILE_PATH)
* --dry-run default true
* --execute enable writes (still env gate required)
* --max-writes default MAX_WRITES_PER_RUN
* --max-lines optional
* --resume default true
* --checkpoint-mode optional override
* --since-date optional (ignore if not implemented yet; add TODO)

⠀Behavior:
1. Load checkpoint if resume and mode matches "products"
2. Stream JSONL from the checkpoint lineNumber
3. For each OFF record:
   * transform via transformOffToProduct(...)
   * validate product JSON via validators (Phase 1.5). If validators missing, perform contract-based checks and emit TODO.
   * Decide action:
     * reject → track and continue (no writes)
     * draft/active → eligible
4. Changed-only writes (optional but strongly recommended now):
   * compute import_hash = sha256(canonical JSON stable stringify)
   * store it in attributes["import_hash"]
   * before writing, optionally read existing doc’s attributes.import_hash to skip unchanged
   * HOWEVER: reads cost and time. Make this configurable:
     * --skip-unchanged=true|false default false for Phase 5
5. Writing:
   * collection ProductCatalog
   * docId = product.productId
   * set with merge true
   * reserve budget 1 per doc written
   * commit in batches using BatchWriter
6. Periodically save checkpoint and write progress logs.

⠀Run report must include:
* scanned lines
* valid OFF JSON parsed
* transformed products
* rejected count + reasons
* drafts vs actives
* planned writes vs executed writes
* stop reason (budget reached, eof, max-lines reached, error)
* checkpoint saved location

⠀IMPORTANT:
* If budget reaches max writes, stop cleanly and save checkpoint.

⠀
# 5.7 Add run reporting
Implement src/firestore/runReports.ts (or src/core/runReports.ts):
* Create per-run folder:
  * output/run_reports/YYYY-MM-DD/
* Write:
  * run_report.json
  * run_report.md summary
* Include key metrics and next instructions (“resume tomorrow will continue from line X”).

⠀
# 5.8 Update docs
Update:
* docs/README_HANDOFF.md with Phase 5 usage:
  * how to run dry-run
  * how to enable execute safely (env gate)
  * how checkpoint works
  * how to interpret reports

⠀Add docs/firestore_schema.md:
* defines collections and doc id rules
* defines checkpoint collection if using firestore mode
* defines run reports doc schema if later moved to firestore

⠀
# 5.9 Wire scripts
Update package.json scripts:
* import:categories
* import:products
* phase5:dryrun (runs importProducts in dry-run with max-lines small) Example:
* npm run import:products -- --file ../openfoodfacts-products.jsonl --max-writes 10000 --dry-run
* IMPORTER_UPLOADS_ENABLED=true npm run import:products -- --execute (should still require credentials)

⠀Also ensure typecheck passes.

# Acceptance criteria
* Dry-run mode works end-to-end without credentials.
* Execute mode requires BOTH --execute and IMPORTER_UPLOADS_ENABLED=true, otherwise fails fast.
* Budget is enforced strictly; importer stops when reaching max writes.
* Checkpoint is saved and resume works.
* Categories import works and respects dry-run gate.
* Products import streams JSONL, transforms, validates, and queues writes correctly.
* Run reports are produced.

⠀When done, print:
* commands to run dry-run imports
* commands to run execute imports (but do NOT run them)
* file list of the new/updated modules
* short note: Phase 6 will add scheduling at 07:00 Asia/Singapore + daily operational runbook.

#kif/ios/brain