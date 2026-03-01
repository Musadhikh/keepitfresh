#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."
npm run build:categories -- --sample output/off_sample_100.json --out output/categories_preview.json
