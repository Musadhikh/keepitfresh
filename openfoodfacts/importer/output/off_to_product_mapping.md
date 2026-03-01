# OFF to Product Mapping Spec (Phase 2)

- Generated at: 2026-03-01T13:29:25.785Z
- Source sample size: 3000
- Candidate OFF paths are derived from observed schema keys only.

## Product.productId

- Candidate OFF field paths:
- code
- ecoscore_data.agribalyse.agribalyse_food_code
- ecoscore_data.agribalyse.agribalyse_proxy_food_code
- ecoscore_data.agribalyse.code
- ecoscore_data.previous_data.agribalyse.agribalyse_food_code
- ecoscore_data.previous_data.agribalyse.agribalyse_proxy_food_code
- ecoscore_data.previous_data.agribalyse.code
- environmental_score_data.agribalyse.agribalyse_food_code
- environmental_score_data.agribalyse.agribalyse_proxy_food_code
- environmental_score_data.agribalyse.code
- Transformation / normalization rules:
- Prefer canonical external product key; trim; if barcode-like normalize to uppercase alphanumeric.
- Fallback behavior:
- Skip record if stable identifier cannot be derived.
- Example sample snippets:
- 0000101209159
- 31032

## Product.barcode

- Candidate OFF field paths:
- code
- ecoscore_data.agribalyse.agribalyse_food_code
- ecoscore_data.agribalyse.agribalyse_proxy_food_code
- ecoscore_data.agribalyse.code
- ecoscore_data.previous_data.agribalyse.agribalyse_food_code
- ecoscore_data.previous_data.agribalyse.agribalyse_proxy_food_code
- ecoscore_data.previous_data.agribalyse.code
- environmental_score_data.agribalyse.agribalyse_food_code
- environmental_score_data.agribalyse.agribalyse_proxy_food_code
- environmental_score_data.agribalyse.code
- Transformation / normalization rules:
- Normalize value (trim + uppercase + alphanumeric); map symbology if observable.
- Fallback behavior:
- Set nil if not confidently present.
- Example sample snippets:
- 0000101209159
- 31032

## Product.title

- Candidate OFF field paths:
- product_name_it
- product_name_it_debug_tags
- product_name_la
- product_name
- product_name_ar
- product_name_da
- product_name_de
- product_name_de_debug_tags
- product_name_debug_tags
- product_name_en
- Transformation / normalization rules:
- Use best user-facing product name, trimmed.
- Fallback behavior:
- Leave nil and allow draft status if barcode exists.
- Example sample snippets:
- Véritable pâte à tartiner noisettes chocolat noir
- Chamomile Herbal Tea

## Product.brand

- Candidate OFF field paths:
- brands
- brands_debug_tags
- brands_hierarchy
- brands_hierarchy[]
- brands_lc
- brands_old
- brands_tags
- brands_tags[]
- brand_owner
- brand_owner_imported
- Transformation / normalization rules:
- Choose primary brand string; collapse arrays to first stable value.
- Fallback behavior:
- Nil.
- Example sample snippets:
- Bovetti
- ["xx:Bovetti"]

## Product.shortDescription

- Candidate OFF field paths:
- generic_name_ar
- generic_name_de
- generic_name_de_debug_tags
- generic_name_es
- generic_name_es_debug_tags
- generic_name
- generic_name_en
- generic_name_en_debug_tags
- generic_name_en_imported
- generic_name_fr
- Transformation / normalization rules:
- Trim and keep concise text only.
- Fallback behavior:
- Nil.
- Example sample snippets:
- Mehrkomponeneten Protein in Haselnuß Geschmack
- []

## Product.storageInstructions

- Candidate OFF field paths:
- completed_t
- created_t
- ecoscore_extended_data.impact.likeliest_recipe.en:confectioner_s_glaze
- ecoscore_extended_data.impact.likeliest_recipe.fr:Carbonate_de_t_calcium
- images.1.uploaded_t
- images.10.uploaded_t
- images.11.uploaded_t
- images.12.uploaded_t
- images.13.uploaded_t
- images.14.uploaded_t
- Transformation / normalization rules:
- Map free-form storage text verbatim after trim.
- Fallback behavior:
- Nil.
- Example sample snippets:
- 1519297017
- 1519297019

## Product.category.main/sub

- Candidate OFF field paths:
- categories_debug_tags
- categories_hierarchy
- categories_hierarchy[]
- categories_next_hierarchy
- categories_next_tags
- categories_prev_hierarchy
- categories_prev_tags
- categories_properties_tags
- categories_properties_tags[]
- categories_tags
- Transformation / normalization rules:
- Map via curated taxonomy (`ProductCategories`) to canonical main/sub.
- Fallback behavior:
- main=other, sub=nil; keep raw hints in attributes/provenance.
- Example sample snippets:
- ["en:breakfasts","en:spreads","en:sweet-spreads","fr:pates-a-tartiner","en:hazelnut-spreads","en:chocolate-spreads","en:cocoa-and-hazelnuts-spreads"]
- en:breakfasts

## Product.productDetails

- Candidate OFF field paths:
- nutrition_score_warning_fruits_vegetables_legumes_estimate_from_ingredients
- nutrition_score_warning_fruits_vegetables_legumes_estimate_from_ingredients_value
- nutrition_score_warning_fruits_vegetables_nuts_estimate_from_ingredients
- nutrition_score_warning_fruits_vegetables_nuts_estimate_from_ingredients_value
- nutrition_score_warning_fruits_vegetables_legumes_from_category
- nutrition_score_warning_fruits_vegetables_legumes_from_category_value
- nutrition_score_warning_fruits_vegetables_nuts_estimate
- nutrition_score_warning_fruits_vegetables_nuts_from_category
- nutrition_score_warning_fruits_vegetables_nuts_from_category_value
- nutrition_score_warning_no_fiber
- Transformation / normalization rules:
- Use tagged union `{kind, value}` with payload matching canonical detail structs.
- Fallback behavior:
- Set nil or `other` with unknown details payload.
- Example sample snippets:
- 1
- 100

