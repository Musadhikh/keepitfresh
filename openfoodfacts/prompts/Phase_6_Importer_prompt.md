# # Codex Prompt — Phase 6: Daily Scheduling (07:00 Asia/Singapore) + Operations Runbook (NO AUTO-UPLOADS)

You are working in the KeepItFresh repo under:
- `openfoodfacts/importer/`

Phase 5 implemented Firestore import commands:
- `npm run import:categories`
- `npm run import:products`
with dry-run default and uploads gated by:
- CLI flag `--execute`
- env `IMPORTER_UPLOADS_ENABLED=true`

Now implement Phase 6:
1) Add **scheduling configuration** to run imports daily at **07:00 Asia/Singapore**.
2) Add an **operations runbook** and “handoff” docs to continue safely every day.
3) Add a “preflight” + “lock” mechanism so the job cannot run concurrently and cannot accidentally upload unless explicitly enabled.

IMPORTANT:
- Do NOT enable uploads by default.
- Do NOT run any imports.
- Provide setup files and documentation only.

---

## Deliverables (create/update these files)

### Docs
1) `openfoodfacts/importer/docs/operations_runbook.md`
2) `openfoodfacts/importer/docs/scheduling.md`
3) Update `openfoodfacts/importer/docs/README_HANDOFF.md` (fill in Phase 6 sections)

### Scripts
4) `openfoodfacts/importer/scripts/run-daily-import.sh`
5) `openfoodfacts/importer/scripts/preflight.sh`
6) `openfoodfacts/importer/scripts/rotate-logs.sh` (optional)

### Scheduling configs (provide both options)
#### macOS launchd
7) `openfoodfacts/importer/schedule/macos/com.keepitfresh.openfoodfacts.importer.plist`

#### Linux cron
8) `openfoodfacts/importer/schedule/linux/cron.sample`

### Concurrency lock
9) `openfoodfacts/importer/src/core/lock.ts` (file lock utility)
10) Wire lock into the import commands so `import:products` refuses to run if lock exists.

---

## 6.1 Preflight script
Create `scripts/preflight.sh` that:
- checks Node version (>=20)
- checks that importer dependencies are installed
- verifies JSONL file path exists and is readable
- verifies required env vars are present ONLY if execute mode is requested:
  - FIREBASE_PROJECT_ID
  - FIREBASE_SERVICE_ACCOUNT_JSON or PATH
- prints current config: max writes, batch size, checkpoint mode, dry-run/execute mode
- verifies timezone is Asia/Singapore for scheduling docs (do not change system timezone automatically)
- exits non-zero if anything critical missing

---

## 6.2 Daily runner script (safe by default)
Create `scripts/run-daily-import.sh` that:
- loads `.env` (dotenv-style) if present
- runs preflight
- acquires a lock (e.g., `output/import.lock`)
- runs product import in **dry-run** unless explicitly passed `--execute`
- writes all stdout/stderr to:
  - `output/run_reports/YYYY-MM-DD/daily_run.log`
- always releases lock on exit (trap)

The script must accept:
- `--execute` (optional; pass through to CLI)
- `--max-writes` override
- `--file` override
- `--max-lines` optional
- `--resume` optional

Default behavior (no args):
- dry-run
- uses env IMPORT_FILE_PATH
- max writes 10000
- resume true

IMPORTANT:
- Even with `--execute`, actual writes still require `IMPORTER_UPLOADS_ENABLED=true`.

---

## 6.3 Concurrency lock in Node
Implement `src/core/lock.ts`:
- uses atomic file creation for lock acquisition
- includes lock metadata: pid, startedAt, command, hostname
- exports:
  - `acquireLock(lockPath): Promise<void>`
  - `releaseLock(lockPath): Promise<void>`
  - `isLockStale(lockPath, maxAgeMinutes): boolean`
- If lock exists and is not stale, import command should refuse to run.

Wire this lock into:
- `src/cli/commands/importProducts.ts`
- `src/cli/commands/importCategories.ts`

Lock path default:
- `output/import.lock`

---

## 6.4 Scheduling configurations (do not activate automatically)
### macOS launchd plist
Create `schedule/macos/com.keepitfresh.openfoodfacts.importer.plist` with:
- StartCalendarInterval: Hour=7 Minute=0
- ProgramArguments pointing to `scripts/run-daily-import.sh`
- WorkingDirectory set to `openfoodfacts/importer`
- StandardOutPath / StandardErrorPath to `output/launchd.log` (or dated logs)
- EnvironmentVariables:
  - PATH includes node path (document how to set)
  - IMPORTER_UPLOADS_ENABLED default false

Provide instructions in docs on:
- how to install with `launchctl`
- how to load/unload
- how to check status/logs

### Linux cron sample
Create `schedule/linux/cron.sample` showing:
- `0 7 * * * cd /path/to/openfoodfacts/importer && ./scripts/run-daily-import.sh >> ./output/cron.log 2>&1`
Note: mention timezone; recommend setting TZ=Asia/Singapore within cron or system.

---

## 6.5 Operations runbook (must be practical)
Create `docs/operations_runbook.md` that includes:
1) Daily checklist (before and after run)
2) How to run manually (dry-run vs execute)
3) How to interpret run reports and checkpoint
4) Common failure modes:
   - quota/resource exhausted
   - invalid credentials
   - JSONL parse spikes
   - lock file stuck
5) How to resume safely
6) How to stop the job
7) Safety rules:
   - never set IMPORTER_UPLOADS_ENABLED=true permanently on shared machines unless intended
   - start with small max-writes for first real run
   - categories import should be done rarely (weekly/monthly) unless taxonomy changed

Create `docs/scheduling.md`:
- explain macOS launchd vs cron
- step-by-step setup
- timezone notes (Asia/Singapore)
- log locations and rotation

Update `docs/README_HANDOFF.md`:
- Fill in Phase 6: scheduling + daily operation steps
- Add a “handoff” section:
  - where checkpoint is stored
  - where run reports are stored
  - what to check if something fails

---

## 6.6 Log rotation (optional but recommended)
Create `scripts/rotate-logs.sh`:
- keeps last N days of run_reports logs (e.g., 30)
- deletes older logs safely
- never deletes checkpoint
Document usage in runbook.

---

## Acceptance criteria
- No uploads are enabled by default.
- `run-daily-import.sh` runs safely in dry-run by default.
- Concurrency lock prevents overlapping runs.
- launchd plist and cron sample exist with clear setup docs.
- Operations runbook is detailed and practical.
- All paths are relative and repo-friendly.

When done, list all created/updated files and show example commands to:
- run dry-run manually
- run execute manually (without actually doing it)
- install launchd job (commands only)
- set up cron (instructions only)


#kif/ios/brain