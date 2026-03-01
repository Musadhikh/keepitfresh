# Scheduling Guide

Target schedule: **07:00 Asia/Singapore**, daily.

## Option A: macOS launchd

Template file:
- `schedule/macos/com.keepitfresh.openfoodfacts.importer.plist`

Steps:
1. Replace `__IMPORTER_ROOT__` in plist with absolute importer path.
2. Copy plist:
```bash
cp schedule/macos/com.keepitfresh.openfoodfacts.importer.plist ~/Library/LaunchAgents/
```
3. Load job:
```bash
launchctl load ~/Library/LaunchAgents/com.keepitfresh.openfoodfacts.importer.plist
```
4. Check status:
```bash
launchctl list | rg com.keepitfresh.openfoodfacts.importer
```
5. Unload job:
```bash
launchctl unload ~/Library/LaunchAgents/com.keepitfresh.openfoodfacts.importer.plist
```

Logs:
- `output/launchd.log`
- `output/run_reports/YYYY-MM-DD/daily_run.log`

## Option B: Linux cron

Template file:
- `schedule/linux/cron.sample`

Steps:
1. Replace `__IMPORTER_ROOT__` with absolute path.
2. Install crontab entry (example):
```cron
TZ=Asia/Singapore
0 7 * * * cd __IMPORTER_ROOT__ && ./scripts/run-daily-import.sh >> ./output/cron.log 2>&1
```
3. Confirm cron service is active and timezone applied.

## Timezone notes
- Scheduling docs assume `Asia/Singapore`.
- Do not auto-change system timezone in scripts.
- Use scheduler-level timezone (`TZ=Asia/Singapore`) where possible.

## Safety reminders
- Runner defaults to dry-run.
- Execute requires explicit `--execute` and upload env gate.
- Lock file prevents overlapping runs.

