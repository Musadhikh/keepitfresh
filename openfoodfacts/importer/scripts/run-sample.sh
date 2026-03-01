#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."
npm run sample -- --count 100 --out output/off_sample_100.json
