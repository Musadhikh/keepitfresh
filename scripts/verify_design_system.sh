#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

if command -v rg >/dev/null 2>&1; then
  FIND_CMD="rg"
else
  FIND_CMD="grep"
fi

UI_SCOPE="keepitfresh/Presentation"
EXIT_CODE=0

print_failure() {
  local message="$1"
  echo "FAILED: ${message}"
  EXIT_CODE=1
}

run_pattern_check() {
  local message="$1"
  local pattern="$2"
  local scope="$3"
  local output_file
  output_file="$(mktemp)"

  if [[ "$FIND_CMD" == "rg" ]]; then
    if rg -n --glob "*.swift" "$pattern" $scope >"$output_file"; then
      print_failure "$message"
      cat "$output_file"
    fi
  else
    if grep -REn --include="*.swift" "$pattern" $scope >"$output_file"; then
      print_failure "$message"
      cat "$output_file"
    fi
  fi

  rm -f "$output_file"
}

assert_file_exists() {
  local file_path="$1"
  if [[ ! -f "$file_path" ]]; then
    print_failure "Missing required file: ${file_path}"
  fi
}

assert_theme_token_exists() {
  local token_name="$1"
  if [[ "$FIND_CMD" == "rg" ]]; then
    if ! rg -q "$token_name" keepitfresh/App/Theme.swift; then
      print_failure "Missing required Theme token: ${token_name}"
    fi
  else
    if ! grep -q "$token_name" keepitfresh/App/Theme.swift; then
      print_failure "Missing required Theme token: ${token_name}"
    fi
  fi
}

run_pattern_check "Use foregroundStyle() instead of foregroundColor() in UI files." "foregroundColor\\(" "$UI_SCOPE"
run_pattern_check "Use clipShape(.rect(cornerRadius:)) instead of cornerRadius()." "cornerRadius\\(" "$UI_SCOPE"
run_pattern_check "Use Theme tokens instead of direct Color(...) construction in UI files." "\\bColor\\(" "$UI_SCOPE"
run_pattern_check "Use Image(icon:) instead of Image(systemName: \"...\") in UI files." "Image\\(systemName:[[:space:]]*\\\"" "$UI_SCOPE"
run_pattern_check "Use Theme.Icon.*.systemName instead of literal systemImage strings." "systemImage:[[:space:]]*\\\"" "$UI_SCOPE"
run_pattern_check "Use Theme.Colors tokens instead of inline hex colors in UI files." "#[0-9A-Fa-f]{6,8}" "$UI_SCOPE"

assert_file_exists "Documentation/LIQUID_GLASS_DESIGN_SYSTEM.md"
assert_file_exists "stitch.config.json"
assert_file_exists "keepitfresh/App/Theme.swift"

assert_theme_token_exists "textOnAccent"
assert_theme_token_exists "glassBorder"
assert_theme_token_exists "displayBold"
assert_theme_token_exists "glassCard"
assert_theme_token_exists "glassShadowColor"

if [[ "$EXIT_CODE" -ne 0 ]]; then
  exit "$EXIT_CODE"
fi

echo "Design system guard passed."
