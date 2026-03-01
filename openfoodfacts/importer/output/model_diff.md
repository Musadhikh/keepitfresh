# OFF vs Canonical Product Model Diff (Phase 2)

## 1) Overview

- Generated at: 2026-03-01T13:29:25.785Z
- Sample size analyzed: 3000
- Observed OFF paths: 4833
- Canonical required fields (contract): productId, images, attributes, source, status, createdAt, updatedAt, version

## 2) Similarities (conceptual matches)

- Product.productId <- code, ecoscore_data.agribalyse.agribalyse_food_code, ecoscore_data.agribalyse.agribalyse_proxy_food_code
- Product.barcode <- code, ecoscore_data.agribalyse.agribalyse_food_code, ecoscore_data.agribalyse.agribalyse_proxy_food_code
- Product.title <- product_name_it, product_name_it_debug_tags, product_name_la
- Product.brand <- brands, brands_debug_tags, brands_hierarchy
- Product.shortDescription <- generic_name_ar, generic_name_de, generic_name_de_debug_tags
- Product.storageInstructions <- completed_t, created_t, ecoscore_extended_data.impact.likeliest_recipe.en:confectioner_s_glaze
- Product.category.main/sub <- categories_debug_tags, categories_hierarchy, categories_hierarchy[]
- Product.productDetails <- nutrition_score_warning_fruits_vegetables_legumes_estimate_from_ingredients, nutrition_score_warning_fruits_vegetables_legumes_estimate_from_ingredients_value, nutrition_score_warning_fruits_vegetables_nuts_estimate_from_ingredients
- Product.packaging <- serving_quantity, serving_quantity_unit, serving_size
- Product.images <- last_image_t, images.front_de.coordinates_image_size, images.front_de.imgid
- Product.attributes <- labels_debug_tags, labels_next_tags, labels_prev_tags
- Product.extractionMetadata <- ecoscore_extended_data.impact.confidence_score_distribution, ecoscore_extended_data.impact.confidence_score_distribution[], ecoscore_extended_data.impact.likeliest_recipe.en:autolyzed_yeast_extract
- Product.qualitySignals <- data_quality_dimensions.completeness.nutrition, data_quality_dimensions.completeness.ingredients, images.nutrition_en.coordinates_image_size
- Product.compliance <- data_quality_warning_tags, data_quality_warning_tags[], ecoscore_data.adjustments.origins_of_ingredients.warning
- Product.source/status/createdAt/updatedAt/version <- created_t, last_updated_t, sources[].import_t

## 3) Differences / gaps


## 4) Canonical fields missing in OFF (defaults or nil)

- None in this sample window.

## 5) OFF fields not represented canonically

- _id: attributes
- _keywords: attributes
- _keywords[]: attributes
- added_countries_tags: attributes
- additives_debug_tags: ignore
- additives_debug_tags[]: ignore
- additives_n: attributes
- additives_old_n: attributes
- additives_old_tags: attributes
- additives_old_tags[]: attributes
- additives_original_tags: attributes
- additives_original_tags[]: attributes
- additives_prev_original_tags: attributes
- additives_prev_original_tags[]: attributes
- additives_tags: attributes
- additives_tags_n: attributes
- additives_tags[]: attributes
- allergens: attributes
- allergens_debug_tags: ignore
- allergens_from_ingredients: attributes
- allergens_from_user: attributes
- allergens_hierarchy: attributes
- allergens_hierarchy[]: attributes
- allergens_imported: attributes
- allergens_lc: attributes
- allergens_tags: attributes
- allergens_tags[]: attributes
- amino_acids_prev_tags: attributes
- amino_acids_tags: attributes
- amino_acids_tags[]: attributes
- carbon_footprint_from_known_ingredients_debug: ignore
- carbon_footprint_from_meat_or_fish_debug: ignore
- carbon_footprint_percent_of_known_ingredients: attributes
- categories: attributes
- categories_imported: attributes
- categories_lc: attributes
- categories_old: attributes
- categories_properties: attributes
- categories_properties.agribalyse_food_code:en: attributes
- categories_properties.agribalyse_proxy_food_code:en: attributes
- categories_properties.ciqual_food_code:en: attributes
- categories_tags[]: attributes
- category_properties: map to canonical field when stable; otherwise attributes
- category_properties.ciqual_food_name:en: map to canonical field when stable; otherwise attributes
- category_properties.ciqual_food_name:fr: map to canonical field when stable; otherwise attributes
- checked: attributes
- checkers: attributes
- checkers_tags: attributes
- checkers_tags[]: attributes
- ciqual_food_name_tags: attributes
- ciqual_food_name_tags[]: attributes
- cities_tags: attributes
- cities_tags[]: attributes
- codes_tags: attributes
- codes_tags[]: attributes
- compared_to_category: map to canonical field when stable; otherwise attributes
- complete: attributes
- completeness: attributes
- correctors: attributes
- correctors_tags: attributes
- correctors_tags[]: attributes
- correctors[]: attributes
- countries: attributes
- countries_beforescanbot: attributes
- countries_debug_tags: ignore
- countries_hierarchy: attributes
- countries_hierarchy[]: attributes
- countries_imported: attributes
- countries_lc: attributes
- countries_tags: attributes
- countries_tags[]: attributes
- creator: attributes
- data_quality_bugs_tags: attributes
- data_quality_dimensions: attributes
- data_quality_dimensions.accuracy: attributes
- data_quality_dimensions.accuracy.overall: attributes
- data_quality_dimensions.completeness.overall: attributes
- data_quality_dimensions.completeness.packaging: attributes
- data_quality_errors_tags: attributes
- data_quality_errors_tags[]: attributes
- ... and 4615 more

## 6) Risk areas

- Large blobs and image-related payloads can inflate document size and write costs.
- Category/tag fields are often noisy; curation-first mapping is required.
- Nutrition structures can vary in shape and units across records.
- Multilingual text fields may require explicit locale strategy in future contract versions.

