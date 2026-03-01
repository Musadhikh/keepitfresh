# Storage Prediction Rules v1

This file defines deterministic rules for predicting **storage type** during OFF -> Product transformation.

## Output keys

When prediction succeeds, importer writes:
- `attributes.storageType`
- `attributes.storageTypeConfidence`
- `attributes.storageTypeReason` (short)

If no rule matches, importer **omits** these keys.

## Rule precedence

1. Text rules (`high`) across normalized text corpus
2. Category rules (`main/sub`)
3. Text rules (`medium`)
4. No match -> omit field

## Text corpus scanned

- `product.storageInstructions`
- `product.title`
- `product.brand`
- category-derived signals
- selected OFF text signals already in mapping flow (no raw payload persistence)

## Tuning guidance

- Add high-confidence phrases only when false positives are low.
- Keep category rules broad but deterministic.
- Avoid inventing unknown buckets: no `other` / `unknown` storage type.
- Keep reason short and query-friendly.

## Example outcomes

- `"keep frozen"` -> `freezer` / `high`
- `"keep refrigerated after opening"` -> `fridge` / `high`
- `category.sub = "canned and jarred"` -> `shelf` / `medium`
- no clear signals -> no storage attributes written

