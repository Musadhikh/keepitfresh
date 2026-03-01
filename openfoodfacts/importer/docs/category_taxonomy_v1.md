# Category Taxonomy v1

This taxonomy is generated from OFF category signals and is intentionally editable.

## Slug rules

- Category id format: `<main>/<sub-slug>`
- `sub-slug` is ASCII kebab-case.
- No random IDs; deterministic from main+sub.

## How categories_preview is generated

1. Read `output/category_signals.json`.
2. Classify `main` with keyword rules from `category_mapping_rules_v1.json`.
3. Derive `sub` from path leaf when available, else from tag.
4. Keep entries with `count >= min-count` as curated categories.
5. Keep lower-frequency entries under candidates for manual curation.

## How importer will use curated categories + mapping rules

- Apply `mainCategoryRules` in order.
- Apply `subCategoryOverrides` first for exact offTag/offPath matches.
- Apply `synonyms` normalization.
- Fallback to `other` when no deterministic match exists.
