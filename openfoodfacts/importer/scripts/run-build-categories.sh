#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."
npm run categories:build -- --signals output/category_signals.json --min-count 50 --out output/categories_preview.json
