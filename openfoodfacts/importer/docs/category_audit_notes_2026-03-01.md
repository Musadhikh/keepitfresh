# Category Audit Notes (300k OFF rows)

Generated from:
- `npm run phase3 -- --file ../../../openfoodfacts-products.jsonl --max-lines 300000 --min-count 10`

## Run snapshot
- Scanned lines: `300001`
- Records with category data: `300000`
- Discovered OFF category field paths: `318`
- Normalized category preview size: `972`

## Current shape
- Main bucket split (by normalized category count):
  - `other`: 781
  - `food`: 107
  - `beverage`: 67
  - `pet`: 15
  - `medicine`: 2

This indicates too much spillover into `other`; mapping/rules need tightening.

## High-volume candidate categories (cleaned view)
Top frequent categories by source-path frequency (after excluding obvious metadata/noise labels):

1. `food/sugary-snacks` (38109)
2. `food/fish-meat-eggs` (24441)
3. `food/milk-and-dairy-products` (22577)
4. `other/cereals-and-potatoes` (19588)
5. `food/snacks-sweet-snacks-confectioneries` (19381)
6. `other/biscuits-and-cakes` (18957)
7. `other/fat-and-sauces` (18935)
8. `food/dairies-fermented-foods-fermented-milk-products-cheeses` (16166)
9. `food/salted-snacks` (16165)
10. `other/dressings-and-sauces` (14645)

Top-20 cleaned categories cover ~`38.24%` of cleaned signal counts.

## Noise findings
Estimated noisy category share in current normalized set:
- Noisy categories: `135 / 972`
- Noisy signal volume: `280588 / 1116255` (~`25.14%`)

Common noisy labels:
- `no nova group when the product does not have ingredients`
- `*-average-*`
- `*-aliment moyen-*`
- `point vert`
- metadata-like tags (`unknown`, completion/process markers, etc.)

## Preparation actions before importing ProductCategories
1. Add explicit denylist rules for known metadata/non-taxonomy categories:
   - `point vert`, `*-average-*`, `*-aliment moyen-*`, `no nova group*`, completion/status markers.
2. Reclassify broad food terms currently ending in `other`:
   - `cereals and potatoes`, `biscuits and cakes`, `fat and sauces`, `dressings and sauces`, `groceries, sauces`.
3. Tighten beverage mapping:
   - several `plant-based foods...` paths currently map to `beverage` and likely need `food`.
4. Add synonym consolidation:
   - `salty snacks` + `salted snacks`
   - similar cheese/dairy variants and language variants.
5. Add threshold policy:
   - keep auto-inclusion for high-frequency categories
   - route low-frequency tail to review queue (manual approval).

## Suggested next command loop
After mapping-rule updates:

```bash
npm run phase3 -- --file ../../../openfoodfacts-products.jsonl --max-lines 300000 --min-count 10
```

Review:
- `output/categories_preview.json`
- `output/categories_preview.md`
- `docs/category_mapping_rules_v1.json`