## Product.packaging

- Candidate OFF field paths:
- serving_quantity
- serving_quantity_unit
- serving_size
- serving_size_debug_tags
- serving_size_imported
- environmental_score_data.adjustments.packaging.packagings[].quantity_per_unit
- environmental_score_data.adjustments.packaging.packagings[].quantity_per_unit_unit
- environmental_score_data.adjustments.packaging.packagings[].quantity_per_unit_value
- images.packaging_en.coordinates_image_size
- images.packaging_fr.coordinates_image_size
- Transformation / normalization rules:
- Parse numeric amount + canonical unit; preserve display text.
- Fallback behavior:
- unit=unknown if packaging exists; otherwise nil.
- Example sample snippets:
- 350
- 1

## Product.images

- Candidate OFF field paths:
- last_image_t
- images.front_de.coordinates_image_size
- images.front_de.imgid
- images.front_en.coordinates_image_size
- images.front_en.imgid
- images.front_es.imgid
- images.front_fr.coordinates_image_size
- images.front_fr.imgid
- images.front_it.imgid
- images.front_la.coordinates_image_size
- Transformation / normalization rules:
- Map image URLs/assets to canonical image objects with stable id + kind.
- Fallback behavior:
- []
- Example sample snippets:
- 1579374831
- 1

## Product.attributes

- Candidate OFF field paths:
- labels_debug_tags
- labels_next_tags
- labels_prev_tags
- labels_prev_tags[]
- labels_tags
- labels_tags[]
- misc_tags
- misc_tags[]
- states_tags
- states_tags[]
- Transformation / normalization rules:
- Store non-canonical but useful fields under allowlist prefix strategy (`off_*`, `import_*`).
- Fallback behavior:
- {}
- Example sample snippets:
- ["en:no-gluten","en:no-palm-oil"]
- en:no-gluten

## Product.extractionMetadata

- Candidate OFF field paths:
- ecoscore_extended_data.impact.confidence_score_distribution
- ecoscore_extended_data.impact.confidence_score_distribution[]
- ecoscore_extended_data.impact.likeliest_recipe.en:autolyzed_yeast_extract
- ecoscore_extended_data.impact.mean_confidence_interval_distribution
- ecoscore_extended_data.impact.mean_confidence_interval_distribution.Climate_change
- ecoscore_extended_data.impact.mean_confidence_interval_distribution.Climate_change[]
- ecoscore_extended_data.impact.mean_confidence_interval_distribution.Climate_change[][]
- ecoscore_extended_data.impact.mean_confidence_interval_distribution.EF_single_score
- ecoscore_extended_data.impact.mean_confidence_interval_distribution.EF_single_score[]
- ecoscore_extended_data.impact.mean_confidence_interval_distribution.EF_single_score[][]
- Transformation / normalization rules:
- Capture extraction-time metadata and confidence maps where available.
- Fallback behavior:
- Nil.
- Example sample snippets:
- [7.090745774748977,3.9560095176114927,6.650909737798823,2.73058651086092,7.4900361449374815,6.13034467480933,7.3749213901239585,4.340670797612794,7.133899730923...
- 7.090745774748977

## Product.qualitySignals

- Candidate OFF field paths:
- data_quality_dimensions.completeness.nutrition
- data_quality_dimensions.completeness.ingredients
- images.nutrition_en.coordinates_image_size
- images.selected.nutrition.en.generation.coordinates_image_size
- images.nutrition_it.coordinates_image_size
- images.selected.nutrition.es.generation.coordinates_image_size
- data_quality_completeness_tags
- data_quality_completeness_tags[]
- data_quality_dimensions.completeness
- data_quality_dimensions.completeness.general_information
- Transformation / normalization rules:
- Compute booleans and score at import-time from observed data.
- Fallback behavior:
- Nil or default booleans false if object is created.
- Example sample snippets:
- full
- 0.67

## Product.compliance

- Candidate OFF field paths:
- data_quality_warning_tags
- data_quality_warning_tags[]
- ecoscore_data.adjustments.origins_of_ingredients.warning
- ecoscore_data.adjustments.packaging.warning
- ecoscore_data.adjustments.production_system.warning
- ecoscore_data.adjustments.threatened_species.warning
- ecoscore_data.agribalyse.warning
- ecoscore_data.missing_agribalyse_match_warning
- ecoscore_data.missing_data_warning
- ecoscore_data.previous_data.agribalyse.warning
- Transformation / normalization rules:
- Map market/restriction/certification arrays when explicitly available.
- Fallback behavior:
- Nil.
- Example sample snippets:
- origins_are_100_percent_unknown
- packaging_data_missing

## Product.source/status/createdAt/updatedAt/version

- Candidate OFF field paths:
- created_t
- last_updated_t
- sources[].import_t
- ecoscore_data.status
- environmental_score_data.status
- interface_version_created
- sources_fields.org-database-usda.fdc_data_source
- sources[].source_licence
- sources[].source_licence_url
- completed_t
- Transformation / normalization rules:
- Set importer-controlled metadata: source=importedFeed, status per validation, createdAt/updatedAt ISO, version monotonic.
- Fallback behavior:
- source=importedFeed, status=draft/active, version=1.
- Example sample snippets:
- 1519297017
- 1743391825

