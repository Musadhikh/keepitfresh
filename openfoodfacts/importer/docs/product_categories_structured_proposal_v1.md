# KeepItFresh Product Category Structure (Proposed v1)

This proposal is designed for KeepItFresh inventory UX: practical grocery-oriented buckets, predictable subcategories, and minimal noise.

## Main categories
- `food`
- `beverage`
- `household`
- `personalCare`
- `medicine`
- `electronics`
- `pet`
- `other` (strict fallback only)

## `food` subcategories (proposed canonical set)

1. `produce`
2. `dairy-and-eggs`
3. `meat-and-poultry`
4. `fish-and-seafood`
5. `bakery`
6. `grains-pasta-and-rice`
7. `breakfast-and-cereal`
8. `snacks-sweet`
9. `snacks-salty`
10. `confectionery`
11. `frozen-foods`
12. `prepared-meals`
13. `soups-and-broths`
14. `sauces-dressings-and-condiments`
15. `spreads-and-nut-butters`
16. `canned-and-jarred`
17. `baking-and-dessert-mixes`
18. `oils-and-fats`
19. `sweeteners-and-syrups`
20. `baby-food`
21. `special-diet-food`
22. `other-food`

## `beverage` subcategories (proposed canonical set)

1. `water`
2. `sparkling-and-soft-drinks`
3. `juice-and-nectar`
4. `tea`
5. `coffee`
6. `plant-based-drinks`
7. `sports-and-energy-drinks`
8. `powdered-and-concentrates`
9. `alcoholic`
10. `other-beverage`

## Normalization rules to keep `other` clean

1. Treat attribute/label metadata as non-categories (do not create category docs):
   - `organic`, `bio`, `non gmo`, `no gluten`, `sans conservateurs`, `sans colorants`
   - packaging markers (`point vert`, `film plastique`, `sachet plastique`, etc.)
   - completion/quality markers (`to-be-completed`, `unknown`, `no nova group...`)
2. Treat `-average-` and `aliment moyen` labels as noise.
3. Treat brand markers (`xx:*`) as noise (brands should live in product brand fields, not category).
4. Route food-like phrases to `food` even if OFF taxonomy is messy:
   - examples: `dressings and sauces`, `mexican dinner mixes`, `frozen dinners & entrees`, `chips`, `cold cuts`, `olive oil`, `peanut butter`.

## Current status after latest rule refinement (100k validation pass)
- Main counts from generated preview:
  - `food`: 302
  - `beverage`: 28
  - `other`: 475
  - `pet`: 10
  - `medicine`: 6
- Remaining high-frequency `other` entries are mostly non-taxonomy values (brand/label/language variants), which is expected and should be filtered further by manual denylist curation.

