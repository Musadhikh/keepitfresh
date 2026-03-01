# OFF Schema Summary (Phase 2)

- Generated at: 2026-03-01T13:29:25.086Z
- Sample path: /Users/musadhikhmuhammed/Projects/Personal/Github/KeepItFresh/keepitfresh/openfoodfacts/importer/output/off_sample_100.json
- Sample size: 3000
- Probe max depth: 6

## Most common keys

| Key | Presence | Rate |
|---|---:|---:|
| _id | 3000 | 100.0% |
| _keywords | 3000 | 100.0% |
| added_countries_tags | 3000 | 100.0% |
| allergens | 3000 | 100.0% |
| allergens_from_ingredients | 3000 | 100.0% |
| allergens_from_user | 3000 | 100.0% |
| allergens_hierarchy | 3000 | 100.0% |
| allergens_tags | 3000 | 100.0% |
| categories_properties | 3000 | 100.0% |
| categories_properties_tags | 3000 | 100.0% |
| checkers_tags | 3000 | 100.0% |
| code | 3000 | 100.0% |
| codes_tags | 3000 | 100.0% |
| complete | 3000 | 100.0% |
| completeness | 3000 | 100.0% |
| correctors_tags | 3000 | 100.0% |
| countries | 3000 | 100.0% |
| countries_hierarchy | 3000 | 100.0% |
| countries_tags | 3000 | 100.0% |
| created_t | 3000 | 100.0% |
| creator | 3000 | 100.0% |
| data_quality_bugs_tags | 3000 | 100.0% |
| data_quality_errors_tags | 3000 | 100.0% |
| data_quality_info_tags | 3000 | 100.0% |
| data_quality_tags | 3000 | 100.0% |
| data_quality_warnings_tags | 3000 | 100.0% |
| editors_tags | 3000 | 100.0% |
| entry_dates_tags | 3000 | 100.0% |
| food_groups_tags | 3000 | 100.0% |
| id | 3000 | 100.0% |

## Top-level key summary

| Path | Presence | Types | Examples |
|---|---:|---|---|
| _id | 3000/3000 | string | 0000101209159<br>0000105000011 |
| _keywords | 3000/3000 | array | ["au","aux","bovetti","cacao","chocolat","de","et","gluten","huile","noir","noisette","palme","pate","petit-dejeuner","p...<br>["chamomile","herbal","lagg","null","tea"] |
| added_countries_tags | 3000/3000 | array | [] |
| additives_debug_tags | 198/3000 | array | []<br>["en-e322i-added","en-e341-added","en-e420i-added","en-e500-added","en-e965-added"] |
| additives_n | 2720/3000 | number | 0<br>4 |
| additives_old_n | 173/3000 | number | 0<br>3 |
| additives_old_tags | 198/3000 | array | []<br>["en:e420","en:e965","en:e967"] |
| additives_original_tags | 2753/3000 | array | []<br>["en:e471","en:e322i","en:e202","en:e330"] |
| additives_prev_original_tags | 198/3000 | array | []<br>["en:e1510","en:e322"] |
| additives_tags | 2753/3000 | array | []<br>["en:e202","en:e322","en:e322i","en:e330","en:e471"] |
| additives_tags_n | 64/3000 | null | null |
| allergens | 3000/3000 | string | en:nuts<br>en:milk,en:soybeans |
| allergens_debug_tags | 27/3000 | array | [] |
| allergens_from_ingredients | 3000/3000 | string | en:soybeans, en:milk, MILK<br>en:soybeans, en:milk, milk |
| allergens_from_user | 3000/3000 | string | (fr) en:nuts<br>(en)  |
| allergens_hierarchy | 3000/3000 | array | ["en:nuts"]<br>[] |
| allergens_imported | 1196/3000 | string | Milk<br>Gluten |
| allergens_lc | 539/3000 | string | fr<br>en |
| allergens_tags | 3000/3000 | array | ["en:nuts"]<br>[] |
| amino_acids_prev_tags | 2997/3000 | array | [] |
| amino_acids_tags | 2999/3000 | array | []<br>["en:l-cysteine"] |
| brand_owner | 2128/3000 | string | LAGG'S<br>Heartlight Corp. Of America |
| brand_owner_imported | 2128/3000 | string | LAGG'S<br>Heartlight Corp. Of America |
| brands | 2911/3000 | string | Bovetti<br>Lagg's |
| brands_debug_tags | 855/3000 | array | [] |
| brands_hierarchy | 791/3000 | array | ["xx:Bovetti"]<br>["xx:Lagg's"] |
| brands_lc | 791/3000 | string | xx |
| brands_old | 368/3000 | string | Bovetti<br>allfitnessfactory.de |
| brands_tags | 2912/3000 | array | ["xx:bovetti"]<br>["lagg-s"] |
| carbon_footprint_from_known_ingredients_debug | 65/3000 | string | en:wheat-germ 1% x 0.6 = 0.6 g - <br>en:tomato-sauce 17% x 2.9 = 49.3 g - en:tomato 3.3% x 0.5 = 1.65 g -  |
| carbon_footprint_from_meat_or_fish_debug | 6/3000 | string | en:pork-meat => en:pork-meat 86% x 7.4 = 636.4 g<br>en:chicken-breast => en:chicken-meat 20% x 4.9 = 98 g |
| carbon_footprint_percent_of_known_ingredients | 69/3000 | number | 1<br>20.3 |
| categories | 2724/3000 | string | Petit-déjeuners,Produits à tartiner,Produits à tartiner sucrés,Pâtes à tartiner,Pâtes à tartiner aux noisettes,Pâtes à t...<br>null |
| categories_debug_tags | 29/3000 | array | [] |
| categories_hierarchy | 2751/3000 | array | ["en:breakfasts","en:spreads","en:sweet-spreads","fr:pates-a-tartiner","en:hazelnut-spreads","en:chocolate-spreads","en:...<br>["en:null"] |
| categories_imported | 2095/3000 | string | Plant-based foods and beverages, Beverages, Hot beverages, Plant-based beverages, Teas, Tea bags<br>Plant-based foods and beverages, Plant-based foods, Fats, Vegetable fats, Vegetable oils |
| categories_lc | 2724/3000 | string | fr<br>en |
| categories_next_hierarchy | 1/3000 | array | [] |
| categories_next_tags | 1/3000 | array | [] |
| categories_old | 2563/3000 | string | Petit-déjeuners, Produits à tartiner, Produits à tartiner sucrés, Pâtes à tartiner, Pâtes à tartiner aux noisettes, Pâte...<br>Plant-based foods and beverages, Beverages, Hot beverages, Plant-based beverages, Teas, Tea bags |
| categories_prev_hierarchy | 28/3000 | array | [] |
| categories_prev_tags | 28/3000 | array | [] |
| categories_properties | 3000/3000 | object | {"agribalyse_food_code:en":"31032","ciqual_food_code:en":"31032","agribalyse_proxy_food_code:en":"31032"}<br>{} |
| categories_properties_tags | 3000/3000 | array | ["all-products","categories-known","agribalyse-food-code-31032","agribalyse-food-code-known","agribalyse-proxy-food-code...<br>["all-products","categories-known","agribalyse-food-code-unknown","agribalyse-proxy-food-code-unknown","ciqual-food-code... |
| categories_tags | 2751/3000 | array | ["en:breakfasts","en:spreads","en:sweet-spreads","fr:pates-a-tartiner","en:hazelnut-spreads","en:chocolate-spreads","en:...<br>["en:null"] |
| category_properties | 2997/3000 | object | {"ciqual_food_name:en":"Chocolate spread with hazelnuts"}<br>{} |
| checked | 3/3000 | string | on |
| checkers | 1/3000 | array | [] |
| checkers_tags | 3000/3000 | array | []<br>["aleene"] |
| ciqual_food_name_tags | 2997/3000 | array | ["chocolate-spread-with-hazelnuts"]<br>["unknown"] |
| cities_tags | 488/3000 | array | []<br>["kervignac-morbihan-france"] |
| code | 3000/3000 | string | 0000101209159<br>0000105000011 |
| codes_tags | 3000/3000 | array | ["code-13","conflict-with-upc-12","0000101209xxx","000010120xxxx","00001012xxxxx","0000101xxxxxx","000010xxxxxxx","00001...<br>["code-13","conflict-with-upc-12","0000105000xxx","000010500xxxx","00001050xxxxx","0000105xxxxxx","000010xxxxxxx","00001... |
| compared_to_category | 2549/3000 | string | en:cocoa-and-hazelnuts-spreads<br>en:tea-bags |
| complete | 3000/3000 | number | 0<br>1 |
| completed_t | 3/3000 | number | 1736724474<br>1677123944 |
| completeness | 3000/3000 | number | 0.6874999999999999<br>0.6 |
| correctors | 1/3000 | array | ["javichu"] |
| correctors_tags | 3000/3000 | array | ["openfoodfacts-contributors","tacite-mass-editor","sebleouf","moon-rabbit","roboto-app","timotheeberthault"]<br>["org-database-usda","openfoodfacts-contributors"] |
| countries | 3000/3000 | string | France<br>United States |
| countries_beforescanbot | 31/3000 | string | en:AU<br>United States |
| countries_debug_tags | 1298/3000 | array | [] |
| countries_hierarchy | 3000/3000 | array | ["en:france"]<br>["en:united-states"] |
| countries_imported | 2128/3000 | string | United States<br>France |
| countries_lc | 2998/3000 | null, string | fr<br>en |
| countries_tags | 3000/3000 | array | ["en:france"]<br>["en:united-states"] |
| created_t | 3000/3000 | number | 1519297017<br>1489055330 |
| creator | 3000/3000 | string | kiliweb<br>usda-ndb-import |
| data_quality_bugs_tags | 3000/3000 | array | [] |
| data_quality_completeness_tags | 223/3000 | array | ["en:photo-and-data-to-be-checked-by-an-experienced-contributor","en:ingredients-en-photo-to-be-selected","en:ingredient...<br>["en:photo-and-data-to-be-checked-by-an-experienced-contributor","en:ingredients-de-photo-to-be-selected","en:ingredient... |
| data_quality_dimensions | 223/3000 | object | {"accuracy":{"overall":"0.00"},"completeness":{"packaging":"0.50","ingredients":"0.50","overall":"0.50","nutrition":"0.6...<br>{"accuracy":{"overall":"0.00"},"completeness":{"overall":"0.50","ingredients":"0.50","packaging":"0.50","nutrition":"0.6... |
| data_quality_errors_tags | 3000/3000 | array | []<br>["en:nutrition-value-total-over-105","en:energy-value-in-kcal-does-not-match-value-computed-from-other-nutrients"] |
| data_quality_info_tags | 3000/3000 | array | ["en:packaging-data-incomplete","en:environmental-score-extended-data-not-computed","en:food-groups-1-known","en:food-gr...<br>["en:no-packaging-data","en:ingredients-percent-analysis-ok","en:all-but-one-ingredient-with-specified-percent","en:envi... |
| data_quality_tags | 3000/3000 | array | ["en:packaging-data-incomplete","en:environmental-score-extended-data-not-computed","en:food-groups-1-known","en:food-gr...<br>["en:no-packaging-data","en:ingredients-percent-analysis-ok","en:all-but-one-ingredient-with-specified-percent","en:envi... |
| data_quality_warning_tags | 1/3000 | array | ["en:sum-of-ingredients-with-specified-percent-greater-than-200"] |
| data_quality_warnings_tags | 3000/3000 | array | ["en:environmental-score-origins-of-ingredients-origins-are-100-percent-unknown","en:environmental-score-packaging-unsco...<br>["en:environmental-score-origins-of-ingredients-origins-are-100-percent-unknown","en:environmental-score-packaging-packa... |
| data_sources | 2879/3000 | string | App - yuka, Apps<br>Database - USDA NDB, Databases, database-usda |
| data_sources_imported | 2128/3000 | string | Databases, database-usda<br>Apps, app-foodbowel |
| data_sources_tags | 2879/3000 | array | ["app-yuka","apps"]<br>["database-usda-ndb","databases","database-usda"] |
| debug_param_sorted_langs | 389/3000 | array | ["fr"]<br>["de"] |
| ecoscore_data | 926/3000 | object | {"missing":{"labels":1,"packagings":1,"origins":1},"agribalyse":{"co2_processing":0,"agribalyse_proxy_food_code":"18020"...<br>{"missing_agribalyse_match_warning":1,"agribalyse":{"warning":"missing_agribalyse_match"},"missing":{"packagings":1,"lab... |
| ecoscore_extended_data | 117/3000 | object | {"impact":{"uncharacterized_ingredients_mass_proportion":{"impact":0.3758411911482487,"nutrition":0.016398179888794433},...<br>{"error":"Exception: estimation process timed out after 600 seconds"} |
| ecoscore_extended_data_version | 117/3000 | string | 4<br>2 |
| ecoscore_grade | 926/3000 | string | a<br>unknown |
| ecoscore_score | 173/3000 | number | 80<br>40 |
| ecoscore_tags | 2998/3000 | array | ["d"]<br>["unknown"] |
| editors | 119/3000 | array | ["elttor","hangy","malikele","upcbot"]<br>["","elttor","hangy","malikele","upcbot"] |
| editors_tags | 3000/3000 | array | ["kiliweb","moon-rabbit","openfoodfacts-contributors","roboto-app","sebleouf","tacite-mass-editor","timotheeberthault","...<br>["openfoodfacts-contributors","org-database-usda","usda-ndb-import"] |
| emb_codes | 488/3000 | string | FR 56.094.004 EC<br>080503190204 |
| emb_codes_20141016 | 146/3000 | null, string | ES 26.01038/SO EC,FABRICANTE Y ENVASADOR:,SORIA NATURAL S.A.<br>FR 31.090.010 CE |
| emb_codes_debug_tags | 101/3000 | array | [] |
| emb_codes_orig | 230/3000 | string | FR 56.094.004 CE<br>ES 26.01038/SO EC,SORIA NATURAL S.A. |
| emb_codes_tags | 488/3000 | array | []<br>["fr-56-094-004-ec"] |
| entry_dates_tags | 3000/3000 | array | ["2018-02-22","2018-02","2018"]<br>["2017-03-09","2017-03","2017"] |
| environment_impact_level | 17/3000 | string | - |
| environment_impact_level_tags | 17/3000 | array | [] |
| environmental_score_data | 2079/3000 | object | {"adjustments":{"packaging":{"non_recyclable_and_non_biodegradable_materials":0,"score":61,"warning":"unscored_shape","v...<br>{"status":"unknown","adjustments":{"production_system":{"labels":[],"value":0,"warning":"no_label"},"origins_of_ingredie... |
| environmental_score_grade | 2079/3000 | string | d<br>unknown |
| environmental_score_score | 317/3000 | number | 42<br>80 |
| environmental_score_tags | 2079/3000 | array | ["d"]<br>["unknown"] |
| expiration_date | 499/3000 | string | 2018-08-31<br>28.01.2020 |
| expiration_date_debug_tags | 93/3000 | array | [] |
| food_groups | 980/3000 | string | en:sweets<br>en:unsweetened-beverages |
| food_groups_tags | 3000/3000 | array | ["en:sugary-snacks","en:sweets"]<br>[] |
| forest_footprint_data | 345/3000 | object | {"ingredients":[{"conditions_tags":[],"type":{"soy_feed_factor":0.035,"deforestation_risk":0.68,"soy_yield":0.3,"name":"...<br>{"ingredients":[{"percent_estimate":0.34722222222222854,"processing_factor":1,"type":{"name":"Oeufs Importés","soy_feed_... |
| fruits-vegetables-nuts_100g_estimate | 2012/3000 | number, string | 0<br>85 |
| generic_name | 449/3000 | string | Mehrkomponeneten Protein in Haselnuß Geschmack<br>Mehrkomponeneten Protein in Bananen Geschmack |
| generic_name_ar | 2/3000 | string | - |
| generic_name_de | 12/3000 | string | Mehrkomponeneten Protein in Haselnuß Geschmack<br>Mehrkomponeneten Protein in Bananen Geschmack |
| generic_name_de_debug_tags | 9/3000 | array | [] |
| generic_name_en | 321/3000 | string | Wheat flour - coconut oil - dehydrated glucose syrup - sugar hazelnuts 10.8% in the cream corresponding to 8,6% of the t...<br>Palm oil, sugar, low fat cocoa, whey powder, cocoa powder, soy lecithin, vanilla extract. fancy truffles. |
| generic_name_en_debug_tags | 33/3000 | array | [] |
| generic_name_en_imported | 15/3000 | string | Wheat flour - coconut oil - dehydrated glucose syrup - sugar hazelnuts 10.8% in the cream corresponding to 8,6% of the t...<br>Palm oil, sugar, low fat cocoa, whey powder, cocoa powder, soy lecithin, vanilla extract. fancy truffles. |
| generic_name_es | 2/3000 | string | Pepinillos Rebanados<br>Seitán ecológico en lonchas |
| generic_name_es_debug_tags | 1/3000 | array | [] |
| generic_name_fr | 205/3000 | string | Confiserie<br>assaisonnement |
| generic_name_fr_debug_tags | 83/3000 | array | [] |
| generic_name_it | 2/3000 | string | Chocolate block |
| generic_name_it_debug_tags | 1/3000 | array | [] |
| generic_name_la | 3/3000 | string | - |
| generic_name_nl | 7/3000 | string | Boterkoekjes met sinaasappelsmaak en gedroogde gezoete cranberry's |
| generic_name_nl_debug_tags | 3/3000 | array | [] |
| generic_name_th | 1/3000 | string | - |
| id | 3000/3000 | string | 0000101209159<br>0000105000011 |
| images | 1179/3000 | object | {"1":{"uploader":"kiliweb","uploaded_t":"1519297019","sizes":{"100":{"w":75,"h":100},"400":{"w":300,"h":400},"full":{"w"...<br>{"1":{"uploader":"openfoodfacts-contributors","uploaded_t":1632611836,"sizes":{"100":{"h":100,"w":93},"400":{"h":400,"w"... |
| informers | 1/3000 | array | ["javichu"] |
| informers_tags | 3000/3000 | array | ["yuka.SGJvbVRKUXpoT2tVaHZCaDNEUEl4NHdrbDdpNVcwR3FEc0E2SVE9PQ","kiliweb","sebleouf","moon-rabbit","roboto-app","timothee...<br>["usda-ndb-import","org-database-usda","openfoodfacts-contributors"] |
| ingredients | 2720/3000 | array | [{"is_in_taxonomy":1,"percent_min":100,"vegan":"yes","percent_max":100,"text":"CHAMOMILE FLOWERS","vegetarian":"yes","pe...<br>[{"id":"en:peppermint","percent_estimate":100,"percent_max":100,"vegan":"yes","vegetarian":"yes","is_in_taxonomy":1,"per... |
| ingredients_analysis | 2725/3000 | object | {}<br>{"en:vegetarian-status-unknown":["en:linden-flowers"],"en:palm-oil-content-unknown":["en:linden-flowers"],"en:vegan-stat... |
| ingredients_analysis_tags | 2725/3000 | array | ["en:palm-oil-free","en:vegan","en:vegetarian"]<br>["en:palm-oil-content-unknown","en:vegan-status-unknown","en:vegetarian-status-unknown"] |
| ingredients_debug | 2/3000 | array | ["Milk chocolate ","(","(",null,null,"sugar",",",null,null,null," milk",",",null,null,null," cocoa butter",",",null,null...<br>["SEITÁN 83%",":",":",null,null," Agua",",",null,null,null," gluten de _trigo_*",",",null,null,null," harina de _trigo_*... |
| ingredients_from_or_that_may_be_from_palm_oil_n | 2708/3000 | number | 0<br>1 |
| ingredients_from_palm_oil_n | 2698/3000 | number | 0<br>1 |
| ingredients_from_palm_oil_tags | 2999/3000 | array | []<br>["huile-de-palme"] |
| ingredients_hierarchy | 2088/3000 | array | ["en:camomile-flower","en:herb","en:camomile"]<br>["en:peppermint","en:herb","en:mint"] |
| ingredients_ids_debug | 2/3000 | array | ["milk-chocolate","sugar","milk","cocoa-butter","chocolate","soy-lecithin-an-emulsifier","vanillian-an-artificial-flavor...<br>["seitan-83","agua","gluten-de-trigo","harina-de-trigo","caldo-de-alga-kombu","agua-y-alga-kombu","16","salsa-de-soja","... |
| ingredients_lc | 2559/3000 | string | en<br>de |
| ingredients_n | 2720/3000 | number, string | 1<br>3 |
| ingredients_n_tags | 2720/3000 | array | ["1","1-10"]<br>["3","1-10"] |
| ingredients_non_nutritive_sweeteners_n | 2546/3000 | number | 0<br>2 |
| ingredients_original_tags | 2720/3000 | array | ["en:camomile-flower"]<br>["en:peppermint"] |
| ingredients_percent_analysis | 2720/3000 | number | 1<br>-1 |
| ingredients_sweeteners_n | 2546/3000 | number | 0<br>1 |
| ingredients_tags | 2720/3000 | array | ["en:camomile-flower","en:herb","en:camomile"]<br>["en:peppermint","en:herb","en:mint"] |
| ingredients_text | 2804/3000 | string | CHAMOMILE FLOWERS.<br>Peppermint. |
| ingredients_text_ar | 2/3000 | string | - |
| ingredients_text_cs | 1/3000 | string | Krupice z tvrdé pšenice, pitná voda |
| ingredients_text_de | 12/3000 | string | Proteinmischung (_Sojaprotein_, _Weizenprotein_, _Molkenprotein_, _Wheyprotein_), _Milchprotein_, _Hühnereiweiss_, Kakao...<br>100% Soja-Protein-Isolat (_Soja_), Aroma, Süßstoff Natrium-Saccharin. |
| ingredients_text_de_debug_tags | 9/3000 | array | [] |
| ingredients_text_debug | 2997/3000 | null, string | Chamomile flowers.<br>Peppermint. |
| ingredients_text_debug_tags | 137/3000 | array | [] |
| ingredients_text_en | 2637/3000 | string | CHAMOMILE FLOWERS.<br>Peppermint. |
| ingredients_text_en_debug_tags | 31/3000 | array | [] |
| ingredients_text_en_imported | 2119/3000 | string | Chamomile flowers.<br>Peppermint. |
| ingredients_text_en_ocr_1545732141 | 1/3000 | string | Corn syrup, enriched flour (wheat flour, niacin, reduced iron, thiamine mononitrate, roboflavin, folic acid), sugar, egg... |
| ingredients_text_en_ocr_1545732141_result | 1/3000 | string | Corn syrup, enriched flour (wheat flour, niacin, reduced iron, thiamine mononitrate, roboflavin, folic acid), sugar, egg... |
| ingredients_text_en_ocr_1545921985 | 1/3000 | string | Ingredients: ice cream: milk, cream, sugar syrup, corn syrup, whey, buttermilk. maltodextrin, cellulose gel, mono- and d... |
| ingredients_text_en_ocr_1545921985_result | 1/3000 | string | Ingredients: ice cream: milk, cream, sugar syrup, corn syrup, whey, buttermilk. maltodextrin, cellulose gel, mono - and ... |
| ingredients_text_en_ocr_1550256471 | 1/3000 | string | Clusters of toffee popcorn pieces (220/ crisped rice (9%) and salted caramel flavour fudge pieces (7%) covered in milk c... |
| ingredients_text_en_ocr_1550256471_result | 1/3000 | string | Clusters of toffee popcorn pieces (220/ crisped rice (9%) and salted caramel flavour fudge pieces (7%) covered in milk c... |
| ingredients_text_en_ocr_1550522031 | 7/3000 | string | Modified corn starch, maltodextrin, wheat flour, whey protein concentrate, salt, partially hydrogenated soybean and/or c...<br>Ice cream - milk and skim milk, cream, sugar, corn syrup, high fructose corn syrup, whey, buttermilk, brown sugar, cellu... |
| ingredients_text_en_ocr_1550522031_result | 7/3000 | string | Modified corn starch, maltodextrin, wheat flour, whey protein concentrate, salt, partially hydrogenated soybean and/or c...<br>Ice cream - milk and skim milk, cream, sugar, corn syrup, high fructose corn syrup, whey, buttermilk, brown sugar, cellu... |
| ingredients_text_en_ocr_1550522033 | 1/3000 | string | Milk, cream, sugar, corn syrup, high fructose corn syrup, cocoa processed with alkali, whey, buttermilk, cellulose gel, ... |
| ingredients_text_en_ocr_1550522033_result | 1/3000 | string | Milk, cream, sugar, corn syrup, high fructose corn syrup, cocoa processed with alkali, whey, buttermilk, cellulose gel, ... |
| ingredients_text_en_ocr_1550522035 | 2/3000 | string | Salted caramel seasoned almonds and cashews (almonds, cashews, vegetable oil [peanut, cottonseed, soybean, and/or sunflo...<br>Enriched flour bleached (wheat flour, malted barley flour, niacin, reduced iron, thiamine mononitrate, riboflavin, folic... |
| ingredients_text_en_ocr_1550522035_result | 2/3000 | string | Salted caramel seasoned almonds and cashews (almonds, cashews, vegetable oil [peanut, cottonseed, soybean, and/or sunflo...<br>Enriched flour bleached (wheat flour, malted barley flour, niacin, reduced iron, thiamine mononitrate, riboflavin, folic... |
| ingredients_text_en_ocr_1550522036 | 3/3000 | string | Water, enriched flour (wheat flour, malted barley, niacin, reduced iron, thiamine mononitrate, riboflavin, folic acid), ...<br>Corn starch, contains 2% or less of: partially hydrogenated soybean and/or cottonseed and/or canola oil, mono- and digly... |
| ingredients_text_en_ocr_1550522036_result | 3/3000 | string | Water, enriched flour (wheat flour, malted barley, niacin, reduced iron, thiamine mononitrate, riboflavin, folic acid), ...<br>Corn starch, contains 2% or less of: partially hydrogenated soybean and/or cottonseed and/or canola oil, mono - and digl... |
| ingredients_text_en_ocr_1550522037 | 4/3000 | string | Sugar, enriched flour (wheat flour, niacin, reduced iron, thiamine mononitrate, riboflavin, folic acid), corn syrup, hig...<br>Enriched flour (wheat flour, malted barley flour, niacin, reduced iron, thiamine mononitrate, riboflavin, folic acid), w... |
| ingredients_text_en_ocr_1550522037_result | 4/3000 | string | Sugar, enriched flour (wheat flour, niacin, reduced iron, thiamine mononitrate, riboflavin, folic acid), corn syrup, hig...<br>Enriched flour (wheat flour, malted barley flour, niacin, reduced iron, thiamine mononitrate, riboflavin, folic acid), w... |
| ingredients_text_en_ocr_1550522039 | 1/3000 | string | Cultured skim milk, cultured cream, salt, whey, guar gum, sorbic acid (to maintain freshness), citric acid, locust bean ... |
| ingredients_text_en_ocr_1550522039_result | 1/3000 | string | Cultured skim milk, cultured cream, salt, whey, guar gum, sorbic acid (to maintain freshness), citric acid, locust bean ... |
| ingredients_text_en_ocr_1550522042 | 1/3000 | string | Pasteurized part -skim milk, cheese culture, salt, enzymes, calcium chloride, potato starch, corn starch, dextrose and c... |
| ingredients_text_en_ocr_1550522042_result | 1/3000 | string | Pasteurized part - skim milk, cheese culture, salt, enzymes, calcium chloride, potato starch, corn starch, dextrose and ... |
| ingredients_text_en_ocr_1550522044 | 6/3000 | string | Milk, sugar syrup, corn syrup, cream, skim milk, buttermilk, high fructose corn syrup, whey protein concentrate, propyle...<br>Milk, sugar, syrup, corn syrup, cream skim milk, buttermilk, high fructose corn syrup, whey protein concentrate, propyle... |
| ingredients_text_en_ocr_1550522044_result | 6/3000 | string | Milk, sugar syrup, corn syrup, cream, skim milk, buttermilk, high fructose corn syrup, whey protein concentrate, propyle...<br>Milk, sugar, syrup, corn syrup, cream skim milk, buttermilk, high fructose corn syrup, whey protein concentrate, propyle... |
| ingredients_text_en_ocr_1550522045 | 11/3000 | string | Milk, cream, sugar syrup, corn syrup, black walnuts, high fructose corn syrup, whey, skim milk, buttermilk powder, cellu...<br>Ice cream: milk, cream, sugar syrup, corn syrup, high fructose corn syrup, whey, buttermilk, natural and artificial flav... |
| ingredients_text_en_ocr_1550522045_result | 11/3000 | string | Milk, cream, sugar syrup, corn syrup, black walnuts, high fructose corn syrup, whey, skim milk, buttermilk powder, cellu...<br>Ice cream: milk, cream, sugar syrup, corn syrup, high fructose corn syrup, whey, buttermilk, natural and artificial flav... |
| ingredients_text_en_ocr_1550522046 | 10/3000 | string | Water, sugar syrup, milk* and skim milk*, corn syrup, pineapple, high fructose corn syrup, pineapple juice concentrate, ...<br>Milk, cream, sugar syrup, corn syrup, high fructose corn syrup, whey, skim milk, artificial and natural flavor, cellulos... |
| ingredients_text_en_ocr_1550522046_result | 10/3000 | string | Water, sugar syrup, milk* and skim milk*, corn syrup, pineapple, high fructose corn syrup, pineapple juice concentrate, ...<br>Milk, cream, sugar syrup, corn syrup, high fructose corn syrup, whey, skim milk, artificial and natural flavor, cellulos... |
| ingredients_text_en_ocr_1550522047 | 1/3000 | string | Ice cream: - milk, cream, corn syrup, sugar, whey, buttermilk, maltodextrin, strawberries, cocoa processed with alkali, ... |
| ingredients_text_en_ocr_1550522047_result | 1/3000 | string | Ice cream: - milk, cream, corn syrup, sugar, whey, buttermilk, maltodextrin, strawberries, cocoa processed with alkali, ... |
| ingredients_text_en_ocr_1550522050 | 1/3000 | string | Ingredients: rolled oats, sugar, flavored fruit pieces (dehydrated apples, artificial flavor, calcium stearate (flow age... |
| ingredients_text_en_ocr_1550522050_result | 1/3000 | string | Ingredients: rolled oats, sugar, flavored fruit pieces (dehydrated apples, artificial flavor, calcium stearate (flow age... |
| ingredients_text_en_ocr_1550522051 | 2/3000 | string | Sugar, modified tapioca and corn starch, dextrose, cocoa processed with alkali, contains 2% or less of: tetrasodium pyro...<br>Sugar, cornstarch, rice flour, partially hydrogenated vegetable oil (soybean, cottonseed), gum arabic, xanthan gum, natu... |
| ingredients_text_en_ocr_1550522051_result | 2/3000 | string | Sugar, modified tapioca and corn starch, dextrose, cocoa processed with alkali, contains 2% or less of: tetrasodium pyro...<br>Sugar, cornstarch, rice flour, partially hydrogenated vegetable oil (soybean, cottonseed), gum arabic, xanthan gum, natu... |
| ingredients_text_en_ocr_1550522052 | 4/3000 | string | Sugar, enriched bleached wheat flour (flour, niacin, reduced iron, thiamine mononitrate, riboflavin, folic acid), margar...<br>Modified corn starch, tapioca maltodextrin*, disodium phosphate, tetrasodium pyrophosphate natural and artificial flavor... |
| ingredients_text_en_ocr_1550522052_result | 4/3000 | string | Sugar, enriched bleached wheat flour (flour, niacin, reduced iron, thiamine mononitrate, riboflavin, folic acid), margar...<br>Modified corn starch, tapioca maltodextrin*, disodium phosphate, tetrasodium pyrophosphate natural and artificial flavor... |
| ingredients_text_en_ocr_1550522053 | 1/3000 | string | Modified corn starch, wheat flour, salt, maltodextrin, mushrooms*, hydrolyzed corn gluten and torula yeast extract, beef... |
| ingredients_text_en_ocr_1550522053_result | 1/3000 | string | Modified corn starch, wheat flour, salt, maltodextrin, mushrooms*, hydrolyzed corn gluten and torula yeast extract, beef... |
| ingredients_text_en_ocr_1550522064 | 5/3000 | string | Milk, cream, corn syrup, sugar, high fructose corn syrup, whey, buttermilk, cellulose gel, guar gum, cellulose gum, mono...<br>Milk, cream, sugar syrup, corn syrup, high fructose corn syrup, whey, skim milk, natural and artificial flavors, cellulo... |
| ingredients_text_en_ocr_1550522064_result | 5/3000 | string | Milk, cream, corn syrup, sugar, high fructose corn syrup, whey, buttermilk, cellulose gel, guar gum, cellulose gum, mono...<br>Milk, cream, sugar syrup, corn syrup, high fructose corn syrup, whey, skim milk, natural and artificial flavors, cellulo... |
| ingredients_text_en_ocr_1550522065 | 3/3000 | string | Water, sugar syrup, milk* and skim milk*, corn syrup, orange pulp, concentrated orange juice, high fructose corn syrup, ...<br>Nonfat sherbet - skim milk, water, sugar, corn syrup, concentrated raspberry juice, high fructose corn syrup, raspberry ... |
| ingredients_text_en_ocr_1550522065_result | 3/3000 | string | Water, sugar syrup, milk* and skim milk*, corn syrup, orange pulp, concentrated orange juice, high fructose corn syrup, ...<br>Nonfat sherbet - skim milk, water, sugar, corn syrup, concentrated raspberry juice, high fructose corn syrup, raspberry ... |
| ingredients_text_en_ocr_1550522066 | 1/3000 | string | Potatoes, sour cream (cream, skim milk, modified corn starch, lactic and citric acid, beef gelatin, mono- and diglycerid... |
| ingredients_text_en_ocr_1550522066_result | 1/3000 | string | Potatoes, sour cream (cream, skim milk, modified corn starch, lactic and citric acid, beef gelatin, mono - and diglyceri... |
| ingredients_text_en_ocr_1550522068 | 1/3000 | string | Modified tapioca and corn starch, hydrolyzed corn gluten, soy protein and whet gluten, salt, dextrose, whey*, autolyzed ... |
| ingredients_text_en_ocr_1550522068_result | 1/3000 | string | Modified tapioca and corn starch, hydrolyzed corn gluten, soy protein and whet gluten, salt, dextrose, whey*, autolyzed ... |
| ingredients_text_en_ocr_1550522070 | 1/3000 | string | Frozen yogurt - cultured pasteurized milk and skim milk, sugar, corn syrup, buttermilk, cocoa processed with alkali, whe... |
| ingredients_text_en_ocr_1550522070_result | 1/3000 | string | Frozen yogurt - cultured pasteurized milk and skim milk, sugar, corn syrup, buttermilk, cocoa processed with alkali, whe... |
| ingredients_text_en_ocr_1562124897 | 1/3000 | string | Nonfat sherbet - skim milk*. sugar, water, corn syrup, milk*, orange pulp, concentrated orange juice, high fructose corn... |
| ingredients_text_en_ocr_1562124897_result | 1/3000 | string | Nonfat sherbet - skim milk*. sugar, water, corn syrup, milk*, orange pulp, concentrated orange juice, high fructose corn... |
| ingredients_text_en_ocr_1562550888 | 1/3000 | string | Milk, cream, sugar, corn syrup, coffee concentrate, whey protein concentrate, propylene glycol monoesters, guar gum, cel... |
| ingredients_text_en_ocr_1562550888_result | 1/3000 | string | Milk, cream, sugar, corn syrup, coffee concentrate, whey protein concentrate, propylene glycol monoesters, guar gum, cel... |
| ingredients_text_en_ocr_1563074700 | 1/3000 | string | Ice cream - milk, cream, sugar, corn syrup, whey protein concentrate, egg yolks, natural flavor, propylene glycol monoes... |
| ingredients_text_en_ocr_1563074700_result | 1/3000 | string | Ice cream - milk, cream, sugar, corn syrup, whey protein concentrate, egg yolks, natural flavor, propylene glycol monoes... |
| ingredients_text_en_ocr_1563189279 | 1/3000 | string | Ice cream: milk, cream, sugar, corn syrup, high fructose corn syrup, whey, buttermilk, sugar, guar gum, mono- and diglyc... |
| ingredients_text_en_ocr_1563189279_result | 1/3000 | string | Ice cream: milk, cream, sugar, corn syrup, high fructose corn syrup, whey, buttermilk, sugar, guar gum, mono - and digly... |
| ingredients_text_en_ocr_1563189298 | 3/3000 | string | Ice cream - milk, cream, sugar, corn syrup, natural flavor, whey protein concentrate, high fructose corn syrup, propylen...<br>Ice cream: milk, cream, corn syrup, sugar, high fructose corn syrup, whey, buttermilk, cellulose gel, guar gum, cellulos... |
| ingredients_text_en_ocr_1563189298_result | 3/3000 | string | Ice cream - milk, cream, sugar, corn syrup, natural flavor, whey protein concentrate, high fructose corn syrup, propylen...<br>Ice cream: milk, cream, corn syrup, sugar, high fructose corn syrup, whey, buttermilk, cellulose gel, guar gum, cellulos... |
| ingredients_text_en_ocr_1563348503 | 1/3000 | string | Whole wheat flour (malted barley), water, whole spelt flour, whole white wheat flour, sugar, wheat gluten, whole bulgur ... |
| ingredients_text_en_ocr_1563348503_result | 1/3000 | string | Whole wheat flour (malted barley), water, whole spelt flour, whole white wheat flour, sugar, wheat gluten, whole bulgur ... |
| ingredients_text_en_ocr_1563792802 | 1/3000 | string | Heavy cream (heavy cream, carrageenan, mono- and diglycerides), sugar, water, cream cheese (pasteurized milk and cream, ... |
| ingredients_text_en_ocr_1563792802_result | 1/3000 | string | Heavy cream (heavy cream, carrageenan, mono - and diglycerides), sugar, water, cream cheese (pasteurized milk and cream,... |
| ingredients_text_en_ocr_1564023541 | 1/3000 | string | Water, whole wheat flour, unbleached enriched wheat flour (wheat flour, niacin, iron, thiamine mononitrate, riboflavin, ... |
| ingredients_text_en_ocr_1564023541_result | 1/3000 | string | Water, whole wheat flour, unbleached enriched wheat flour (wheat flour, niacin, iron, thiamine mononitrate, riboflavin, ... |
| ingredients_text_en_ocr_1574118744 | 1/3000 | string | INGREDIENTS: PORK, WATER, CORN SYRUP CONTAINS 2% OR LESS 0F: SALT SODIUM LACTATE, BROWN SUGAR TOMATO POWDER, SUGAR, SPIC... |
| ingredients_text_en_ocr_1574118744_result | 1/3000 | string | INGREDIENTS: PORK, WATER, CORN SYRUP CONTAINS 2% OR LESS 0F: SALT SODIUM LACTATE, BROWN SUGAR TOMATO POWDER, SUGAR, SPIC... |
| ingredients_text_en_ocr_1574121916 | 1/3000 | string | Orange Juice (26%) - Carrot Purée (22 %) - Apple Purée - Apple Juice - Banana Purée - Mango Purée (7 %) - Pumpkin Purée ... |
| ingredients_text_en_ocr_1574121916_result | 1/3000 | string | Orange Juice (26%) - Carrot Purée (22 %) - Apple Purée - Apple Juice - Banana Purée - Mango Purée (7 %) - Pumpkin Purée ... |
| ingredients_text_en_ocr_1582913374 | 1/3000 | string | ingredients: prepared red beans, water, salt, calcium disodium edta added to promote color retention, |
| ingredients_text_en_ocr_1582913374_result | 1/3000 | string | prepared red beans, water, salt, calcium disodium edta added to promote color retention, |
| ingredients_text_en_ocr_1585176090 | 1/3000 | string | ingredients: water, soybean oil, high fructose corn syrup, distilled vinegar, salt, contains 2% or less of : dried garli... |
| ingredients_text_en_ocr_1585176090_result | 1/3000 | string | water, soybean oil, high fructose corn syrup, distilled vinegar, salt, contains 2% or less of : dried garlic, dried onio... |
| ingredients_text_en_ocr_1585414176 | 1/3000 | string | INGREDIENTS: ENRICHED FLOUR (WHEAT
FLOUR, MALTED BARLEY FLOUR, NIACIN,
REDUCED IRON, THIAMINE MONONITRATE
RIBOFLAVIN, FO... |
| ingredients_text_en_ocr_1585414176_result | 1/3000 | string | ENRICHED FLOUR (WHEAT
FLOUR, MALTED BARLEY FLOUR, NIACIN,
REDUCED IRON, THIAMINE MONONITRATE
RIBOFLAVIN, FOLIC ACID), WA... |
| ingredients_text_en_ocr_1594040535 | 1/3000 | string | Porc d’origine britannique (élaboré avec 120 g de porc cru pour 100 g de jambon rôti au miel); Sucre; Miel (2%); Sels de... |
| ingredients_text_en_ocr_1594040535_result | 1/3000 | string | Porc d’origine britannique (élaboré avec 120 g de porc cru pour 100 g de jambon rôti au miel); Sucre; Miel (2%); Sels de... |
| ingredients_text_en_ocr_1596556204 | 1/3000 | string | Sugar, Raspberries, Acidity Regulators (Citric Acid, Sodium Citrate), Gelling Agent (Pectin)   |
| ingredients_text_en_ocr_1596556204_result | 1/3000 | string | Sugar, Raspberries, Acidity Regulators (Citric Acid, Sodium Citrate), Gelling Agent (Pectin) |
| ingredients_text_en_ocr_1600727187 | 1/3000 | string | INGREDIENTS: PORK, WATER, CORN SYRUP CONTAINS 2% OR LESS 0F: SALT SODIUM LACTATE, BROWN SUGAR TOMATO POWDER, SUGAR, SPIC... |
| ingredients_text_en_ocr_1600727187_result | 1/3000 | string | PORK, WATER, CORN SYRUP CONTAINS 2% OR LESS 0F: SALT SODIUM LACTATE, BROWN SUGAR TOMATO POWDER, SUGAR, SPICES, MALTODEXT... |
| ingredients_text_en_ocr_1603524551 | 1/3000 | string | Potatoes · Sunflower Oil Sugar · Salt- Maltodextrin · Dried Garlic · Dried Onions Ground Spices (Ginger Coriander · Star... |
| ingredients_text_en_ocr_1603524551_result | 1/3000 | string | Potatoes · Sunflower Oil Sugar · Salt - Maltodextrin · Dried Garlic · Dried Onions Ground Spices (Ginger Coriander · Sta... |
| ingredients_text_en_ocr_1605336098 | 1/3000 | string | sucre sirop de glucose - fécule de pomme de terre modifiée · amidon de tapioca modifié acidifiant : acide citrique, acid... |
| ingredients_text_en_ocr_1605336098_result | 1/3000 | string | sucre sirop de glucose - fécule de pomme de terre modifiée · amidon de tapioca modifié acidifiant : acide citrique, acid... |
| ingredients_text_en_ocr_1605389497 | 1/3000 | string | Ingredients: cultured skin milk, cultured cream, whey, salt, maltodextrin, citric acid, carraceenan, guar gum, locust be... |
| ingredients_text_en_ocr_1605389497_result | 1/3000 | string | Cultured skin milk, cultured cream, whey, salt, maltodextrin, citric acid, carraceenan, guar gum, locust bean gum, cultu... |
| ingredients_text_en_ocr_1630690091 | 1/3000 | string | Ingredients: soybean oil, water, vinegar,high fructose, corn syrup, salt, sugar, contains 2% or less of: dried garlic, x... |
| ingredients_text_en_ocr_1630690091_result | 1/3000 | string | Soybean oil, water, vinegar,high fructose, corn syrup, salt, sugar, contains 2% or less of: dried garlic, xanthan gum, p... |
| ingredients_text_en_ocr_1638212133 | 1/3000 | string | Ingredients: water, distilled vinegar, molasses, salt, citric acid, dextrose, caramel color, natural flavors, malic acid... |
| ingredients_text_en_ocr_1638212133_result | 1/3000 | string | Water, distilled vinegar, molasses, salt, citric acid, dextrose, caramel color, natural flavors, malic acid, hydrolyzed ... |
| ingredients_text_en_ocr_1693249087 | 1/3000 | string | CUCUMBERS, WATER, VINEGAR, SALT, CALCIUM CHLORIDE, 0.1% SODIUM BENZOATE (PRESERVATIVE), NATURAL FLAVORS, POLYSORBATE 80,... |
| ingredients_text_en_ocr_1693249087_result | 1/3000 | string | CUCUMBERS, WATER, VINEGAR, SALT, CALCIUM CHLORIDE, 0.1% SODIUM BENZOATE (PRESERVATIVE), NATURAL FLAVORS, POLYSORBATE 80,... |
| ingredients_text_en_ocr_1724909552 | 1/3000 | string | Fortified British Wheat Flour (Wheat Flour, Calcium Carbonate, Niacin, Iron, Thiamin).   |
| ingredients_text_en_ocr_1724909552_result | 1/3000 | string | Fortified British Wheat Flour (Wheat Flour, Calcium Carbonate, Niacin, Iron, Thiamin). |
| ingredients_text_en_ocr_1729956608 | 1/3000 | string | Egg Noodles (62 %) (Wheatflour contains Gluten (with Wheatflour, Calcium Carbonate, Iron, Niacin, Thiamin) - Water Paste... |
| ingredients_text_en_ocr_1729956608_result | 1/3000 | string | Egg Noodles (62 %) (Wheatflour contains Gluten (with Wheatflour, Calcium Carbonate, Iron, Niacin, Thiamin) - Water Paste... |
| ingredients_text_en_ocr_1729988179 | 1/3000 | string | Ingredients: high fructose corn syrup, tomato puree (tomato paste, water), distilled vinegar, modified corn starch, cont... |
| ingredients_text_en_ocr_1729988179_result | 1/3000 | string | High fructose corn syrup, tomato puree (tomato paste, water), distilled vinegar, modified corn starch, contains 2% or le... |
| ingredients_text_en_ocr_1734739445 | 1/3000 | string | beef braising steak   |
| ingredients_text_en_ocr_1734739445_result | 1/3000 | string | beef braising steak |
| ingredients_text_en_ocr_1740106404 | 1/3000 | string | INGREDIENTS: DRY ROASTED ALMONDS, CASHEWS, PISTACHIOS, PURE CANE SUGAR, RICE SYRUP, DRIED BLUEBERRIES, POMEGRANATE POWDE... |
| ingredients_text_en_ocr_1740106404_result | 1/3000 | string | DRY ROASTED ALMONDS, CASHEWS, PISTACHIOS, PURE CANE SUGAR, RICE SYRUP, DRIED BLUEBERRIES, POMEGRANATE POWDER, SEA SALT A... |
| ingredients_text_en_ocr_1740106550 | 1/3000 | string | WHOLE WHEAT FLOUR, WATER, SHORTENING (SOYBEAN OIL, HYDROGENATED SOYBEAN OIL), BAKING BLEND (SALT, MONO- AND DIGLYCERIDES... |
| ingredients_text_en_ocr_1740106550_result | 1/3000 | string | WHOLE WHEAT FLOUR, WATER, SHORTENING (SOYBEAN OIL, HYDROGENATED SOYBEAN OIL), BAKING BLEND (SALT, MONO - AND DIGLYCERIDE... |
| ingredients_text_en_ocr_1740106994 | 1/3000 | string | INGREDIENTS- MILK CHOCOLATE (SUGAR, COCOA BUTTER, COCOA MASS, SKIM MILK POWDER, BUTTERFOIL, LECITHIN AS EMULSIFIER (SOY)... |
| ingredients_text_en_ocr_1740106994_result | 1/3000 | string | MILK CHOCOLATE (SUGAR, COCOA BUTTER, COCOA MASS, SKIM MILK POWDER, BUTTERFOIL, LECITHIN AS EMULSIFIER (SOY). VANULLIN: A... |
| ingredients_text_en_ocr_1740107026 | 1/3000 | string | INGREDIENTS: SEMISWEET CHOCOLATE (SUGAR. COCOA MASS, COCOA BUTTER, LECITHIN AS EMULSIFIER (SOY), VANILLIN: AN ARTIFICIAL... |
| ingredients_text_en_ocr_1740107026_result | 1/3000 | string | SEMISWEET CHOCOLATE (SUGAR. COCOA MASS, COCOA BUTTER, LECITHIN AS EMULSIFIER (SOY), VANILLIN: AN ARTIFICIAL FLAVOR), SUG... |
| ingredients_text_en_ocr_1740107067 | 1/3000 | string | INGREDIENTS: PARMESAN CHEESE MADE FROM PASTEURIZED PART-SKIM COW'S MILK, CHEESE CULTURE, SALT AND ENZYMES. PARMESAN FLAV... |
| ingredients_text_en_ocr_1740107067_result | 1/3000 | string | PARMESAN CHEESE MADE FROM PASTEURIZED PART-SKIM COW'S MILK, CHEESE CULTURE, SALT AND ENZYMES. PARMESAN FLAVORED TOPPING ... |
| ingredients_text_en_ocr_1740107170 | 1/3000 | string | INGREDIENTS: WALNUTS, ALMONDS |
| ingredients_text_en_ocr_1740107170_result | 1/3000 | string | WALNUTS, ALMONDS |
| ingredients_text_en_ocr_1740107178 | 1/3000 | string | INGREDIENTS: WALNUTS SUGAR, CORN SYRUP, SESAME SEEDS, SALT, CANOLA OIL, SOY LECITHIN (AN EMULSIFIER), NATURAL FLAVOR, CI... |
| ingredients_text_en_ocr_1740107178_result | 1/3000 | string | WALNUTS SUGAR, CORN SYRUP, SESAME SEEDS, SALT, CANOLA OIL, SOY LECITHIN (AN EMULSIFIER), NATURAL FLAVOR, CITRIC ACID. |
| ingredients_text_en_ocr_1740107352 | 1/3000 | string | SUGAR, WATER, BLEACHED ENRICHED WHEAT FLOUR (FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC ACID),... |
| ingredients_text_en_ocr_1740107352_result | 1/3000 | string | SUGAR, WATER, BLEACHED ENRICHED WHEAT FLOUR (FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC ACID),... |
| ingredients_text_en_ocr_1740107357 | 1/3000 | string | SUGAR, WATER, BLEACHED ENRICHED WHEAT FLOUR (FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC ACID),... |
| ingredients_text_en_ocr_1740107357_result | 1/3000 | string | SUGAR, WATER, BLEACHED ENRICHED WHEAT FLOUR (FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC ACID),... |
| ingredients_text_en_ocr_1740107359 | 1/3000 | string | SUGAR, WATER, BLEACHED ENRICHED WHEAT FLOUR (FLOUR, NIACIN, REDUCED IRON, THIAMIN MONONITRATE, RIBOFLAVIN, FOLIC ACID), ... |
| ingredients_text_en_ocr_1740107359_result | 1/3000 | string | SUGAR, WATER, BLEACHED ENRICHED WHEAT FLOUR (FLOUR, NIACIN, REDUCED IRON, THIAMIN MONONITRATE, RIBOFLAVIN, FOLIC ACID), ... |
| ingredients_text_en_ocr_1740107368 | 1/3000 | string | SUGAR, WATER, BLEACHED ENRICHED WHEAT FLOUR (FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC ACID),... |
| ingredients_text_en_ocr_1740107368_result | 1/3000 | string | SUGAR, WATER, BLEACHED ENRICHED WHEAT FLOUR (FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC ACID),... |
| ingredients_text_en_ocr_1740107384 | 1/3000 | string | INGREDIENTS: TOMATILLOS, NOPALES CACTUS, ONION, SERRANO PEPPER, PINEAPPLE JUICE, CILANTRO, SALT. |
| ingredients_text_en_ocr_1740107384_result | 1/3000 | string | TOMATILLOS, NOPALES CACTUS, ONION, SERRANO PEPPER, PINEAPPLE JUICE, CILANTRO, SALT. |
| ingredients_text_en_ocr_1740107390 | 1/3000 | string | WHOLE WHEAT FLOUR (MALTED BARLEY), WATER, WHOLE SPELT FLOUR, WHOLE WHITE WHEAT FLOUR, SUGAR, WHEAT GLUTEN, WHOLE BULGUR ... |
| ingredients_text_en_ocr_1740107390_result | 1/3000 | string | WHOLE WHEAT FLOUR (MALTED BARLEY), WATER, WHOLE SPELT FLOUR, WHOLE WHITE WHEAT FLOUR, SUGAR, WHEAT GLUTEN, WHOLE BULGUR ... |
| ingredients_text_en_ocr_1740107395 | 1/3000 | string | WATER, WHOLE WHEAT FLOUR, ENRICHED WHEAT FLOUR (WHEAT FLOUR, MALTED BARLEY FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONIT... |
| ingredients_text_en_ocr_1740107395_result | 1/3000 | string | WATER, WHOLE WHEAT FLOUR, ENRICHED WHEAT FLOUR (WHEAT FLOUR, MALTED BARLEY FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONIT... |
| ingredients_text_en_ocr_1740107408 | 1/3000 | string | ENRICHED WHEAT FLOUR (FLOUR, MALTED BARLEY FLOUR, REDUCED IRON, NIACIN, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC ACID), W... |
| ingredients_text_en_ocr_1740107408_result | 1/3000 | string | ENRICHED WHEAT FLOUR (FLOUR, MALTED BARLEY FLOUR, REDUCED IRON, NIACIN, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC ACID), W... |
| ingredients_text_en_ocr_1740107418 | 1/3000 | string | INGREDIENTS: HIGH FRUCTOSE CORN SYRUP, CORN SYRUP, WATER, CONTAINS LESS THAN 2% OF: CARAMEL COLOR, SALT, CELLULOSE GUM, ... |
| ingredients_text_en_ocr_1740107418_result | 1/3000 | string | HIGH FRUCTOSE CORN SYRUP, CORN SYRUP, WATER, CONTAINS LESS THAN 2% OF: CARAMEL COLOR, SALT, CELLULOSE GUM, NATURAL FLAVO... |
| ingredients_text_en_ocr_1740107441 | 1/3000 | string | ICE CREAM - MILK, CREAM, SUGAR, CORN SYRUP, NATURAL FLAVOR, WHEY PROTEIN CONCENTRATE, PROPYLENE GLYCOL MONOESTERS, GUAR ... |
| ingredients_text_en_ocr_1740107441_result | 1/3000 | string | ICE CREAM - MILK, CREAM, SUGAR, CORN SYRUP, NATURAL FLAVOR, WHEY PROTEIN CONCENTRATE, PROPYLENE GLYCOL MONOESTERS, GUAR ... |
| ingredients_text_en_ocr_1740107461 | 1/3000 | string | BROWNIE- SUGAR, ENRICHED WHEAT FLOUR, BLEACHED (FLOUR, NIACIN, IRON THIAMINE, MONONITRATE, RIBOFLAVIN, FOLIC ACID), PALM... |
| ingredients_text_en_ocr_1740107461_result | 1/3000 | string | BROWNIE - SUGAR, ENRICHED WHEAT FLOUR, BLEACHED (FLOUR, NIACIN, IRON THIAMINE, MONONITRATE, RIBOFLAVIN, FOLIC ACID), PAL... |
| ingredients_text_en_ocr_1740107462 | 1/3000 | string | INGREDIENTS: WATER, SOYBEAN OIL, VINEGAR, CORN STARCH-MODIFIED*, EGG YOLKS, SUGAR, SALT, CULTURED NONFAT MILK*, LACTIC A... |
| ingredients_text_en_ocr_1740107462_result | 1/3000 | string | WATER, SOYBEAN OIL, VINEGAR, CORN STARCH-MODIFIED*, EGG YOLKS, SUGAR, SALT, CULTURED NONFAT MILK*, LACTIC ACID*, MUSTARD... |
| ingredients_text_en_ocr_1740107464 | 1/3000 | string | INGREDIENTS: WATER, HIGH FRUCTOSE CORN SYRUP, SOYBEAN, VINEGAR, MODIFIED CORN STARCH, CELLULOSE GEL, CELLULOSE GUM, EGG ... |
| ingredients_text_en_ocr_1740107464_result | 1/3000 | string | WATER, HIGH FRUCTOSE CORN SYRUP, SOYBEAN, VINEGAR, MODIFIED CORN STARCH, CELLULOSE GEL, CELLULOSE GUM, EGG YOLKS, SALT, ... |
| ingredients_text_en_ocr_1740107473 | 1/3000 | string | INGREDIENTS: PEANUTS, CASHEWS, ALMONDS, BRAZIL NUTS, PECANS, VEGETABLE OIL (PEANUT, COTTONSEED, SOYBEAN, AND/OR SUNFLOWE... |
| ingredients_text_en_ocr_1740107473_result | 1/3000 | string | PEANUTS, CASHEWS, ALMONDS, BRAZIL NUTS, PECANS, VEGETABLE OIL (PEANUT, COTTONSEED, SOYBEAN, AND/OR SUNFLOWER OIL), FILBE... |
| ingredients_text_en_ocr_1740107495 | 1/3000 | string | INGREDIENTS:WATER, SOYBEAN OIL, HONEY, DIJON MUSTARD (WATER, MUSTARD SEED, VINEGAR, SALT, WHITE WINE, CITRIC ACID, TARTA... |
| ingredients_text_en_ocr_1740107495_result | 1/3000 | string | WATER, SOYBEAN OIL, HONEY, DIJON MUSTARD (WATER, MUSTARD SEED, VINEGAR, SALT, WHITE WINE, CITRIC ACID, TARTARIC ACID, SP... |
| ingredients_text_en_ocr_1740107496 | 1/3000 | string | INGREDIENTS:WATER, HIGH FRUCTOSE CORN SYRUP, RED WINE VINEGAR, SOYBEAN OIL, DISTILLED VINEGAR, CONTAINS 2% LESS OF: SALT... |
| ingredients_text_en_ocr_1740107496_result | 1/3000 | string | WATER, HIGH FRUCTOSE CORN SYRUP, RED WINE VINEGAR, SOYBEAN OIL, DISTILLED VINEGAR, CONTAINS 2% LESS OF: SALT, RED RASPBE... |
| ingredients_text_en_ocr_1740107502 | 1/3000 | string | MODIFIED CORN STARCH, MALTODEXTRIN, WHEAT FLOUR, WHEY PROTEIN CONCENTRATE, SALT, PARTIALLY HYDROGENATED SOYBEAN AND/OR C... |
| ingredients_text_en_ocr_1740107502_result | 1/3000 | string | MODIFIED CORN STARCH, MALTODEXTRIN, WHEAT FLOUR, WHEY PROTEIN CONCENTRATE, SALT, PARTIALLY HYDROGENATED SOYBEAN AND/OR C... |
| ingredients_text_en_ocr_1740107504 | 1/3000 | string | ICE CREAM - MILK AND SKIM MILK, CREAM, SUGAR, CORN SYRUP, HIGH FRUCTOSE CORN SYRUP, WHEY, BUTTERMILK, CELLULOSE GEL, GUA... |
| ingredients_text_en_ocr_1740107504_result | 1/3000 | string | ICE CREAM - MILK AND SKIM MILK, CREAM, SUGAR, CORN SYRUP, HIGH FRUCTOSE CORN SYRUP, WHEY, BUTTERMILK, CELLULOSE GEL, GUA... |
| ingredients_text_en_ocr_1740107513 | 1/3000 | string | ICE CREAM - MILK, CREAM, SUGAR, CORN SYRUP, WHEY PROTEIN CONCENTRATE, EGG YOLKS, NATURAL FLAVOR, PROPYLENE GLYCOL MONOES... |
| ingredients_text_en_ocr_1740107513_result | 1/3000 | string | ICE CREAM - MILK, CREAM, SUGAR, CORN SYRUP, WHEY PROTEIN CONCENTRATE, EGG YOLKS, NATURAL FLAVOR, PROPYLENE GLYCOL MONOES... |
| ingredients_text_en_ocr_1740107522 | 1/3000 | string | ENRICHED FLOUR (WHEAT FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC ACID), CHOCOLATE CHIPS (SUGAR... |
| ingredients_text_en_ocr_1740107522_result | 1/3000 | string | ENRICHED FLOUR (WHEAT FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC ACID), CHOCOLATE CHIPS (SUGAR... |
| ingredients_text_en_ocr_1740107530 | 1/3000 | string | INGREDIENTS: ROLLED OATS, SOLUBLE CORN FIBER, DEHYDRATED APPLE FLAKES (TREATED WITH SODIUM SULFITE AND SULFUR DIOXIDE TO... |
| ingredients_text_en_ocr_1740107530_result | 1/3000 | string | ROLLED OATS, SOLUBLE CORN FIBER, DEHYDRATED APPLE FLAKES (TREATED WITH SODIUM SULFITE AND SULFUR DIOXIDE TO PROMOTE COLO... |
| ingredients_text_en_ocr_1740107535 | 1/3000 | string | MILK, CREAM, CORN SYRUP, SUGAR, HIGH FRUCTOSE CORN SYRUP, STRAWBERRIES, COCOA PROCESSED WITH ALKALI, WHEY, BUTTERMILK, C... |
| ingredients_text_en_ocr_1740107535_result | 1/3000 | string | MILK, CREAM, CORN SYRUP, SUGAR, HIGH FRUCTOSE CORN SYRUP, STRAWBERRIES, COCOA PROCESSED WITH ALKALI, WHEY, BUTTERMILK, C... |
| ingredients_text_en_ocr_1740107541 | 1/3000 | string | WATER, SUGAR, MILK* AND SKIM MILK*, CORN SYRUP, CONCENTRATED RASPBERRY JUICE, CONCENTRATED LIME JUICE, ORANGE PULP, CONC... |
| ingredients_text_en_ocr_1740107541_result | 1/3000 | string | WATER, SUGAR, MILK* AND SKIM MILK*, CORN SYRUP, CONCENTRATED RASPBERRY JUICE, CONCENTRATED LIME JUICE, ORANGE PULP, CONC... |
| ingredients_text_en_ocr_1740107546 | 1/3000 | string | DAIRY DESSERT - MILK, SUGAR, CORN SYRUP, CREAM, HIGH FRUCTOSE CORN SYRUP, NONFAT MILK, WHEY, MALTODEXTRIN, WHEY PROTEIN ... |
| ingredients_text_en_ocr_1740107546_result | 1/3000 | string | DAIRY DESSERT - MILK, SUGAR, CORN SYRUP, CREAM, HIGH FRUCTOSE CORN SYRUP, NONFAT MILK, WHEY, MALTODEXTRIN, WHEY PROTEIN ... |
| ingredients_text_en_ocr_1740107564 | 1/3000 | string | INGREDIENTS: SOYBEAN OIL,WATER.EGG YOLK, CORN SYRUP, VINEGAR, SALT, MUSTARD POWDER, LEMON JUICE CONCENTRATE,NATURAL FLAV... |
| ingredients_text_en_ocr_1740107564_result | 1/3000 | string | SOYBEAN OIL,WATER.EGG YOLK, CORN SYRUP, VINEGAR, SALT, MUSTARD POWDER, LEMON JUICE CONCENTRATE,NATURAL FLAVOR, CALCIUM D... |
| ingredients_text_en_ocr_1740107565 | 1/3000 | string | INGREDIENTS: WATER, DISTILLED VINEGAR, SOYBEAN OIL, HIGH FRUCTOSE CORN SYRUP, SALT, CONTAINS 2% LESS OF: DRIED GARLIC, D... |
| ingredients_text_en_ocr_1740107565_result | 1/3000 | string | WATER, DISTILLED VINEGAR, SOYBEAN OIL, HIGH FRUCTOSE CORN SYRUP, SALT, CONTAINS 2% LESS OF: DRIED GARLIC, DRIED ONION, D... |
| ingredients_text_en_ocr_1740107567 | 1/3000 | string | INGREDIENTS: HIGH FRUCTOSE CORN, SYRUP, TOMATO PUREE (TOMATO PASTE, WATER), DISTILLED VINEGAR, MODIFIED CORN STARCH, CON... |
| ingredients_text_en_ocr_1740107567_result | 1/3000 | string | HIGH FRUCTOSE CORN, SYRUP, TOMATO PUREE (TOMATO PASTE, WATER), DISTILLED VINEGAR, MODIFIED CORN STARCH, CONTAINS 2% OR L... |
| ingredients_text_en_ocr_1740107569 | 1/3000 | string | INGREDIENTS: HIGH FRUCTOSE CORN SYRUP, TOMATO PUREE (TOMATO PASTE, WATER), DISTILLED VINEGAR, MODIFIED CORN STARCH, CONT... |
| ingredients_text_en_ocr_1740107569_result | 1/3000 | string | HIGH FRUCTOSE CORN SYRUP, TOMATO PUREE (TOMATO PASTE, WATER), DISTILLED VINEGAR, MODIFIED CORN STARCH, CONTAINS 2% OR LE... |
| ingredients_text_en_ocr_1740107578 | 2/3000 | string | INGREDIENTS: SOYBEAN OIL, EGGS AND EGG YOLKS, WATER, DISTILLED VINEGAR, SUGAR, SALT, LEMON JUICE CONCENTRATE, NATURAL FL...<br>INGREDIENTS: SOYBEAN OIL, EGGS AND EGG YOLKS, WATER, DISTILLED VINEGAR, SUGAR, SALT, LEMON JUICE CONCENTRATE, NATURAL, F... |
| ingredients_text_en_ocr_1740107578_result | 2/3000 | string | SOYBEAN OIL, EGGS AND EGG YOLKS, WATER, DISTILLED VINEGAR, SUGAR, SALT, LEMON JUICE CONCENTRATE, NATURAL FLAVORS, CALCIU...<br>SOYBEAN OIL, EGGS AND EGG YOLKS, WATER, DISTILLED VINEGAR, SUGAR, SALT, LEMON JUICE CONCENTRATE, NATURAL, FLAVORS, CALCI... |
| ingredients_text_en_ocr_1740107580 | 1/3000 | string | INGREDIENTS: ENRICHED LONG GRAIN RICE (RICE, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, FOLIC ACID), ENRICHED VERMICELL... |
| ingredients_text_en_ocr_1740107580_result | 1/3000 | string | ENRICHED LONG GRAIN RICE (RICE, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, FOLIC ACID), ENRICHED VERMICELLI (DURUM SEMO... |
| ingredients_text_en_ocr_1740107604 | 2/3000 | string | INGREDIENTS: ALMONDS<br>INGREDIENTS: PINE NUTS. |
| ingredients_text_en_ocr_1740107604_result | 2/3000 | string | ALMONDS<br>PINE NUTS. |
| ingredients_text_en_ocr_1740107613 | 1/3000 | string | INGREDIENTS: WATER, SOYBEAN OIL, FETA CHEESE (MILK, SALT, CULTURES, ENZYMES), WHITE WINE VINEGAR, OLIVE OIL, DISTILLED V... |
| ingredients_text_en_ocr_1740107613_result | 1/3000 | string | WATER, SOYBEAN OIL, FETA CHEESE (MILK, SALT, CULTURES, ENZYMES), WHITE WINE VINEGAR, OLIVE OIL, DISTILLED VINEGAR, DRIED... |
| ingredients_text_en_ocr_1740107614 | 1/3000 | string | INGREDIENTS: SOYBEAN OIL, WATER, LOWFAT BUTTERMILK (CULTURED LOWFAT AND SKIM MILK, SALT, TAPIOCA STARCH, LOCUST BEAN GUM... |
| ingredients_text_en_ocr_1740107614_result | 1/3000 | string | SOYBEAN OIL, WATER, LOWFAT BUTTERMILK (CULTURED LOWFAT AND SKIM MILK, SALT, TAPIOCA STARCH, LOCUST BEAN GUM, CARRAGEENAN... |
| ingredients_text_en_ocr_1740107616 | 1/3000 | string | ICE CREAM - MILK, CREAM, SUGAR, CORN SYRUP, NATURAL FLAVOR, WHEY PROTEIN CONCENTRATE, HIGH FRUCTOSE CORN SYRUP, PROPYLEN... |
| ingredients_text_en_ocr_1740107616_result | 1/3000 | string | ICE CREAM - MILK, CREAM, SUGAR, CORN SYRUP, NATURAL FLAVOR, WHEY PROTEIN CONCENTRATE, HIGH FRUCTOSE CORN SYRUP, PROPYLEN... |
| ingredients_text_en_ocr_1740107629 | 1/3000 | string | INGREDIENTS: WATER, LIME JUICE FROM CONCENTRATE, HIGH FRUCTOSE CORN SYRUP, DISTILLED VINEGAR, SOY SAUCE (WATER, SOYBEANS... |
| ingredients_text_en_ocr_1740107629_result | 1/3000 | string | WATER, LIME JUICE FROM CONCENTRATE, HIGH FRUCTOSE CORN SYRUP, DISTILLED VINEGAR, SOY SAUCE (WATER, SOYBEANS, WHEAT AND S... |
| ingredients_text_en_ocr_1740107635 | 1/3000 | string | INGREDIENTS: HIGH FRUCTOSE CORN SYRUP, TOMATO PUREE (WATER, TOMATO PASTE), DISTILLED VINEGAR, LIME JUICE FROM CONCENTRAT... |
| ingredients_text_en_ocr_1740107635_result | 1/3000 | string | HIGH FRUCTOSE CORN SYRUP, TOMATO PUREE (WATER, TOMATO PASTE), DISTILLED VINEGAR, LIME JUICE FROM CONCENTRATE WATER, LIME... |
| ingredients_text_en_ocr_1740107640 | 1/3000 | string | SALTED CARAMEL SEASONED ALMONDS AND CASHEWS (ALMONDS, CASHEWS, VEGETABLE OIL [PEANUT, COTTONSEED, SOYBEAN, AND/OR SUNFLO... |
| ingredients_text_en_ocr_1740107640_result | 1/3000 | string | SALTED CARAMEL SEASONED ALMONDS AND CASHEWS (ALMONDS, CASHEWS, VEGETABLE OIL [PEANUT, COTTONSEED, SOYBEAN, AND/OR SUNFLO... |
| ingredients_text_en_ocr_1740107645 | 1/3000 | string | INGREDIENTS: WATER, HIGH FRUCTOSE CORN SYRUP, SOYBEAN OIL, VINEGAR, MODIFIED CORN STARCH, CELLULOSE GEL, CELLULOSE GUM, ... |
| ingredients_text_en_ocr_1740107645_result | 1/3000 | string | WATER, HIGH FRUCTOSE CORN SYRUP, SOYBEAN OIL, VINEGAR, MODIFIED CORN STARCH, CELLULOSE GEL, CELLULOSE GUM, EGG YOLKS, SA... |
| ingredients_text_en_ocr_1740107652 | 1/3000 | string | MILK, CREAM, SUGAR, CORN SYRUP, COFFEE CONCENTRATE, WHEY PROTEIN CONCENTRATE, PROPYLENE GLYCOL MONOESTERS, GUAR GUM, CEL... |
| ingredients_text_en_ocr_1740107652_result | 1/3000 | string | MILK, CREAM, SUGAR, CORN SYRUP, COFFEE CONCENTRATE, WHEY PROTEIN CONCENTRATE, PROPYLENE GLYCOL MONOESTERS, GUAR GUM, CEL... |
| ingredients_text_en_ocr_1740107675 | 1/3000 | string | INGREDIENTS: SOYBEAN OIL, WATER, BLUE CHEESE (MILK, CHEESE CULTURES, SALT, ENZYMES), DISTILLED VINEGAR, EGG YOLK, CONTAI... |
| ingredients_text_en_ocr_1740107675_result | 1/3000 | string | SOYBEAN OIL, WATER, BLUE CHEESE (MILK, CHEESE CULTURES, SALT, ENZYMES), DISTILLED VINEGAR, EGG YOLK, CONTAINS 2% OR LESS... |
| ingredients_text_en_ocr_1740107693 | 1/3000 | string | WATER, ENRICHED FLOUR (WHEAT FLOUR, MALTED BARLEY, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC ACID), ... |
| ingredients_text_en_ocr_1740107693_result | 1/3000 | string | WATER, ENRICHED FLOUR (WHEAT FLOUR, MALTED BARLEY, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC ACID), ... |
| ingredients_text_en_ocr_1740107695 | 1/3000 | string | POTATOES, SOUR CREAM (CREAM, SKIM MILK, MODIFIED CORN STARCH, LACTIC AND CITRIC ACID, BEEF GELATIN, MONO- AND DIGLYCERID... |
| ingredients_text_en_ocr_1740107695_result | 1/3000 | string | POTATOES, SOUR CREAM (CREAM, SKIM MILK, MODIFIED CORN STARCH, LACTIC AND CITRIC ACID, BEEF GELATIN, MONO - AND DIGLYCERI... |
| ingredients_text_en_ocr_1740107714 | 1/3000 | string | ENRICHED FLOUR BLEACHED (WHEAT FLOUR, MALTED BARLEY FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC... |
| ingredients_text_en_ocr_1740107714_result | 1/3000 | string | ENRICHED FLOUR BLEACHED (WHEAT FLOUR, MALTED BARLEY FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC... |
| ingredients_text_en_ocr_1740107742 | 1/3000 | string | SUGAR, ENRICHED BLEACHED FLOUR (WHEAT FLOUR, MALTED BARLEY FLOUR, NIACIN, FERROUS SULFATE, THIAMINE MONONITRATE, RIBOFLA... |
| ingredients_text_en_ocr_1740107742_result | 1/3000 | string | SUGAR, ENRICHED BLEACHED FLOUR (WHEAT FLOUR, MALTED BARLEY FLOUR, NIACIN, FERROUS SULFATE, THIAMINE MONONITRATE, RIBOFLA... |
| ingredients_text_en_ocr_1740107769 | 1/3000 | string | INGREDIENTS: ENRICHED FLOUR (WHEAT FLOUR, BARLEY MALT, NIACIAN, REDUCED IRON, THIAMIN MONONITRATE, RIBOFLAVIN, FOLIC ACI... |
| ingredients_text_en_ocr_1740107769_result | 1/3000 | string | ENRICHED FLOUR (WHEAT FLOUR, BARLEY MALT, NIACIAN, REDUCED IRON, THIAMIN MONONITRATE, RIBOFLAVIN, FOLIC ACID), PARTIALLY... |
| ingredients_text_en_ocr_1740107772 | 1/3000 | string | SUGAR, ENRICHED FLOUR (WHEAT FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC ACID), CORN SYRUP, HIG... |
| ingredients_text_en_ocr_1740107772_result | 1/3000 | string | SUGAR, ENRICHED FLOUR (WHEAT FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC ACID), CORN SYRUP, HIG... |
| ingredients_text_en_ocr_1740107780 | 1/3000 | string | INGREDIENTS: BLEACHED ENRICHED WHEAT FLOUR (WHEAT FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC A... |
| ingredients_text_en_ocr_1740107780_result | 1/3000 | string | BLEACHED ENRICHED WHEAT FLOUR (WHEAT FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC ACID), BROWN S... |
| ingredients_text_en_ocr_1740107785 | 1/3000 | string | INGREDIENTS: ENRICHED WHEAT FLOUR (WHEAT FLOUR, NIACIN, REDUCED IRON, THIAMIN FLOUR, SUGAR, VEGETABLE OIL SHORTENING (SO... |
| ingredients_text_en_ocr_1740107785_result | 1/3000 | string | ENRICHED WHEAT FLOUR (WHEAT FLOUR, NIACIN, REDUCED IRON, THIAMIN FLOUR, SUGAR, VEGETABLE OIL SHORTENING (SOYBEAN OIL OR ... |
| ingredients_text_en_ocr_1740107883 | 1/3000 | string | ENRICHED BLEACHED WHEAT FLOUR (FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC ACID), SUGAR, EGGS, ... |
| ingredients_text_en_ocr_1740107883_result | 1/3000 | string | ENRICHED BLEACHED WHEAT FLOUR (FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC ACID), SUGAR, EGGS, ... |
| ingredients_text_en_ocr_1740107899 | 1/3000 | string | ENRICHED FLOUR (WHEAT FLOUR, MALTED BARLEY FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC ACID), W... |
| ingredients_text_en_ocr_1740107899_result | 1/3000 | string | ENRICHED FLOUR (WHEAT FLOUR, MALTED BARLEY FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC ACID), W... |
| ingredients_text_en_ocr_1740107933 | 1/3000 | string | WATER, WHOLE WHEAT FLOUR, UNBLEACHED ENRICHED WHEAT FLOUR (WHEAT FLOUR, NIACIN, IRON, THIAMINE MONONITRATE, RIBOFLAVIN, ... |
| ingredients_text_en_ocr_1740107933_result | 1/3000 | string | WATER, WHOLE WHEAT FLOUR, UNBLEACHED ENRICHED WHEAT FLOUR (WHEAT FLOUR, NIACIN, IRON, THIAMINE MONONITRATE, RIBOFLAVIN, ... |
| ingredients_text_en_ocr_1740107940 | 1/3000 | string | BROWNIE- BLEACHED ENRICHED FLOUR (BLEACHED WHEAT FLOUR, NIACIN, FERROUS SULFATE, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC... |
| ingredients_text_en_ocr_1740107940_result | 1/3000 | string | BROWNIE - BLEACHED ENRICHED FLOUR (BLEACHED WHEAT FLOUR, NIACIN, FERROUS SULFATE, THIAMINE MONONITRATE, RIBOFLAVIN, FOLI... |
| ingredients_text_en_ocr_1740107944 | 1/3000 | string | SUGAR, BLEACHED ENRICHED FLOUR (WHEAT FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC ACID), WHOLE ... |
| ingredients_text_en_ocr_1740107944_result | 1/3000 | string | SUGAR, BLEACHED ENRICHED FLOUR (WHEAT FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC ACID), WHOLE ... |
| ingredients_text_en_ocr_1740107949 | 1/3000 | string | CORN SYRUP, ENRICHED FLOUR (WHEAT FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, ROBOFLAVIN, FOLIC ACID), SUGAR, EGG... |
| ingredients_text_en_ocr_1740107949_result | 1/3000 | string | CORN SYRUP, ENRICHED FLOUR (WHEAT FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, ROBOFLAVIN, FOLIC ACID), SUGAR, EGG... |
| ingredients_text_en_ocr_1740107968 | 1/3000 | string | BROWNIE- BLEACHED ENRICHED FLOUR (BLEACHED WHEAT FLOUR, NIACIN, FERROUS SULFATE, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC... |
| ingredients_text_en_ocr_1740107968_result | 1/3000 | string | BROWNIE - BLEACHED ENRICHED FLOUR (BLEACHED WHEAT FLOUR, NIACIN, FERROUS SULFATE, THIAMINE MONONITRATE, RIBOFLAVIN, FOLI... |
| ingredients_text_en_ocr_1740108042 | 1/3000 | string | INGREDIENTS: CULTURED SKIN MILK, CULTURED CREAM, WHEY, SALT, MALTODEXTRIN, CITRIC ACID, CARRACEENAN, GUAR GUM, LOCUST BE... |
| ingredients_text_en_ocr_1740108042_result | 1/3000 | string | CULTURED SKIN MILK, CULTURED CREAM, WHEY, SALT, MALTODEXTRIN, CITRIC ACID, CARRACEENAN, GUAR GUM, LOCUST BEAN GUM, CULTU... |
| ingredients_text_en_ocr_1740108043 | 1/3000 | string | CULTURED SKIM MILK, CULTURED CREAM, SALT, WHEY, GUAR GUM, SORBIC ACID (TO MAINTAIN FRESHNESS), CITRIC ACID, LOCUST BEAN ... |
| ingredients_text_en_ocr_1740108043_result | 1/3000 | string | CULTURED SKIM MILK, CULTURED CREAM, SALT, WHEY, GUAR GUM, SORBIC ACID (TO MAINTAIN FRESHNESS), CITRIC ACID, LOCUST BEAN ... |
| ingredients_text_en_ocr_1740108056 | 1/3000 | string | HEAVY CREAM (HEAVY CREAM, CARRAGEENAN, MONO- AND DIGLYCERIDES), SUGAR, WATER, CREAM CHEESE (PASTEURIZED MILK AND CREAM, ... |
| ingredients_text_en_ocr_1740108056_result | 1/3000 | string | HEAVY CREAM (HEAVY CREAM, CARRAGEENAN, MONO - AND DIGLYCERIDES), SUGAR, WATER, CREAM CHEESE (PASTEURIZED MILK AND CREAM,... |
| ingredients_text_en_ocr_1740108057 | 1/3000 | string | APPLE, WATER, SUGAR, BROWN SUGAR, ENRICHED FLOUR (WHEAT FLOUR, MALTED BARLEY FLOUR, NIACIN, IRON, THIAMINE MONONITRATE, ... |
| ingredients_text_en_ocr_1740108057_result | 1/3000 | string | APPLE, WATER, SUGAR, BROWN SUGAR, ENRICHED FLOUR (WHEAT FLOUR, MALTED BARLEY FLOUR, NIACIN, IRON, THIAMINE MONONITRATE, ... |
| ingredients_text_en_ocr_1740108058 | 1/3000 | string | SUGAR, PEANUT BUTTER CUPS (MILK CHOCOLATE [SUGAR, COCOA BUTTER, CHOCOLATE, NONFAT MILK, MILKFAT, LACTOSE, SOY LECITHIN A... |
| ingredients_text_en_ocr_1740108058_result | 1/3000 | string | SUGAR, PEANUT BUTTER CUPS (MILK CHOCOLATE [SUGAR, COCOA BUTTER, CHOCOLATE, NONFAT MILK, MILKFAT, LACTOSE, SOY LECITHIN A... |
| ingredients_text_en_ocr_1740108068 | 1/3000 | string | HEAVY CREAM (HEAVY CREAM, CARRAGEENAN, MONO- AND DIGLYCERIDES), YELLOW CAKE (SUGAR, ENRICHED WHEAT FLOUR BLEACHED [FLOUR... |
| ingredients_text_en_ocr_1740108068_result | 1/3000 | string | HEAVY CREAM (HEAVY CREAM, CARRAGEENAN, MONO - AND DIGLYCERIDES), YELLOW CAKE (SUGAR, ENRICHED WHEAT FLOUR BLEACHED [FLOU... |
| ingredients_text_en_ocr_1740108074 | 1/3000 | string | INGREDIENTS: CULTURED CREAM, SKIM MILK, WHEY, MODIFIED CORN STARCH, CULTURED DEXTROSE, GELATIN, SODIUM PHOSPHATE, GUAR G... |
| ingredients_text_en_ocr_1740108074_result | 1/3000 | string | CULTURED CREAM, SKIM MILK, WHEY, MODIFIED CORN STARCH, CULTURED DEXTROSE, GELATIN, SODIUM PHOSPHATE, GUAR GUM, CARRAGEEN... |
| ingredients_text_en_ocr_1740108127 | 1/3000 | string | ICE CREAM: MILK, CREAM, CORN SYRUP, SUGAR, HIGH FRUCTOSE CORN SYRUP, WHEY, BUTTERMILK, CELLULOSE GEL, GUAR GUM, CELLULOS... |
| ingredients_text_en_ocr_1740108127_result | 1/3000 | string | ICE CREAM: MILK, CREAM, CORN SYRUP, SUGAR, HIGH FRUCTOSE CORN SYRUP, WHEY, BUTTERMILK, CELLULOSE GEL, GUAR GUM, CELLULOS... |
| ingredients_text_en_ocr_1740108187 | 1/3000 | string | MILK, CREAM, CORN SYRUP, SUGAR, HIGH FRUCTOSE CORN SYRUP, WHEY, BUTTERMILK, CELLULOSE GEL, GUAR GUM, CELLULOSE GUM, MONO... |
| ingredients_text_en_ocr_1740108187_result | 1/3000 | string | MILK, CREAM, CORN SYRUP, SUGAR, HIGH FRUCTOSE CORN SYRUP, WHEY, BUTTERMILK, CELLULOSE GEL, GUAR GUM, CELLULOSE GUM, MONO... |
| ingredients_text_en_ocr_1740108191 | 1/3000 | string | ICE CREAM - MILK, CREAM, SUGAR, CORN SYRUP, WHEY PROTEIN CONCENTRATE, BUTTER (CREAM, SALT), MOLASSES, NATURAL FLAVOR, PR... |
| ingredients_text_en_ocr_1740108191_result | 1/3000 | string | ICE CREAM - MILK, CREAM, SUGAR, CORN SYRUP, WHEY PROTEIN CONCENTRATE, BUTTER (CREAM, SALT), MOLASSES, NATURAL FLAVOR, PR... |
| ingredients_text_en_ocr_1740108197 | 1/3000 | string | MILK, CREAM, SUGAR, CORN SYRUP, HIGH FRUCTOSE CORN SYRUP, COCOA PROCESSED WITH ALKALI, WHEY, BUTTERMILK, CELLULOSE GEL, ... |
| ingredients_text_en_ocr_1740108197_result | 1/3000 | string | MILK, CREAM, SUGAR, CORN SYRUP, HIGH FRUCTOSE CORN SYRUP, COCOA PROCESSED WITH ALKALI, WHEY, BUTTERMILK, CELLULOSE GEL, ... |
| ingredients_text_en_ocr_1740108200 | 1/3000 | string | ICE CREAM: MILK, CREAM, SUGAR, CORN SYRUP, HIGH FRUCTOSE CORN SYRUP, WHEY, BUTTERMILK, SUGAR, GUAR GUM, MONO- AND DIGLYC... |
| ingredients_text_en_ocr_1740108200_result | 1/3000 | string | ICE CREAM: MILK, CREAM, SUGAR, CORN SYRUP, HIGH FRUCTOSE CORN SYRUP, WHEY, BUTTERMILK, SUGAR, GUAR GUM, MONO - AND DIGLY... |
| ingredients_text_en_ocr_1740108201 | 1/3000 | string | MILK, SUGAR SYRUP, CORN SYRUP, HIGH FRUCTOSE CORN SYRUP, WHEY, BUTTER MILK, CREAM, SKIM MILK, CELLULOSE GEL, GUAR GUM, C... |
| ingredients_text_en_ocr_1740108201_result | 1/3000 | string | MILK, SUGAR SYRUP, CORN SYRUP, HIGH FRUCTOSE CORN SYRUP, WHEY, BUTTER MILK, CREAM, SKIM MILK, CELLULOSE GEL, GUAR GUM, C... |
| ingredients_text_en_ocr_1740108202 | 1/3000 | string | MILK, SUGAR SYRUP, CORN SYRUP, HIGH FRUCTOSE CORN SYRUP, WHEY, BUTTERMILK, SKIM MILK, CREAM, COCOA PROCESSED WITH ALKALI... |
| ingredients_text_en_ocr_1740108202_result | 1/3000 | string | MILK, SUGAR SYRUP, CORN SYRUP, HIGH FRUCTOSE CORN SYRUP, WHEY, BUTTERMILK, SKIM MILK, CREAM, COCOA PROCESSED WITH ALKALI... |
| ingredients_text_en_ocr_1740108203 | 1/3000 | string | MILK* AND SKIM MILK*, SUGAR, WATER, CORN SYRUP, ORANGE PULP, CONCENTRATED ORANGE JUICE, HIGH FRUCTOSE CORN SYRUP, NATURA... |
| ingredients_text_en_ocr_1740108203_result | 1/3000 | string | MILK* AND SKIM MILK*, SUGAR, WATER, CORN SYRUP, ORANGE PULP, CONCENTRATED ORANGE JUICE, HIGH FRUCTOSE CORN SYRUP, NATURA... |
| ingredients_text_en_ocr_1740108204 | 2/3000 | string | WATER, SUGAR SYRUP, CORN SYRUP, SKIM MILK*, PINEAPPLE, PINEAPPLE JUICE, CITRIC ACID, LOCUST BEAN GUM, DEXTROSE, MONO- AN...<br>WATER, SUGAR SYRUP, MILK* AND SKIM MILK*, CORN SYRUP, CONCENTRATED LIME JUICE*, CONCENTRATED ORANGE JUICE, NATURAL FLAVO... |
| ingredients_text_en_ocr_1740108204_result | 2/3000 | string | WATER, SUGAR SYRUP, CORN SYRUP, SKIM MILK*, PINEAPPLE, PINEAPPLE JUICE, CITRIC ACID, LOCUST BEAN GUM, DEXTROSE, MONO - A...<br>WATER, SUGAR SYRUP, MILK* AND SKIM MILK*, CORN SYRUP, CONCENTRATED LIME JUICE*, CONCENTRATED ORANGE JUICE, NATURAL FLAVO... |
| ingredients_text_en_ocr_1740108206 | 1/3000 | string | ICE CREAM - MILK, CREAM, SUGAR, CORN SYRUP, HIGH FRUCTOSE CORN SYRUP, PEANUT BUTTER (GROUND PEANUTS), PEANUT OIL, WHEY, ... |
| ingredients_text_en_ocr_1740108206_result | 1/3000 | string | ICE CREAM - MILK, CREAM, SUGAR, CORN SYRUP, HIGH FRUCTOSE CORN SYRUP, PEANUT BUTTER (GROUND PEANUTS), PEANUT OIL, WHEY, ... |
| ingredients_text_en_ocr_1740108207 | 1/3000 | string | MILK, CREAM, SUGAR SYRUP, CORN SYRUP, HIGH FRUCTOSE CORN SYRUP, WHEY, SKIM MILK, ARTIFICIAL AND NATURAL FLAVOR, CELLULOS... |
| ingredients_text_en_ocr_1740108207_result | 1/3000 | string | MILK, CREAM, SUGAR SYRUP, CORN SYRUP, HIGH FRUCTOSE CORN SYRUP, WHEY, SKIM MILK, ARTIFICIAL AND NATURAL FLAVOR, CELLULOS... |
| ingredients_text_en_ocr_1740108208 | 1/3000 | string | CHOCOLATE ICE CREAM - MILK, CREAM, SUGAR SYRUP, CORN SYRUP, BUTTERMILK, WHEY, COCOA PROCESSED WITH ALKALI, SALT, GUAR GU... |
| ingredients_text_en_ocr_1740108208_result | 1/3000 | string | CHOCOLATE ICE CREAM - MILK, CREAM, SUGAR SYRUP, CORN SYRUP, BUTTERMILK, WHEY, COCOA PROCESSED WITH ALKALI, SALT, GUAR GU... |
| ingredients_text_en_ocr_1740108212 | 1/3000 | string | NONFAT SHERBET - SKIM MILK*. SUGAR, WATER, CORN SYRUP, MILK*, ORANGE PULP, CONCENTRATED ORANGE JUICE, HIGH FRUCTOSE CORN... |
| ingredients_text_en_ocr_1740108212_result | 1/3000 | string | NONFAT SHERBET - SKIM MILK*. SUGAR, WATER, CORN SYRUP, MILK*, ORANGE PULP, CONCENTRATED ORANGE JUICE, HIGH FRUCTOSE CORN... |
| ingredients_text_en_ocr_1740108213 | 2/3000 | string | NONFAT SHERBET - SKIM MILK, WATER, SUGAR, CORN SYRUP, CONCENTRATED RASPBERRY JUICE, HIGH FRUCTOSE CORN SYRUP, RASPBERRY ...<br>FROZEN YOGURT - CULTURED PASTEURIZED MILK AND SKIM MILK, SUGAR, CORN SYRUP, BUTTERMILK, COCOA PROCESSED WITH ALKALI, WHE... |
| ingredients_text_en_ocr_1740108213_result | 2/3000 | string | NONFAT SHERBET - SKIM MILK, WATER, SUGAR, CORN SYRUP, CONCENTRATED RASPBERRY JUICE, HIGH FRUCTOSE CORN SYRUP, RASPBERRY ...<br>FROZEN YOGURT - CULTURED PASTEURIZED MILK AND SKIM MILK, SUGAR, CORN SYRUP, BUTTERMILK, COCOA PROCESSED WITH ALKALI, WHE... |
| ingredients_text_en_ocr_1740108214 | 1/3000 | string | INGREDIENTS: ICE CREAM: MILK, CREAM, SUGAR SYRUP, CORN SYRUP, WHEY, BUTTERMILK. MALTODEXTRIN, CELLULOSE GEL, MONO- AND D... |
| ingredients_text_en_ocr_1740108214_result | 1/3000 | string | ICE CREAM: MILK, CREAM, SUGAR SYRUP, CORN SYRUP, WHEY, BUTTERMILK. MALTODEXTRIN, CELLULOSE GEL, MONO - AND DIGLYCERIDES.... |
| ingredients_text_en_ocr_1740108312 | 1/3000 | string | SUGAR, ENRICHED WHEAT FLOUR (WHEAT FLOUR, MALTED BARLEY FLOUR, FERROUS SULFATE, NIACIN, THIAMINE MONONITRATE, RIBOFLAVIN... |
| ingredients_text_en_ocr_1740108312_result | 1/3000 | string | SUGAR, ENRICHED WHEAT FLOUR (WHEAT FLOUR, MALTED BARLEY FLOUR, FERROUS SULFATE, NIACIN, THIAMINE MONONITRATE, RIBOFLAVIN... |
| ingredients_text_en_ocr_1740108422 | 1/3000 | string | INGREDIENTS: ROLLED OATS, SUGAR, FLAVORED FRUIT PIECES (DEHYDRATED APPLES, ARTIFICIAL FLAVOR, CALCIUM STEARATE (FLOW AGE... |
| ingredients_text_en_ocr_1740108422_result | 1/3000 | string | ROLLED OATS, SUGAR, FLAVORED FRUIT PIECES (DEHYDRATED APPLES, ARTIFICIAL FLAVOR, CALCIUM STEARATE (FLOW AGENT), CITRIC A... |
| ingredients_text_en_ocr_1740108423 | 1/3000 | string | INGREDIENTS: HIGH FRUCTOSE CORN SYRUP, CORN SYRUP, WATER, CONTAINS LESS THAN 2% OF: CELLULOSE GUM, CARAMEL COLOR, SALT, ... |
| ingredients_text_en_ocr_1740108423_result | 1/3000 | string | HIGH FRUCTOSE CORN SYRUP, CORN SYRUP, WATER, CONTAINS LESS THAN 2% OF: CELLULOSE GUM, CARAMEL COLOR, SALT, NATURAL AND A... |
| ingredients_text_en_ocr_1740108424 | 1/3000 | string | INGREDIENTS: SOYBEAN OIL, SUGAR, WATER, VINEGAR, SALT, POPPYSEED, DRIED ONION, SPICE, POTASSIUM SORBATE (PRESERVATIVE), ... |
| ingredients_text_en_ocr_1740108424_result | 1/3000 | string | SOYBEAN OIL, SUGAR, WATER, VINEGAR, SALT, POPPYSEED, DRIED ONION, SPICE, POTASSIUM SORBATE (PRESERVATIVE), XANTHAN GUM, ... |
| ingredients_text_en_ocr_1740108446 | 1/3000 | string | INGREDIENTS: DEGERMINATED WHITE CORN GRITS, DEHYDRATED CHEESE POWDER, (MODIFIED WHEY, PARTIALLY HYDROGENATED VEGETABLE O... |
| ingredients_text_en_ocr_1740108446_result | 1/3000 | string | DEGERMINATED WHITE CORN GRITS, DEHYDRATED CHEESE POWDER, (MODIFIED WHEY, PARTIALLY HYDROGENATED VEGETABLE OIL [SOYBEAN, ... |
| ingredients_text_en_ocr_1740108447 | 1/3000 | string | INGREDIENTS: DEGERMINATED WHITE CORN GRITS, WHEY POWDER, DRIED MARGARINE (PARTIALLY HYDROGENATED SOYBEAN OIL, NONFAT MIL... |
| ingredients_text_en_ocr_1740108447_result | 1/3000 | string | DEGERMINATED WHITE CORN GRITS, WHEY POWDER, DRIED MARGARINE (PARTIALLY HYDROGENATED SOYBEAN OIL, NONFAT MILK, SWEET WHEY... |
| ingredients_text_en_ocr_1740108449 | 1/3000 | string | INGREDIENTS: DEGERMINATED WHITE CORN GRITS, SALT,CALCIUM CARBONATE, FERRIC PHOSPHATE, SOY LECITHIN BHA AND CITRIC ACID (... |
| ingredients_text_en_ocr_1740108449_result | 1/3000 | string | DEGERMINATED WHITE CORN GRITS, SALT,CALCIUM CARBONATE, FERRIC PHOSPHATE, SOY LECITHIN BHA AND CITRIC ACID (AS PRESERVATI... |
| ingredients_text_en_ocr_1740108453 | 1/3000 | string | INGREDIENTS: WHITE HOMINY GRITS, NIACIN, REDUCED IRON, THIAMIN MONONITRATE, RIBOFLAVIN, FOLIC ACID. |
| ingredients_text_en_ocr_1740108453_result | 1/3000 | string | WHITE HOMINY GRITS, NIACIN, REDUCED IRON, THIAMIN MONONITRATE, RIBOFLAVIN, FOLIC ACID. |
| ingredients_text_en_ocr_1740108465 | 1/3000 | string | INGREDIENTS: SOYBEAN OIL, WATER, LOWFAT BUTTERMILK (CULTURED LOWFAT AND SKIM MILK, SALT, TAPIOCA STARCH, LOCUST BEAN GUM... |
| ingredients_text_en_ocr_1740108465_result | 1/3000 | string | SOYBEAN OIL, WATER, LOWFAT BUTTERMILK (CULTURED LOWFAT AND SKIM MILK, SALT, TAPIOCA STARCH, LOCUST BEAN GUM, CARRAGEENAN... |
| ingredients_text_en_ocr_1740108466 | 1/3000 | string | INGREDIENTS: TOMATO PUREE (WATER, TOMATO PASTE, CONCENTRATE), HIGH FRUCTOSE CORN SYRUP, SOYBEAN OIL, CORN-CIDER VINEGAR,... |
| ingredients_text_en_ocr_1740108466_result | 1/3000 | string | TOMATO PUREE (WATER, TOMATO PASTE, CONCENTRATE), HIGH FRUCTOSE CORN SYRUP, SOYBEAN OIL, CORN-CIDER VINEGAR, SUGAR, SALT,... |
| ingredients_text_en_ocr_1740108470 | 1/3000 | string | SUGAR, DEXTROSE, MODIFIED TAPIOCA AND CORN STARCH, MONO- AND DIGLYCERIDES, TETRASODIUM PYROPHOSPHATE. CONTAINS 2% OR LES... |
| ingredients_text_en_ocr_1740108470_result | 1/3000 | string | SUGAR, DEXTROSE, MODIFIED TAPIOCA AND CORN STARCH, MONO - AND DIGLYCERIDES, TETRASODIUM PYROPHOSPHATE. CONTAINS 2% OR LE... |
| ingredients_text_en_ocr_1740108477 | 1/3000 | string | INGREDIENTS: WATER, SOYBEAN OIL, HIGH FRUCTOSE CORN SYRUP, DISTILLED VINEGAR, SALT. CONTAINS 2% OR LESS OF : DRIED GARLI... |
| ingredients_text_en_ocr_1740108477_result | 1/3000 | string | WATER, SOYBEAN OIL, HIGH FRUCTOSE CORN SYRUP, DISTILLED VINEGAR, SALT. CONTAINS 2% OR LESS OF : DRIED GARLIC, DRIED ONIO... |
| ingredients_text_en_ocr_1740108479 | 1/3000 | string | INGREDIENTS: SOYBEAN OIL, TOMATO PUREE (WATER, TOMATO PASTE CONCENTRATE), WATER, HIGH FRUCTOSE CORN SYRUP, VINEGAR, RELI... |
| ingredients_text_en_ocr_1740108479_result | 1/3000 | string | SOYBEAN OIL, TOMATO PUREE (WATER, TOMATO PASTE CONCENTRATE), WATER, HIGH FRUCTOSE CORN SYRUP, VINEGAR, RELISH (CUCUMBERS... |
| ingredients_text_en_ocr_1740108480 | 1/3000 | string | INGREDIENTS: HIGH FRUCTOSE CORN SYRUP, TOMATO PUREE (WATER, TOMATO PASTE), VINEGAR, APPLE CIDER VINEGAR, MOLASEES, MODIF... |
| ingredients_text_en_ocr_1740108480_result | 1/3000 | string | HIGH FRUCTOSE CORN SYRUP, TOMATO PUREE (WATER, TOMATO PASTE), VINEGAR, APPLE CIDER VINEGAR, MOLASEES, MODIFIED CORN STAR... |
| ingredients_text_en_ocr_1740108489 | 1/3000 | string | INGREDIENTS: ENRICHED WHEAT FLOUR (WHEAT FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC ACID), HIG... |
| ingredients_text_en_ocr_1740108489_result | 1/3000 | string | ENRICHED WHEAT FLOUR (WHEAT FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC ACID), HIGH FRUCTOSE CO... |
| ingredients_text_en_ocr_1740108493 | 1/3000 | string | INGREDIENTS:SOYBEAN OIL, CUCUMBER JUICE, SUGAR, SOUR CREAM POWDER (CREAM, NONFAT MILK, CULTURES), SALT, VINEGAR, DRIED O... |
| ingredients_text_en_ocr_1740108493_result | 1/3000 | string | SOYBEAN OIL, CUCUMBER JUICE, SUGAR, SOUR CREAM POWDER (CREAM, NONFAT MILK, CULTURES), SALT, VINEGAR, DRIED ONION, NATURA... |
| ingredients_text_en_ocr_1740108494 | 1/3000 | string | INGREDIENTS: SOYBEAN OIL, WATER, VINEGAR,HIGH FRUCTOSE, CORN SYRUP, SALT, SUGAR, CONTAINS 2% OR LESS OF: DRIED GARLIC, X... |
| ingredients_text_en_ocr_1740108494_result | 1/3000 | string | SOYBEAN OIL, WATER, VINEGAR,HIGH FRUCTOSE, CORN SYRUP, SALT, SUGAR, CONTAINS 2% OR LESS OF: DRIED GARLIC, XANTHAN GUM, P... |
| ingredients_text_en_ocr_1740108498 | 1/3000 | string | INGREDIENTS: SOYBEAN OIL, LOWFAT BUTTERMILK (CULTURED LOWFAT AND SKIM MILK, SALT, TAPIOCA STARCH, LOCUST BEAN GUM, CARRA... |
| ingredients_text_en_ocr_1740108498_result | 1/3000 | string | SOYBEAN OIL, LOWFAT BUTTERMILK (CULTURED LOWFAT AND SKIM MILK, SALT, TAPIOCA STARCH, LOCUST BEAN GUM, CARRAGEENAN), WATE... |
| ingredients_text_en_ocr_1740108509 | 1/3000 | string | INGREDIENTS: TOMATO PUREE (TOMATO PASTE, WATER), HIGH FRUCTOSE CORN SYRUP, MOLASSES, VINEGAR, NATURAL SMOKE FLAVOR, CONT... |
| ingredients_text_en_ocr_1740108509_result | 1/3000 | string | TOMATO PUREE (TOMATO PASTE, WATER), HIGH FRUCTOSE CORN SYRUP, MOLASSES, VINEGAR, NATURAL SMOKE FLAVOR, CONTAINS LESS THA... |
| ingredients_text_en_ocr_1740108510 | 1/3000 | string | INGREDIENTS: WATER, LOWFAT BUTTERMILK** (CULTURED LOWFAT AND MILK, SALT, TAPIOCA STARCH, LOCUST BEAN GUM, CARRAGEENAN), ... |
| ingredients_text_en_ocr_1740108510_result | 1/3000 | string | WATER, LOWFAT BUTTERMILK** (CULTURED LOWFAT AND MILK, SALT, TAPIOCA STARCH, LOCUST BEAN GUM, CARRAGEENAN), CORN SYRUP, D... |
| ingredients_text_en_ocr_1740108512 | 1/3000 | string | MODIFIED CORN STARCH, TAPIOCA MALTODEXTRIN*, DISODIUM PHOSPHATE, TETRASODIUM PYROPHOSPHATE NATURAL AND ARTIFICIAL FLAVOR... |
| ingredients_text_en_ocr_1740108512_result | 1/3000 | string | MODIFIED CORN STARCH, TAPIOCA MALTODEXTRIN*, DISODIUM PHOSPHATE, TETRASODIUM PYROPHOSPHATE NATURAL AND ARTIFICIAL FLAVOR... |
| ingredients_text_en_ocr_1740108515 | 1/3000 | string | INGREDIENTS: SOYBEAN OIL, HIGH FRUCTOSE CORN SYRUP, CORN SYRUP, VINEGAR, BACON (CURED WITH WATER, SALT, SUGAR, SODIUM PH... |
| ingredients_text_en_ocr_1740108515_result | 1/3000 | string | SOYBEAN OIL, HIGH FRUCTOSE CORN SYRUP, CORN SYRUP, VINEGAR, BACON (CURED WITH WATER, SALT, SUGAR, SODIUM PHOSPHATE, HYDR... |
| ingredients_text_en_ocr_1740108526 | 1/3000 | string | INGREDIENTS: SOYBEAN OIL, WATER, SUGAR, HONEY, VINEGAR, TOMATO PASTE, SALT, CONTAINS 2% OR LESS OF: POPPY SEEDS, XANTHAN... |
| ingredients_text_en_ocr_1740108526_result | 1/3000 | string | SOYBEAN OIL, WATER, SUGAR, HONEY, VINEGAR, TOMATO PASTE, SALT, CONTAINS 2% OR LESS OF: POPPY SEEDS, XANTHAN GUM, DRIED O... |
| ingredients_text_en_ocr_1740108543 | 1/3000 | string | INGREDIENTS: PREPARED BLACKEYED PEAS, WATER, SALT, CALCIUM CHLORIDE (FIRMING AGENT), DISODIUM EDTA ADDED TO PROMOTE COLO... |
| ingredients_text_en_ocr_1740108543_result | 1/3000 | string | PREPARED BLACKEYED PEAS, WATER, SALT, CALCIUM CHLORIDE (FIRMING AGENT), DISODIUM EDTA ADDED TO PROMOTE COLOR RETENTION. |
| ingredients_text_en_ocr_1740108544 | 1/3000 | string | INGREDIENTS: PREPARED KIDNEY BEANS, WATER, SUGAR, SALT, CALCIUM CHLORIDE (FIRMING AGENT), DISODIUM EDTA (TO PROMOTE COLO... |
| ingredients_text_en_ocr_1740108544_result | 1/3000 | string | PREPARED KIDNEY BEANS, WATER, SUGAR, SALT, CALCIUM CHLORIDE (FIRMING AGENT), DISODIUM EDTA (TO PROMOTE COLOR RETENTION). |
| ingredients_text_en_ocr_1740108553 | 1/3000 | string | INGREDIENTS: PREPARED RED BEANS, WATER, SALT, CALCIUM DISODIUM EDTA ADDED TO PROMOTE COLOR RETENTION. |
| ingredients_text_en_ocr_1740108553_result | 1/3000 | string | PREPARED RED BEANS, WATER, SALT, CALCIUM DISODIUM EDTA ADDED TO PROMOTE COLOR RETENTION. |
| ingredients_text_en_ocr_1740108554 | 1/3000 | string | MODIFIED CORN STARCH, MALTODEXTRIN, WHEAT FLOUR, RENDERED BEEF FAT (WITH CITRIC ACID AND BHA TO PROTECT FLAVOR), HYDROLY... |
| ingredients_text_en_ocr_1740108554_result | 1/3000 | string | MODIFIED CORN STARCH, MALTODEXTRIN, WHEAT FLOUR, RENDERED BEEF FAT (WITH CITRIC ACID AND BHA TO PROTECT FLAVOR), HYDROLY... |
| ingredients_text_en_ocr_1740108560 | 1/3000 | string | INGREDIENTS: WATER, DISTILLED VINEGAR, MOLASSES, SALT, CITRIC ACID, DEXTROSE, CARAMEL COLOR, NATURAL FLAVORS, MALIC ACID... |
| ingredients_text_en_ocr_1740108560_result | 1/3000 | string | WATER, DISTILLED VINEGAR, MOLASSES, SALT, CITRIC ACID, DEXTROSE, CARAMEL COLOR, NATURAL FLAVORS, MALIC ACID, HYDROLYZED ... |
| ingredients_text_en_ocr_1740108565 | 1/3000 | string | MODIFIED CORN STARCH, WHEAT FLOUR, SALT, MALTODEXTRIN, MUSHROOMS*, HYDROLYZED CORN GLUTEN AND TORULA YEAST EXTRACT, BEEF... |
| ingredients_text_en_ocr_1740108565_result | 1/3000 | string | MODIFIED CORN STARCH, WHEAT FLOUR, SALT, MALTODEXTRIN, MUSHROOMS*, HYDROLYZED CORN GLUTEN AND TORULA YEAST EXTRACT, BEEF... |
| ingredients_text_en_ocr_1740108567 | 1/3000 | string | MODIFIED TAPIOCA AND CORN STARCH, HYDROLYZED CORN GLUTEN, SOY PROTEIN AND WHET GLUTEN, SALT, DEXTROSE, WHEY*, AUTOLYZED ... |
| ingredients_text_en_ocr_1740108567_result | 1/3000 | string | MODIFIED TAPIOCA AND CORN STARCH, HYDROLYZED CORN GLUTEN, SOY PROTEIN AND WHET GLUTEN, SALT, DEXTROSE, WHEY*, AUTOLYZED ... |
| ingredients_text_en_ocr_1740179863 | 1/3000 | string | INGREDIENTS: DRY ROASTED ALMONDS, CASHEWS, PISTACHIOS, PURE CANE SUGAR, RICE SYRUP, DRIED BLUEBERRIES, POMEGRANATE POWDE... |
| ingredients_text_en_ocr_1740179863_result | 1/3000 | string | DRY ROASTED ALMONDS, CASHEWS, PISTACHIOS, PURE CANE SUGAR, RICE SYRUP, DRIED BLUEBERRIES, POMEGRANATE POWDER, SEA SALT A... |
| ingredients_text_en_ocr_1740179984 | 1/3000 | string | WHOLE WHEAT FLOUR, WATER, SHORTENING (SOYBEAN OIL, HYDROGENATED SOYBEAN OIL), BAKING BLEND (SALT, MONO- AND DIGLYCERIDES... |
| ingredients_text_en_ocr_1740179984_result | 1/3000 | string | WHOLE WHEAT FLOUR, WATER, SHORTENING (SOYBEAN OIL, HYDROGENATED SOYBEAN OIL), BAKING BLEND (SALT, MONO - AND DIGLYCERIDE... |
| ingredients_text_en_ocr_1740180316 | 1/3000 | string | INGREDIENTS- MILK CHOCOLATE (SUGAR, COCOA BUTTER, COCOA MASS, SKIM MILK POWDER, BUTTERFOIL, LECITHIN AS EMULSIFIER (SOY)... |
| ingredients_text_en_ocr_1740180316_result | 1/3000 | string | MILK CHOCOLATE (SUGAR, COCOA BUTTER, COCOA MASS, SKIM MILK POWDER, BUTTERFOIL, LECITHIN AS EMULSIFIER (SOY). VANULLIN: A... |
| ingredients_text_en_ocr_1740180330 | 1/3000 | string | INGREDIENTS: SEMISWEET CHOCOLATE (SUGAR. COCOA MASS, COCOA BUTTER, LECITHIN AS EMULSIFIER (SOY), VANILLIN: AN ARTIFICIAL... |
| ingredients_text_en_ocr_1740180330_result | 1/3000 | string | SEMISWEET CHOCOLATE (SUGAR. COCOA MASS, COCOA BUTTER, LECITHIN AS EMULSIFIER (SOY), VANILLIN: AN ARTIFICIAL FLAVOR), SUG... |
| ingredients_text_en_ocr_1740180345 | 1/3000 | string | INGREDIENTS: PARMESAN CHEESE MADE FROM PASTEURIZED PART-SKIM COW'S MILK, CHEESE CULTURE, SALT AND ENZYMES. PARMESAN FLAV... |
| ingredients_text_en_ocr_1740180345_result | 1/3000 | string | PARMESAN CHEESE MADE FROM PASTEURIZED PART-SKIM COW'S MILK, CHEESE CULTURE, SALT AND ENZYMES. PARMESAN FLAVORED TOPPING ... |
| ingredients_text_en_ocr_1740180387 | 1/3000 | string | INGREDIENTS: WALNUTS, ALMONDS |
| ingredients_text_en_ocr_1740180387_result | 1/3000 | string | WALNUTS, ALMONDS |
| ingredients_text_en_ocr_1740180389 | 1/3000 | string | INGREDIENTS: WALNUTS SUGAR, CORN SYRUP, SESAME SEEDS, SALT, CANOLA OIL, SOY LECITHIN (AN EMULSIFIER), NATURAL FLAVOR, CI... |
| ingredients_text_en_ocr_1740180389_result | 1/3000 | string | WALNUTS SUGAR, CORN SYRUP, SESAME SEEDS, SALT, CANOLA OIL, SOY LECITHIN (AN EMULSIFIER), NATURAL FLAVOR, CITRIC ACID. |
| ingredients_text_en_ocr_1740180507 | 1/3000 | string | SUGAR, WATER, BLEACHED ENRICHED WHEAT FLOUR (FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC ACID),... |
| ingredients_text_en_ocr_1740180507_result | 1/3000 | string | SUGAR, WATER, BLEACHED ENRICHED WHEAT FLOUR (FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC ACID),... |
| ingredients_text_en_ocr_1740180510 | 1/3000 | string | SUGAR, WATER, BLEACHED ENRICHED WHEAT FLOUR (FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC ACID),... |
| ingredients_text_en_ocr_1740180510_result | 1/3000 | string | SUGAR, WATER, BLEACHED ENRICHED WHEAT FLOUR (FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC ACID),... |
| ingredients_text_en_ocr_1740180511 | 1/3000 | string | SUGAR, WATER, BLEACHED ENRICHED WHEAT FLOUR (FLOUR, NIACIN, REDUCED IRON, THIAMIN MONONITRATE, RIBOFLAVIN, FOLIC ACID), ... |
| ingredients_text_en_ocr_1740180511_result | 1/3000 | string | SUGAR, WATER, BLEACHED ENRICHED WHEAT FLOUR (FLOUR, NIACIN, REDUCED IRON, THIAMIN MONONITRATE, RIBOFLAVIN, FOLIC ACID), ... |
| ingredients_text_en_ocr_1740180515 | 1/3000 | string | SUGAR, WATER, BLEACHED ENRICHED WHEAT FLOUR (FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC ACID),... |
| ingredients_text_en_ocr_1740180515_result | 1/3000 | string | SUGAR, WATER, BLEACHED ENRICHED WHEAT FLOUR (FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC ACID),... |
| ingredients_text_en_ocr_1740180530 | 1/3000 | string | INGREDIENTS: TOMATILLOS, NOPALES CACTUS, ONION, SERRANO PEPPER, PINEAPPLE JUICE, CILANTRO, SALT. |
| ingredients_text_en_ocr_1740180530_result | 1/3000 | string | TOMATILLOS, NOPALES CACTUS, ONION, SERRANO PEPPER, PINEAPPLE JUICE, CILANTRO, SALT. |
| ingredients_text_en_ocr_1740180537 | 1/3000 | string | WHOLE WHEAT FLOUR (MALTED BARLEY), WATER, WHOLE SPELT FLOUR, WHOLE WHITE WHEAT FLOUR, SUGAR, WHEAT GLUTEN, WHOLE BULGUR ... |
| ingredients_text_en_ocr_1740180537_result | 1/3000 | string | WHOLE WHEAT FLOUR (MALTED BARLEY), WATER, WHOLE SPELT FLOUR, WHOLE WHITE WHEAT FLOUR, SUGAR, WHEAT GLUTEN, WHOLE BULGUR ... |
| ingredients_text_en_ocr_1740180538 | 1/3000 | string | WATER, WHOLE WHEAT FLOUR, ENRICHED WHEAT FLOUR (WHEAT FLOUR, MALTED BARLEY FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONIT... |
| ingredients_text_en_ocr_1740180538_result | 1/3000 | string | WATER, WHOLE WHEAT FLOUR, ENRICHED WHEAT FLOUR (WHEAT FLOUR, MALTED BARLEY FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONIT... |
| ingredients_text_en_ocr_1740180550 | 1/3000 | string | ENRICHED WHEAT FLOUR (FLOUR, MALTED BARLEY FLOUR, REDUCED IRON, NIACIN, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC ACID), W... |
| ingredients_text_en_ocr_1740180550_result | 1/3000 | string | ENRICHED WHEAT FLOUR (FLOUR, MALTED BARLEY FLOUR, REDUCED IRON, NIACIN, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC ACID), W... |
| ingredients_text_en_ocr_1740180555 | 1/3000 | string | INGREDIENTS: HIGH FRUCTOSE CORN SYRUP, CORN SYRUP, WATER, CONTAINS LESS THAN 2% OF: CARAMEL COLOR, SALT, CELLULOSE GUM, ... |
| ingredients_text_en_ocr_1740180555_result | 1/3000 | string | HIGH FRUCTOSE CORN SYRUP, CORN SYRUP, WATER, CONTAINS LESS THAN 2% OF: CARAMEL COLOR, SALT, CELLULOSE GUM, NATURAL FLAVO... |
| ingredients_text_en_ocr_1740180566 | 1/3000 | string | ICE CREAM - MILK, CREAM, SUGAR, CORN SYRUP, NATURAL FLAVOR, WHEY PROTEIN CONCENTRATE, PROPYLENE GLYCOL MONOESTERS, GUAR ... |
| ingredients_text_en_ocr_1740180566_result | 1/3000 | string | ICE CREAM - MILK, CREAM, SUGAR, CORN SYRUP, NATURAL FLAVOR, WHEY PROTEIN CONCENTRATE, PROPYLENE GLYCOL MONOESTERS, GUAR ... |
| ingredients_text_en_ocr_1740180585 | 1/3000 | string | BROWNIE- SUGAR, ENRICHED WHEAT FLOUR, BLEACHED (FLOUR, NIACIN, IRON THIAMINE, MONONITRATE, RIBOFLAVIN, FOLIC ACID), PALM... |
| ingredients_text_en_ocr_1740180585_result | 1/3000 | string | BROWNIE - SUGAR, ENRICHED WHEAT FLOUR, BLEACHED (FLOUR, NIACIN, IRON THIAMINE, MONONITRATE, RIBOFLAVIN, FOLIC ACID), PAL... |
| ingredients_text_en_ocr_1740180586 | 1/3000 | string | INGREDIENTS: WATER, SOYBEAN OIL, VINEGAR, CORN STARCH-MODIFIED*, EGG YOLKS, SUGAR, SALT, CULTURED NONFAT MILK*, LACTIC A... |
| ingredients_text_en_ocr_1740180586_result | 1/3000 | string | WATER, SOYBEAN OIL, VINEGAR, CORN STARCH-MODIFIED*, EGG YOLKS, SUGAR, SALT, CULTURED NONFAT MILK*, LACTIC ACID*, MUSTARD... |
| ingredients_text_en_ocr_1740180587 | 1/3000 | string | INGREDIENTS: WATER, HIGH FRUCTOSE CORN SYRUP, SOYBEAN, VINEGAR, MODIFIED CORN STARCH, CELLULOSE GEL, CELLULOSE GUM, EGG ... |
| ingredients_text_en_ocr_1740180587_result | 1/3000 | string | WATER, HIGH FRUCTOSE CORN SYRUP, SOYBEAN, VINEGAR, MODIFIED CORN STARCH, CELLULOSE GEL, CELLULOSE GUM, EGG YOLKS, SALT, ... |
| ingredients_text_en_ocr_1740180596 | 1/3000 | string | INGREDIENTS: PEANUTS, CASHEWS, ALMONDS, BRAZIL NUTS, PECANS, VEGETABLE OIL (PEANUT, COTTONSEED, SOYBEAN, AND/OR SUNFLOWE... |
| ingredients_text_en_ocr_1740180596_result | 1/3000 | string | PEANUTS, CASHEWS, ALMONDS, BRAZIL NUTS, PECANS, VEGETABLE OIL (PEANUT, COTTONSEED, SOYBEAN, AND/OR SUNFLOWER OIL), FILBE... |
| ingredients_text_en_ocr_1740180603 | 1/3000 | string | INGREDIENTS:WATER, SOYBEAN OIL, HONEY, DIJON MUSTARD (WATER, MUSTARD SEED, VINEGAR, SALT, WHITE WINE, CITRIC ACID, TARTA... |
| ingredients_text_en_ocr_1740180603_result | 1/3000 | string | WATER, SOYBEAN OIL, HONEY, DIJON MUSTARD (WATER, MUSTARD SEED, VINEGAR, SALT, WHITE WINE, CITRIC ACID, TARTARIC ACID, SP... |
| ingredients_text_en_ocr_1740180604 | 1/3000 | string | INGREDIENTS:WATER, HIGH FRUCTOSE CORN SYRUP, RED WINE VINEGAR, SOYBEAN OIL, DISTILLED VINEGAR, CONTAINS 2% LESS OF: SALT... |
| ingredients_text_en_ocr_1740180604_result | 1/3000 | string | WATER, HIGH FRUCTOSE CORN SYRUP, RED WINE VINEGAR, SOYBEAN OIL, DISTILLED VINEGAR, CONTAINS 2% LESS OF: SALT, RED RASPBE... |
| ingredients_text_en_ocr_1740180610 | 1/3000 | string | MODIFIED CORN STARCH, MALTODEXTRIN, WHEAT FLOUR, WHEY PROTEIN CONCENTRATE, SALT, PARTIALLY HYDROGENATED SOYBEAN AND/OR C... |
| ingredients_text_en_ocr_1740180610_result | 1/3000 | string | MODIFIED CORN STARCH, MALTODEXTRIN, WHEAT FLOUR, WHEY PROTEIN CONCENTRATE, SALT, PARTIALLY HYDROGENATED SOYBEAN AND/OR C... |
| ingredients_text_en_ocr_1740180618 | 1/3000 | string | ICE CREAM - MILK AND SKIM MILK, CREAM, SUGAR, CORN SYRUP, HIGH FRUCTOSE CORN SYRUP, WHEY, BUTTERMILK, CELLULOSE GEL, GUA... |
| ingredients_text_en_ocr_1740180618_result | 1/3000 | string | ICE CREAM - MILK AND SKIM MILK, CREAM, SUGAR, CORN SYRUP, HIGH FRUCTOSE CORN SYRUP, WHEY, BUTTERMILK, CELLULOSE GEL, GUA... |
| ingredients_text_en_ocr_1740180623 | 1/3000 | string | ICE CREAM - MILK, CREAM, SUGAR, CORN SYRUP, WHEY PROTEIN CONCENTRATE, EGG YOLKS, NATURAL FLAVOR, PROPYLENE GLYCOL MONOES... |
| ingredients_text_en_ocr_1740180623_result | 1/3000 | string | ICE CREAM - MILK, CREAM, SUGAR, CORN SYRUP, WHEY PROTEIN CONCENTRATE, EGG YOLKS, NATURAL FLAVOR, PROPYLENE GLYCOL MONOES... |
| ingredients_text_en_ocr_1740180635 | 1/3000 | string | ENRICHED FLOUR (WHEAT FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC ACID), CHOCOLATE CHIPS (SUGAR... |
| ingredients_text_en_ocr_1740180635_result | 1/3000 | string | ENRICHED FLOUR (WHEAT FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC ACID), CHOCOLATE CHIPS (SUGAR... |
| ingredients_text_en_ocr_1740180648 | 1/3000 | string | INGREDIENTS: ROLLED OATS, SOLUBLE CORN FIBER, DEHYDRATED APPLE FLAKES (TREATED WITH SODIUM SULFITE AND SULFUR DIOXIDE TO... |
| ingredients_text_en_ocr_1740180648_result | 1/3000 | string | ROLLED OATS, SOLUBLE CORN FIBER, DEHYDRATED APPLE FLAKES (TREATED WITH SODIUM SULFITE AND SULFUR DIOXIDE TO PROMOTE COLO... |
| ingredients_text_en_ocr_1740180652 | 1/3000 | string | MILK, CREAM, CORN SYRUP, SUGAR, HIGH FRUCTOSE CORN SYRUP, STRAWBERRIES, COCOA PROCESSED WITH ALKALI, WHEY, BUTTERMILK, C... |
| ingredients_text_en_ocr_1740180652_result | 1/3000 | string | MILK, CREAM, CORN SYRUP, SUGAR, HIGH FRUCTOSE CORN SYRUP, STRAWBERRIES, COCOA PROCESSED WITH ALKALI, WHEY, BUTTERMILK, C... |
| ingredients_text_en_ocr_1740180657 | 1/3000 | string | WATER, SUGAR, MILK* AND SKIM MILK*, CORN SYRUP, CONCENTRATED RASPBERRY JUICE, CONCENTRATED LIME JUICE, ORANGE PULP, CONC... |
| ingredients_text_en_ocr_1740180657_result | 1/3000 | string | WATER, SUGAR, MILK* AND SKIM MILK*, CORN SYRUP, CONCENTRATED RASPBERRY JUICE, CONCENTRATED LIME JUICE, ORANGE PULP, CONC... |
| ingredients_text_en_ocr_1740180661 | 1/3000 | string | DAIRY DESSERT - MILK, SUGAR, CORN SYRUP, CREAM, HIGH FRUCTOSE CORN SYRUP, NONFAT MILK, WHEY, MALTODEXTRIN, WHEY PROTEIN ... |
| ingredients_text_en_ocr_1740180661_result | 1/3000 | string | DAIRY DESSERT - MILK, SUGAR, CORN SYRUP, CREAM, HIGH FRUCTOSE CORN SYRUP, NONFAT MILK, WHEY, MALTODEXTRIN, WHEY PROTEIN ... |
| ingredients_text_en_ocr_1740180670 | 2/3000 | string | INGREDIENTS: SOYBEAN OIL,WATER.EGG YOLK, CORN SYRUP, VINEGAR, SALT, MUSTARD POWDER, LEMON JUICE CONCENTRATE,NATURAL FLAV...<br>INGREDIENTS: WATER, DISTILLED VINEGAR, SOYBEAN OIL, HIGH FRUCTOSE CORN SYRUP, SALT, CONTAINS 2% LESS OF: DRIED GARLIC, D... |
| ingredients_text_en_ocr_1740180670_result | 2/3000 | string | SOYBEAN OIL,WATER.EGG YOLK, CORN SYRUP, VINEGAR, SALT, MUSTARD POWDER, LEMON JUICE CONCENTRATE,NATURAL FLAVOR, CALCIUM D...<br>WATER, DISTILLED VINEGAR, SOYBEAN OIL, HIGH FRUCTOSE CORN SYRUP, SALT, CONTAINS 2% LESS OF: DRIED GARLIC, DRIED ONION, D... |
| ingredients_text_en_ocr_1740180673 | 1/3000 | string | INGREDIENTS: HIGH FRUCTOSE CORN, SYRUP, TOMATO PUREE (TOMATO PASTE, WATER), DISTILLED VINEGAR, MODIFIED CORN STARCH, CON... |
| ingredients_text_en_ocr_1740180673_result | 1/3000 | string | HIGH FRUCTOSE CORN, SYRUP, TOMATO PUREE (TOMATO PASTE, WATER), DISTILLED VINEGAR, MODIFIED CORN STARCH, CONTAINS 2% OR L... |
| ingredients_text_en_ocr_1740180674 | 1/3000 | string | INGREDIENTS: HIGH FRUCTOSE CORN SYRUP, TOMATO PUREE (TOMATO PASTE, WATER), DISTILLED VINEGAR, MODIFIED CORN STARCH, CONT... |
| ingredients_text_en_ocr_1740180674_result | 1/3000 | string | HIGH FRUCTOSE CORN SYRUP, TOMATO PUREE (TOMATO PASTE, WATER), DISTILLED VINEGAR, MODIFIED CORN STARCH, CONTAINS 2% OR LE... |
| ingredients_text_en_ocr_1740180688 | 1/3000 | string | INGREDIENTS: SOYBEAN OIL, EGGS AND EGG YOLKS, WATER, DISTILLED VINEGAR, SUGAR, SALT, LEMON JUICE CONCENTRATE, NATURAL FL... |
| ingredients_text_en_ocr_1740180688_result | 1/3000 | string | SOYBEAN OIL, EGGS AND EGG YOLKS, WATER, DISTILLED VINEGAR, SUGAR, SALT, LEMON JUICE CONCENTRATE, NATURAL FLAVORS, CALCIU... |
| ingredients_text_en_ocr_1740180692 | 1/3000 | string | INGREDIENTS: SOYBEAN OIL, EGGS AND EGG YOLKS, WATER, DISTILLED VINEGAR, SUGAR, SALT, LEMON JUICE CONCENTRATE, NATURAL, F... |
| ingredients_text_en_ocr_1740180692_result | 1/3000 | string | SOYBEAN OIL, EGGS AND EGG YOLKS, WATER, DISTILLED VINEGAR, SUGAR, SALT, LEMON JUICE CONCENTRATE, NATURAL, FLAVORS, CALCI... |
| ingredients_text_en_ocr_1740180696 | 1/3000 | string | INGREDIENTS: ENRICHED LONG GRAIN RICE (RICE, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, FOLIC ACID), ENRICHED VERMICELL... |
| ingredients_text_en_ocr_1740180696_result | 1/3000 | string | ENRICHED LONG GRAIN RICE (RICE, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, FOLIC ACID), ENRICHED VERMICELLI (DURUM SEMO... |
| ingredients_text_en_ocr_1740180710 | 2/3000 | string | INGREDIENTS: ALMONDS<br>INGREDIENTS: PINE NUTS. |
| ingredients_text_en_ocr_1740180710_result | 2/3000 | string | ALMONDS<br>PINE NUTS. |
| ingredients_text_en_ocr_1740180711 | 1/3000 | string | INGREDIENTS: WATER, SOYBEAN OIL, FETA CHEESE (MILK, SALT, CULTURES, ENZYMES), WHITE WINE VINEGAR, OLIVE OIL, DISTILLED V... |
| ingredients_text_en_ocr_1740180711_result | 1/3000 | string | WATER, SOYBEAN OIL, FETA CHEESE (MILK, SALT, CULTURES, ENZYMES), WHITE WINE VINEGAR, OLIVE OIL, DISTILLED VINEGAR, DRIED... |
| ingredients_text_en_ocr_1740180712 | 1/3000 | string | INGREDIENTS: SOYBEAN OIL, WATER, LOWFAT BUTTERMILK (CULTURED LOWFAT AND SKIM MILK, SALT, TAPIOCA STARCH, LOCUST BEAN GUM... |
| ingredients_text_en_ocr_1740180712_result | 1/3000 | string | SOYBEAN OIL, WATER, LOWFAT BUTTERMILK (CULTURED LOWFAT AND SKIM MILK, SALT, TAPIOCA STARCH, LOCUST BEAN GUM, CARRAGEENAN... |
| ingredients_text_en_ocr_1740180717 | 1/3000 | string | ICE CREAM - MILK, CREAM, SUGAR, CORN SYRUP, NATURAL FLAVOR, WHEY PROTEIN CONCENTRATE, HIGH FRUCTOSE CORN SYRUP, PROPYLEN... |
| ingredients_text_en_ocr_1740180717_result | 1/3000 | string | ICE CREAM - MILK, CREAM, SUGAR, CORN SYRUP, NATURAL FLAVOR, WHEY PROTEIN CONCENTRATE, HIGH FRUCTOSE CORN SYRUP, PROPYLEN... |
| ingredients_text_en_ocr_1740180732 | 1/3000 | string | INGREDIENTS: WATER, LIME JUICE FROM CONCENTRATE, HIGH FRUCTOSE CORN SYRUP, DISTILLED VINEGAR, SOY SAUCE (WATER, SOYBEANS... |
| ingredients_text_en_ocr_1740180732_result | 1/3000 | string | WATER, LIME JUICE FROM CONCENTRATE, HIGH FRUCTOSE CORN SYRUP, DISTILLED VINEGAR, SOY SAUCE (WATER, SOYBEANS, WHEAT AND S... |
| ingredients_text_en_ocr_1740180734 | 1/3000 | string | INGREDIENTS: HIGH FRUCTOSE CORN SYRUP, TOMATO PUREE (WATER, TOMATO PASTE), DISTILLED VINEGAR, LIME JUICE FROM CONCENTRAT... |
| ingredients_text_en_ocr_1740180734_result | 1/3000 | string | HIGH FRUCTOSE CORN SYRUP, TOMATO PUREE (WATER, TOMATO PASTE), DISTILLED VINEGAR, LIME JUICE FROM CONCENTRATE WATER, LIME... |
| ingredients_text_en_ocr_1740180741 | 1/3000 | string | SALTED CARAMEL SEASONED ALMONDS AND CASHEWS (ALMONDS, CASHEWS, VEGETABLE OIL [PEANUT, COTTONSEED, SOYBEAN, AND/OR SUNFLO... |
| ingredients_text_en_ocr_1740180741_result | 1/3000 | string | SALTED CARAMEL SEASONED ALMONDS AND CASHEWS (ALMONDS, CASHEWS, VEGETABLE OIL [PEANUT, COTTONSEED, SOYBEAN, AND/OR SUNFLO... |
| ingredients_text_en_ocr_1740180745 | 1/3000 | string | INGREDIENTS: WATER, HIGH FRUCTOSE CORN SYRUP, SOYBEAN OIL, VINEGAR, MODIFIED CORN STARCH, CELLULOSE GEL, CELLULOSE GUM, ... |
| ingredients_text_en_ocr_1740180745_result | 1/3000 | string | WATER, HIGH FRUCTOSE CORN SYRUP, SOYBEAN OIL, VINEGAR, MODIFIED CORN STARCH, CELLULOSE GEL, CELLULOSE GUM, EGG YOLKS, SA... |
| ingredients_text_en_ocr_1740180749 | 1/3000 | string | MILK, CREAM, SUGAR, CORN SYRUP, COFFEE CONCENTRATE, WHEY PROTEIN CONCENTRATE, PROPYLENE GLYCOL MONOESTERS, GUAR GUM, CEL... |
| ingredients_text_en_ocr_1740180749_result | 1/3000 | string | MILK, CREAM, SUGAR, CORN SYRUP, COFFEE CONCENTRATE, WHEY PROTEIN CONCENTRATE, PROPYLENE GLYCOL MONOESTERS, GUAR GUM, CEL... |
| ingredients_text_en_ocr_1740180795 | 1/3000 | string | INGREDIENTS: SOYBEAN OIL, WATER, BLUE CHEESE (MILK, CHEESE CULTURES, SALT, ENZYMES), DISTILLED VINEGAR, EGG YOLK, CONTAI... |
| ingredients_text_en_ocr_1740180795_result | 1/3000 | string | SOYBEAN OIL, WATER, BLUE CHEESE (MILK, CHEESE CULTURES, SALT, ENZYMES), DISTILLED VINEGAR, EGG YOLK, CONTAINS 2% OR LESS... |
| ingredients_text_en_ocr_1740180804 | 1/3000 | string | WATER, ENRICHED FLOUR (WHEAT FLOUR, MALTED BARLEY, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC ACID), ... |
| ingredients_text_en_ocr_1740180804_result | 1/3000 | string | WATER, ENRICHED FLOUR (WHEAT FLOUR, MALTED BARLEY, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC ACID), ... |
| ingredients_text_en_ocr_1740180805 | 1/3000 | string | POTATOES, SOUR CREAM (CREAM, SKIM MILK, MODIFIED CORN STARCH, LACTIC AND CITRIC ACID, BEEF GELATIN, MONO- AND DIGLYCERID... |
| ingredients_text_en_ocr_1740180805_result | 1/3000 | string | POTATOES, SOUR CREAM (CREAM, SKIM MILK, MODIFIED CORN STARCH, LACTIC AND CITRIC ACID, BEEF GELATIN, MONO - AND DIGLYCERI... |
| ingredients_text_en_ocr_1740180809 | 1/3000 | string | ENRICHED FLOUR BLEACHED (WHEAT FLOUR, MALTED BARLEY FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC... |
| ingredients_text_en_ocr_1740180809_result | 1/3000 | string | ENRICHED FLOUR BLEACHED (WHEAT FLOUR, MALTED BARLEY FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC... |
| ingredients_text_en_ocr_1740180823 | 1/3000 | string | SUGAR, ENRICHED BLEACHED FLOUR (WHEAT FLOUR, MALTED BARLEY FLOUR, NIACIN, FERROUS SULFATE, THIAMINE MONONITRATE, RIBOFLA... |
| ingredients_text_en_ocr_1740180823_result | 1/3000 | string | SUGAR, ENRICHED BLEACHED FLOUR (WHEAT FLOUR, MALTED BARLEY FLOUR, NIACIN, FERROUS SULFATE, THIAMINE MONONITRATE, RIBOFLA... |
| ingredients_text_en_ocr_1740180840 | 1/3000 | string | INGREDIENTS: ENRICHED FLOUR (WHEAT FLOUR, BARLEY MALT, NIACIAN, REDUCED IRON, THIAMIN MONONITRATE, RIBOFLAVIN, FOLIC ACI... |
| ingredients_text_en_ocr_1740180840_result | 1/3000 | string | ENRICHED FLOUR (WHEAT FLOUR, BARLEY MALT, NIACIAN, REDUCED IRON, THIAMIN MONONITRATE, RIBOFLAVIN, FOLIC ACID), PARTIALLY... |
| ingredients_text_en_ocr_1740180843 | 1/3000 | string | SUGAR, ENRICHED FLOUR (WHEAT FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC ACID), CORN SYRUP, HIG... |
| ingredients_text_en_ocr_1740180843_result | 1/3000 | string | SUGAR, ENRICHED FLOUR (WHEAT FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC ACID), CORN SYRUP, HIG... |
| ingredients_text_en_ocr_1740180857 | 1/3000 | string | INGREDIENTS: BLEACHED ENRICHED WHEAT FLOUR (WHEAT FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC A... |
| ingredients_text_en_ocr_1740180857_result | 1/3000 | string | BLEACHED ENRICHED WHEAT FLOUR (WHEAT FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC ACID), BROWN S... |
| ingredients_text_en_ocr_1740180862 | 1/3000 | string | INGREDIENTS: ENRICHED WHEAT FLOUR (WHEAT FLOUR, NIACIN, REDUCED IRON, THIAMIN FLOUR, SUGAR, VEGETABLE OIL SHORTENING (SO... |
| ingredients_text_en_ocr_1740180862_result | 1/3000 | string | ENRICHED WHEAT FLOUR (WHEAT FLOUR, NIACIN, REDUCED IRON, THIAMIN FLOUR, SUGAR, VEGETABLE OIL SHORTENING (SOYBEAN OIL OR ... |
| ingredients_text_en_ocr_1740180923 | 1/3000 | string | ENRICHED BLEACHED WHEAT FLOUR (FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC ACID), SUGAR, EGGS, ... |
| ingredients_text_en_ocr_1740180923_result | 1/3000 | string | ENRICHED BLEACHED WHEAT FLOUR (FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC ACID), SUGAR, EGGS, ... |
| ingredients_text_en_ocr_1740180931 | 1/3000 | string | ENRICHED FLOUR (WHEAT FLOUR, MALTED BARLEY FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC ACID), W... |
| ingredients_text_en_ocr_1740180931_result | 1/3000 | string | ENRICHED FLOUR (WHEAT FLOUR, MALTED BARLEY FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC ACID), W... |
| ingredients_text_en_ocr_1740180969 | 1/3000 | string | WATER, WHOLE WHEAT FLOUR, UNBLEACHED ENRICHED WHEAT FLOUR (WHEAT FLOUR, NIACIN, IRON, THIAMINE MONONITRATE, RIBOFLAVIN, ... |
| ingredients_text_en_ocr_1740180969_result | 1/3000 | string | WATER, WHOLE WHEAT FLOUR, UNBLEACHED ENRICHED WHEAT FLOUR (WHEAT FLOUR, NIACIN, IRON, THIAMINE MONONITRATE, RIBOFLAVIN, ... |
| ingredients_text_en_ocr_1740180973 | 1/3000 | string | BROWNIE- BLEACHED ENRICHED FLOUR (BLEACHED WHEAT FLOUR, NIACIN, FERROUS SULFATE, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC... |
| ingredients_text_en_ocr_1740180973_result | 1/3000 | string | BROWNIE - BLEACHED ENRICHED FLOUR (BLEACHED WHEAT FLOUR, NIACIN, FERROUS SULFATE, THIAMINE MONONITRATE, RIBOFLAVIN, FOLI... |
| ingredients_text_en_ocr_1740180979 | 1/3000 | string | SUGAR, BLEACHED ENRICHED FLOUR (WHEAT FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC ACID), WHOLE ... |
| ingredients_text_en_ocr_1740180979_result | 1/3000 | string | SUGAR, BLEACHED ENRICHED FLOUR (WHEAT FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC ACID), WHOLE ... |
| ingredients_text_en_ocr_1740180983 | 1/3000 | string | CORN SYRUP, ENRICHED FLOUR (WHEAT FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, ROBOFLAVIN, FOLIC ACID), SUGAR, EGG... |
| ingredients_text_en_ocr_1740180983_result | 1/3000 | string | CORN SYRUP, ENRICHED FLOUR (WHEAT FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, ROBOFLAVIN, FOLIC ACID), SUGAR, EGG... |
| ingredients_text_en_ocr_1740180988 | 1/3000 | string | BROWNIE- BLEACHED ENRICHED FLOUR (BLEACHED WHEAT FLOUR, NIACIN, FERROUS SULFATE, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC... |
| ingredients_text_en_ocr_1740180988_result | 1/3000 | string | BROWNIE - BLEACHED ENRICHED FLOUR (BLEACHED WHEAT FLOUR, NIACIN, FERROUS SULFATE, THIAMINE MONONITRATE, RIBOFLAVIN, FOLI... |
| ingredients_text_en_ocr_1740181053 | 1/3000 | string | INGREDIENTS: CULTURED SKIN MILK, CULTURED CREAM, WHEY, SALT, MALTODEXTRIN, CITRIC ACID, CARRACEENAN, GUAR GUM, LOCUST BE... |
| ingredients_text_en_ocr_1740181053_result | 1/3000 | string | CULTURED SKIN MILK, CULTURED CREAM, WHEY, SALT, MALTODEXTRIN, CITRIC ACID, CARRACEENAN, GUAR GUM, LOCUST BEAN GUM, CULTU... |
| ingredients_text_en_ocr_1740181057 | 1/3000 | string | CULTURED SKIM MILK, CULTURED CREAM, SALT, WHEY, GUAR GUM, SORBIC ACID (TO MAINTAIN FRESHNESS), CITRIC ACID, LOCUST BEAN ... |
| ingredients_text_en_ocr_1740181057_result | 1/3000 | string | CULTURED SKIM MILK, CULTURED CREAM, SALT, WHEY, GUAR GUM, SORBIC ACID (TO MAINTAIN FRESHNESS), CITRIC ACID, LOCUST BEAN ... |
| ingredients_text_en_ocr_1740181064 | 1/3000 | string | HEAVY CREAM (HEAVY CREAM, CARRAGEENAN, MONO- AND DIGLYCERIDES), SUGAR, WATER, CREAM CHEESE (PASTEURIZED MILK AND CREAM, ... |
| ingredients_text_en_ocr_1740181064_result | 1/3000 | string | HEAVY CREAM (HEAVY CREAM, CARRAGEENAN, MONO - AND DIGLYCERIDES), SUGAR, WATER, CREAM CHEESE (PASTEURIZED MILK AND CREAM,... |
| ingredients_text_en_ocr_1740181065 | 1/3000 | string | APPLE, WATER, SUGAR, BROWN SUGAR, ENRICHED FLOUR (WHEAT FLOUR, MALTED BARLEY FLOUR, NIACIN, IRON, THIAMINE MONONITRATE, ... |
| ingredients_text_en_ocr_1740181065_result | 1/3000 | string | APPLE, WATER, SUGAR, BROWN SUGAR, ENRICHED FLOUR (WHEAT FLOUR, MALTED BARLEY FLOUR, NIACIN, IRON, THIAMINE MONONITRATE, ... |
| ingredients_text_en_ocr_1740181066 | 1/3000 | string | SUGAR, PEANUT BUTTER CUPS (MILK CHOCOLATE [SUGAR, COCOA BUTTER, CHOCOLATE, NONFAT MILK, MILKFAT, LACTOSE, SOY LECITHIN A... |
| ingredients_text_en_ocr_1740181066_result | 1/3000 | string | SUGAR, PEANUT BUTTER CUPS (MILK CHOCOLATE [SUGAR, COCOA BUTTER, CHOCOLATE, NONFAT MILK, MILKFAT, LACTOSE, SOY LECITHIN A... |
| ingredients_text_en_ocr_1740181068 | 1/3000 | string | HEAVY CREAM (HEAVY CREAM, CARRAGEENAN, MONO- AND DIGLYCERIDES), YELLOW CAKE (SUGAR, ENRICHED WHEAT FLOUR BLEACHED [FLOUR... |
| ingredients_text_en_ocr_1740181068_result | 1/3000 | string | HEAVY CREAM (HEAVY CREAM, CARRAGEENAN, MONO - AND DIGLYCERIDES), YELLOW CAKE (SUGAR, ENRICHED WHEAT FLOUR BLEACHED [FLOU... |
| ingredients_text_en_ocr_1740181070 | 1/3000 | string | INGREDIENTS: CULTURED CREAM, SKIM MILK, WHEY, MODIFIED CORN STARCH, CULTURED DEXTROSE, GELATIN, SODIUM PHOSPHATE, GUAR G... |
| ingredients_text_en_ocr_1740181070_result | 1/3000 | string | CULTURED CREAM, SKIM MILK, WHEY, MODIFIED CORN STARCH, CULTURED DEXTROSE, GELATIN, SODIUM PHOSPHATE, GUAR GUM, CARRAGEEN... |
| ingredients_text_en_ocr_1740181108 | 1/3000 | string | ICE CREAM: MILK, CREAM, CORN SYRUP, SUGAR, HIGH FRUCTOSE CORN SYRUP, WHEY, BUTTERMILK, CELLULOSE GEL, GUAR GUM, CELLULOS... |
| ingredients_text_en_ocr_1740181108_result | 1/3000 | string | ICE CREAM: MILK, CREAM, CORN SYRUP, SUGAR, HIGH FRUCTOSE CORN SYRUP, WHEY, BUTTERMILK, CELLULOSE GEL, GUAR GUM, CELLULOS... |
| ingredients_text_en_ocr_1740181154 | 1/3000 | string | MILK, CREAM, CORN SYRUP, SUGAR, HIGH FRUCTOSE CORN SYRUP, WHEY, BUTTERMILK, CELLULOSE GEL, GUAR GUM, CELLULOSE GUM, MONO... |
| ingredients_text_en_ocr_1740181154_result | 1/3000 | string | MILK, CREAM, CORN SYRUP, SUGAR, HIGH FRUCTOSE CORN SYRUP, WHEY, BUTTERMILK, CELLULOSE GEL, GUAR GUM, CELLULOSE GUM, MONO... |
| ingredients_text_en_ocr_1740181155 | 1/3000 | string | ICE CREAM - MILK, CREAM, SUGAR, CORN SYRUP, WHEY PROTEIN CONCENTRATE, BUTTER (CREAM, SALT), MOLASSES, NATURAL FLAVOR, PR... |
| ingredients_text_en_ocr_1740181155_result | 1/3000 | string | ICE CREAM - MILK, CREAM, SUGAR, CORN SYRUP, WHEY PROTEIN CONCENTRATE, BUTTER (CREAM, SALT), MOLASSES, NATURAL FLAVOR, PR... |
| ingredients_text_en_ocr_1740181156 | 1/3000 | string | MILK, CREAM, SUGAR, CORN SYRUP, HIGH FRUCTOSE CORN SYRUP, COCOA PROCESSED WITH ALKALI, WHEY, BUTTERMILK, CELLULOSE GEL, ... |
| ingredients_text_en_ocr_1740181156_result | 1/3000 | string | MILK, CREAM, SUGAR, CORN SYRUP, HIGH FRUCTOSE CORN SYRUP, COCOA PROCESSED WITH ALKALI, WHEY, BUTTERMILK, CELLULOSE GEL, ... |
| ingredients_text_en_ocr_1740181158 | 1/3000 | string | ICE CREAM: MILK, CREAM, SUGAR, CORN SYRUP, HIGH FRUCTOSE CORN SYRUP, WHEY, BUTTERMILK, SUGAR, GUAR GUM, MONO- AND DIGLYC... |
| ingredients_text_en_ocr_1740181158_result | 1/3000 | string | ICE CREAM: MILK, CREAM, SUGAR, CORN SYRUP, HIGH FRUCTOSE CORN SYRUP, WHEY, BUTTERMILK, SUGAR, GUAR GUM, MONO - AND DIGLY... |
| ingredients_text_en_ocr_1740181159 | 1/3000 | string | MILK, SUGAR SYRUP, CORN SYRUP, HIGH FRUCTOSE CORN SYRUP, WHEY, BUTTER MILK, CREAM, SKIM MILK, CELLULOSE GEL, GUAR GUM, C... |
| ingredients_text_en_ocr_1740181159_result | 1/3000 | string | MILK, SUGAR SYRUP, CORN SYRUP, HIGH FRUCTOSE CORN SYRUP, WHEY, BUTTER MILK, CREAM, SKIM MILK, CELLULOSE GEL, GUAR GUM, C... |
| ingredients_text_en_ocr_1740181160 | 1/3000 | string | MILK, SUGAR SYRUP, CORN SYRUP, HIGH FRUCTOSE CORN SYRUP, WHEY, BUTTERMILK, SKIM MILK, CREAM, COCOA PROCESSED WITH ALKALI... |
| ingredients_text_en_ocr_1740181160_result | 1/3000 | string | MILK, SUGAR SYRUP, CORN SYRUP, HIGH FRUCTOSE CORN SYRUP, WHEY, BUTTERMILK, SKIM MILK, CREAM, COCOA PROCESSED WITH ALKALI... |
| ingredients_text_en_ocr_1740181161 | 1/3000 | string | MILK* AND SKIM MILK*, SUGAR, WATER, CORN SYRUP, ORANGE PULP, CONCENTRATED ORANGE JUICE, HIGH FRUCTOSE CORN SYRUP, NATURA... |
| ingredients_text_en_ocr_1740181161_result | 1/3000 | string | MILK* AND SKIM MILK*, SUGAR, WATER, CORN SYRUP, ORANGE PULP, CONCENTRATED ORANGE JUICE, HIGH FRUCTOSE CORN SYRUP, NATURA... |
| ingredients_text_en_ocr_1740181162 | 2/3000 | string | WATER, SUGAR SYRUP, CORN SYRUP, SKIM MILK*, PINEAPPLE, PINEAPPLE JUICE, CITRIC ACID, LOCUST BEAN GUM, DEXTROSE, MONO- AN...<br>WATER, SUGAR SYRUP, MILK* AND SKIM MILK*, CORN SYRUP, CONCENTRATED LIME JUICE*, CONCENTRATED ORANGE JUICE, NATURAL FLAVO... |
| ingredients_text_en_ocr_1740181162_result | 2/3000 | string | WATER, SUGAR SYRUP, CORN SYRUP, SKIM MILK*, PINEAPPLE, PINEAPPLE JUICE, CITRIC ACID, LOCUST BEAN GUM, DEXTROSE, MONO - A...<br>WATER, SUGAR SYRUP, MILK* AND SKIM MILK*, CORN SYRUP, CONCENTRATED LIME JUICE*, CONCENTRATED ORANGE JUICE, NATURAL FLAVO... |
| ingredients_text_en_ocr_1740181163 | 1/3000 | string | ICE CREAM - MILK, CREAM, SUGAR, CORN SYRUP, HIGH FRUCTOSE CORN SYRUP, PEANUT BUTTER (GROUND PEANUTS), PEANUT OIL, WHEY, ... |
| ingredients_text_en_ocr_1740181163_result | 1/3000 | string | ICE CREAM - MILK, CREAM, SUGAR, CORN SYRUP, HIGH FRUCTOSE CORN SYRUP, PEANUT BUTTER (GROUND PEANUTS), PEANUT OIL, WHEY, ... |
| ingredients_text_en_ocr_1740181164 | 1/3000 | string | MILK, CREAM, SUGAR SYRUP, CORN SYRUP, HIGH FRUCTOSE CORN SYRUP, WHEY, SKIM MILK, ARTIFICIAL AND NATURAL FLAVOR, CELLULOS... |
| ingredients_text_en_ocr_1740181164_result | 1/3000 | string | MILK, CREAM, SUGAR SYRUP, CORN SYRUP, HIGH FRUCTOSE CORN SYRUP, WHEY, SKIM MILK, ARTIFICIAL AND NATURAL FLAVOR, CELLULOS... |
| ingredients_text_en_ocr_1740181165 | 1/3000 | string | CHOCOLATE ICE CREAM - MILK, CREAM, SUGAR SYRUP, CORN SYRUP, BUTTERMILK, WHEY, COCOA PROCESSED WITH ALKALI, SALT, GUAR GU... |
| ingredients_text_en_ocr_1740181165_result | 1/3000 | string | CHOCOLATE ICE CREAM - MILK, CREAM, SUGAR SYRUP, CORN SYRUP, BUTTERMILK, WHEY, COCOA PROCESSED WITH ALKALI, SALT, GUAR GU... |
| ingredients_text_en_ocr_1740181167 | 2/3000 | string | NONFAT SHERBET - SKIM MILK*. SUGAR, WATER, CORN SYRUP, MILK*, ORANGE PULP, CONCENTRATED ORANGE JUICE, HIGH FRUCTOSE CORN...<br>NONFAT SHERBET - SKIM MILK, WATER, SUGAR, CORN SYRUP, CONCENTRATED RASPBERRY JUICE, HIGH FRUCTOSE CORN SYRUP, RASPBERRY ... |
| ingredients_text_en_ocr_1740181167_result | 2/3000 | string | NONFAT SHERBET - SKIM MILK*. SUGAR, WATER, CORN SYRUP, MILK*, ORANGE PULP, CONCENTRATED ORANGE JUICE, HIGH FRUCTOSE CORN...<br>NONFAT SHERBET - SKIM MILK, WATER, SUGAR, CORN SYRUP, CONCENTRATED RASPBERRY JUICE, HIGH FRUCTOSE CORN SYRUP, RASPBERRY ... |
| ingredients_text_en_ocr_1740181168 | 1/3000 | string | FROZEN YOGURT - CULTURED PASTEURIZED MILK AND SKIM MILK, SUGAR, CORN SYRUP, BUTTERMILK, COCOA PROCESSED WITH ALKALI, WHE... |
| ingredients_text_en_ocr_1740181168_result | 1/3000 | string | FROZEN YOGURT - CULTURED PASTEURIZED MILK AND SKIM MILK, SUGAR, CORN SYRUP, BUTTERMILK, COCOA PROCESSED WITH ALKALI, WHE... |
| ingredients_text_en_ocr_1740181172 | 1/3000 | string | INGREDIENTS: ICE CREAM: MILK, CREAM, SUGAR SYRUP, CORN SYRUP, WHEY, BUTTERMILK. MALTODEXTRIN, CELLULOSE GEL, MONO- AND D... |
| ingredients_text_en_ocr_1740181172_result | 1/3000 | string | ICE CREAM: MILK, CREAM, SUGAR SYRUP, CORN SYRUP, WHEY, BUTTERMILK. MALTODEXTRIN, CELLULOSE GEL, MONO - AND DIGLYCERIDES.... |
| ingredients_text_en_ocr_1740181241 | 1/3000 | string | SUGAR, ENRICHED WHEAT FLOUR (WHEAT FLOUR, MALTED BARLEY FLOUR, FERROUS SULFATE, NIACIN, THIAMINE MONONITRATE, RIBOFLAVIN... |
| ingredients_text_en_ocr_1740181241_result | 1/3000 | string | SUGAR, ENRICHED WHEAT FLOUR (WHEAT FLOUR, MALTED BARLEY FLOUR, FERROUS SULFATE, NIACIN, THIAMINE MONONITRATE, RIBOFLAVIN... |
| ingredients_text_en_ocr_1740181360 | 1/3000 | string | INGREDIENTS: ROLLED OATS, SUGAR, FLAVORED FRUIT PIECES (DEHYDRATED APPLES, ARTIFICIAL FLAVOR, CALCIUM STEARATE (FLOW AGE... |
| ingredients_text_en_ocr_1740181360_result | 1/3000 | string | ROLLED OATS, SUGAR, FLAVORED FRUIT PIECES (DEHYDRATED APPLES, ARTIFICIAL FLAVOR, CALCIUM STEARATE (FLOW AGENT), CITRIC A... |
| ingredients_text_en_ocr_1740181361 | 1/3000 | string | INGREDIENTS: HIGH FRUCTOSE CORN SYRUP, CORN SYRUP, WATER, CONTAINS LESS THAN 2% OF: CELLULOSE GUM, CARAMEL COLOR, SALT, ... |
| ingredients_text_en_ocr_1740181361_result | 1/3000 | string | HIGH FRUCTOSE CORN SYRUP, CORN SYRUP, WATER, CONTAINS LESS THAN 2% OF: CELLULOSE GUM, CARAMEL COLOR, SALT, NATURAL AND A... |
| ingredients_text_en_ocr_1740181362 | 1/3000 | string | INGREDIENTS: SOYBEAN OIL, SUGAR, WATER, VINEGAR, SALT, POPPYSEED, DRIED ONION, SPICE, POTASSIUM SORBATE (PRESERVATIVE), ... |
| ingredients_text_en_ocr_1740181362_result | 1/3000 | string | SOYBEAN OIL, SUGAR, WATER, VINEGAR, SALT, POPPYSEED, DRIED ONION, SPICE, POTASSIUM SORBATE (PRESERVATIVE), XANTHAN GUM, ... |
| ingredients_text_en_ocr_1740181368 | 1/3000 | string | INGREDIENTS: DEGERMINATED WHITE CORN GRITS, DEHYDRATED CHEESE POWDER, (MODIFIED WHEY, PARTIALLY HYDROGENATED VEGETABLE O... |
| ingredients_text_en_ocr_1740181368_result | 1/3000 | string | DEGERMINATED WHITE CORN GRITS, DEHYDRATED CHEESE POWDER, (MODIFIED WHEY, PARTIALLY HYDROGENATED VEGETABLE OIL [SOYBEAN, ... |
| ingredients_text_en_ocr_1740181369 | 1/3000 | string | INGREDIENTS: DEGERMINATED WHITE CORN GRITS, WHEY POWDER, DRIED MARGARINE (PARTIALLY HYDROGENATED SOYBEAN OIL, NONFAT MIL... |
| ingredients_text_en_ocr_1740181369_result | 1/3000 | string | DEGERMINATED WHITE CORN GRITS, WHEY POWDER, DRIED MARGARINE (PARTIALLY HYDROGENATED SOYBEAN OIL, NONFAT MILK, SWEET WHEY... |
| ingredients_text_en_ocr_1740181370 | 2/3000 | string | INGREDIENTS: DEGERMINATED WHITE CORN GRITS, SALT,CALCIUM CARBONATE, FERRIC PHOSPHATE, SOY LECITHIN BHA AND CITRIC ACID (...<br>INGREDIENTS: WHITE HOMINY GRITS, NIACIN, REDUCED IRON, THIAMIN MONONITRATE, RIBOFLAVIN, FOLIC ACID. |
| ingredients_text_en_ocr_1740181370_result | 2/3000 | string | DEGERMINATED WHITE CORN GRITS, SALT,CALCIUM CARBONATE, FERRIC PHOSPHATE, SOY LECITHIN BHA AND CITRIC ACID (AS PRESERVATI...<br>WHITE HOMINY GRITS, NIACIN, REDUCED IRON, THIAMIN MONONITRATE, RIBOFLAVIN, FOLIC ACID. |
| ingredients_text_en_ocr_1740181379 | 1/3000 | string | INGREDIENTS: SOYBEAN OIL, WATER, LOWFAT BUTTERMILK (CULTURED LOWFAT AND SKIM MILK, SALT, TAPIOCA STARCH, LOCUST BEAN GUM... |
| ingredients_text_en_ocr_1740181379_result | 1/3000 | string | SOYBEAN OIL, WATER, LOWFAT BUTTERMILK (CULTURED LOWFAT AND SKIM MILK, SALT, TAPIOCA STARCH, LOCUST BEAN GUM, CARRAGEENAN... |
| ingredients_text_en_ocr_1740181380 | 1/3000 | string | INGREDIENTS: TOMATO PUREE (WATER, TOMATO PASTE, CONCENTRATE), HIGH FRUCTOSE CORN SYRUP, SOYBEAN OIL, CORN-CIDER VINEGAR,... |
| ingredients_text_en_ocr_1740181380_result | 1/3000 | string | TOMATO PUREE (WATER, TOMATO PASTE, CONCENTRATE), HIGH FRUCTOSE CORN SYRUP, SOYBEAN OIL, CORN-CIDER VINEGAR, SUGAR, SALT,... |
| ingredients_text_en_ocr_1740181386 | 1/3000 | string | SUGAR, DEXTROSE, MODIFIED TAPIOCA AND CORN STARCH, MONO- AND DIGLYCERIDES, TETRASODIUM PYROPHOSPHATE. CONTAINS 2% OR LES... |
| ingredients_text_en_ocr_1740181386_result | 1/3000 | string | SUGAR, DEXTROSE, MODIFIED TAPIOCA AND CORN STARCH, MONO - AND DIGLYCERIDES, TETRASODIUM PYROPHOSPHATE. CONTAINS 2% OR LE... |
| ingredients_text_en_ocr_1740181389 | 1/3000 | string | INGREDIENTS: WATER, SOYBEAN OIL, HIGH FRUCTOSE CORN SYRUP, DISTILLED VINEGAR, SALT. CONTAINS 2% OR LESS OF : DRIED GARLI... |
| ingredients_text_en_ocr_1740181389_result | 1/3000 | string | WATER, SOYBEAN OIL, HIGH FRUCTOSE CORN SYRUP, DISTILLED VINEGAR, SALT. CONTAINS 2% OR LESS OF : DRIED GARLIC, DRIED ONIO... |
| ingredients_text_en_ocr_1740181390 | 1/3000 | string | INGREDIENTS: SOYBEAN OIL, TOMATO PUREE (WATER, TOMATO PASTE CONCENTRATE), WATER, HIGH FRUCTOSE CORN SYRUP, VINEGAR, RELI... |
| ingredients_text_en_ocr_1740181390_result | 1/3000 | string | SOYBEAN OIL, TOMATO PUREE (WATER, TOMATO PASTE CONCENTRATE), WATER, HIGH FRUCTOSE CORN SYRUP, VINEGAR, RELISH (CUCUMBERS... |
| ingredients_text_en_ocr_1740181391 | 1/3000 | string | INGREDIENTS: HIGH FRUCTOSE CORN SYRUP, TOMATO PUREE (WATER, TOMATO PASTE), VINEGAR, APPLE CIDER VINEGAR, MOLASEES, MODIF... |
| ingredients_text_en_ocr_1740181391_result | 1/3000 | string | HIGH FRUCTOSE CORN SYRUP, TOMATO PUREE (WATER, TOMATO PASTE), VINEGAR, APPLE CIDER VINEGAR, MOLASEES, MODIFIED CORN STAR... |
| ingredients_text_en_ocr_1740181418 | 1/3000 | string | INGREDIENTS: ENRICHED WHEAT FLOUR (WHEAT FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC ACID), HIG... |
| ingredients_text_en_ocr_1740181418_result | 1/3000 | string | ENRICHED WHEAT FLOUR (WHEAT FLOUR, NIACIN, REDUCED IRON, THIAMINE MONONITRATE, RIBOFLAVIN, FOLIC ACID), HIGH FRUCTOSE CO... |
| ingredients_text_en_ocr_1740181424 | 1/3000 | string | INGREDIENTS:SOYBEAN OIL, CUCUMBER JUICE, SUGAR, SOUR CREAM POWDER (CREAM, NONFAT MILK, CULTURES), SALT, VINEGAR, DRIED O... |
| ingredients_text_en_ocr_1740181424_result | 1/3000 | string | SOYBEAN OIL, CUCUMBER JUICE, SUGAR, SOUR CREAM POWDER (CREAM, NONFAT MILK, CULTURES), SALT, VINEGAR, DRIED ONION, NATURA... |
| ingredients_text_en_ocr_1740181426 | 1/3000 | string | INGREDIENTS: SOYBEAN OIL, WATER, VINEGAR,HIGH FRUCTOSE, CORN SYRUP, SALT, SUGAR, CONTAINS 2% OR LESS OF: DRIED GARLIC, X... |
| ingredients_text_en_ocr_1740181426_result | 1/3000 | string | SOYBEAN OIL, WATER, VINEGAR,HIGH FRUCTOSE, CORN SYRUP, SALT, SUGAR, CONTAINS 2% OR LESS OF: DRIED GARLIC, XANTHAN GUM, P... |
| ingredients_text_en_ocr_1740181427 | 1/3000 | string | INGREDIENTS: SOYBEAN OIL, LOWFAT BUTTERMILK (CULTURED LOWFAT AND SKIM MILK, SALT, TAPIOCA STARCH, LOCUST BEAN GUM, CARRA... |
| ingredients_text_en_ocr_1740181427_result | 1/3000 | string | SOYBEAN OIL, LOWFAT BUTTERMILK (CULTURED LOWFAT AND SKIM MILK, SALT, TAPIOCA STARCH, LOCUST BEAN GUM, CARRAGEENAN), WATE... |
| ingredients_text_en_ocr_1740181436 | 1/3000 | string | INGREDIENTS: TOMATO PUREE (TOMATO PASTE, WATER), HIGH FRUCTOSE CORN SYRUP, MOLASSES, VINEGAR, NATURAL SMOKE FLAVOR, CONT... |
| ingredients_text_en_ocr_1740181436_result | 1/3000 | string | TOMATO PUREE (TOMATO PASTE, WATER), HIGH FRUCTOSE CORN SYRUP, MOLASSES, VINEGAR, NATURAL SMOKE FLAVOR, CONTAINS LESS THA... |
| ingredients_text_en_ocr_1740181437 | 1/3000 | string | INGREDIENTS: WATER, LOWFAT BUTTERMILK** (CULTURED LOWFAT AND MILK, SALT, TAPIOCA STARCH, LOCUST BEAN GUM, CARRAGEENAN), ... |
| ingredients_text_en_ocr_1740181437_result | 1/3000 | string | WATER, LOWFAT BUTTERMILK** (CULTURED LOWFAT AND MILK, SALT, TAPIOCA STARCH, LOCUST BEAN GUM, CARRAGEENAN), CORN SYRUP, D... |
| ingredients_text_en_ocr_1740181439 | 1/3000 | string | MODIFIED CORN STARCH, TAPIOCA MALTODEXTRIN*, DISODIUM PHOSPHATE, TETRASODIUM PYROPHOSPHATE NATURAL AND ARTIFICIAL FLAVOR... |
| ingredients_text_en_ocr_1740181439_result | 1/3000 | string | MODIFIED CORN STARCH, TAPIOCA MALTODEXTRIN*, DISODIUM PHOSPHATE, TETRASODIUM PYROPHOSPHATE NATURAL AND ARTIFICIAL FLAVOR... |
| ingredients_text_en_ocr_1740181445 | 1/3000 | string | INGREDIENTS: SOYBEAN OIL, HIGH FRUCTOSE CORN SYRUP, CORN SYRUP, VINEGAR, BACON (CURED WITH WATER, SALT, SUGAR, SODIUM PH... |
| ingredients_text_en_ocr_1740181445_result | 1/3000 | string | SOYBEAN OIL, HIGH FRUCTOSE CORN SYRUP, CORN SYRUP, VINEGAR, BACON (CURED WITH WATER, SALT, SUGAR, SODIUM PHOSPHATE, HYDR... |
| ingredients_text_en_ocr_1740181449 | 1/3000 | string | INGREDIENTS: SOYBEAN OIL, WATER, SUGAR, HONEY, VINEGAR, TOMATO PASTE, SALT, CONTAINS 2% OR LESS OF: POPPY SEEDS, XANTHAN... |
| ingredients_text_en_ocr_1740181449_result | 1/3000 | string | SOYBEAN OIL, WATER, SUGAR, HONEY, VINEGAR, TOMATO PASTE, SALT, CONTAINS 2% OR LESS OF: POPPY SEEDS, XANTHAN GUM, DRIED O... |
| ingredients_text_en_ocr_1740181457 | 1/3000 | string | INGREDIENTS: PREPARED BLACKEYED PEAS, WATER, SALT, CALCIUM CHLORIDE (FIRMING AGENT), DISODIUM EDTA ADDED TO PROMOTE COLO... |
| ingredients_text_en_ocr_1740181457_result | 1/3000 | string | PREPARED BLACKEYED PEAS, WATER, SALT, CALCIUM CHLORIDE (FIRMING AGENT), DISODIUM EDTA ADDED TO PROMOTE COLOR RETENTION. |
| ingredients_text_en_ocr_1740181458 | 1/3000 | string | INGREDIENTS: PREPARED KIDNEY BEANS, WATER, SUGAR, SALT, CALCIUM CHLORIDE (FIRMING AGENT), DISODIUM EDTA (TO PROMOTE COLO... |
| ingredients_text_en_ocr_1740181458_result | 1/3000 | string | PREPARED KIDNEY BEANS, WATER, SUGAR, SALT, CALCIUM CHLORIDE (FIRMING AGENT), DISODIUM EDTA (TO PROMOTE COLOR RETENTION). |
| ingredients_text_en_ocr_1740181463 | 1/3000 | string | INGREDIENTS: PREPARED RED BEANS, WATER, SALT, CALCIUM DISODIUM EDTA ADDED TO PROMOTE COLOR RETENTION. |
| ingredients_text_en_ocr_1740181463_result | 1/3000 | string | PREPARED RED BEANS, WATER, SALT, CALCIUM DISODIUM EDTA ADDED TO PROMOTE COLOR RETENTION. |
| ingredients_text_en_ocr_1740181468 | 1/3000 | string | MODIFIED CORN STARCH, MALTODEXTRIN, WHEAT FLOUR, RENDERED BEEF FAT (WITH CITRIC ACID AND BHA TO PROTECT FLAVOR), HYDROLY... |
| ingredients_text_en_ocr_1740181468_result | 1/3000 | string | MODIFIED CORN STARCH, MALTODEXTRIN, WHEAT FLOUR, RENDERED BEEF FAT (WITH CITRIC ACID AND BHA TO PROTECT FLAVOR), HYDROLY... |
| ingredients_text_en_ocr_1740181473 | 1/3000 | string | INGREDIENTS: WATER, DISTILLED VINEGAR, MOLASSES, SALT, CITRIC ACID, DEXTROSE, CARAMEL COLOR, NATURAL FLAVORS, MALIC ACID... |
| ingredients_text_en_ocr_1740181473_result | 1/3000 | string | WATER, DISTILLED VINEGAR, MOLASSES, SALT, CITRIC ACID, DEXTROSE, CARAMEL COLOR, NATURAL FLAVORS, MALIC ACID, HYDROLYZED ... |
| ingredients_text_en_ocr_1740181485 | 1/3000 | string | MODIFIED CORN STARCH, WHEAT FLOUR, SALT, MALTODEXTRIN, MUSHROOMS*, HYDROLYZED CORN GLUTEN AND TORULA YEAST EXTRACT, BEEF... |
| ingredients_text_en_ocr_1740181485_result | 1/3000 | string | MODIFIED CORN STARCH, WHEAT FLOUR, SALT, MALTODEXTRIN, MUSHROOMS*, HYDROLYZED CORN GLUTEN AND TORULA YEAST EXTRACT, BEEF... |
| ingredients_text_en_ocr_1740181490 | 1/3000 | string | MODIFIED TAPIOCA AND CORN STARCH, HYDROLYZED CORN GLUTEN, SOY PROTEIN AND WHET GLUTEN, SALT, DEXTROSE, WHEY*, AUTOLYZED ... |
| ingredients_text_en_ocr_1740181490_result | 1/3000 | string | MODIFIED TAPIOCA AND CORN STARCH, HYDROLYZED CORN GLUTEN, SOY PROTEIN AND WHET GLUTEN, SALT, DEXTROSE, WHEY*, AUTOLYZED ... |
| ingredients_text_es | 2/3000 | string | PEPINILLOS, AGUA, VINAGRE, SAL, CLORURO DE CALCIO, BENZOATO DE SODIO 0.1% (CONSERVADOR), SULFATO DE ALUMINIO Y SODIO, SA...<br>_Seitán_ 83% (agua, gluten de _trigo_, harina de _trigo_, caldo de alga kombu (agua, alga kombu), salsa de _soja_ (agua,... |
| ingredients_text_es_debug_tags | 1/3000 | array | [] |
| ingredients_text_es_ocr_1727198952 | 1/3000 | string | SEITÁN 83%: Agua, gluten de _trigo_*, harina de _trigo_*, caldo de alga kombu (agua y alga kombu (16%)), salsa de _soja_... |
| ingredients_text_es_ocr_1727198952_result | 1/3000 | string | SEITÁN 83%: Agua, gluten de _trigo_*, harina de _trigo_*, caldo de alga kombu (agua y alga kombu (16%)), salsa de _soja_... |
| ingredients_text_fi | 1/3000 | string | - |
| ingredients_text_fr | 274/3000 | string | Eau ; fécule de tapioca ; farine de riz ; fécule de pomme de terre ; huiles végétales : huile de colza, huile de tournes...<br>Farine de _blé_ (farine de _blé_, _gluten de blé_, farine de _blé_ malté), eau, _graines de sésame_ décortiquées toastée... |
| ingredients_text_fr_debug_tags | 77/3000 | array | [] |
| ingredients_text_fr_ocr_1546335197 | 1/3000 | string | 1 sliced wholemeal bread from British Soissons wholemeal INGREDIENTS Soissons wholemeal Wheatflour (contains Gluten) . w... |
| ingredients_text_fr_ocr_1546335197_result | 1/3000 | string | Soissons wholemeal Wheatflour (contains Gluten) . water • Mother Yeast (Wheatflour (contains Gluten) • Starter Culture).... |
| ingredients_text_fr_ocr_1550061027 | 1/3000 | string | Spécialité céréalière aux 3 céréales : farine de riz, farine de sarrasin• 24 farine de millet• 20%, farine de souchet to... |
| ingredients_text_fr_ocr_1550061027_result | 1/3000 | string | Spécialité céréalière aux 3 céréales : farine de riz, farine de sarrasin• 24 farine de millet• 20%, farine de souchet to... |
| ingredients_text_fr_ocr_1550065169 | 1/3000 | string | Gelée Royale 8% Ingrédients issus de l'agriculture biologique Déclaration nutritionnelle pour 100g : énergie 1353kJ/318 ... |
| ingredients_text_fr_ocr_1550065169_result | 1/3000 | string | Gelée Royale 8% Ingrédients issus de l'agriculture biologique |
| ingredients_text_fr_ocr_1550235891 | 1/3000 | string | Energy 8400kJ/2000kcal Fat 70g Saturates 20g Sugars 90g Salt 6g biscottes sans gluten avec des dattes, des noix et des g... |
| ingredients_text_fr_ocr_1550235891_result | 1/3000 | string | Farine de riz • Dattes hachées (21 %) • Fécule de maïs • Amidon de tapioca • Farine de pois chiches • Noix concassées • ... |
| ingredients_text_fr_ocr_1550235898 | 1/3000 | string | 4 750w 4min 850w 30sec After cooking leave to stand for 1 min. Guide for one pack only. OVEN Preheat oven. Place on baki... |
| ingredients_text_fr_ocr_1550235898_result | 1/3000 | string | Cooked Jasmine Rice (34%) (Water • Jasmine Rice) • Water • Coconut Cream (12%) (Coconut Extract • Water) • Sweet Potatoe... |
| ingredients_text_fr_ocr_1550235900 | 1/3000 | string | fromagc cheddar affiné pendant 3 ans, au lait pasteq.:isé : Contient lait. INFORMATION Ce cheddar peut de HI lactate nat... |
| ingredients_text_fr_ocr_1550235900_result | 1/3000 | string | fromagc cheddar affiné pendant 3 ans, au lait pasteq.:isé : Contient lait. INFORMATION Ce cheddar peut de HI lactate nat... |
| ingredients_text_fr_ocr_1550235905 | 1/3000 | string | NGREDIENTS Carrot Juice • Carrot Purée Acid: )itric Acid. Suitable for vegetarians and vegans SERVING Serve chilled. Sha... |
| ingredients_text_fr_ocr_1550235905_result | 1/3000 | string | NGREDIENTS Carrot Juice • Carrot Purée Acid: )itric Acid. Suitable for vegetarians and vegans SERVING Serve chilled. Sha... |
| ingredients_text_fr_ocr_1550235906 | 1/3000 | string | SOURCE OF FIBRE Serves 3 - each cake provides Energy} Fai iSaturateSSugars Salt 119kJ i o.2g : &lt;o.lg ko.lg &lt;o.lg 2... |
| ingredients_text_fr_ocr_1550235906_result | 1/3000 | string | SOURCE OF FIBRE Serves 3 - each cake provides Energy} Fai iSaturateSSugars Salt 119kJ i o.2g : &lt;o.lg ko.lg &lt;o.lg |
| ingredients_text_fr_ocr_1550256394 | 1/3000 | string | soft cookies With salted caramel pieces and Belgian milk chocolate chunks INGREDIENTS Wheatflour contains Gluten (With W... |
| ingredients_text_fr_ocr_1550256394_result | 1/3000 | string | Wheatflour contains Gluten (With Wheatflour, Calcium Carbonate, Iron, Niacin, Thiamin) • nu tt Salted Caramel (14%) (Sug... |
| ingredients_text_fr_ocr_1550256395 | 3/3000 | string | filets de poulet fumé au bois de caryer cuits O dans une marinade sucrée et fumée INGRÉDIENTS Blanc de poulet fumé au bo...<br>une pâte à pizza cuite sur pierre recouverte de sauce V tomate épicée, de fromage mozzarella, de fromage cheddar, de pou... |
| ingredients_text_fr_ocr_1550256395_result | 3/3000 | string | Blanc de poulet fumé au bois de caryer (86%) • Cassonade brune • Sel • Sucre • Fécule de pomme de terre • Vinaigre • Epi...<br>Farine de Élé contient Gluten (avec Farine de blé, Carbonate de calcium, Fer, Niacine, Thiamine) • Eau • Tomates • Froma... |
| ingredients_text_fr_ocr_1550256471 | 1/3000 | string | all butter reduced fat cookies With Belgian white chocolate chunks INGREDIENTS Wheatflour contains Gluten (With Wheatflo... |
| ingredients_text_fr_ocr_1550256471_result | 1/3000 | string | Wheatflour contains Gluten (With Wheatflour, Calcium Carbonate, Iron, ,Jtab/e Niacin, Thiamin) • White Chocolate Chunks ... |
| ingredients_text_fr_ocr_1550256472 | 7/3000 | string | 8 saucisses d'origine britannique au porc : INGRÉDIENTS Viande de porc élevé en plein air diorigine britannique (93%) • ...<br>confiseries saveur boisson gazeuse, sans gélatine INGRÉDIENTS Sucre • sirop de glucose Eau • i Fécule de pomme de terre ... |
| ingredients_text_fr_ocr_1550256472_result | 7/3000 | string | Viande de porc élevé en plein air diorigine britannique (93%) • : Eau • Farine de riz • S,er• Farine de pois . chiches •...<br>Sucre • sirop de glucose Eau • i Fécule de pomme de terre modifiée Amidon de tapioca modifié Acidifiant : Acide citrique... |
| ingredients_text_fr_ocr_1550256780 | 4/3000 | string | organic mixed baby leaves and rocket INGREDIENTS Rocket (50%) • Red Lettuce • Produced under organic standards.<br>fromage mozzarella enrobé de chapelure INGREDIENTS Fromage mozzarella (Lait) (65%) Farine de blé contient Gluten (avec F... |
| ingredients_text_fr_ocr_1550256780_result | 4/3000 | string | Rocket (50%) • Red Lettuce • Produced under organic standards.<br>Fromage mozzarella (Lait) (65%) Farine de blé contient Gluten (avec Farine de blé, Carbonate de calcium, Fer, Niacine, T... |
| ingredients_text_fr_ocr_1550256781 | 2/3000 | string | arachides (39%) enrobées de choédiat au lait belge i INGRÉDIENTS Arachides • Sucre • Lait en poudre entier • , Beurre de...<br>green vcgctablo soup INGREDIENTS Water • Broccoli (9%) Sprnach (8%) • Peas (8%) • Onions • Edamame C Soybeans (6%) Sprin... |
| ingredients_text_fr_ocr_1550256781_result | 2/3000 | string | Arachides • Sucre • Lait en poudre entier • , Beurre de cacao • Masse de cacao • Huile de colza • : Emulsifiant : Lécith...<br>Water • Broccoli (9%) Sprnach (8%) • Peas (8%) • Onions • Edamame C Soybeans (6%) Spring Cabbage (6%) • Leeks (4%) , Low... |
| ingredients_text_fr_ocr_1550256782 | 4/3000 | string | boisson pasteurisée aux jus de canneberge et de framboise avec édulcorant INGRÉDIENTS Eau Jus de canneberge à base : de ...<br>press along here to sugarttee manao and lime fla vour chewing gum With c sweeteners - Chewing-gum sans sucres saveur et ... |
| ingredients_text_fr_ocr_1550256782_result | 4/3000 | string | Eau Jus de canneberge à base : de concentré (20%) • Jus 4e framboise à base de : concentré (9%) • Arômes • Edulcorant : ...<br>press along here to sugarttee manao and lime fla vour chewing gum With c sweeteners - Chewing-gum sans sucres saveur et ... |
| ingredients_text_fr_ocr_1550256783 | 5/3000 | string | aangegeven daturn en binnen een maand n- Voor het opwarmen in de magnetron volledig t Verenigd Koninkrijk- INGREDIENTS W...<br>cubes de caramel mou aromatisé au citron avec de la crème caillée et des morceaux de meringue INGREDIENTS sucre Sirop de... |
| ingredients_text_fr_ocr_1550256783_result | 5/3000 | string | Whole Milk • Water Beef (14%) • Free Range Egg Pasta (13%) (Durum Wheat Semolina (contains Gluten) • Water • Pasteurised...<br>sucre Sirop de glucose Lait concentré sucré (Lait entier Sucre) • Crème caillée (Lait) (10%) • Huile . de palme • Morcea... |
| ingredients_text_fr_ocr_1552297686 | 1/3000 | string | 95.351 .ool CE À consommer de préférence avant le : voir sur le côté. À conserver entre +20 Ch POIDS F/ |
| ingredients_text_fr_ocr_1552297686_result | 1/3000 | string | 95.351 .ool CE |
| ingredients_text_fr_ocr_1553587768 | 1/3000 | string | Sucre • Beurre (_Lait_) (15%) • flocons d'_avoine_ (contient du _gluten_) • Farine de _blé_(contient du _gluten_) (avec ... |
| ingredients_text_fr_ocr_1553587768_result | 1/3000 | string | Sucre • Beurre (_Lait_) (15%) • flocons d'_avoine_ (contient du _gluten_) • Farine de _blé_(contient du _gluten_) (avec ... |
| ingredients_text_fr_ocr_1554276510 | 1/3000 | string | EPICES A PAINS DI EPICES ln Epices cannelle) gingembre, coriandre, anis, clous de girofle, anis étoilé, muscade, poivre ... |
| ingredients_text_fr_ocr_1554276510_result | 1/3000 | string | EPICES A PAINS DI EPICES ln Epices cannelle) gingembre, coriandre, anis, clous de girofle, anis étoilé, muscade, poivre ... |
| ingredients_text_fr_ocr_1557146461 | 1/3000 | string | PETITES BAGUETTES DE PAIN Ingédjenjs . eau, amidon de maïs* , farine de riz complet* , farine de millet* , farine de sar... |
| ingredients_text_fr_ocr_1557146461_result | 1/3000 | string | PETITES BAGUETTES DE PAIN Ingédjenjs . eau, amidon de maïs* , farine de riz complet* , farine de millet* , farine de sar... |
| ingredients_text_fr_ocr_1559325558 | 1/3000 | string | PIZZA MARGHERITA MOZZARELLA, TOMATES SÉCHÉES, BASILIC INGRÉDIENTS : Pâte* '53.570 (farine de blé* , eau, sel, levure*), ... |
| ingredients_text_fr_ocr_1559325558_result | 1/3000 | string | Pâte* '53.570 (farine de blé* , eau, sel, levure*), sauce tomate* 17% (purée de tomate* , oignon* sucre* , sel, ail* , o... |
| ingredients_text_fr_ocr_1562591327 | 1/3000 | string | . - m - a*es de riz complet avec un enrobage aromatisé au yaouFi : Enrobage aromatisé au yaourt (60%) (Sucre • Huile de ... |
| ingredients_text_fr_ocr_1562591327_result | 1/3000 | string | . - m - a*es de riz complet avec un enrobage aromatisé au yaouFi : Enrobage aromatisé au yaourt (60%) (Sucre • Huile de ... |
| ingredients_text_fr_ocr_1562600554 | 1/3000 | string | fromagc cheddar affiné pendant 3 ans, au lait pasteq.:isé : Contient lait. INFORMATION Ce cheddar peut de HI lactate nat... |
| ingredients_text_fr_ocr_1562600554_result | 1/3000 | string | fromagc cheddar affiné pendant 3 ans, au lait pasteq.:isé : Contient lait. INFORMATION Ce cheddar peut de HI lactate nat... |
| ingredients_text_fr_ocr_1566592555 | 1/3000 | string | INGRÉDiENT: Eau ; fécule de tapioca ; farine de riz ; fécule de pomme de terre ; huiles végétales : huile de colza, huil... |
| ingredients_text_fr_ocr_1566592555_result | 1/3000 | string | Eau ; fécule de tapioca ; farine de riz ; fécule de pomme de terre ; huiles végétales : huile de colza, huile de tournes... |
| ingredients_text_fr_ocr_1566592560 | 1/3000 | string | Pâte* '53.570 (farine de blé* , eau, sel, levure*), sauce tomate* 17% (purée de tomate* , oignon* sucre* , sel, ail* , o... |
| ingredients_text_fr_ocr_1566592560_result | 1/3000 | string | Pâte* '53.570 (farine de blé* , eau, sel, levure*), sauce tomate* 17% (purée de tomate* , oignon* sucre* , sel, ail* , o... |
| ingredients_text_fr_ocr_1574091724 | 1/3000 | string | _Fromage_ cheddar jeune (_Lait_) (94%) . Oignon émincé réhydraté ‘ Cjbouje’çte Iyqphghsep. gPour les allergenes, vour‘le... |
| ingredients_text_fr_ocr_1574091724_result | 1/3000 | string | _Fromage_ cheddar jeune (_Lait_) (94%) . Oignon émincé réhydraté ‘ Cjbouje’çte Iyqphghsep. gPour les allergenes, vour‘le... |
| ingredients_text_fr_ocr_1574120054 | 1/3000 | string | Morceaux de chocolat blanc (35 %) (Sucre - _Lait_ en poudre entier -Beurre de cacao - _Lait_ en poudre écrémé émulsifian... |
| ingredients_text_fr_ocr_1574120054_result | 1/3000 | string | Morceaux de chocolat blanc (35 %) (Sucre - _Lait_ en poudre entier - Beurre de cacao - _Lait_ en poudre écrémé émulsifia... |
| ingredients_text_fr_ocr_1579622569 | 1/3000 | string | Confiture de cassis (29%) (Sirop de glucose-fructose • Purée de cassis • Acidifiant : Acide citrique • Correcteur d'acid... |
| ingredients_text_fr_ocr_1579622569_result | 1/3000 | string | Confiture de cassis (29%) (Sirop de glucose-fructose • Purée de cassis • Acidifiant : Acide citrique • Correcteur d'acid... |
| ingredients_text_fr_ocr_1582743448 | 1/3000 | string | La crème de coco JAJA est un prcuuit naturel à base d'extrait de noix Ge coco mt eau soleil. Ne contient ni prc Zit lait... |
| ingredients_text_fr_ocr_1582743448_result | 1/3000 | string | Extraits de noix de co' 48%,sucre,eau,s gélifiant E415, acidifian &lt;330. |
| ingredients_text_fr_ocr_1586424882 | 1/3000 | string | [INGRÉDIENTS Eau • Jus de pasteque 25%) • Sucre • Jus de citron vert (3%). |
| ingredients_text_fr_ocr_1586424882_result | 1/3000 | string | Eau • Jus de pasteque 25%) • Sucre • Jus de citron vert (3%). |
| ingredients_text_fr_ocr_1586799457 | 1/3000 | string | Sugar, cocoa mass, _almonds_ (796), orange pieces (7%) [orange puree B4%), sugar, apple, pineapple fibres, food acid (ci... |
| ingredients_text_fr_ocr_1586799457_result | 1/3000 | string | Sugar, cocoa mass, _almonds_ (796), orange pieces (7%) [orange puree B4%), sugar, apple, pineapple fibres, food acid (ci... |
| ingredients_text_fr_ocr_1600099529 | 1/3000 | string | Sucre - _Lait_ en poudre entier - Beurre de cacao -  Masse de cacao - émulsifiant : Lécithine de soja - Amidon de tapioc... |
| ingredients_text_fr_ocr_1600099529_result | 1/3000 | string | Sucre - _Lait_ en poudre entier - Beurre de cacao -  Masse de cacao - émulsifiant : Lécithine de soja - Amidon de tapioc... |
| ingredients_text_fr_ocr_1609851238 | 1/3000 | string | Tomate (23%) • _Lait_ demi-écrémé • Bœuf haché (22%) • Pâtes sans gluten (12%) (Fécule de maïs • Farine de riz • Émulsif... |
| ingredients_text_fr_ocr_1609851238_result | 1/3000 | string | Tomate (23%) • _Lait_ demi-écrémé • Bœuf haché (22%) • Pâtes sans gluten (12%) (Fécule de maïs • Farine de riz • Émulsif... |
| ingredients_text_fr_ocr_1612453971 | 1/3000 | string | Riz basmati cuit (38%) (Eau, Riz basmati); Bouillon de porc rôti (Eau, Os de porc, Extrait de levure, Sel, Sucre); Haric... |
| ingredients_text_fr_ocr_1612453971_result | 1/3000 | string | Riz basmati cuit (38%) (Eau, Riz basmati); Bouillon de porc rôti (Eau, Os de porc, Extrait de levure, Sel, Sucre); Haric... |
| ingredients_text_fr_ocr_1729956600 | 1/3000 | string | Farine de _blé_ contient _Gluten_ (avec Farine de _blé_, Carbonate de calcium, Fer Niacine, Thiamine) - Blanc de poulet ... |
| ingredients_text_fr_ocr_1729956600_result | 1/3000 | string | Farine de _blé_ contient _Gluten_ (avec Farine de _blé_, Carbonate de calcium, Fer Niacine, Thiamine) - Blanc de poulet ... |
| ingredients_text_fr_ocr_1729956619 | 1/3000 | string | Farine de _blé_ (_gluten_), raisins secs 13 %, sucre, _beurre_ (_lait_), écorces d'oranges confites 9 % (écorces d'orang... |
| ingredients_text_fr_ocr_1729956619_result | 1/3000 | string | Farine de _blé_ (_gluten_), raisins secs 13 %, sucre, _beurre_ (_lait_), écorces d'oranges confites 9 % (écorces d'orang... |
| ingredients_text_fr_ocr_1734740770 | 1/3000 | string | Maïs doux (15%) • Poivrons rouges (14%) • Riz arborio cuit (13%) (Eau • Riz arborio) • Sauce au piment et au citron vert... |
| ingredients_text_fr_ocr_1734740770_result | 1/3000 | string | Maïs doux (15%) • Poivrons rouges (14%) • Riz arborio cuit (13%) (Eau • Riz arborio) • Sauce au piment et au citron vert... |
| ingredients_text_it | 2/3000 | string | vinaigre de vin, moult de raisin concentré, colorant E150d, antioxygène: sulfites (E224) |
| ingredients_text_it_debug_tags | 1/3000 | array | [] |
| ingredients_text_la | 7/3000 | string | Cucumbers, water, vinegar, salt, calcium chloride, 0,1% sodium benzoate (preservative), natural flavors, polysorbate 80,... |
| ingredients_text_nl | 7/3000 | string | _tarwebloem_ bevat _gluten_ (met _tarwebloem_, calciumcarbonaat, ijzer, niacine, thiamine), gezoete gedroogde cranberry'...<br>Tarwebloem bevat gluten (met tarwebloem, calciumcarbonaat, ijzer, niacine, thiamine) boter (melk) (23%) gekristalliseerd... |
| ingredients_text_nl_debug_tags | 3/3000 | array | [] |
| ingredients_text_ro | 1/3000 | string | Organic skim milk, vitamin a palmitate and vitamin d3, |
| ingredients_text_th | 1/3000 | string | INGREDIENTS Wheatflour (contains Gluten) Unsalted Butter (Milk) (28% ) . Gruyère Cheese (Milk) (11 % ) Dried Skimmed Mil... |
| ingredients_text_with_allergens | 2737/3000 | string | CHAMOMILE FLOWERS.<br>Peppermint. |
| ingredients_text_with_allergens_ar | 1/3000 | string | - |
| ingredients_text_with_allergens_cs | 1/3000 | string | Krupice z tvrdé pšenice, pitná voda |
| ingredients_text_with_allergens_de | 12/3000 | string | Proteinmischung (<span class="allergen">Sojaprotein</span>, <span class="allergen">Weizenprotein</span>, <span class="al...<br>100% Soja-Protein-Isolat (<span class="allergen">Soja</span>), Aroma, Süßstoff Natrium-Saccharin. |
| ingredients_text_with_allergens_en | 2628/3000 | string | CHAMOMILE FLOWERS.<br>Peppermint. |
| ingredients_text_with_allergens_es | 2/3000 | string | PEPINILLOS, AGUA, VINAGRE, SAL, CLORURO DE CALCIO, BENZOATO DE SODIO 0.1% (CONSERVADOR), SULFATO DE ALUMINIO Y SODIO, SA...<br><span class="allergen">Seitán</span> 83% (agua, gluten de <span class="allergen">trigo</span>, harina de <span class="al... |
| ingredients_text_with_allergens_fr | 248/3000 | string | Eau ; fécule de tapioca ; farine de riz ; fécule de pomme de terre ; huiles végétales : huile de colza, huile de tournes...<br>Farine de <span class="allergen">blé</span> (farine de <span class="allergen">blé</span>, <span class="allergen">gluten ... |
| ingredients_text_with_allergens_it | 2/3000 | string | vinaigre de vin, moult de raisin concentré, colorant E150d, antioxygène: sulfites (E224) |
| ingredients_text_with_allergens_la | 6/3000 | string | Cucumbers, water, vinegar, salt, calcium chloride, 0,1% sodium benzoate (preservative), natural flavors, polysorbate 80,... |
| ingredients_text_with_allergens_nl | 7/3000 | string | <span class="allergen">tarwebloem</span> bevat <span class="allergen">gluten</span> (met <span class="allergen">tarweblo...<br>Tarwebloem bevat<span class="allergen"> gluten</span> (met tarwebloem, calciumcarbonaat, ijzer, niacine, thiamine)<span ... |
| ingredients_text_with_allergens_ro | 1/3000 | string | Organic skim milk, vitamin a palmitate and vitamin d3, |
| ingredients_text_with_allergens_th | 1/3000 | string | INGREDIENTS Wheatflour (contains Gluten) Unsalted Butter (<span class="allergen">Milk</span>) (28% ) . Gruyère Cheese (<... |
| ingredients_that_may_be_from_palm_oil_n | 2698/3000 | number | 0<br>1 |
| ingredients_that_may_be_from_palm_oil_tags | 2999/3000 | array | []<br>["e160a-beta-carotene"] |
| ingredients_with_specified_percent_n | 2720/3000 | number | 0<br>2 |
| ingredients_with_specified_percent_sum | 2720/3000 | number | 0<br>100 |
| ingredients_with_unspecified_percent_n | 2720/3000 | number | 1<br>3 |
| ingredients_with_unspecified_percent_sum | 2720/3000 | number | 100<br>0 |
| ingredients_without_ciqual_codes | 2720/3000 | array | ["en:camomile-flower"]<br>[] |
| ingredients_without_ciqual_codes_n | 2720/3000 | number | 1<br>0 |
| ingredients_without_ecobalyse_ids | 2544/3000 | array | ["en:camomile-flower"]<br>["en:peppermint"] |
| ingredients_without_ecobalyse_ids_n | 2544/3000 | number | 1<br>3 |
| interface_version_created | 3000/3000 | string | 20150316.jqm2<br>import_us_ndb.pl - version 2017/03/04 |
| interface_version_modified | 2515/3000 | string | 20190830<br>20150316.jqm2 |
| known_ingredients_n | 2720/3000 | number | 3<br>0 |
| labels | 724/3000 | string | Sans gluten,Sans huile de palme<br>Sans gluten, Sans lactose |
| labels_debug_tags | 29/3000 | array | [] |
| labels_hierarchy | 752/3000 | array | ["en:no-gluten","en:no-palm-oil"]<br>[] |
| labels_imported | 27/3000 | string | Organic, en:organic<br>Pure cocoa butter |
| labels_lc | 724/3000 | string | fr<br>la |
| labels_next_hierarchy | 1/3000 | array | [] |
| labels_next_tags | 1/3000 | array | [] |
| labels_old | 610/3000 | string | Sans gluten, Sans huile de palme<br>Sans gluten, Sans lactose |
| labels_prev_hierarchy | 31/3000 | array | []<br>["en:organic","en:vegetarian","en:eu-organic","en:vegan","en:es-eco-016-cl","en:green-dot"] |
| labels_prev_tags | 31/3000 | array | []<br>["en:organic","en:vegetarian","en:eu-organic","en:vegan","en:es-eco-016-cl","en:green-dot"] |
| labels_tags | 752/3000 | array | ["en:no-gluten","en:no-palm-oil"]<br>[] |
| lang | 3000/3000 | string | fr<br>en |
| lang_debug_tags | 108/3000 | array | [] |
| languages | 3000/3000 | object | {"en:french":4}<br>{"en:english":2} |
| languages_codes | 3000/3000 | object | {"fr":4}<br>{"en":2} |
| languages_hierarchy | 3000/3000 | array | ["en:french"]<br>["en:english"] |
| languages_tags | 3000/3000 | array | ["en:french","en:1"]<br>["en:english","en:1"] |
| last_check_dates_tags | 3/3000 | array | ["2019-09-23","2019-09","2019"]<br>["2025-10-27","2025-10","2025"] |
| last_checked_t | 3/3000 | number | 1569245207<br>1761570328 |
| last_checker | 3/3000 | string | aleene<br>beniben |
| last_edit_dates_tags | 3000/3000 | array | ["2024-11-14","2024-11","2024"]<br>["2025-02-21","2025-02","2025"] |
| last_editor | 3000/3000 | null, string | timotheeberthault<br>null |
| last_image_dates_tags | 1144/3000 | array | ["2020-01-18","2020-01","2020"]<br>["2021-09-25","2021-09","2021"] |
| last_image_t | 1144/3000 | number | 1579374831<br>1632611837 |
| last_modified_by | 3000/3000 | null, string | timotheeberthault<br>null |
| last_modified_t | 3000/3000 | number | 1731601773<br>1740179797 |
| last_updated_t | 3000/3000 | number | 1743391825<br>1740179797 |
| lc | 3000/3000 | string | fr<br>en |
| lc_imported | 2128/3000 | string | en<br>fr |
| link | 450/3000 | string | http://www.allfitnessfactory.de/protein-90-kaufen/<br>http://www.allfitnessfactory.de/whey-oder-mehrkomponenten-protein/ |
| link_debug_tags | 104/3000 | array | [] |
| main_countries_tags | 3000/3000 | array | [] |
| manufacturing_places | 451/3000 | string | Germany<br>Japon |
| manufacturing_places_debug_tags | 104/3000 | array | [] |
| manufacturing_places_tags | 451/3000 | array | []<br>["germany"] |
| max_imgid | 1144/3000 | number, string | 3<br>1 |
| minerals_prev_tags | 2997/3000 | array | []<br>["en:iron"] |
| minerals_tags | 2999/3000 | array | []<br>["en:calcium","en:iron"] |
| misc_tags | 3000/3000 | array | ["en:environmental-score-computed","en:environmental-score-missing-data-labels","en:environmental-score-missing-data-ori...<br>["en:environmental-score-not-computed","en:nutriscore-missing-nutrition-data","en:nutriscore-missing-nutrition-data-ener... |
| new_additives_n | 5/3000 | number | 2<br>0 |
| no_nutrition_data | 1507/3000 | null, string | null<br>on |
| nova_group | 2600/3000 | number | 1<br>4 |
| nova_group_debug | 3000/3000 | string | no nova group when the product does not have ingredients<br>no nova group if too many ingredients are unknown: 1 out of 1 |
| nova_group_error | 400/3000 | string | missing_ingredients<br>too_many_unknown_ingredients |
| nova_groups | 2600/3000 | string | 1<br>4 |
| nova_groups_markers | 2600/3000 | object | {}<br>{"4":[["ingredients","en:flavouring"]]} |
| nova_groups_tags | 3000/3000 | array | ["unknown"]<br>["en:1-unprocessed-or-minimally-processed-foods"] |
| nucleotides_prev_tags | 2997/3000 | array | [] |
| nucleotides_tags | 2999/3000 | array | [] |
| nutrient_levels | 3000/3000 | object | {"fat":"high","saturated-fat":"high","sugars":"high","salt":"low"}<br>{} |
| nutrient_levels_tags | 3000/3000 | array | ["en:fat-in-high-quantity","en:saturated-fat-in-high-quantity","en:sugars-in-high-quantity","en:salt-in-low-quantity"]<br>[] |
| nutriments | 3000/3000 | object | {"nutrition-score-fr":25,"saturated-fat_100g":10,"proteins":8,"fruits-vegetables-nuts-estimate_100g":40,"sodium_value":0...<br>{"fruits-vegetables-legumes-estimate-from-ingredients_serving":100,"fat_value":0,"sodium":0.3,"potassium_value":3200,"fa... |
| nutriments_estimated | 691/3000 | object | {"zinc_100g":0.0011,"galactose_100g":0.19,"selenium_100g":5e-7,"phylloquinone_100g":0.000152,"fructose_100g":0.25,"gluco...<br>{"vitamin-b1_100g":0.000007499999999999999,"phylloquinone_100g":4.0000000000000003e-7,"saturated-fat_100g":0,"magnesium_... |
| nutriscore | 3000/3000 | object | {"2021":{"nutriscore_computed":1,"category_available":1,"grade":"e","data":{"sugars_value":32,"energy_value":2582,"fiber...<br>{"2021":{"category_available":1,"grade":"unknown","data":{"fiber":0,"proteins":null,"energy":null,"is_water":0,"fruits_v... |
| nutriscore_2021_tags | 3000/3000 | array | ["e"]<br>["unknown"] |
| nutriscore_2023_tags | 3000/3000 | array | ["e"]<br>["unknown"] |
| nutriscore_data | 2390/3000 | object | {"negative_points":25,"positive_points":0,"positive_nutrients":["fiber","fruits_vegetables_legumes"],"components":{"posi...<br>{"count_proteins":1,"is_water":0,"negative_points_max":54,"negative_points":0,"positive_points_max":18,"positive_points"... |
| nutriscore_grade | 3000/3000 | string | e<br>unknown |
| nutriscore_score | 2358/3000 | number | 25<br>0 |
| nutriscore_score_opposite | 2358/3000 | number | -25<br>0 |
| nutriscore_tags | 3000/3000 | array | ["e"]<br>["unknown"] |
| nutriscore_version | 3000/3000 | string | 2023<br>2021 |
| nutrition_data | 2731/3000 | string | on<br>null |
| nutrition_data_per | 3000/3000 | string | 100g<br>serving |
| nutrition_data_per_debug_tags | 236/3000 | array | [] |
| nutrition_data_per_imported | 2128/3000 | string | 100g |
| nutrition_data_prepared | 323/3000 | string | on |
| nutrition_data_prepared_per | 3000/3000 | string | 100g<br>serving |
| nutrition_data_prepared_per_debug_tags | 43/3000 | array | [] |
| nutrition_data_prepared_per_imported | 2128/3000 | string | 100g |
| nutrition_grade_fr | 3000/3000 | string | e<br>unknown |
| nutrition_grades | 3000/3000 | string | e<br>unknown |
| nutrition_grades_tags | 3000/3000 | array | ["e"]<br>["unknown"] |
| nutrition_score_beverage | 3000/3000 | number | 0<br>1 |
| nutrition_score_debug | 3000/3000 | string | missing energy_100g - missing fat_100g - missing saturated-fat_100g - missing sugars_100g - missing sodium_100g - missin...<br>missing sugars_100g |
| nutrition_score_warning_fruits_vegetables_legumes_estimate_from_ingredients | 2695/3000 | number | 1 |
| nutrition_score_warning_fruits_vegetables_legumes_estimate_from_ingredients_value | 2695/3000 | number | 100<br>0 |
| nutrition_score_warning_fruits_vegetables_legumes_from_category | 6/3000 | string | en:vegetables<br>en:jams |
| nutrition_score_warning_fruits_vegetables_legumes_from_category_value | 6/3000 | number | 90<br>50 |
| nutrition_score_warning_fruits_vegetables_nuts_estimate | 14/3000 | number | 1 |
| nutrition_score_warning_fruits_vegetables_nuts_estimate_from_ingredients | 2679/3000 | number | 1 |
| nutrition_score_warning_fruits_vegetables_nuts_estimate_from_ingredients_value | 2679/3000 | number | 100<br>0 |
| nutrition_score_warning_fruits_vegetables_nuts_from_category | 10/3000 | string | en:vegetables-based-foods<br>en:vegetables |
| nutrition_score_warning_fruits_vegetables_nuts_from_category_value | 10/3000 | number | 85<br>90 |
| nutrition_score_warning_no_fiber | 803/3000 | number | 1 |
| nutrition_score_warning_no_fruits_vegetables_nuts | 272/3000 | number | 1 |
| nutrition_score_warning_nutriments_estimated | 24/3000 | number | 1 |
| obsolete | 112/3000 | string | - |
| obsolete_since_date | 112/3000 | string | - |
| origin | 184/3000 | string | Made in Canada<br>Kent, UK |
| origin_ar | 1/3000 | string | - |
| origin_de | 1/3000 | string | - |
| origin_en | 154/3000 | string | Made in Canada<br>Kent, UK |
| origin_es | 2/3000 | string | - |
| origin_fr | 64/3000 | string | - |
| origin_it | 1/3000 | string | - |
| origin_la | 1/3000 | string | - |
| origin_nl | 2/3000 | string | - |
| origin_th | 1/3000 | string | - |
| origins | 454/3000 | string | Germany<br>Canada |
| origins_debug_tags | 1/3000 | array | [] |
| origins_hierarchy | 454/3000 | array | []<br>["en:germany"] |
| origins_lc | 454/3000 | string | fr<br>de |
| origins_old | 304/3000 | string | Germany<br>Canada |
| origins_tags | 454/3000 | array | []<br>["en:germany"] |
| other_nutritional_substances_prev_tags | 5/3000 | array | [] |
| other_nutritional_substances_tags | 2999/3000 | array | [] |
| owner_fields | 49/3000 | object | {} |
| packaging | 402/3000 | string | en:Bucket<br>Dose |
| packaging_debug_tags | 1/3000 | array | [] |
| packaging_hierarchy | 401/3000 | array | []<br>["en:bucket"] |
| packaging_lc | 401/3000 | string | fr<br>de |
| packaging_materials_tags | 3000/3000 | array | ["en:glass","en:metal"]<br>[] |
| packaging_old | 384/3000 | string | en:Bucket<br>Dose |
| packaging_old_before_taxonomization | 167/3000 | string | bucket<br>can |
| packaging_recycling_tags | 3000/3000 | array | ["en:recycle-in-sorting-bin"]<br>[] |
| packaging_shapes_tags | 3000/3000 | array | ["en:jar","en:lid"]<br>[] |
| packaging_tags | 403/3000 | array | []<br>["en:bucket"] |
| packaging_text | 201/3000 | string | Bag: Paper - widely recycled.<br>1 425 g transparent PET 1 plastic jar with opaque plastic lid to recycle |
| packaging_text_ar | 1/3000 | string | - |
| packaging_text_de | 1/3000 | string | - |
| packaging_text_en | 166/3000 | string | Bag: Paper - widely recycled.<br>1 425 g transparent PET 1 plastic jar with opaque plastic lid to recycle |
| packaging_text_es | 2/3000 | string | - |
| packaging_text_fr | 71/3000 | string | - |
| packaging_text_it | 1/3000 | string | - |
| packaging_text_la | 1/3000 | string | - |
| packaging_text_nl | 2/3000 | string | - |
| packaging_text_th | 1/3000 | string | - |
| packagings | 3000/3000 | array | [{"recycling":"en:recycle-in-sorting-bin","shape":"en:jar","number_of_units":1,"food_contact":1,"quantity_per_unit":"350...<br>[] |
| packagings_complete | 164/3000 | number | 1<br>0 |
| packagings_materials | 3000/3000 | object | {"en:glass":{},"all":{},"en:metal":{}}<br>{} |
| packagings_n | 208/3000 | number | 2<br>1 |
| photographers | 1/3000 | array | ["javichu"] |
| photographers_tags | 3000/3000 | array | ["kiliweb"]<br>[] |
| pnns_groups_1 | 3000/3000 | string | Sugary snacks<br>unknown |
| pnns_groups_1_tags | 3000/3000 | array | ["sugary-snacks","known"]<br>["unknown","missing-association"] |
| pnns_groups_2 | 3000/3000 | string | Sweets<br>unknown |
| pnns_groups_2_tags | 3000/3000 | array | ["sweets","known"]<br>["unknown","missing-association"] |
| popularity_key | 3000/3000 | number | 1<br>0 |
| popularity_tags | 820/3000 | array | ["top-75-percent-scans-2024","top-80-percent-scans-2024","top-85-percent-scans-2024","top-90-percent-scans-2024","top-10...<br>["bottom-25-percent-scans-2020","bottom-20-percent-scans-2020","top-85-percent-scans-2020","top-90-percent-scans-2020","... |
| product | 4/3000 | object | {} |
| product_name | 2973/3000 | string | Véritable pâte à tartiner noisettes chocolat noir<br>Chamomile Herbal Tea |
| product_name_ar | 2/3000 | string | - |
| product_name_da | 10/3000 | string | Polarbrød Havre<br>1% Milk |
| product_name_de | 20/3000 | string | Mehrkomponeneten Protein 90 C6 Haselnuß<br>Mehrkomponeneten Protein 90 C6 Banane |
| product_name_de_debug_tags | 13/3000 | array | [] |
| product_name_debug_tags | 309/3000 | array | [] |
| product_name_en | 2669/3000 | string | Chamomile Herbal Tea<br>Lagg's, herbal tea, peppermint |
| product_name_en_debug_tags | 32/3000 | array | [] |
| product_name_en_imported | 2128/3000 | string | Lagg's, chamomile herbal tea<br>Lagg's, herbal tea, peppermint |
| product_name_es | 13/3000 | string | Macarroni and cheese dinner<br>Hamburger Dill Chips |
| product_name_es_debug_tags | 1/3000 | array | [] |
| product_name_fr | 439/3000 | string | Véritable pâte à tartiner noisettes chocolat noir<br>Escalope de dinde |
| product_name_fr_debug_tags | 87/3000 | array | [] |
| product_name_it | 12/3000 | string | Balsamic vinegar of Modena<br>Lindt 90% chocolate |
| product_name_it_debug_tags | 1/3000 | array | [] |
| product_name_la | 7/3000 | string | Original Buttery Spread<br>Hamburger dill chips pickles |
| product_name_nl | 8/3000 | string | Fall Hornin' pumpkin ale<br>Diet Sparkling Fiery Ginger Beer |
| product_name_nl_debug_tags | 3/3000 | array | [] |
| product_name_pt | 2/3000 | string | Tartar Sauce<br>Medium Picante Sauce |
| product_name_ro | 2/3000 | string | Balsamic Vinegar<br>Low-fat Caramel Praline Frozen Yogurt |
| product_name_sv | 1/3000 | string | Fattoi |
| product_name_th | 1/3000 | string | Cheese Twists |
| product_quantity | 1789/3000 | number, string | 350<br>1 |
| product_quantity_unit | 1755/3000 | string | g<br>ml |
| product_type | 3000/3000 | string | food |
| purchase_places | 454/3000 | string | Germany<br>France |
| purchase_places_debug_tags | 104/3000 | array | [] |
| purchase_places_tags | 454/3000 | array | []<br>["germany"] |
| quantity | 1936/3000 | string | 350 g<br>1 g |
| quantity_debug_tags | 114/3000 | array | [] |
| removed_countries_tags | 3000/3000 | array | [] |
| rev | 3000/3000 | number, string | 18<br>4 |
| scans_n | 828/3000 | number | 1<br>2 |
| schema_version | 872/3000 | number | 1001<br>1002 |
| serving_quantity | 2605/3000 | null, number, string | 1<br>45 |
| serving_quantity_unit | 2434/3000 | string | g<br>ml |
| serving_size | 2604/3000 | string | 1g<br>1.61 ONZ (45 g) |
| serving_size_debug_tags | 89/3000 | array | [] |
| serving_size_imported | 2128/3000 | string | 1 TEA BAG (1 g)<br>1.61 ONZ (45 g) |
| sortkey | 2/3000 | number | 1587632374<br>301492610836 |
| sources | 2462/3000 | array | [{"url":"https://api.nal.usda.gov/ndb/reports/?ndbno=45022269&type=f&format=json&api_key=DEMO_KEY","fields":["product_na...<br>[{"images":[],"id":"usda-ndb","import_t":1489055331,"url":"https://api.nal.usda.gov/ndb/reports/?ndbno=45022278&type=f&f... |
| sources_fields | 2128/3000 | object | {"org-database-usda":{"fdc_id":"366948","available_date":"2018-07-05T00:00:00Z","publication_date":"2019-04-01T00:00:00Z...<br>{"org-database-usda":{"publication_date":"2019-04-01T00:00:00Z","fdc_category":"Tea Bags","fdc_id":"366952","available_d... |
| specific_ingredients | 2/3000 | array | [{"origins":"en:france","label":"en:french-meat","ingredient":"en:meat","id":"en:meat"},{"id":"en:pork","label":"en:fren...<br>[{"id":"en:meat","label":"en:french-meat","origins":"en:france","ingredient":"en:meat"},{"id":"en:pork","label":"en:fren... |
| states | 3000/3000 | string | en:to-be-completed, en:nutrition-facts-completed, en:ingredients-to-be-completed, en:expiration-date-completed, en:packa...<br>en:to-be-completed, en:nutrition-facts-completed, en:ingredients-completed, en:expiration-date-to-be-completed, en:packa... |
| states_hierarchy | 3000/3000 | array | ["en:to-be-completed","en:nutrition-facts-completed","en:ingredients-to-be-completed","en:expiration-date-completed","en...<br>["en:to-be-completed","en:nutrition-facts-completed","en:ingredients-completed","en:expiration-date-to-be-completed","en... |
| states_tags | 3000/3000 | array | ["en:to-be-completed","en:nutrition-facts-completed","en:ingredients-to-be-completed","en:expiration-date-completed","en...<br>["en:to-be-completed","en:nutrition-facts-completed","en:ingredients-completed","en:expiration-date-to-be-completed","en... |
| stores | 1269/3000 | string | allfitnessfactory.de<br>Intermarché |
| stores_debug_tags | 79/3000 | array | [] |
| stores_tags | 1269/3000 | array | []<br>["allfitnessfactory-de"] |
| taxonomies_enhancer_tags | 4/3000 | array | ["ingredients-nl-sinaasappelaroma-is-possible-typo-for-nl-sinaasappelsmaak"]<br>["ingredients-taxonomy-between-acide-ascorbique-id-en-vitamin-c-and-ascorbic-acid-id-en-e300-should-be-same-id"] |
| teams | 294/3000 | string | chocolatine,la-robe-est-bleue<br>shark-attack |
| teams_tags | 294/3000 | array | ["chocolatine","la-robe-est-bleue"]<br>["shark-attack"] |
| traces | 3000/3000 | string | en:gluten,en:milk,en:nuts<br>en:nuts,en:peanuts |
| traces_debug_tags | 105/3000 | array | [] |
| traces_from_ingredients | 3000/3000 | string | gluten, crustacés, mollusques, oeufs, poisson, soja, sésames, fruits à coque, moutarde<br>lait, soja, céleri, crustacés, mollusques, fruits à coques, lupin, sulfites |
| traces_from_user | 3000/3000 | string | (fr) <br>(en)  |
| traces_hierarchy | 3000/3000 | array | []<br>["en:gluten","en:milk","en:nuts"] |
| traces_imported | 12/3000 | string | Nuts, Peanuts<br>Soybeans |
| traces_lc | 313/3000 | string | fr<br>en |
| traces_tags | 3000/3000 | array | []<br>["en:gluten","en:milk","en:nuts"] |
| unique_scans_n | 828/3000 | number | 1<br>2 |
| unknown_ingredients_n | 2720/3000 | number, string | 0<br>1 |
| unknown_nutrients_tags | 2996/3000 | array | []<br>["proteins-dry-substance"] |
| update_key | 3000/3000 | string | brands<br>sort |
| vitamins_prev_tags | 2997/3000 | array | []<br>["en:vitamin-e","en:cholecalciferol"] |
| vitamins_tags | 2999/3000 | array | []<br>["en:vitamin-e","en:dl-alpha-tocopheryl-acetate","en:retinyl-palmitate","en:cholecalciferol"] |
| weighers_tags | 1948/3000 | array | [] |
| weighters_tags | 8/3000 | array | [] |
| with_non_nutritive_sweeteners | 153/3000 | number | 1 |
| with_sweeteners | 23/3000 | number | 1 |

## Nested field summary (depth <= 6)

| Path | Observed | Types | Array element types | Examples |
|---|---:|---|---|---|
| _keywords[] | 26447 | string | - | au<br>aux |
| additives_debug_tags[] | 198 | string | - | en-e322i-added<br>en-e341-added |
| additives_old_tags[] | 254 | string | - | en:e420<br>en:e965 |
| additives_original_tags[] | 7343 | string | - | en:e471<br>en:e322i |
| additives_prev_original_tags[] | 521 | string | - | en:e1510<br>en:e322 |
| additives_tags[] | 8604 | string | - | en:e202<br>en:e322 |
| allergens_hierarchy[] | 4424 | string | - | en:nuts<br>en:milk |
| allergens_tags[] | 4424 | string | - | en:nuts<br>en:milk |
| amino_acids_tags[] | 7 | string | - | en:l-cysteine |
| brands_hierarchy[] | 865 | string | - | xx:Bovetti<br>xx:Lagg's |
| brands_tags[] | 3471 | string | - | xx:bovetti<br>lagg-s |
| categories_hierarchy[] | 7189 | string | - | en:breakfasts<br>en:spreads |
| categories_properties_tags[] | 19580 | string | - | all-products<br>categories-known |
| categories_properties.agribalyse_food_code:en | 234 | string | - | 31032<br>18020 |
| categories_properties.agribalyse_proxy_food_code:en | 362 | string | - | 31032<br>24000 |
| categories_properties.ciqual_food_code:en | 458 | string | - | 31032<br>18020 |
| categories_tags[] | 7189 | string | - | en:breakfasts<br>en:spreads |
| category_properties.ciqual_food_name:en | 804 | string | - | Chocolate spread with hazelnuts<br>Vegetable oil -average- |
| category_properties.ciqual_food_name:fr | 775 | string | - | Huile végétale -aliment moyen-<br>Pain -aliment moyen- |
| checkers_tags[] | 3 | string | - | aleene<br>beniben |
| ciqual_food_name_tags[] | 2997 | string | - | chocolate-spread-with-hazelnuts<br>unknown |
| cities_tags[] | 2 | string | - | kervignac-morbihan-france<br>brignemont-haute-garonne-france |
| codes_tags[] | 32803 | string | - | code-13<br>conflict-with-upc-12 |
| correctors_tags[] | 8557 | string | - | openfoodfacts-contributors<br>tacite-mass-editor |
| correctors[] | 1 | string | - | javichu |
| countries_hierarchy[] | 3199 | string | - | en:france<br>en:united-states |
| countries_tags[] | 3199 | string | - | en:france<br>en:united-states |
| data_quality_completeness_tags[] | 3313 | string | - | en:photo-and-data-to-be-checked-by-an-experienced-contributor<br>en:ingredients-en-photo-to-be-selected |
| data_quality_dimensions.accuracy | 223 | object | - | {"overall":"0.00"}<br>{"overall":"1.00"} |
| data_quality_dimensions.accuracy.overall | 223 | string | - | 0.00<br>1.00 |
| data_quality_dimensions.completeness | 223 | object | - | {"packaging":"0.50","ingredients":"0.50","overall":"0.50","nutrition":"0.67","general_information":"0.40"}<br>{"overall":"0.50","ingredients":"0.50","packaging":"0.50","nutrition":"0.67","general_information":"0.40"} |
| data_quality_dimensions.completeness.general_information | 223 | string | - | 0.40<br>0.60 |
| data_quality_dimensions.completeness.ingredients | 223 | string | - | 0.50<br>0.25 |
| data_quality_dimensions.completeness.nutrition | 223 | string | - | 0.67<br>1.00 |
| data_quality_dimensions.completeness.overall | 223 | string | - | 0.50<br>0.58 |
| data_quality_dimensions.completeness.packaging | 223 | string | - | 0.50<br>0.33 |
| data_quality_errors_tags[] | 2495 | string | - | en:nutrition-value-total-over-105<br>en:energy-value-in-kcal-does-not-match-value-computed-from-other-nutrients |
| data_quality_info_tags[] | 17543 | string | - | en:packaging-data-incomplete<br>en:environmental-score-extended-data-not-computed |
| data_quality_tags[] | 36102 | string | - | en:packaging-data-incomplete<br>en:environmental-score-extended-data-not-computed |
| data_quality_warning_tags[] | 1 | string | - | en:sum-of-ingredients-with-specified-percent-greater-than-200 |
| data_quality_warnings_tags[] | 12751 | string | - | en:environmental-score-origins-of-ingredients-origins-are-100-percent-unknown<br>en:environmental-score-packaging-unscored-shape |
| data_sources_tags[] | 10011 | string | - | app-yuka<br>apps |
| debug_param_sorted_langs[] | 473 | string | - | fr<br>de |
| ecoscore_data.adjustments | 926 | object | - | {"threatened_species":{},"packaging":{"value":-15,"warning":"packaging_data_missing"},"origins_of_ingredients":{"values"...<br>{"origins_of_ingredients":{"epi_value":-5,"origins_from_origins_field":["en:unknown"],"values":{"gi":-5,"ma":-5,"mc":-5,... |
| ecoscore_data.adjustments.origins_of_ingredients | 926 | object | - | {"values":{"hr":-5,"ps":-5,"al":-5,"uk":-5,"dk":-5,"li":-5,"ad":-5,"at":-5,"es":-5,"sy":-5,"ie":-5,"cy":-5,"sk":-5,"ax":...<br>{"epi_value":-5,"origins_from_origins_field":["en:unknown"],"values":{"gi":-5,"ma":-5,"mc":-5,"hu":-5,"tr":-5,"me":-5,"v... |
| ecoscore_data.adjustments.origins_of_ingredients.aggregated_origins | 926 | array | object | [{"percent":100,"origin":"en:unknown"}]<br>[{"origin":"en:unknown","percent":100}] |
| ecoscore_data.adjustments.origins_of_ingredients.aggregated_origins[] | 929 | object | - | {"percent":100,"origin":"en:unknown"}<br>{"origin":"en:unknown","percent":100} |
| ecoscore_data.adjustments.origins_of_ingredients.aggregated_origins[].origin | 929 | string | - | en:unknown<br>en:canada |
| ecoscore_data.adjustments.origins_of_ingredients.aggregated_origins[].percent | 929 | number | - | 100<br>99.99999999999997 |
| ecoscore_data.adjustments.origins_of_ingredients.epi_score | 926 | number | - | 0<br>68 |
| ecoscore_data.adjustments.origins_of_ingredients.epi_value | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.origins_from_categories | 926 | array | string | ["en:unknown"]<br>["en:italy"] |
| ecoscore_data.adjustments.origins_of_ingredients.origins_from_categories[] | 926 | string | - | en:unknown<br>en:italy |
| ecoscore_data.adjustments.origins_of_ingredients.origins_from_origins_field | 926 | array | string | ["en:unknown"]<br>["en:canada"] |
| ecoscore_data.adjustments.origins_of_ingredients.origins_from_origins_field[] | 926 | string | - | en:unknown<br>en:canada |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores | 926 | object | - | {"fi":0,"lb":0,"nl":0,"ax":0,"xk":0,"rs":0,"es":0,"ad":0,"at":0,"cy":0,"sk":0,"sy":0,"ie":0,"ps":0,"al":0,"hr":0,"dk":0,...<br>{"de":0,"ly":0,"lv":0,"si":0,"se":0,"world":0,"ua":0,"mt":0,"md":0,"dz":0,"gr":0,"lu":0,"pt":0,"cz":0,"je":0,"fo":0,"pl"... |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.ad | 926 | number | - | 0<br>44 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.al | 926 | number | - | 0<br>53 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.at | 926 | number | - | 0<br>64 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.ax | 926 | number | - | 0<br>32 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.ba | 926 | number | - | 0<br>58 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.be | 926 | number | - | 0<br>27 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.bg | 926 | number | - | 0<br>35 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.ch | 926 | number | - | 0<br>56 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.cy | 926 | number | - | 0<br>60 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.cz | 926 | number | - | 0<br>52 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.de | 926 | number | - | 0<br>21 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.dk | 926 | number | - | 0<br>18 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.dz | 926 | number | - | 0<br>56 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.ee | 926 | number | - | 0<br>36 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.eg | 926 | number | - | 0<br>55 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.es | 926 | number | - | 0<br>3 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.fi | 926 | number | - | 0<br>35 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.fo | 926 | number | - | 0<br>28 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.fr | 926 | number | - | 0<br>54 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.gg | 926 | number | - | 0<br>23 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.gi | 926 | number | - | 0<br>72 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.gr | 926 | number | - | 0<br>24 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.hr | 926 | number | - | 0<br>74 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.hu | 926 | number | - | 0<br>58 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.ie | 926 | number | - | 0<br>54 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.il | 926 | number | - | 0<br>55 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.im | 926 | number | - | 0<br>24 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.is | 926 | number | - | 0<br>26 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.it | 926 | number | - | 0<br>100 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.je | 926 | number | - | 0<br>25 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.lb | 926 | number | - | 0<br>60 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.li | 926 | number | - | 0<br>76 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.lt | 926 | number | - | 0<br>9 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.lu | 926 | number | - | 0<br>53 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.lv | 926 | number | - | 0<br>37 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.ly | 926 | number | - | 0<br>74 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.ma | 926 | number | - | 0<br>39 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.mc | 926 | number | - | 0<br>77 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.md | 926 | number | - | 0<br>12 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.me | 926 | number | - | 0<br>45 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.mk | 926 | number | - | 0<br>33 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.mt | 926 | number | - | 0<br>30 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.nl | 926 | number | - | 0<br>19 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.no | 926 | number | - | 0<br>44 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.pl | 926 | number | - | 0<br>35 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.ps | 926 | number | - | 0<br>63 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.pt | 926 | number | - | 0<br>60 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.ro | 926 | number | - | 0<br>17 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.rs | 926 | number | - | 0<br>55 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.se | 926 | number | - | 0<br>30 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.si | 926 | number | - | 0<br>81 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.sj | 926 | number | - | 0<br>19 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.sk | 926 | number | - | 0<br>50 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.sm | 926 | number | - | 0<br>93 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.sy | 926 | number | - | 0<br>47 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.tn | 926 | number | - | 0<br>18 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.tr | 926 | number | - | 0<br>28 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.ua | 926 | number | - | 0<br>61 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.uk | 926 | number | - | 0<br>20 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.us | 926 | number | - | 0<br>100 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.va | 926 | number | - | 0<br>81 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.world | 926 | number | - | 0 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_scores.xk | 926 | number | - | 0<br>29 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values | 926 | object | - | {"ro":0,"il":0,"lt":0,"bg":0,"mk":0,"fr":0,"eg":0,"it":0,"im":0,"gg":0,"us":0,"ch":0,"li":0,"dk":0,"uk":0,"ps":0,"al":0,...<br>{"uk":0,"li":0,"dk":0,"hr":0,"ps":0,"al":0,"ie":0,"sy":0,"cy":0,"sk":0,"es":0,"at":0,"ad":0,"rs":0,"xk":0,"ax":0,"nl":0,... |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.ad | 926 | number | - | 0<br>7 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.al | 926 | number | - | 0<br>8 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.at | 926 | number | - | 0<br>10 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.ax | 926 | number | - | 0<br>5 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.ba | 926 | number | - | 0<br>9 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.be | 926 | number | - | 0<br>4 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.bg | 926 | number | - | 0<br>5 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.ch | 926 | number | - | 0<br>8 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.cy | 926 | number | - | 0<br>9 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.cz | 926 | number | - | 0<br>8 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.de | 926 | number | - | 0<br>3 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.dk | 926 | number | - | 0<br>3 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.dz | 926 | number | - | 0<br>8 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.ee | 926 | number | - | 0<br>5 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.eg | 926 | number | - | 0<br>8 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.es | 926 | number | - | 0<br>3 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.fi | 926 | number | - | 0<br>5 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.fo | 926 | number | - | 0<br>4 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.fr | 926 | number | - | 0<br>8 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.gg | 926 | number | - | 0<br>3 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.gi | 926 | number | - | 0<br>11 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.gr | 926 | number | - | 0<br>4 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.hr | 926 | number | - | 0<br>11 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.hu | 926 | number | - | 0<br>9 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.ie | 926 | number | - | 0<br>8 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.il | 926 | number | - | 0<br>8 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.im | 926 | number | - | 0<br>4 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.is | 926 | number | - | 0<br>4 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.it | 926 | number | - | 0<br>15 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.je | 926 | number | - | 0<br>4 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.lb | 926 | number | - | 0<br>9 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.li | 926 | number | - | 0<br>11 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.lt | 926 | number | - | 0<br>1 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.lu | 926 | number | - | 0<br>8 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.lv | 926 | number | - | 0<br>6 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.ly | 926 | number | - | 0<br>11 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.ma | 926 | number | - | 0<br>6 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.mc | 926 | number | - | 0<br>12 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.md | 926 | number | - | 0<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.me | 926 | number | - | 0<br>7 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.mk | 926 | number | - | 0<br>5 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.mt | 926 | number | - | 0<br>5 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.nl | 926 | number | - | 0<br>3 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.no | 926 | number | - | 0<br>7 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.pl | 926 | number | - | 0<br>5 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.ps | 926 | number | - | 0<br>9 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.pt | 926 | number | - | 0<br>9 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.ro | 926 | number | - | 0<br>3 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.rs | 926 | number | - | 0<br>8 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.se | 926 | number | - | 0<br>5 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.si | 926 | number | - | 0<br>12 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.sj | 926 | number | - | 0<br>3 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.sk | 926 | number | - | 0<br>8 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.sm | 926 | number | - | 0<br>14 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.sy | 926 | number | - | 0<br>7 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.tn | 926 | number | - | 0<br>3 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.tr | 926 | number | - | 0<br>4 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.ua | 926 | number | - | 0<br>9 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.uk | 926 | number | - | 0<br>3 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.us | 926 | number | - | 0<br>15 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.va | 926 | number | - | 0<br>12 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.world | 926 | number | - | 0 |
| ecoscore_data.adjustments.origins_of_ingredients.transportation_values.xk | 926 | number | - | 0<br>4 |
| ecoscore_data.adjustments.origins_of_ingredients.values | 926 | object | - | {"hr":-5,"ps":-5,"al":-5,"uk":-5,"dk":-5,"li":-5,"ad":-5,"at":-5,"es":-5,"sy":-5,"ie":-5,"cy":-5,"sk":-5,"ax":-5,"xk":-5...<br>{"gi":-5,"ma":-5,"mc":-5,"hu":-5,"tr":-5,"me":-5,"va":-5,"ba":-5,"sm":-5,"tn":-5,"ee":-5,"no":-5,"is":-5,"sj":-5,"be":-5... |
| ecoscore_data.adjustments.origins_of_ingredients.values.ad | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.al | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.at | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.ax | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.ba | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.be | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.bg | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.ch | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.cy | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.cz | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.de | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.dk | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.dz | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.ee | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.eg | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.es | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.fi | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.fo | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.fr | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.gg | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.gi | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.gr | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.hr | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.hu | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.ie | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.il | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.im | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.is | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.it | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.je | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.lb | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.li | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.lt | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.lu | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.lv | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.ly | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.ma | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.mc | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.md | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.me | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.mk | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.mt | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.nl | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.no | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.pl | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.ps | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.pt | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.ro | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.rs | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.se | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.si | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.sj | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.sk | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.sm | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.sy | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.tn | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.tr | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.ua | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.uk | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.us | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.va | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.world | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.values.xk | 926 | number | - | -5<br>2 |
| ecoscore_data.adjustments.origins_of_ingredients.warning | 909 | string | - | origins_are_100_percent_unknown |
| ecoscore_data.adjustments.packaging | 926 | object | - | {"value":-15,"warning":"packaging_data_missing"}<br>{"non_recyclable_and_non_biodegradable_materials":1,"value":-15,"warning":"packaging_data_missing"} |
| ecoscore_data.adjustments.packaging.non_recyclable_and_non_biodegradable_materials | 229 | number | - | 1<br>0 |
| ecoscore_data.adjustments.packaging.packagings | 43 | array | object | [{"material":"en:plastic","shape":"en:unknown","ecoscore_shape_ratio":1,"non_recyclable_and_non_biodegradable":"maybe","...<br>[{"ecoscore_material_score":0,"shape":"en:pot","material":"en:unknown","ecoscore_shape_ratio":1}] |
| ecoscore_data.adjustments.packaging.packagings[] | 57 | object | - | {"material":"en:plastic","shape":"en:unknown","ecoscore_shape_ratio":1,"non_recyclable_and_non_biodegradable":"maybe","e...<br>{"shape":"en:unknown","ecoscore_material_score":92,"ecoscore_shape_ratio":1,"material":"en:cardboard"} |
| ecoscore_data.adjustments.packaging.packagings[].ecoscore_material_score | 57 | number | - | 0<br>92 |
| ecoscore_data.adjustments.packaging.packagings[].ecoscore_shape_ratio | 57 | number | - | 1<br>0.2 |
| ecoscore_data.adjustments.packaging.packagings[].material | 57 | string | - | en:plastic<br>en:cardboard |
| ecoscore_data.adjustments.packaging.packagings[].material_shape | 3 | string | - | en:pet-1-polyethylene-terephthalate.en:bottle |
| ecoscore_data.adjustments.packaging.packagings[].non_recyclable_and_non_biodegradable | 31 | string | - | maybe<br>no |
| ecoscore_data.adjustments.packaging.packagings[].number_of_units | 3 | number | - | 1<br>2 |
| ecoscore_data.adjustments.packaging.packagings[].shape | 57 | string | - | en:unknown<br>en:pot |
| ecoscore_data.adjustments.packaging.score | 43 | number | - | -8<br>0 |
| ecoscore_data.adjustments.packaging.value | 926 | number | - | -15<br>-11 |
| ecoscore_data.adjustments.packaging.warning | 905 | string | - | packaging_data_missing<br>unspecified_shape |
| ecoscore_data.adjustments.production_system | 926 | object | - | {"value":0,"warning":"no_label","labels":[]}<br>{"value":0,"labels":[],"warning":"no_label"} |
| ecoscore_data.adjustments.production_system.labels | 926 | array | string | []<br>["en:sustainable-seafood-msc"] |
| ecoscore_data.adjustments.production_system.labels[] | 1 | string | - | en:sustainable-seafood-msc |
| ecoscore_data.adjustments.production_system.value | 926 | number | - | 0<br>10 |
| ecoscore_data.adjustments.production_system.warning | 925 | string | - | no_label |
| ecoscore_data.adjustments.threatened_species | 926 | object | - | {}<br>{"value":-10,"ingredient":"en:palm-oil"} |
| ecoscore_data.adjustments.threatened_species.ingredient | 199 | string | - | en:palm-oil |
| ecoscore_data.adjustments.threatened_species.value | 199 | number | - | -10 |
| ecoscore_data.adjustments.threatened_species.warning | 40 | string | - | ingredients_missing |
| ecoscore_data.agribalyse | 887 | object | - | {"co2_processing":0,"agribalyse_proxy_food_code":"18020","name_en":"Tea, brewed, without sugar","co2_distribution":0.000...<br>{"warning":"missing_agribalyse_match"} |
| ecoscore_data.agribalyse.agribalyse_food_code | 171 | string | - | 18020<br>24000 |
| ecoscore_data.agribalyse.agribalyse_proxy_food_code | 123 | string | - | 18020<br>24000 |
| ecoscore_data.agribalyse.co2_agriculture | 173 | number | - | 0.022870449<br>2.3635185 |
| ecoscore_data.agribalyse.co2_consumption | 173 | number | - | 0.0112323<br>0 |
| ecoscore_data.agribalyse.co2_distribution | 173 | number | - | 0.0001567597<br>0.019437894 |
| ecoscore_data.agribalyse.co2_packaging | 173 | number | - | 0.0026323455<br>0.10986902 |
| ecoscore_data.agribalyse.co2_processing | 173 | number | - | 0<br>0.22831584 |
| ecoscore_data.agribalyse.co2_total | 173 | number | - | 0.039161353499999996<br>2.8562304240000005 |
| ecoscore_data.agribalyse.co2_transportation | 173 | number | - | 0.0022694993<br>0.13508917 |
| ecoscore_data.agribalyse.code | 173 | string | - | 18020<br>24000 |
| ecoscore_data.agribalyse.dqr | 173 | string | - | 2.98<br>2.14 |
| ecoscore_data.agribalyse.ef_agriculture | 173 | number | - | 0.0081036052<br>0.27654213 |
| ecoscore_data.agribalyse.ef_consumption | 173 | number | - | 0.0043474982<br>0 |
| ecoscore_data.agribalyse.ef_distribution | 173 | number | - | 0.000044793367<br>0.004789504500000001 |
| ecoscore_data.agribalyse.ef_packaging | 173 | number | - | 0.00021662681<br>0.01090994 |
| ecoscore_data.agribalyse.ef_processing | 173 | number | - | 0<br>0.04151582 |
| ecoscore_data.agribalyse.ef_total | 173 | number | - | 0.012940544857<br>0.3448030585 |
| ecoscore_data.agribalyse.ef_transportation | 173 | number | - | 0.00022802128<br>0.011045664 |
| ecoscore_data.agribalyse.is_beverage | 173 | number | - | 1<br>0 |
| ecoscore_data.agribalyse.name_en | 173 | string | - | Tea, brewed, without sugar<br>Biscuit (cookie) |
| ecoscore_data.agribalyse.name_fr | 173 | string | - | Thé infusé, non sucré<br>Biscuit sec, sans précision |
| ecoscore_data.agribalyse.score | 173 | number | - | 100<br>70 |
| ecoscore_data.agribalyse.version | 173 | string | - | 3.1.1 |
| ecoscore_data.agribalyse.warning | 713 | string | - | missing_agribalyse_match |
| ecoscore_data.ecoscore_not_applicable_for_category | 39 | string | - | en:sodas<br>en:fresh-vegetables |
| ecoscore_data.grade | 173 | string | - | a<br>d |
| ecoscore_data.grades | 173 | object | - | {"il":"a","lt":"a","ro":"a","eg":"a","it":"a","fr":"a","mk":"a","bg":"a","us":"a","gg":"a","im":"a","ch":"a","hr":"a","p...<br>{"ro":"a","il":"a","lt":"a","bg":"a","mk":"a","fr":"a","eg":"a","it":"a","im":"a","us":"a","gg":"a","ch":"a","dk":"a","l... |
| ecoscore_data.grades.ad | 173 | string | - | a<br>d |
| ecoscore_data.grades.al | 173 | string | - | a<br>d |
| ecoscore_data.grades.at | 173 | string | - | a<br>d |
| ecoscore_data.grades.ax | 173 | string | - | a<br>d |
| ecoscore_data.grades.ba | 173 | string | - | a<br>d |
| ecoscore_data.grades.be | 173 | string | - | a<br>d |
| ecoscore_data.grades.bg | 173 | string | - | a<br>d |
| ecoscore_data.grades.ch | 173 | string | - | a<br>d |
| ecoscore_data.grades.cy | 173 | string | - | a<br>d |
| ecoscore_data.grades.cz | 173 | string | - | a<br>d |
| ecoscore_data.grades.de | 173 | string | - | a<br>d |
| ecoscore_data.grades.dk | 173 | string | - | a<br>d |
| ecoscore_data.grades.dz | 173 | string | - | a<br>d |
| ecoscore_data.grades.ee | 173 | string | - | a<br>d |
| ecoscore_data.grades.eg | 173 | string | - | a<br>d |
| ecoscore_data.grades.es | 173 | string | - | a<br>d |
| ecoscore_data.grades.fi | 173 | string | - | a<br>d |
| ecoscore_data.grades.fo | 173 | string | - | a<br>d |
| ecoscore_data.grades.fr | 173 | string | - | a<br>d |
| ecoscore_data.grades.gg | 173 | string | - | a<br>d |
| ecoscore_data.grades.gi | 173 | string | - | a<br>d |
| ecoscore_data.grades.gr | 173 | string | - | a<br>d |
| ecoscore_data.grades.hr | 173 | string | - | a<br>d |
| ecoscore_data.grades.hu | 173 | string | - | a<br>d |
| ecoscore_data.grades.ie | 173 | string | - | a<br>d |
| ecoscore_data.grades.il | 173 | string | - | a<br>d |
| ecoscore_data.grades.im | 173 | string | - | a<br>d |
| ecoscore_data.grades.is | 173 | string | - | a<br>d |
| ecoscore_data.grades.it | 173 | string | - | a<br>d |
| ecoscore_data.grades.je | 173 | string | - | a<br>d |
| ecoscore_data.grades.lb | 173 | string | - | a<br>d |
| ecoscore_data.grades.li | 173 | string | - | a<br>d |
| ecoscore_data.grades.lt | 173 | string | - | a<br>d |
| ecoscore_data.grades.lu | 173 | string | - | a<br>d |
| ecoscore_data.grades.lv | 173 | string | - | a<br>d |
| ecoscore_data.grades.ly | 173 | string | - | a<br>d |
| ecoscore_data.grades.ma | 173 | string | - | a<br>d |
| ecoscore_data.grades.mc | 173 | string | - | a<br>d |
| ecoscore_data.grades.md | 173 | string | - | a<br>d |
| ecoscore_data.grades.me | 173 | string | - | a<br>d |
| ecoscore_data.grades.mk | 173 | string | - | a<br>d |
| ecoscore_data.grades.mt | 173 | string | - | a<br>d |
| ecoscore_data.grades.nl | 173 | string | - | a<br>d |
| ecoscore_data.grades.no | 173 | string | - | a<br>d |
| ecoscore_data.grades.pl | 173 | string | - | a<br>d |
| ecoscore_data.grades.ps | 173 | string | - | a<br>d |
| ecoscore_data.grades.pt | 173 | string | - | a<br>d |
| ecoscore_data.grades.ro | 173 | string | - | a<br>d |
| ecoscore_data.grades.rs | 173 | string | - | a<br>d |
| ecoscore_data.grades.se | 173 | string | - | a<br>d |
| ecoscore_data.grades.si | 173 | string | - | a<br>d |
| ecoscore_data.grades.sj | 173 | string | - | a<br>d |
| ecoscore_data.grades.sk | 173 | string | - | a<br>d |
| ecoscore_data.grades.sm | 173 | string | - | a<br>d |
| ecoscore_data.grades.sy | 173 | string | - | a<br>d |
| ecoscore_data.grades.tn | 173 | string | - | a<br>d |
| ecoscore_data.grades.tr | 173 | string | - | a<br>d |
| ecoscore_data.grades.ua | 173 | string | - | a<br>d |
| ecoscore_data.grades.uk | 173 | string | - | a<br>d |
| ecoscore_data.grades.us | 173 | string | - | a<br>d |
| ecoscore_data.grades.va | 173 | string | - | a<br>d |
| ecoscore_data.grades.world | 173 | string | - | a<br>d |
| ecoscore_data.grades.xk | 173 | string | - | a<br>d |
| ecoscore_data.missing | 926 | object | - | {"labels":1,"packagings":1,"origins":1}<br>{"packagings":1,"labels":1,"origins":1,"categories":1} |
| ecoscore_data.missing_agribalyse_match_warning | 714 | number | - | 1 |
| ecoscore_data.missing_data_warning | 173 | number | - | 1 |
| ecoscore_data.missing_key_data | 883 | number | - | 1 |
| ecoscore_data.missing.agb_category | 560 | number | - | 1 |
| ecoscore_data.missing.categories | 153 | number | - | 1 |
| ecoscore_data.missing.ingredients | 40 | number | - | 1 |
| ecoscore_data.missing.labels | 925 | number | - | 1 |
| ecoscore_data.missing.origins | 909 | number | - | 1 |
| ecoscore_data.missing.packagings | 905 | number | - | 1 |
| ecoscore_data.previous_data | 171 | object | - | {"agribalyse":{"ef_processing":0,"code":"18020","ef_total":0.012977799404000002,"co2_transportation":0.0022748854,"co2_c...<br>{"grade":"b","agribalyse":{"agribalyse_food_code":"18020","ef_distribution":0.000045028964,"co2_processing":0,"name_en":... |
| ecoscore_data.previous_data.agribalyse | 171 | object | - | {"ef_processing":0,"code":"18020","ef_total":0.012977799404000002,"co2_transportation":0.0022748854,"co2_consumption":0....<br>{"agribalyse_food_code":"18020","ef_distribution":0.000045028964,"co2_processing":0,"name_en":"Tea, brewed, without suga... |
| ecoscore_data.previous_data.agribalyse.agribalyse_food_code | 49 | string | - | 18020<br>31003 |
| ecoscore_data.previous_data.agribalyse.agribalyse_proxy_food_code | 105 | string | - | 24000<br>12001 |
| ecoscore_data.previous_data.agribalyse.co2_agriculture | 151 | number | - | 0.023049705<br>3.8424243000000002 |
| ecoscore_data.previous_data.agribalyse.co2_consumption | 151 | number | - | 0.011257129<br>0 |
| ecoscore_data.previous_data.agribalyse.co2_distribution | 151 | number | - | 0.00015708527<br>0.029120657 |
| ecoscore_data.previous_data.agribalyse.co2_packaging | 151 | number | - | 0.0026356466<br>0.10869536 |
| ecoscore_data.previous_data.agribalyse.co2_processing | 151 | number | - | 0<br>0.32913764 |
| ecoscore_data.previous_data.agribalyse.co2_total | 151 | number | - | 0.03937445127<br>4.4447267 |
| ecoscore_data.previous_data.agribalyse.co2_transportation | 151 | number | - | 0.0022748854<br>0.135384 |
| ecoscore_data.previous_data.agribalyse.code | 151 | string | - | 18020<br>24000 |
| ecoscore_data.previous_data.agribalyse.dqr | 151 | string | - | 2.98<br>2.14 |
| ecoscore_data.previous_data.agribalyse.ef_agriculture | 151 | number | - | 0.008117486<br>0.3606135399999999 |
| ecoscore_data.previous_data.agribalyse.ef_consumption | 151 | number | - | 0.004368421<br>0 |
| ecoscore_data.previous_data.agribalyse.ef_distribution | 151 | number | - | 0.000045028964<br>0.0098990521 |
| ecoscore_data.previous_data.agribalyse.ef_packaging | 151 | number | - | 0.00021776693<br>0.016471127999999998 |
| ecoscore_data.previous_data.agribalyse.ef_processing | 151 | number | - | 0<br>0.051325736 |
| ecoscore_data.previous_data.agribalyse.ef_total | 151 | number | - | 0.012977799404000002<br>0.44895118 |
| ecoscore_data.previous_data.agribalyse.ef_transportation | 151 | number | - | 0.00022909651<br>0.010645482 |
| ecoscore_data.previous_data.agribalyse.is_beverage | 151 | number | - | 1<br>0 |
| ecoscore_data.previous_data.agribalyse.name_en | 151 | string | - | Tea, brewed, without sugar<br>Biscuit (cookie) |
| ecoscore_data.previous_data.agribalyse.name_fr | 151 | string | - | Thé infusé, non sucré<br>Biscuit sec, sans précision |
| ecoscore_data.previous_data.agribalyse.score | 151 | number | - | 100<br>58 |
| ecoscore_data.previous_data.agribalyse.version | 26 | string | - | 3.1 |
| ecoscore_data.previous_data.agribalyse.warning | 20 | string | - | missing_agribalyse_match |
| ecoscore_data.previous_data.grade | 171 | null, string | - | b<br>d |
| ecoscore_data.previous_data.score | 171 | null, number | - | 79<br>28 |
| ecoscore_data.score | 173 | number | - | 80<br>40 |
| ecoscore_data.scores | 173 | object | - | {"hr":80,"ps":80,"al":80,"uk":80,"dk":80,"li":80,"ad":80,"at":80,"es":80,"ie":80,"sy":80,"sk":80,"cy":80,"xk":80,"ax":80...<br>{"al":80,"ps":80,"hr":80,"li":80,"dk":80,"uk":80,"es":80,"at":80,"ad":80,"cy":80,"sk":80,"sy":80,"ie":80,"nl":80,"xk":80... |
| ecoscore_data.scores.ad | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.al | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.at | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.ax | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.ba | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.be | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.bg | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.ch | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.cy | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.cz | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.de | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.dk | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.dz | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.ee | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.eg | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.es | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.fi | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.fo | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.fr | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.gg | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.gi | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.gr | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.hr | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.hu | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.ie | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.il | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.im | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.is | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.it | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.je | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.lb | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.li | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.lt | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.lu | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.lv | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.ly | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.ma | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.mc | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.md | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.me | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.mk | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.mt | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.nl | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.no | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.pl | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.ps | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.pt | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.ro | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.rs | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.se | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.si | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.sj | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.sk | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.sm | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.sy | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.tn | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.tr | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.ua | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.uk | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.us | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.va | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.world | 173 | number | - | 80<br>40 |
| ecoscore_data.scores.xk | 173 | number | - | 80<br>40 |
| ecoscore_data.status | 926 | string | - | known<br>unknown |
| ecoscore_extended_data.error | 15 | string | - | Exception: estimation process timed out after 600 seconds<br>Exception: estimation queue read: Exception: estimation process got exception: NoCharacterizedIngredientsError:  |
| ecoscore_extended_data.impact | 102 | object | - | {"uncharacterized_ingredients_mass_proportion":{"impact":0.3758411911482487,"nutrition":0.016398179888794433},"likeliest...<br>{"likeliest_recipe":{"en:water":4.517731404409833,"en:sesame_oil":93.39084078290311},"likeliest_impacts":{"Climate_chang... |
| ecoscore_extended_data.impact.average_total_used_mass | 6 | number | - | 100.6683596837593<br>105.64182059892234 |
| ecoscore_extended_data.impact.calculation_time | 6 | number | - | 38.466102600097656<br>37.423117876052856 |
| ecoscore_extended_data.impact.confidence_score_distribution | 6 | array | number | [7.090745774748977,3.9560095176114927,6.650909737798823,2.73058651086092,7.4900361449374815,6.13034467480933,7.374921390...<br>[2.879782416056636,5.239642428973405,4.746901482716975,1.695219665555849,2.4181388186577384,7.6511752303798595,5.5352622... |
| ecoscore_extended_data.impact.confidence_score_distribution[] | 196 | number | - | 7.090745774748977<br>3.9560095176114927 |
| ecoscore_extended_data.impact.const_relax_coef | 6 | number | - | 0<br>0.05 |
| ecoscore_extended_data.impact.data_sources | 6 | object | - | {"en:e415":{"nutrition":[{"database":"manual sources","entry":"http://www.peaks-freefrom.com/fr/produits/gomme-xanthane/...<br>{"en:water":{"nutrition":[{"entry":"Water, municipal","database":"ciqual"}],"environmental_impact":[{"entry":"Water, mun... |
| ecoscore_extended_data.impact.data_sources.en:celery_seed | 1 | object | - | {"nutrition":[{"entry":"Spices, celery seed","database":"fcen"}]} |
| ecoscore_extended_data.impact.data_sources.en:celery_seed.nutrition | 1 | array | object | [{"entry":"Spices, celery seed","database":"fcen"}] |
| ecoscore_extended_data.impact.data_sources.en:celery_seed.nutrition[] | 1 | object | - | {"entry":"Spices, celery seed","database":"fcen"} |
| ecoscore_extended_data.impact.data_sources.en:cream | 1 | object | - | {"nutrition":[{"database":"ciqual","entry":"Liquid cream 30% fat, UHT"},{"entry":"Thick cream 30% fat, refrigerated","da... |
| ecoscore_extended_data.impact.data_sources.en:cream.environmental_impact | 1 | array | object | [{"database":"agribalyse","entry":"Thick cream 30% fat, refrigerated"},{"entry":"Liquid cream 30% fat, UHT","database":"... |
| ecoscore_extended_data.impact.data_sources.en:cream.environmental_impact[] | 3 | object | - | {"database":"agribalyse","entry":"Thick cream 30% fat, refrigerated"}<br>{"entry":"Liquid cream 30% fat, UHT","database":"agribalyse"} |
| ecoscore_extended_data.impact.data_sources.en:cream.nutrition | 1 | array | object | [{"database":"ciqual","entry":"Liquid cream 30% fat, UHT"},{"entry":"Thick cream 30% fat, refrigerated","database":"ciqu... |
| ecoscore_extended_data.impact.data_sources.en:cream.nutrition[] | 3 | object | - | {"database":"ciqual","entry":"Liquid cream 30% fat, UHT"}<br>{"entry":"Thick cream 30% fat, refrigerated","database":"ciqual"} |
| ecoscore_extended_data.impact.data_sources.en:cucumber | 2 | object | - | {"environmental_impact":[{"entry":"Cucumber, pulp and peel, raw","database":"agribalyse"},{"entry":"Cucumber, pulp, raw"...<br>{"nutrition":[{"entry":"Cucumber, pulp and peel, raw","database":"ciqual"},{"database":"ciqual","entry":"Cucumber, pulp,... |
| ecoscore_extended_data.impact.data_sources.en:cucumber.environmental_impact | 2 | array | object | [{"entry":"Cucumber, pulp and peel, raw","database":"agribalyse"},{"entry":"Cucumber, pulp, raw","database":"agribalyse"...<br>[{"database":"agribalyse","entry":"Cucumber, pulp and peel, raw"},{"entry":"Cucumber, pulp, raw","database":"agribalyse"... |
| ecoscore_extended_data.impact.data_sources.en:cucumber.environmental_impact[] | 4 | object | - | {"entry":"Cucumber, pulp and peel, raw","database":"agribalyse"}<br>{"entry":"Cucumber, pulp, raw","database":"agribalyse"} |
| ecoscore_extended_data.impact.data_sources.en:cucumber.nutrition | 2 | array | object | [{"entry":"Cucumber, pulp and peel, raw","database":"ciqual"},{"database":"ciqual","entry":"Cucumber, pulp, raw"}] |
| ecoscore_extended_data.impact.data_sources.en:cucumber.nutrition[] | 4 | object | - | {"entry":"Cucumber, pulp and peel, raw","database":"ciqual"}<br>{"database":"ciqual","entry":"Cucumber, pulp, raw"} |
| ecoscore_extended_data.impact.data_sources.en:e202 | 1 | object | - | {"nutrition":[{"entry":"Manual entry","database":"manual sources"}]} |
| ecoscore_extended_data.impact.data_sources.en:e202.nutrition | 1 | array | object | [{"entry":"Manual entry","database":"manual sources"}] |
| ecoscore_extended_data.impact.data_sources.en:e202.nutrition[] | 1 | object | - | {"entry":"Manual entry","database":"manual sources"} |
| ecoscore_extended_data.impact.data_sources.en:e211 | 2 | object | - | {"nutrition":[{"database":"manual sources","entry":"Manual entry"}]} |
| ecoscore_extended_data.impact.data_sources.en:e211.nutrition | 2 | array | object | [{"database":"manual sources","entry":"Manual entry"}] |
| ecoscore_extended_data.impact.data_sources.en:e211.nutrition[] | 2 | object | - | {"database":"manual sources","entry":"Manual entry"} |
| ecoscore_extended_data.impact.data_sources.en:e270 | 1 | object | - | {"nutrition":[{"entry":"Manual entry","database":"manual sources"}]} |
| ecoscore_extended_data.impact.data_sources.en:e270.nutrition | 1 | array | object | [{"entry":"Manual entry","database":"manual sources"}] |
| ecoscore_extended_data.impact.data_sources.en:e270.nutrition[] | 1 | object | - | {"entry":"Manual entry","database":"manual sources"} |
| ecoscore_extended_data.impact.data_sources.en:e330 | 1 | object | - | {"nutrition":[{"entry":"Manual entry","database":"manual sources"}]} |
| ecoscore_extended_data.impact.data_sources.en:e330.nutrition | 1 | array | object | [{"entry":"Manual entry","database":"manual sources"}] |
| ecoscore_extended_data.impact.data_sources.en:e330.nutrition[] | 1 | object | - | {"entry":"Manual entry","database":"manual sources"} |
| ecoscore_extended_data.impact.data_sources.en:e415 | 2 | object | - | {"nutrition":[{"database":"manual sources","entry":"http://www.peaks-freefrom.com/fr/produits/gomme-xanthane/"}]}<br>{"nutrition":[{"entry":"http://www.peaks-freefrom.com/fr/produits/gomme-xanthane/","database":"manual sources"}]} |
| ecoscore_extended_data.impact.data_sources.en:e415.nutrition | 2 | array | object | [{"database":"manual sources","entry":"http://www.peaks-freefrom.com/fr/produits/gomme-xanthane/"}]<br>[{"entry":"http://www.peaks-freefrom.com/fr/produits/gomme-xanthane/","database":"manual sources"}] |
| ecoscore_extended_data.impact.data_sources.en:e415.nutrition[] | 2 | object | - | {"database":"manual sources","entry":"http://www.peaks-freefrom.com/fr/produits/gomme-xanthane/"}<br>{"entry":"http://www.peaks-freefrom.com/fr/produits/gomme-xanthane/","database":"manual sources"} |
| ecoscore_extended_data.impact.data_sources.en:e433 | 1 | object | - | {"nutrition":[{"entry":"Vegetable oil (average)","database":"ciqual"}]} |
| ecoscore_extended_data.impact.data_sources.en:e433.nutrition | 1 | array | object | [{"entry":"Vegetable oil (average)","database":"ciqual"}] |
| ecoscore_extended_data.impact.data_sources.en:e433.nutrition[] | 1 | object | - | {"entry":"Vegetable oil (average)","database":"ciqual"} |
| ecoscore_extended_data.impact.data_sources.en:e440a | 1 | object | - | {"nutrition":[{"entry":"Manual entry","database":"manual sources"}]} |
| ecoscore_extended_data.impact.data_sources.en:e440a.nutrition | 1 | array | object | [{"entry":"Manual entry","database":"manual sources"}] |
| ecoscore_extended_data.impact.data_sources.en:e440a.nutrition[] | 1 | object | - | {"entry":"Manual entry","database":"manual sources"} |
| ecoscore_extended_data.impact.data_sources.en:e509 | 2 | object | - | {"nutrition":[{"database":"manual sources","entry":"Manual entry"}]}<br>{"nutrition":[{"entry":"Manual entry","database":"manual sources"}]} |
| ecoscore_extended_data.impact.data_sources.en:e509.nutrition | 2 | array | object | [{"database":"manual sources","entry":"Manual entry"}]<br>[{"entry":"Manual entry","database":"manual sources"}] |
| ecoscore_extended_data.impact.data_sources.en:e509.nutrition[] | 2 | object | - | {"database":"manual sources","entry":"Manual entry"}<br>{"entry":"Manual entry","database":"manual sources"} |
| ecoscore_extended_data.impact.data_sources.en:e572 | 1 | object | - | {"nutrition":[{"entry":"Manual entry","database":"manual sources"}]} |
| ecoscore_extended_data.impact.data_sources.en:e572.nutrition | 1 | array | object | [{"entry":"Manual entry","database":"manual sources"}] |
| ecoscore_extended_data.impact.data_sources.en:e572.nutrition[] | 1 | object | - | {"entry":"Manual entry","database":"manual sources"} |
| ecoscore_extended_data.impact.data_sources.en:e621 | 1 | object | - | {"nutrition":[{"entry":"Manual entry","database":"manual sources"}]} |
| ecoscore_extended_data.impact.data_sources.en:e621.nutrition | 1 | array | object | [{"entry":"Manual entry","database":"manual sources"}] |
| ecoscore_extended_data.impact.data_sources.en:e621.nutrition[] | 1 | object | - | {"entry":"Manual entry","database":"manual sources"} |
| ecoscore_extended_data.impact.data_sources.en:e955 | 1 | object | - | {"nutrition":[{"entry":"https://www.eatthismuch.com/food/nutrition/sucralose,4740/","database":"manual sources"}]} |
| ecoscore_extended_data.impact.data_sources.en:e955.nutrition | 1 | array | object | [{"entry":"https://www.eatthismuch.com/food/nutrition/sucralose,4740/","database":"manual sources"}] |
| ecoscore_extended_data.impact.data_sources.en:e955.nutrition[] | 1 | object | - | {"entry":"https://www.eatthismuch.com/food/nutrition/sucralose,4740/","database":"manual sources"} |
| ecoscore_extended_data.impact.data_sources.en:garlic | 1 | object | - | {"environmental_impact":[{"entry":"Garlic, fresh","database":"agribalyse"}],"nutrition":[{"entry":"Garlic, fresh","datab... |
| ecoscore_extended_data.impact.data_sources.en:garlic.environmental_impact | 1 | array | object | [{"entry":"Garlic, fresh","database":"agribalyse"}] |
| ecoscore_extended_data.impact.data_sources.en:garlic.environmental_impact[] | 1 | object | - | {"entry":"Garlic, fresh","database":"agribalyse"} |
| ecoscore_extended_data.impact.data_sources.en:garlic.nutrition | 1 | array | object | [{"entry":"Garlic, fresh","database":"ciqual"}] |
| ecoscore_extended_data.impact.data_sources.en:garlic.nutrition[] | 1 | object | - | {"entry":"Garlic, fresh","database":"ciqual"} |
| ecoscore_extended_data.impact.data_sources.en:gelling_agent | 1 | object | - | {"nutrition":[{"database":"ciqual","entry":"Gelling agent for jam"}]} |
| ecoscore_extended_data.impact.data_sources.en:gelling_agent.nutrition | 1 | array | object | [{"database":"ciqual","entry":"Gelling agent for jam"}] |
| ecoscore_extended_data.impact.data_sources.en:gelling_agent.nutrition[] | 1 | object | - | {"database":"ciqual","entry":"Gelling agent for jam"} |
| ecoscore_extended_data.impact.data_sources.en:maltodextrins | 1 | object | - | {"nutrition":[{"entry":"https://www.pharma-gdd.com/fr/delical-maltodextridine-350g","database":"manual sources"}]} |
| ecoscore_extended_data.impact.data_sources.en:maltodextrins.nutrition | 1 | array | object | [{"entry":"https://www.pharma-gdd.com/fr/delical-maltodextridine-350g","database":"manual sources"}] |
| ecoscore_extended_data.impact.data_sources.en:maltodextrins.nutrition[] | 1 | object | - | {"entry":"https://www.pharma-gdd.com/fr/delical-maltodextridine-350g","database":"manual sources"} |
| ecoscore_extended_data.impact.data_sources.en:modified_corn_starch | 1 | object | - | {"environmental_impact":[{"entry":"Maize/corn starch","database":"agribalyse"}],"nutrition":[{"database":"ciqual","entry... |
| ecoscore_extended_data.impact.data_sources.en:modified_corn_starch.environmental_impact | 1 | array | object | [{"entry":"Maize/corn starch","database":"agribalyse"}] |
| ecoscore_extended_data.impact.data_sources.en:modified_corn_starch.environmental_impact[] | 1 | object | - | {"entry":"Maize/corn starch","database":"agribalyse"} |
| ecoscore_extended_data.impact.data_sources.en:modified_corn_starch.nutrition | 1 | array | object | [{"database":"ciqual","entry":"Maize/corn starch"}] |
| ecoscore_extended_data.impact.data_sources.en:modified_corn_starch.nutrition[] | 1 | object | - | {"database":"ciqual","entry":"Maize/corn starch"} |
| ecoscore_extended_data.impact.data_sources.en:mustard_seed | 1 | object | - | {"environmental_impact":[{"database":"agribalyse","entry":"Mustard"}],"nutrition":[{"entry":"Spices, mustard seed, yello... |
| ecoscore_extended_data.impact.data_sources.en:mustard_seed.environmental_impact | 1 | array | object | [{"database":"agribalyse","entry":"Mustard"}] |
| ecoscore_extended_data.impact.data_sources.en:mustard_seed.environmental_impact[] | 1 | object | - | {"database":"agribalyse","entry":"Mustard"} |
| ecoscore_extended_data.impact.data_sources.en:mustard_seed.nutrition | 1 | array | object | [{"entry":"Spices, mustard seed, yellow","database":"fcen"}] |
| ecoscore_extended_data.impact.data_sources.en:mustard_seed.nutrition[] | 1 | object | - | {"entry":"Spices, mustard seed, yellow","database":"fcen"} |
| ecoscore_extended_data.impact.data_sources.en:onion | 2 | object | - | {"environmental_impact":[{"entry":"Onion, raw","database":"agribalyse"}],"nutrition":[{"entry":"Onion, raw","database":"...<br>{"nutrition":[{"entry":"Onion, raw","database":"ciqual"}],"environmental_impact":[{"database":"agribalyse","entry":"Onio... |
| ecoscore_extended_data.impact.data_sources.en:onion.environmental_impact | 2 | array | object | [{"entry":"Onion, raw","database":"agribalyse"}]<br>[{"database":"agribalyse","entry":"Onion, raw"}] |
| ecoscore_extended_data.impact.data_sources.en:onion.environmental_impact[] | 2 | object | - | {"entry":"Onion, raw","database":"agribalyse"}<br>{"database":"agribalyse","entry":"Onion, raw"} |
| ecoscore_extended_data.impact.data_sources.en:onion.nutrition | 2 | array | object | [{"entry":"Onion, raw","database":"ciqual"}] |
| ecoscore_extended_data.impact.data_sources.en:onion.nutrition[] | 2 | object | - | {"entry":"Onion, raw","database":"ciqual"} |
| ecoscore_extended_data.impact.data_sources.en:parsley | 1 | object | - | {"environmental_impact":[{"database":"agribalyse","entry":"Parsley, dried"},{"entry":"Parsley, fresh","database":"agriba... |
| ecoscore_extended_data.impact.data_sources.en:parsley.environmental_impact | 1 | array | object | [{"database":"agribalyse","entry":"Parsley, dried"},{"entry":"Parsley, fresh","database":"agribalyse"}] |
| ecoscore_extended_data.impact.data_sources.en:parsley.environmental_impact[] | 2 | object | - | {"database":"agribalyse","entry":"Parsley, dried"}<br>{"entry":"Parsley, fresh","database":"agribalyse"} |
| ecoscore_extended_data.impact.data_sources.en:parsley.nutrition | 1 | array | object | [{"database":"ciqual","entry":"Parsley, dried"},{"database":"ciqual","entry":"Parsley, fresh"}] |
| ecoscore_extended_data.impact.data_sources.en:parsley.nutrition[] | 2 | object | - | {"database":"ciqual","entry":"Parsley, dried"}<br>{"database":"ciqual","entry":"Parsley, fresh"} |
| ecoscore_extended_data.impact.data_sources.en:pasteurized_skimmed_milk | 1 | object | - | {"nutrition":[{"entry":"Milk, skimmed, pasteurised","database":"ciqual"}],"environmental_impact":[{"database":"agribalys... |
| ecoscore_extended_data.impact.data_sources.en:pasteurized_skimmed_milk.environmental_impact | 1 | array | object | [{"database":"agribalyse","entry":"Milk, skimmed, pasteurised"}] |
| ecoscore_extended_data.impact.data_sources.en:pasteurized_skimmed_milk.environmental_impact[] | 1 | object | - | {"database":"agribalyse","entry":"Milk, skimmed, pasteurised"} |
| ecoscore_extended_data.impact.data_sources.en:pasteurized_skimmed_milk.nutrition | 1 | array | object | [{"entry":"Milk, skimmed, pasteurised","database":"ciqual"}] |
| ecoscore_extended_data.impact.data_sources.en:pasteurized_skimmed_milk.nutrition[] | 1 | object | - | {"entry":"Milk, skimmed, pasteurised","database":"ciqual"} |
| ecoscore_extended_data.impact.data_sources.en:raspberry | 1 | object | - | {"environmental_impact":[{"entry":"Raspberry, raw","database":"agribalyse"}],"nutrition":[{"entry":"Raspberry, raw","dat... |
| ecoscore_extended_data.impact.data_sources.en:raspberry.environmental_impact | 1 | array | object | [{"entry":"Raspberry, raw","database":"agribalyse"}] |
| ecoscore_extended_data.impact.data_sources.en:raspberry.environmental_impact[] | 1 | object | - | {"entry":"Raspberry, raw","database":"agribalyse"} |
| ecoscore_extended_data.impact.data_sources.en:raspberry.nutrition | 1 | array | object | [{"entry":"Raspberry, raw","database":"ciqual"}] |
| ecoscore_extended_data.impact.data_sources.en:raspberry.nutrition[] | 1 | object | - | {"entry":"Raspberry, raw","database":"ciqual"} |
| ecoscore_extended_data.impact.data_sources.en:roasted_peanuts | 1 | object | - | {"nutrition":[{"database":"ciqual","entry":"Peanut, dry-grilled, salted"}],"environmental_impact":[{"database":"agribaly... |
| ecoscore_extended_data.impact.data_sources.en:roasted_peanuts.environmental_impact | 1 | array | object | [{"database":"agribalyse","entry":"Peanut, grilled"}] |
| ecoscore_extended_data.impact.data_sources.en:roasted_peanuts.environmental_impact[] | 1 | object | - | {"database":"agribalyse","entry":"Peanut, grilled"} |
| ecoscore_extended_data.impact.data_sources.en:roasted_peanuts.nutrition | 1 | array | object | [{"database":"ciqual","entry":"Peanut, dry-grilled, salted"}] |
| ecoscore_extended_data.impact.data_sources.en:roasted_peanuts.nutrition[] | 1 | object | - | {"database":"ciqual","entry":"Peanut, dry-grilled, salted"} |
| ecoscore_extended_data.impact.data_sources.en:salt | 5 | object | - | {"nutrition":[{"database":"ciqual","entry":"Salt, white (sea, igneous or rock), no enrichment"},{"database":"ciqual","en...<br>{"environmental_impact":[{"database":"agribalyse","entry":"Salt, white, for human consumption (sea, igneous or rock), no... |
| ecoscore_extended_data.impact.data_sources.en:salt.environmental_impact | 5 | array | object | [{"database":"agribalyse","entry":"Salt, white, for human consumption (sea, igneous or rock), no enrichment"},{"database...<br>[{"entry":"Salt, white, for human consumption (sea, igneous or rock), no enrichment","database":"agribalyse"},{"database... |
| ecoscore_extended_data.impact.data_sources.en:salt.environmental_impact[] | 15 | object | - | {"database":"agribalyse","entry":"Salt, white, for human consumption (sea, igneous or rock), no enrichment"}<br>{"database":"agribalyse","entry":"Sea salt, grey, no enrichment"} |
| ecoscore_extended_data.impact.data_sources.en:salt.nutrition | 5 | array | object | [{"database":"ciqual","entry":"Salt, white (sea, igneous or rock), no enrichment"},{"database":"ciqual","entry":"Salt, w...<br>[{"entry":"Salt, white (sea, igneous or rock), no enrichment","database":"ciqual"},{"entry":"Salt, white (sea, igneous o... |
| ecoscore_extended_data.impact.data_sources.en:salt.nutrition[] | 20 | object | - | {"database":"ciqual","entry":"Salt, white (sea, igneous or rock), no enrichment"}<br>{"database":"ciqual","entry":"Salt, white (sea, igneous or rock), iodine added, no other enrichment"} |
| ecoscore_extended_data.impact.data_sources.en:sodium_citrate | 1 | object | - | {"nutrition":[{"database":"manual sources","entry":"Manual entry"}],"environmental_impact":[{"entry":"Sodium bicarbonate... |
| ecoscore_extended_data.impact.data_sources.en:sodium_citrate.environmental_impact | 1 | array | object | [{"entry":"Sodium bicarbonate","database":"agribalyse"}] |
| ecoscore_extended_data.impact.data_sources.en:sodium_citrate.environmental_impact[] | 1 | object | - | {"entry":"Sodium bicarbonate","database":"agribalyse"} |
| ecoscore_extended_data.impact.data_sources.en:sodium_citrate.nutrition | 1 | array | object | [{"database":"manual sources","entry":"Manual entry"}] |
| ecoscore_extended_data.impact.data_sources.en:sodium_citrate.nutrition[] | 1 | object | - | {"database":"manual sources","entry":"Manual entry"} |
| ecoscore_extended_data.impact.data_sources.en:spice | 1 | object | - | {"nutrition":[{"entry":"Spice (average)","database":"ciqual"}],"environmental_impact":[{"database":"agribalyse","entry":... |
| ecoscore_extended_data.impact.data_sources.en:spice.environmental_impact | 1 | array | object | [{"database":"agribalyse","entry":"Mix of 4 spices"}] |
| ecoscore_extended_data.impact.data_sources.en:spice.environmental_impact[] | 1 | object | - | {"database":"agribalyse","entry":"Mix of 4 spices"} |
| ecoscore_extended_data.impact.data_sources.en:spice.nutrition | 1 | array | object | [{"entry":"Spice (average)","database":"ciqual"}] |
| ecoscore_extended_data.impact.data_sources.en:spice.nutrition[] | 1 | object | - | {"entry":"Spice (average)","database":"ciqual"} |
| ecoscore_extended_data.impact.data_sources.en:sugar | 2 | object | - | {"nutrition":[{"entry":"Sugar, white","database":"ciqual"}],"environmental_impact":[{"entry":"Sugar, white","database":"...<br>{"nutrition":[{"database":"ciqual","entry":"Sugar, white"}],"environmental_impact":[{"entry":"Sugar, white","database":"... |
| ecoscore_extended_data.impact.data_sources.en:sugar.environmental_impact | 2 | array | object | [{"entry":"Sugar, white","database":"agribalyse"}] |
| ecoscore_extended_data.impact.data_sources.en:sugar.environmental_impact[] | 2 | object | - | {"entry":"Sugar, white","database":"agribalyse"} |
| ecoscore_extended_data.impact.data_sources.en:sugar.nutrition | 2 | array | object | [{"entry":"Sugar, white","database":"ciqual"}]<br>[{"database":"ciqual","entry":"Sugar, white"}] |
| ecoscore_extended_data.impact.data_sources.en:sugar.nutrition[] | 2 | object | - | {"entry":"Sugar, white","database":"ciqual"}<br>{"database":"ciqual","entry":"Sugar, white"} |
| ecoscore_extended_data.impact.data_sources.en:vinegar | 2 | object | - | {"environmental_impact":[{"database":"agribalyse","entry":"Vinegar"}],"nutrition":[{"entry":"Vinegar","database":"ciqual...<br>{"nutrition":[{"database":"ciqual","entry":"Vinegar"}],"environmental_impact":[{"database":"agribalyse","entry":"Vinegar... |
| ecoscore_extended_data.impact.data_sources.en:vinegar.environmental_impact | 2 | array | object | [{"database":"agribalyse","entry":"Vinegar"}] |
| ecoscore_extended_data.impact.data_sources.en:vinegar.environmental_impact[] | 2 | object | - | {"database":"agribalyse","entry":"Vinegar"} |
| ecoscore_extended_data.impact.data_sources.en:vinegar.nutrition | 2 | array | object | [{"entry":"Vinegar","database":"ciqual"}]<br>[{"database":"ciqual","entry":"Vinegar"}] |
| ecoscore_extended_data.impact.data_sources.en:vinegar.nutrition[] | 2 | object | - | {"entry":"Vinegar","database":"ciqual"}<br>{"database":"ciqual","entry":"Vinegar"} |
| ecoscore_extended_data.impact.data_sources.en:water | 3 | object | - | {"nutrition":[{"database":"ciqual","entry":"Water, municipal"}],"environmental_impact":[{"database":"agribalyse","entry"...<br>{"nutrition":[{"entry":"Water, municipal","database":"ciqual"}],"environmental_impact":[{"entry":"Water, municipal","dat... |
| ecoscore_extended_data.impact.data_sources.en:water.environmental_impact | 3 | array | object | [{"database":"agribalyse","entry":"Water, municipal"}]<br>[{"entry":"Water, municipal","database":"agribalyse"}] |
| ecoscore_extended_data.impact.data_sources.en:water.environmental_impact[] | 3 | object | - | {"database":"agribalyse","entry":"Water, municipal"}<br>{"entry":"Water, municipal","database":"agribalyse"} |
| ecoscore_extended_data.impact.data_sources.en:water.nutrition | 3 | array | object | [{"database":"ciqual","entry":"Water, municipal"}]<br>[{"entry":"Water, municipal","database":"ciqual"}] |
| ecoscore_extended_data.impact.data_sources.en:water.nutrition[] | 3 | object | - | {"database":"ciqual","entry":"Water, municipal"}<br>{"entry":"Water, municipal","database":"ciqual"} |
| ecoscore_extended_data.impact.data_sources.en:whey | 1 | object | - | {"environmental_impact":[{"database":"agribalyse","entry":"Milk, powder, skimmed"}],"nutrition":[{"entry":"Whey, acid, d... |
| ecoscore_extended_data.impact.data_sources.en:whey.environmental_impact | 1 | array | object | [{"database":"agribalyse","entry":"Milk, powder, skimmed"}] |
| ecoscore_extended_data.impact.data_sources.en:whey.environmental_impact[] | 1 | object | - | {"database":"agribalyse","entry":"Milk, powder, skimmed"} |
| ecoscore_extended_data.impact.data_sources.en:whey.nutrition | 1 | array | object | [{"entry":"Whey, acid, dry","database":"fcen"},{"database":"fcen","entry":"Whey, sweet, fluid"},{"entry":"Whey, sweet, d... |
| ecoscore_extended_data.impact.data_sources.en:whey.nutrition[] | 4 | object | - | {"entry":"Whey, acid, dry","database":"fcen"}<br>{"database":"fcen","entry":"Whey, sweet, fluid"} |
| ecoscore_extended_data.impact.ef_single_score_log_stddev | 96 | number | - | 0.22443804565304187<br>0.0027113138044231534 |
| ecoscore_extended_data.impact.ignored_unknown_ingredients | 6 | array | string | ["en:splenda brand","en:and yellow 5"]<br>["en:alum","en:and yellow 5"] |
| ecoscore_extended_data.impact.ignored_unknown_ingredients[] | 5 | string | - | en:splenda brand<br>en:and yellow 5 |
| ecoscore_extended_data.impact.impact_distributions | 6 | object | - | {"EF_single_score":[0.031576561105593884,0.02146056039109761,0.02078606055833765,0.03713516810406299,0.02913925406471245...<br>{"EF_single_score":[0.018467108553427036,0.02897867061476138,0.032578786852503365,0.023362054880732407,0.027328809396722... |
| ecoscore_extended_data.impact.impact_distributions.Climate_change | 6 | array | number | [0.3518532120027658,0.23477006398536832,0.226842896833469,0.420903302306611,0.3260376466248802,0.36330061380507994,0.372...<br>[0.1921709971794408,0.3232856031518413,0.369227035407064,0.26137481139615004,0.2978802416689186,0.3885140203690759,0.335... |
| ecoscore_extended_data.impact.impact_distributions.Climate_change[] | 196 | number | - | 0.3518532120027658<br>0.23477006398536832 |
| ecoscore_extended_data.impact.impact_distributions.EF_single_score | 6 | array | number | [0.031576561105593884,0.02146056039109761,0.02078606055833765,0.03713516810406299,0.02913925406471245,0.0325413520060720...<br>[0.018467108553427036,0.02897867061476138,0.032578786852503365,0.023362054880732407,0.02732880939672224,0.03430387304095... |
| ecoscore_extended_data.impact.impact_distributions.EF_single_score[] | 196 | number | - | 0.031576561105593884<br>0.02146056039109761 |
| ecoscore_extended_data.impact.impacts_geom_means | 6 | object | - | {"EF_single_score":0.027591290865558532,"Climate_change":0.3062863239814801}<br>{"Climate_change":0.32328355899056754,"EF_single_score":0.02890231787457911} |
| ecoscore_extended_data.impact.impacts_geom_means.Climate_change | 6 | number | - | 0.3062863239814801<br>0.32328355899056754 |
| ecoscore_extended_data.impact.impacts_geom_means.EF_single_score | 6 | number | - | 0.027591290865558532<br>0.02890231787457911 |
| ecoscore_extended_data.impact.impacts_geom_stdevs | 6 | object | - | {"Climate_change":1.2768859193796338,"EF_single_score":1.2538141998817278}<br>{"Climate_change":1.2002819155236337,"EF_single_score":1.1856009118889972} |
| ecoscore_extended_data.impact.impacts_geom_stdevs.Climate_change | 6 | number | - | 1.2768859193796338<br>1.2002819155236337 |
| ecoscore_extended_data.impact.impacts_geom_stdevs.EF_single_score | 6 | number | - | 1.2538141998817278<br>1.1856009118889972 |
| ecoscore_extended_data.impact.impacts_quantiles | 6 | object | - | {"EF_single_score":{"0_75":0.03222158457387103,"0_05":0.017487184386112718,"0_25":0.02086613304460631,"0_5":0.0304990348...<br>{"Climate_change":{"0_25":0.27688510993982246,"0_05":0.2527478646978424,"0_75":0.3716813927490795,"0_95":0.4389216751683... |
| ecoscore_extended_data.impact.impacts_quantiles.Climate_change | 6 | object | - | {"0_95":0.3887799511112361,"0_5":0.3403792758405751,"0_25":0.2310479781849264,"0_05":0.1879787836946039,"0_75":0.3626982...<br>{"0_25":0.27688510993982246,"0_05":0.2527478646978424,"0_75":0.3716813927490795,"0_95":0.4389216751683327,"0_5":0.323285... |
| ecoscore_extended_data.impact.impacts_quantiles.Climate_change.0_05 | 6 | number | - | 0.1879787836946039<br>0.2527478646978424 |
| ecoscore_extended_data.impact.impacts_quantiles.Climate_change.0_25 | 6 | number | - | 0.2310479781849264<br>0.27688510993982246 |
| ecoscore_extended_data.impact.impacts_quantiles.Climate_change.0_5 | 6 | number | - | 0.3403792758405751<br>0.3232856031518413 |
| ecoscore_extended_data.impact.impacts_quantiles.Climate_change.0_75 | 6 | number | - | 0.36269827993352494<br>0.3716813927490795 |
| ecoscore_extended_data.impact.impacts_quantiles.Climate_change.0_95 | 6 | number | - | 0.3887799511112361<br>0.4389216751683327 |
| ecoscore_extended_data.impact.impacts_quantiles.EF_single_score | 6 | object | - | {"0_75":0.03222158457387103,"0_05":0.017487184386112718,"0_25":0.02086613304460631,"0_5":0.030499034811453305,"0_95":0.0...<br>{"0_75":0.03286680114606291,"0_05":0.023102167288206885,"0_25":0.024704679964136153,"0_5":0.02897867061476138,"0_95":0.0... |
| ecoscore_extended_data.impact.impacts_quantiles.EF_single_score.0_05 | 6 | number | - | 0.017487184386112718<br>0.023102167288206885 |
| ecoscore_extended_data.impact.impacts_quantiles.EF_single_score.0_25 | 6 | number | - | 0.02086613304460631<br>0.024704679964136153 |
| ecoscore_extended_data.impact.impacts_quantiles.EF_single_score.0_5 | 6 | number | - | 0.030499034811453305<br>0.02897867061476138 |
| ecoscore_extended_data.impact.impacts_quantiles.EF_single_score.0_75 | 6 | number | - | 0.03222158457387103<br>0.03286680114606291 |
| ecoscore_extended_data.impact.impacts_quantiles.EF_single_score.0_95 | 6 | number | - | 0.03462078952734182<br>0.0387281265967684 |
| ecoscore_extended_data.impact.impacts_relative_interquartile | 6 | object | - | {"EF_single_score":0.3723216685204873,"Climate_change":0.38677531534046783}<br>{"Climate_change":0.29322766583185267,"EF_single_score":0.2816596140807465} |
| ecoscore_extended_data.impact.impacts_relative_interquartile.Climate_change | 6 | number | - | 0.38677531534046783<br>0.29322766583185267 |
| ecoscore_extended_data.impact.impacts_relative_interquartile.EF_single_score | 6 | number | - | 0.3723216685204873<br>0.2816596140807465 |
| ecoscore_extended_data.impact.impacts_units | 6 | object | - | {"EF_single_score":"mPt","Climate_change":"kg CO2 eq"} |
| ecoscore_extended_data.impact.impacts_units.Climate_change | 6 | string | - | kg CO2 eq |
| ecoscore_extended_data.impact.impacts_units.EF_single_score | 6 | string | - | mPt |
| ecoscore_extended_data.impact.ingredients_impacts_share | 6 | object | - | {"EF_single_score":{"en:e955":0.000680236840542008,"en:onion":0.002476851939371361,"en:salt":0.0027075552546275104,"en:c...<br>{"Climate_change":{"en:salt":0.0033799501789353323,"en:cucumber":0.9635674513132348,"en:e211":0.0010000000010178482,"en:... |
| ecoscore_extended_data.impact.ingredients_impacts_share.Climate_change | 6 | object | - | {"en:cucumber":0.9628600375811884,"en:e415":0.001114521620074487,"en:e509":0.009341362013407684,"en:e211":0.001000000000...<br>{"en:salt":0.0033799501789353323,"en:cucumber":0.9635674513132348,"en:e211":0.0010000000010178482,"en:e433":0.0013542091... |
| ecoscore_extended_data.impact.ingredients_impacts_share.Climate_change.en:celery_seed | 1 | number | - | 0.012040574177594136 |
| ecoscore_extended_data.impact.ingredients_impacts_share.Climate_change.en:cream | 1 | number | - | 0.011835123922171013 |
| ecoscore_extended_data.impact.ingredients_impacts_share.Climate_change.en:cucumber | 2 | number | - | 0.9628600375811884<br>0.9635674513132348 |
| ecoscore_extended_data.impact.ingredients_impacts_share.Climate_change.en:e202 | 1 | number | - | 0.0005873699267172212 |
| ecoscore_extended_data.impact.ingredients_impacts_share.Climate_change.en:e211 | 2 | number | - | 0.0010000000000000002<br>0.0010000000010178482 |
| ecoscore_extended_data.impact.ingredients_impacts_share.Climate_change.en:e270 | 1 | number | - | 0.011160731763843666 |
| ecoscore_extended_data.impact.ingredients_impacts_share.Climate_change.en:e330 | 1 | number | - | 0.0825547698359706 |
| ecoscore_extended_data.impact.ingredients_impacts_share.Climate_change.en:e407 | 1 | number | - | 0.009236982365343042 |
| ecoscore_extended_data.impact.ingredients_impacts_share.Climate_change.en:e415 | 2 | number | - | 0.001114521620074487<br>0.002799423319586425 |
| ecoscore_extended_data.impact.ingredients_impacts_share.Climate_change.en:e433 | 1 | number | - | 0.0013542091576578851 |
| ecoscore_extended_data.impact.ingredients_impacts_share.Climate_change.en:e440a | 1 | number | - | 0.0393074083560678 |
| ecoscore_extended_data.impact.ingredients_impacts_share.Climate_change.en:e509 | 2 | number | - | 0.009341362013407684<br>0.021431388408057004 |
| ecoscore_extended_data.impact.ingredients_impacts_share.Climate_change.en:e572 | 1 | number | - | 0.006839632438054476 |
| ecoscore_extended_data.impact.ingredients_impacts_share.Climate_change.en:e621 | 1 | number | - | 0.07539636124059346 |
| ecoscore_extended_data.impact.ingredients_impacts_share.Climate_change.en:e955 | 1 | number | - | 0.000680236840542008 |
| ecoscore_extended_data.impact.ingredients_impacts_share.Climate_change.en:garlic | 1 | number | - | 0.010624966726320784 |
| ecoscore_extended_data.impact.ingredients_impacts_share.Climate_change.en:maltodextrins | 1 | number | - | 0.4723155793537462 |
| ecoscore_extended_data.impact.ingredients_impacts_share.Climate_change.en:modified_corn_starch | 1 | number | - | 0.00035260453543945147 |
| ecoscore_extended_data.impact.ingredients_impacts_share.Climate_change.en:mustard_seed | 1 | number | - | 0.0030333809866354153 |
| ecoscore_extended_data.impact.ingredients_impacts_share.Climate_change.en:natural_flavouring | 1 | number | - | 0.001561691086232118 |
| ecoscore_extended_data.impact.ingredients_impacts_share.Climate_change.en:onion | 2 | number | - | 0.000517412928356894<br>0.05468881277709328 |
| ecoscore_extended_data.impact.ingredients_impacts_share.Climate_change.en:parsley | 1 | number | - | 0.03598644757467536 |
| ecoscore_extended_data.impact.ingredients_impacts_share.Climate_change.en:pasteurized_skimmed_milk | 1 | number | - | 0.06929620762717857 |
| ecoscore_extended_data.impact.ingredients_impacts_share.Climate_change.en:raspberry | 1 | number | - | 0.469299160365711 |
| ecoscore_extended_data.impact.ingredients_impacts_share.Climate_change.en:roasted_peanuts | 1 | number | - | 0.9997898545667052 |
| ecoscore_extended_data.impact.ingredients_impacts_share.Climate_change.en:salt | 5 | number | - | 0.0019524984665128429<br>0.0033799501789353323 |
| ecoscore_extended_data.impact.ingredients_impacts_share.Climate_change.en:sodium_citrate | 1 | number | - | 0 |
| ecoscore_extended_data.impact.ingredients_impacts_share.Climate_change.en:spice | 1 | number | - | -0.0010037128708119637 |
| ecoscore_extended_data.impact.ingredients_impacts_share.Climate_change.en:sugar | 2 | number | - | 0.408808422077013<br>0.019281233925368783 |
| ecoscore_extended_data.impact.ingredients_impacts_share.Climate_change.en:vinegar | 2 | number | - | 0.007434643969325345<br>0.007681570639581639 |
| ecoscore_extended_data.impact.ingredients_impacts_share.Climate_change.en:water | 6 | number | - | 0.000025331416363206294<br>0.000023739215282877663 |
| ecoscore_extended_data.impact.ingredients_impacts_share.Climate_change.en:whey | 1 | number | - | 0.903621234284587 |
| ecoscore_extended_data.impact.ingredients_impacts_share.EF_single_score | 6 | object | - | {"en:e955":0.000680236840542008,"en:onion":0.002476851939371361,"en:salt":0.0027075552546275104,"en:celery_seed":0.01204...<br>{"en:natural_flavouring":0.001561691086232118,"en:water":2.781986539707983e-7,"en:vinegar":0.027162891700890736,"en:e509... |
| ecoscore_extended_data.impact.ingredients_impacts_share.EF_single_score.en:celery_seed | 1 | number | - | 0.012040574177594136 |
| ecoscore_extended_data.impact.ingredients_impacts_share.EF_single_score.en:cream | 1 | number | - | 0.010888651661869968 |
| ecoscore_extended_data.impact.ingredients_impacts_share.EF_single_score.en:cucumber | 2 | number | - | 0.9350120764208172<br>0.942751933315402 |
| ecoscore_extended_data.impact.ingredients_impacts_share.EF_single_score.en:e202 | 1 | number | - | 0.0005873699267172212 |
| ecoscore_extended_data.impact.ingredients_impacts_share.EF_single_score.en:e211 | 2 | number | - | 0.0010000000000000002<br>0.0010000000010178482 |
| ecoscore_extended_data.impact.ingredients_impacts_share.EF_single_score.en:e270 | 1 | number | - | 0.011160731763843666 |
| ecoscore_extended_data.impact.ingredients_impacts_share.EF_single_score.en:e330 | 1 | number | - | 0.0825547698359706 |
| ecoscore_extended_data.impact.ingredients_impacts_share.EF_single_score.en:e407 | 1 | number | - | 0.009236982365343042 |
| ecoscore_extended_data.impact.ingredients_impacts_share.EF_single_score.en:e415 | 2 | number | - | 0.001114521620074487<br>0.002799423319586425 |
| ecoscore_extended_data.impact.ingredients_impacts_share.EF_single_score.en:e433 | 1 | number | - | 0.0013542091576578851 |
| ecoscore_extended_data.impact.ingredients_impacts_share.EF_single_score.en:e440a | 1 | number | - | 0.0393074083560678 |
| ecoscore_extended_data.impact.ingredients_impacts_share.EF_single_score.en:e509 | 2 | number | - | 0.009341362013407684<br>0.021431388408057004 |
| ecoscore_extended_data.impact.ingredients_impacts_share.EF_single_score.en:e572 | 1 | number | - | 0.006839632438054476 |
| ecoscore_extended_data.impact.ingredients_impacts_share.EF_single_score.en:e621 | 1 | number | - | 0.07539636124059346 |
| ecoscore_extended_data.impact.ingredients_impacts_share.EF_single_score.en:e955 | 1 | number | - | 0.000680236840542008 |
| ecoscore_extended_data.impact.ingredients_impacts_share.EF_single_score.en:garlic | 1 | number | - | 0.028695855986243662 |
| ecoscore_extended_data.impact.ingredients_impacts_share.EF_single_score.en:maltodextrins | 1 | number | - | 0.4723155793537462 |
| ecoscore_extended_data.impact.ingredients_impacts_share.EF_single_score.en:modified_corn_starch | 1 | number | - | 0.0007203846020129114 |
| ecoscore_extended_data.impact.ingredients_impacts_share.EF_single_score.en:mustard_seed | 1 | number | - | 0.009745587223229062 |
| ecoscore_extended_data.impact.ingredients_impacts_share.EF_single_score.en:natural_flavouring | 1 | number | - | 0.001561691086232118 |
| ecoscore_extended_data.impact.ingredients_impacts_share.EF_single_score.en:onion | 2 | number | - | 0.002476851939371361<br>0.10668859435969633 |
| ecoscore_extended_data.impact.ingredients_impacts_share.EF_single_score.en:parsley | 1 | number | - | 0.043408210726861365 |
| ecoscore_extended_data.impact.ingredients_impacts_share.EF_single_score.en:pasteurized_skimmed_milk | 1 | number | - | 0.06749371020253747 |
| ecoscore_extended_data.impact.ingredients_impacts_share.EF_single_score.en:raspberry | 1 | number | - | 0.652224430518821 |
| ecoscore_extended_data.impact.ingredients_impacts_share.EF_single_score.en:roasted_peanuts | 1 | number | - | 0.999811752808502 |
| ecoscore_extended_data.impact.ingredients_impacts_share.EF_single_score.en:salt | 5 | number | - | 0.0027075552546275104<br>0.004737608132087967 |
| ecoscore_extended_data.impact.ingredients_impacts_share.EF_single_score.en:sodium_citrate | 1 | number | - | 0 |
| ecoscore_extended_data.impact.ingredients_impacts_share.EF_single_score.en:spice | 1 | number | - | 0.03245907648213598 |
| ecoscore_extended_data.impact.ingredients_impacts_share.EF_single_score.en:sugar | 2 | number | - | 0.225913332230229<br>0.02649335884663446 |
| ecoscore_extended_data.impact.ingredients_impacts_share.EF_single_score.en:vinegar | 2 | number | - | 0.02588094188452657<br>0.027162891700890736 |
| ecoscore_extended_data.impact.ingredients_impacts_share.EF_single_score.en:water | 6 | number | - | 2.9262581023531315e-7<br>2.781986539707983e-7 |
| ecoscore_extended_data.impact.ingredients_impacts_share.EF_single_score.en:whey | 1 | number | - | 0.9058955812238224 |
| ecoscore_extended_data.impact.ingredients_mass_share | 6 | object | - | {"en:vinegar":0.08452377930139156,"en:celery_seed":0.01204057417759414,"en:water":0.1780572289674376,"en:mustard_seed":0...<br>{"en:natural_flavouring":0.0015616910862321185,"en:water":0.1812684931249071,"en:e433":0.0013542091576578851,"en:e211":0... |
| ecoscore_extended_data.impact.ingredients_mass_share.en:celery_seed | 1 | number | - | 0.01204057417759414 |
| ecoscore_extended_data.impact.ingredients_mass_share.en:cream | 1 | number | - | 0.02400815396256553 |
| ecoscore_extended_data.impact.ingredients_mass_share.en:cucumber | 2 | number | - | 0.6651908835223781<br>0.6661617045330014 |
| ecoscore_extended_data.impact.ingredients_mass_share.en:e202 | 1 | number | - | 0.0005873699267172211 |
| ecoscore_extended_data.impact.ingredients_mass_share.en:e211 | 2 | number | - | 0.0010000000000000002<br>0.0010000000010178486 |
| ecoscore_extended_data.impact.ingredients_mass_share.en:e270 | 1 | number | - | 0.011160731763843666 |
| ecoscore_extended_data.impact.ingredients_mass_share.en:e330 | 1 | number | - | 0.0825547698359707 |
| ecoscore_extended_data.impact.ingredients_mass_share.en:e407 | 1 | number | - | 0.009236982365343042 |
| ecoscore_extended_data.impact.ingredients_mass_share.en:e415 | 2 | number | - | 0.0011145216200744877<br>0.002799423319586425 |
| ecoscore_extended_data.impact.ingredients_mass_share.en:e433 | 1 | number | - | 0.0013542091576578851 |
| ecoscore_extended_data.impact.ingredients_mass_share.en:e440a | 1 | number | - | 0.0393074083560678 |
| ecoscore_extended_data.impact.ingredients_mass_share.en:e509 | 2 | number | - | 0.009341362013407684<br>0.021431388408057004 |
| ecoscore_extended_data.impact.ingredients_mass_share.en:e572 | 1 | number | - | 0.006839632438054473 |
| ecoscore_extended_data.impact.ingredients_mass_share.en:e621 | 1 | number | - | 0.07539636124059344 |
| ecoscore_extended_data.impact.ingredients_mass_share.en:e955 | 1 | number | - | 0.0006802368405420081 |
| ecoscore_extended_data.impact.ingredients_mass_share.en:garlic | 1 | number | - | 0.032318913170760376 |
| ecoscore_extended_data.impact.ingredients_mass_share.en:maltodextrins | 1 | number | - | 0.4723155793537462 |
| ecoscore_extended_data.impact.ingredients_mass_share.en:modified_corn_starch | 1 | number | - | 0.004095858960512154 |
| ecoscore_extended_data.impact.ingredients_mass_share.en:mustard_seed | 1 | number | - | 0.015184631576639645 |
| ecoscore_extended_data.impact.ingredients_mass_share.en:natural_flavouring | 1 | number | - | 0.0015616910862321185 |
| ecoscore_extended_data.impact.ingredients_mass_share.en:onion | 2 | number | - | 0.014493155551133906<br>0.10332044571548056 |
| ecoscore_extended_data.impact.ingredients_mass_share.en:parsley | 1 | number | - | 0.025004344518290995 |
| ecoscore_extended_data.impact.ingredients_mass_share.en:pasteurized_skimmed_milk | 1 | number | - | 0.33139294550325316 |
| ecoscore_extended_data.impact.ingredients_mass_share.en:raspberry | 1 | number | - | 0.33924804157433 |
| ecoscore_extended_data.impact.ingredients_mass_share.en:roasted_peanuts | 1 | number | - | 0.9742066617306284 |
| ecoscore_extended_data.impact.ingredients_mass_share.en:salt | 5 | number | - | 0.018373626429400956<br>0.0321390568960188 |
| ecoscore_extended_data.impact.ingredients_mass_share.en:sodium_citrate | 1 | number | - | 0.0504317132155239 |
| ecoscore_extended_data.impact.ingredients_mass_share.en:spice | 1 | number | - | 0.01151945145571205 |
| ecoscore_extended_data.impact.ingredients_mass_share.en:sugar | 2 | number | - | 0.45852736667716<br>0.01310299748547367 |
| ecoscore_extended_data.impact.ingredients_mass_share.en:vinegar | 2 | number | - | 0.08452377930139156<br>0.09508345679310756 |
| ecoscore_extended_data.impact.ingredients_mass_share.en:water | 6 | number | - | 0.1780572289674376<br>0.1812684931249071 |
| ecoscore_extended_data.impact.ingredients_mass_share.en:whey | 1 | number | - | 0.3071794210556125 |
| ecoscore_extended_data.impact.likeliest_impacts | 96 | object | - | {"EF_single_score":0.009281193252925124,"Climate_change":0.10527864025335862}<br>{"Climate_change":0.1434048593888307,"EF_single_score":0.039997318003765665} |
| ecoscore_extended_data.impact.likeliest_impacts.Climate_change | 96 | number | - | 0.10527864025335862<br>0.1434048593888307 |
| ecoscore_extended_data.impact.likeliest_impacts.EF_single_score | 96 | number | - | 0.009281193252925124<br>0.039997318003765665 |
| ecoscore_extended_data.impact.likeliest_recipe | 96 | object | - | {"en:e202":0.17658574070910332,"en:e282":0.3008894369878989,"en:enzyme":0.5640899377572764,"en:e521":0.23420482990362135...<br>{"en:water":4.517731404409833,"en:sesame_oil":93.39084078290311} |
| ecoscore_extended_data.impact.likeliest_recipe.en:acerola | 1 | number | - | 3.138355576572228 |
| ecoscore_extended_data.impact.likeliest_recipe.en:aged_over_60_days | 1 | number | - | 11.640196757218938 |
| ecoscore_extended_data.impact.likeliest_recipe.en:almond | 3 | number | - | 89.27462551387279<br>14.8465512199491 |
| ecoscore_extended_data.impact.likeliest_recipe.en:and_caffeine | 1 | number | - | 0.4809174276744846 |
| ecoscore_extended_data.impact.likeliest_recipe.en:and_safflower_oil | 1 | number | - | 1.2190642456651626 |
| ecoscore_extended_data.impact.likeliest_recipe.en:and_salt | 3 | number | - | 0.0174660967470466<br>0.15001827341290894 |
| ecoscore_extended_data.impact.likeliest_recipe.en:and_sunflower_oil | 2 | number | - | 0.13706243483756<br>1.9716809951199992 |
| ecoscore_extended_data.impact.likeliest_recipe.en:and_yellow_5 | 4 | number | - | 0.03918629297611364<br>0 |
| ecoscore_extended_data.impact.likeliest_recipe.en:anhydrous_dextrose | 1 | number | - | 12.896770426548887 |
| ecoscore_extended_data.impact.likeliest_recipe.en:apple | 1 | number | - | 2.377553008223832 |
| ecoscore_extended_data.impact.likeliest_recipe.en:artificial_flavouring | 10 | number | - | 1.7035875488565964<br>0.3611978682761164 |
| ecoscore_extended_data.impact.likeliest_recipe.en:autolyzed_yeast_extract | 2 | number | - | 0.326770381448611<br>1.4762042055758444 |
| ecoscore_extended_data.impact.likeliest_recipe.en:barley_malt_flour | 1 | number | - | 1.5945612841359884 |
| ecoscore_extended_data.impact.likeliest_recipe.en:beef | 1 | number | - | 99.01238392838732 |
| ecoscore_extended_data.impact.likeliest_recipe.en:beetroot_juice_concentrate | 1 | number | - | 2.362262715435439 |
| ecoscore_extended_data.impact.likeliest_recipe.en:blackcurrant | 1 | number | - | 30.944689443021545 |
| ecoscore_extended_data.impact.likeliest_recipe.en:blueberry | 1 | number | - | 94.52734409373302 |
| ecoscore_extended_data.impact.likeliest_recipe.en:brazil_nut | 1 | number | - | 10.2152183189579 |
| ecoscore_extended_data.impact.likeliest_recipe.en:broccoli | 1 | number | - | 20.898167752381113 |
| ecoscore_extended_data.impact.likeliest_recipe.en:brown_sugar | 1 | number | - | 5.2452040302348175 |
| ecoscore_extended_data.impact.likeliest_recipe.en:buttermilk | 1 | number | - | 3.349539183149218 |
| ecoscore_extended_data.impact.likeliest_recipe.en:butteroil | 4 | number | - | 0<br>0.8334942024739 |
| ecoscore_extended_data.impact.likeliest_recipe.en:butterroil | 1 | number | - | 0.10714074449859702 |
| ecoscore_extended_data.impact.likeliest_recipe.en:carbonated_water | 3 | number | - | 18.56342367277908<br>99.24728457128991 |
| ecoscore_extended_data.impact.likeliest_recipe.en:carraceenan | 1 | number | - | 0.0284812311733204 |
| ecoscore_extended_data.impact.likeliest_recipe.en:carrot | 1 | number | - | 24.87877113378704 |
| ecoscore_extended_data.impact.likeliest_recipe.en:cashew_nuts | 1 | number | - | 56.807488076286 |
| ecoscore_extended_data.impact.likeliest_recipe.en:celery | 1 | number | - | 0.9106064076056284 |
| ecoscore_extended_data.impact.likeliest_recipe.en:celllulose_gel | 1 | number | - | 1.7588790893795625 |
| ecoscore_extended_data.impact.likeliest_recipe.en:cellulose_gel | 5 | number | - | 4.008830284710049<br>0.28823497192298503 |
| ecoscore_extended_data.impact.likeliest_recipe.en:chicken_fat | 1 | number | - | 1.0395425969444219 |
| ecoscore_extended_data.impact.likeliest_recipe.en:chili_pepper | 1 | number | - | 16.9637772163822 |
| ecoscore_extended_data.impact.likeliest_recipe.en:choco_chip | 1 | number | - | 1.6199353306208648 |
| ecoscore_extended_data.impact.likeliest_recipe.en:chocolate | 9 | number | - | 38.44485253775173<br>23.51799764130897 |
| ecoscore_extended_data.impact.likeliest_recipe.en:chocolate_peanut_butter_cup | 1 | number | - | 0.1767118368840458 |
| ecoscore_extended_data.impact.likeliest_recipe.en:chocolate_swirl | 2 | number | - | 0.176711836884046<br>2.9526561440799304 |
| ecoscore_extended_data.impact.likeliest_recipe.en:cholecalciferol | 3 | number | - | 0.12515090623807568<br>0.4242013688978307 |
| ecoscore_extended_data.impact.likeliest_recipe.en:cider_vinegar | 1 | number | - | 5.877860161620531 |
| ecoscore_extended_data.impact.likeliest_recipe.en:cinnamon | 1 | number | - | 2.0317746784583224 |
| ecoscore_extended_data.impact.likeliest_recipe.en:cocoa | 3 | number | - | 1.03684356301638<br>4.44378204671096 |
| ecoscore_extended_data.impact.likeliest_recipe.en:cocoa_butter | 17 | number | - | 12.997476210003859<br>23.51799764130897 |
| ecoscore_extended_data.impact.likeliest_recipe.en:cocoa_paste | 6 | number | - | 10.361244852578741<br>0.3556769297223212 |
| ecoscore_extended_data.impact.likeliest_recipe.en:cocoa_processed_with_alkali | 5 | number | - | 1.917764984994655<br>0.3534236737680923 |
| ecoscore_extended_data.impact.likeliest_recipe.en:coconut | 9 | number | - | 46.109004825438205<br>14.533543501445711 |
| ecoscore_extended_data.impact.likeliest_recipe.en:coconut__defatted_cocoa_powder | 1 | number | - | 0.21870157912215543 |
| ecoscore_extended_data.impact.likeliest_recipe.en:coconut_oil | 6 | number | - | 8.7686424497784<br>15.936693026975242 |
| ecoscore_extended_data.impact.likeliest_recipe.en:colour | 18 | number | - | 0.019187042668012865<br>0 |
| ecoscore_extended_data.impact.likeliest_recipe.en:colza_oil | 1 | number | - | 6.4433547925926975 |
| ecoscore_extended_data.impact.likeliest_recipe.en:confectioner_s_glaze | 1 | number | - | 0.8731228206531162 |
| ecoscore_extended_data.impact.likeliest_recipe.en:contains_2__and_less_of | 6 | number | - | 4.44378204671096<br>0.31815717395799836 |
| ecoscore_extended_data.impact.likeliest_recipe.en:contains_2__and_less_of_oat_bran | 1 | number | - | 1.2191825409357464 |
| ecoscore_extended_data.impact.likeliest_recipe.en:corn | 2 | number | - | 8.84474449024929<br>119.86931498146019 |
| ecoscore_extended_data.impact.likeliest_recipe.en:corn_oil | 1 | number | - | 21.4480464595233 |
| ecoscore_extended_data.impact.likeliest_recipe.en:corn_starch | 9 | number | - | 0.17658574070910332<br>1.924583923229287 |
| ecoscore_extended_data.impact.likeliest_recipe.en:corn_syrup | 9 | number | - | 43.81644122172438<br>8.844641174024218 |
| ecoscore_extended_data.impact.likeliest_recipe.en:corn_syrup_solids | 1 | number | - | 0.0022808279770124952 |
| ecoscore_extended_data.impact.likeliest_recipe.en:cottonseed | 5 | number | - | 0.834229081696407<br>1.738532220048979 |
| ecoscore_extended_data.impact.likeliest_recipe.en:cracked_black_pepper | 1 | number | - | 0.0708994346600127 |
| ecoscore_extended_data.impact.likeliest_recipe.en:cream | 11 | number | - | 0.10774439785808766<br>3.850541623822963 |
| ecoscore_extended_data.impact.likeliest_recipe.en:crushed_tomato | 2 | number | - | 15.617997023844195<br>7.520234206388162 |
| ecoscore_extended_data.impact.likeliest_recipe.en:cucumber | 6 | number | - | 81.53721334716718<br>38.79167338221619 |
| ecoscore_extended_data.impact.likeliest_recipe.en:cultured_cream | 3 | number | - | 41.65002530823509<br>1.76621169221954 |
| ecoscore_extended_data.impact.likeliest_recipe.en:Cultured_cream_and_skim_milk | 1 | number | - | 35.675868247502805 |
| ecoscore_extended_data.impact.likeliest_recipe.en:cultured_dextrose | 4 | number | - | 0.0798803739906464<br>0.0284812311733176 |
| ecoscore_extended_data.impact.likeliest_recipe.en:Cultured_skim_milk | 1 | number | - | 42.779743594273576 |
| ecoscore_extended_data.impact.likeliest_recipe.en:cultured_skin_milk | 1 | number | - | 95.211783955347 |
| ecoscore_extended_data.impact.likeliest_recipe.en:dehydrated_onion | 5 | number | - | 0.219583580359271<br>3.2423164000457763 |
| ecoscore_extended_data.impact.likeliest_recipe.en:dextrose | 8 | number | - | 0.6672324015316184<br>0.44651703531784614 |
| ecoscore_extended_data.impact.likeliest_recipe.en:diced_tomatoes_in_tomato_juice | 2 | number | - | 20.74389046383028<br>24.63062490711563 |
| ecoscore_extended_data.impact.likeliest_recipe.en:distilled_vinegar | 2 | number | - | 1.4583020017540804<br>30.828315721502776 |
| ecoscore_extended_data.impact.likeliest_recipe.en:dried | 1 | number | - | 0.5562934874108538 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e101 | 6 | number | - | 3.5079911028699247<br>0.10725664187672124 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e102 | 3 | number | - | 2.0456249878728303<br>0.5357122477165255 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e110 | 4 | number | - | 2.0942814768003526<br>4.294898322014551 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e1200 | 2 | number | - | 4.008830284708669<br>2.8235301556276386 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e129 | 5 | number | - | 1.9890207728952292<br>1.7264552506589446 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e133 | 5 | number | - | 1.9890207728952292<br>0.6800824902920304 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e1400 | 1 | number | - | 3.1471038940143092 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e150a | 5 | number | - | 17.77580174711409<br>1.2818384560940501 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e160b | 1 | number | - | 0.4940137000174285 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e170i | 2 | number | - | 0.0669215008077465<br>0.1182646083892908 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e200 | 2 | number | - | 0.0798803739906464<br>0.0284812311733052 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e202 | 3 | number | - | 0.17658574070910332<br>0.04116532033054691 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e211 | 8 | number | - | 0.10032749081198876<br>0.10028053282114864 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e212 | 2 | number | - | 13.586014387348103<br>0.04424917032910261 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e220 | 1 | number | - | 1.9681865500313003 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e223 | 1 | number | - | 0.0875103520343528 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e224 | 1 | number | - | 0.0905461771463352 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e235 | 3 | number | - | 3.0095474981445<br>0.4124636378902349 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e270 | 1 | number | - | 1.9266528565014784 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e282 | 3 | number | - | 0.3008894369878989<br>0.15535084068584448 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e296 | 5 | number | - | 3.139156683439096<br>15.975395638170793 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e297 | 1 | number | - | 0.17658574070910332 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e300 | 3 | number | - | 2.0942814768007443<br>4.47242169789345 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e321 | 1 | number | - | 0.03874177765336056 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e330 | 13 | number | - | 3.138355576572228<br>0.0537675520530814 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e332ii | 2 | number | - | 7.495191198349845<br>0.07371788416584704 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e333 | 1 | number | - | 0 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e334 | 2 | number | - | 3.1471038940143092<br>5.3678713422433795 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e338 | 1 | number | - | 15.277696521923168 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e339 | 2 | number | - | 0.08583785823606808<br>5.039712753384186 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e341i | 1 | number | - | 0.043619118143234194 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e375 | 7 | number | - | 3.507991102869903<br>1.1371482249534584 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e385 | 1 | number | - | 0.34539906408340604 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e407 | 11 | number | - | 0.04673327537866148<br>0.6063910075244777 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e410 | 11 | number | - | 0.37854149688095445<br>0.07988037399064635 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e412 | 11 | number | - | 2.697668036301495<br>0.0798803739906464 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e414 | 2 | number | - | 3.1471038940146743<br>4.862924328773772 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e415 | 2 | number | - | 0.0875103520343528<br>0.6837450137399245 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e420 | 1 | number | - | 0.1767118368840458 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e422 | 4 | number | - | 6.424085032799196<br>14.406612468222555 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e428 | 3 | number | - | 2.289057302280981<br>0.08583785823636973 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e433 | 8 | number | - | 0.03918629297611364<br>0 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e440a | 1 | number | - | 15.070367064195084 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e450 | 1 | number | - | 0.1511857933015507 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e461 | 1 | number | - | 1.0364952741617774 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e466 | 7 | number | - | 0.1765857407091629<br>0.32346573571577364 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e471 | 9 | number | - | 0.6672324015316192<br>1.9927529101160735 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e481 | 1 | number | - | 0.8586883731964953 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e492 | 2 | number | - | 0.18012030412961816<br>4.383740465249553 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e500ii | 6 | number | - | 0.6672324015316192<br>0.15117804532322204 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e503ii | 1 | number | - | 0 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e509 | 8 | number | - | 1.0032487337063256<br>0.2556400411598985 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e516 | 6 | number | - | 0.15535084068584967<br>0.08583785823636923 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e517 | 1 | number | - | 0.15535084068584967 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e521 | 1 | number | - | 0.23420482990362135 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e541 | 1 | number | - | 0.23420482990362135 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e572 | 2 | number | - | 3.139156683439096<br>4.808907207202067 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e621 | 3 | number | - | 0.92893596083697<br>0.16491192183000666 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e627 | 1 | number | - | 0.5562934874108538 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e631 | 1 | number | - | 0.5562934874108538 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e903 | 2 | number | - | 2.9595800667333583<br>2.2813516217615315 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e905a | 1 | number | - | 2.5687713003634216 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e927a | 1 | number | - | 0.12208526691668645 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e950 | 3 | number | - | 5.968771731397781<br>0.07988037399064357 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e951 | 1 | number | - | 9.107159175118467 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e955 | 5 | number | - | 0.022348814916003844<br>0.06962336477033787 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e961 | 1 | number | - | 0 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e965 | 3 | number | - | 14.427316102959749<br>4.185542121594101 |
| ecoscore_extended_data.impact.likeliest_recipe.en:e966 | 1 | number | - | 0.176711836884046 |
| ecoscore_extended_data.impact.likeliest_recipe.en:egg | 1 | number | - | 6.636277581924105 |
| ecoscore_extended_data.impact.likeliest_recipe.en:egg_white | 1 | number | - | 0.44651703531785153 |
| ecoscore_extended_data.impact.likeliest_recipe.en:emulsifier | 12 | number | - | 2.4479143972204036<br>1.6492185228961012 |
| ecoscore_extended_data.impact.likeliest_recipe.en:enzyme | 16 | number | - | 0.5640899377572764<br>0.022348814916003844 |
| ecoscore_extended_data.impact.likeliest_recipe.en:extra_virgin_olive_oil | 1 | number | - | 94.09163620351836 |
| ecoscore_extended_data.impact.likeliest_recipe.en:ferric_orthophosphate | 1 | number | - | 0.40358752890873345 |
| ecoscore_extended_data.impact.likeliest_recipe.en:filberts | 1 | number | - | 2.76240129095641 |
| ecoscore_extended_data.impact.likeliest_recipe.en:folic_acid | 6 | number | - | 0<br>0.08072026426206853 |
| ecoscore_extended_data.impact.likeliest_recipe.en:fresh_yellow_chile | 1 | number | - | 25.2339183856645 |
| ecoscore_extended_data.impact.likeliest_recipe.en:fructose_corn_syrup | 1 | number | - | 16.75636107401369 |
| ecoscore_extended_data.impact.likeliest_recipe.en:fruit_pectin | 2 | number | - | 21.574503717483736<br>19.93933755706834 |
| ecoscore_extended_data.impact.likeliest_recipe.en:fudge_cups | 1 | number | - | 0.7925521762067947 |
| ecoscore_extended_data.impact.likeliest_recipe.en:garlic | 6 | number | - | 0.00302700481751959<br>0.6504363587413471 |
| ecoscore_extended_data.impact.likeliest_recipe.en:garlic_powder | 2 | number | - | 0.06907785431082669<br>0.03085967334250968 |
| ecoscore_extended_data.impact.likeliest_recipe.en:ginger | 1 | number | - | 1.4889267161414128 |
| ecoscore_extended_data.impact.likeliest_recipe.en:glucose_syrup | 1 | number | - | 0.44651703531785153 |
| ecoscore_extended_data.impact.likeliest_recipe.en:grape | 1 | number | - | 30.59748136252435 |
| ecoscore_extended_data.impact.likeliest_recipe.en:grape_juice | 1 | number | - | 0.892241494768132 |
| ecoscore_extended_data.impact.likeliest_recipe.en:green_apple | 1 | number | - | 2.9595800667333583 |
| ecoscore_extended_data.impact.likeliest_recipe.en:green_chili_pepper | 1 | number | - | 46.0203902369488 |
| ecoscore_extended_data.impact.likeliest_recipe.en:ground_vanilla_beans | 1 | number | - | 1.9182244632427168 |
| ecoscore_extended_data.impact.likeliest_recipe.en:guar_and_carob_bean_and_xanthan_gums | 1 | number | - | 8.473781136668945 |
| ecoscore_extended_data.impact.likeliest_recipe.en:hazelnut | 6 | number | - | 20.324708785947017<br>8.30879352573149 |
| ecoscore_extended_data.impact.likeliest_recipe.en:high_fructose_corn_syrup | 10 | number | - | 3.111835724738455<br>4.7251895237136425 |
| ecoscore_extended_data.impact.likeliest_recipe.en:honey | 1 | number | - | 3.111835724742185 |
| ecoscore_extended_data.impact.likeliest_recipe.en:hydrogenated_soy_oil | 1 | number | - | 0 |
| ecoscore_extended_data.impact.likeliest_recipe.en:hydrolyzed_con_protein | 1 | number | - | 1.0487122868981023 |
| ecoscore_extended_data.impact.likeliest_recipe.en:hydrolyzed_soy_and_corn_protein | 1 | number | - | 0.04633482818819251 |
| ecoscore_extended_data.impact.likeliest_recipe.en:ice_cream | 3 | number | - | 13.024840806119078<br>37.72522360420787 |
| ecoscore_extended_data.impact.likeliest_recipe.en:iron | 2 | number | - | 1.137168183586639<br>0.10725664187671868 |
| ecoscore_extended_data.impact.likeliest_recipe.en:jalapeno | 5 | number | - | 0.00302700481751959<br>17.01302934445679 |
| ecoscore_extended_data.impact.likeliest_recipe.en:lactic_ferments | 14 | number | - | 17.341945979797188<br>10.4601441434024 |
| ecoscore_extended_data.impact.likeliest_recipe.en:lactose | 1 | number | - | 1.3976025004395707 |
| ecoscore_extended_data.impact.likeliest_recipe.en:lemon_and_lime_juices_from_concentrate_and_spices | 1 | number | - | 1.0582710885775057 |
| ecoscore_extended_data.impact.likeliest_recipe.en:lemon_juice_concentrate | 1 | number | - | 0.5907474644481665 |
| ecoscore_extended_data.impact.likeliest_recipe.en:less_than_2__corn_starch | 1 | number | - | 0.0798803739906464 |
| ecoscore_extended_data.impact.likeliest_recipe.en:lime | 1 | number | - | 1.4960958066337826 |
| ecoscore_extended_data.impact.likeliest_recipe.en:lowfat_cocoa_powder | 5 | number | - | 0.11909090504991976<br>7.92015265386186 |
| ecoscore_extended_data.impact.likeliest_recipe.en:malted_barley | 8 | number | - | 0.556420966728813<br>0.07516294406424942 |
| ecoscore_extended_data.impact.likeliest_recipe.en:maltodextrin_cream | 1 | number | - | 15.174110808076115 |
| ecoscore_extended_data.impact.likeliest_recipe.en:maltodextrins | 8 | number | - | 5.646838868030456<br>6.218929237178375 |
| ecoscore_extended_data.impact.likeliest_recipe.en:microbial_coagulating_enzyme | 1 | number | - | 7.97681915650913 |
| ecoscore_extended_data.impact.likeliest_recipe.en:milk | 32 | number | - | 3.6379642324141357<br>4.544019677149743 |
| ecoscore_extended_data.impact.likeliest_recipe.en:milkat | 1 | number | - | 1.800495806109381 |
| ecoscore_extended_data.impact.likeliest_recipe.en:milkfat | 7 | number | - | 3.4664313170373244<br>1.7474879796874974 |
| ecoscore_extended_data.impact.likeliest_recipe.en:modified_corn_starch | 5 | number | - | 0.08583785823636973<br>5.451649379458433 |
| ecoscore_extended_data.impact.likeliest_recipe.en:modified_starch | 1 | number | - | 5.378074853638347 |
| ecoscore_extended_data.impact.likeliest_recipe.en:modified_tapioca_starch | 1 | number | - | 0.1767118368840458 |
| ecoscore_extended_data.impact.likeliest_recipe.en:molasses | 3 | number | - | 0.892241494768132<br>4.427633004485233 |
| ecoscore_extended_data.impact.likeliest_recipe.en:mono__and_diclycerides | 1 | number | - | 3.1514304578866317 |
| ecoscore_extended_data.impact.likeliest_recipe.en:mustard_seed | 1 | number | - | 0.08195792735460876 |
| ecoscore_extended_data.impact.likeliest_recipe.en:natural_and_artificial_flavouring | 15 | number | - | 0.4966542532002002<br>3.668155748550966 |
| ecoscore_extended_data.impact.likeliest_recipe.en:natural_flavouring | 20 | number | - | 0.10032749081198876<br>0.04302302295992658 |
| ecoscore_extended_data.impact.likeliest_recipe.en:nut | 1 | number | - | 95.24902998623786 |
| ecoscore_extended_data.impact.likeliest_recipe.en:oat_flakes | 2 | number | - | 51.872035874148054<br>3.1118357247384667 |
| ecoscore_extended_data.impact.likeliest_recipe.en:onion | 7 | number | - | 1.18320976569503<br>0.06991220108180791 |
| ecoscore_extended_data.impact.likeliest_recipe.en:palm_iol | 1 | number | - | 7.944302623812656 |
| ecoscore_extended_data.impact.likeliest_recipe.en:palm_kernel_oil | 10 | number | - | 0.4277503385008758<br>8.984454139863264 |
| ecoscore_extended_data.impact.likeliest_recipe.en:palm_kerner | 1 | number | - | 16.345691829968256 |
| ecoscore_extended_data.impact.likeliest_recipe.en:palm_oil | 7 | number | - | 4.103034864162813<br>18.336261320892557 |
| ecoscore_extended_data.impact.likeliest_recipe.en:paprika | 2 | number | - | 0.22089285440383788<br>0.01715014792440674 |
| ecoscore_extended_data.impact.likeliest_recipe.en:parsley | 2 | number | - | 1.632871461449878<br>0.91060640760563 |
| ecoscore_extended_data.impact.likeliest_recipe.en:partially_hydrogenated_coconut_oil | 1 | number | - | 0.422586278843819 |
| ecoscore_extended_data.impact.likeliest_recipe.en:partially_hydrogenated_palm_kernel_oil | 1 | number | - | 11.780740258842023 |
| ecoscore_extended_data.impact.likeliest_recipe.en:partially_hydrogenated_soybean_and_cottonseed_oil | 1 | number | - | 0.3181571739579894 |
| ecoscore_extended_data.impact.likeliest_recipe.en:partially_hydrogenated_soybean_and_cottonseed_oils | 1 | number | - | 1.7162845104298912 |
| ecoscore_extended_data.impact.likeliest_recipe.en:pasteurised_milk | 10 | number | - | 59.34609801716099<br>27.74301196226377 |
| ecoscore_extended_data.impact.likeliest_recipe.en:pasteurized_milk_and_cream | 1 | number | - | 58.30408432543446 |
| ecoscore_extended_data.impact.likeliest_recipe.en:pasteurized_semi_skimmed_milk | 2 | number | - | 29.1024557281142<br>63.42840733537611 |
| ecoscore_extended_data.impact.likeliest_recipe.en:pea | 1 | number | - | 22.888469443084077 |
| ecoscore_extended_data.impact.likeliest_recipe.en:peanut | 3 | number | - | 2.43974647300184<br>0.176711836884046 |
| ecoscore_extended_data.impact.likeliest_recipe.en:peanut_oil | 1 | number | - | 0 |
| ecoscore_extended_data.impact.likeliest_recipe.en:pecan_nut | 1 | number | - | 14.471633272712 |
| ecoscore_extended_data.impact.likeliest_recipe.en:peppermint_oil | 1 | number | - | 5.5164381687328135 |
| ecoscore_extended_data.impact.likeliest_recipe.en:pineapple | 2 | number | - | 9.233784660037239<br>2.9279811532358067 |
| ecoscore_extended_data.impact.likeliest_recipe.en:pineapple_juice_from_concentrate | 3 | number | - | 28.89019150183367<br>0.4975126043523375 |
| ecoscore_extended_data.impact.likeliest_recipe.en:polysorbate_80_pectin | 1 | number | - | 0.9741545555909796 |
| ecoscore_extended_data.impact.likeliest_recipe.en:potato_starch | 4 | number | - | 0.4465170353178488<br>8.32291014110168 |
| ecoscore_extended_data.impact.likeliest_recipe.en:powder | 1 | number | - | 0.10714074449859702 |
| ecoscore_extended_data.impact.likeliest_recipe.en:poydextrose | 1 | number | - | 14.061334238141788 |
| ecoscore_extended_data.impact.likeliest_recipe.en:preservative | 1 | number | - | 1.924583923229287 |
| ecoscore_extended_data.impact.likeliest_recipe.en:propylene_glycol_monoesters | 4 | number | - | 2.8896441219756372<br>4.008830284710055 |
| ecoscore_extended_data.impact.likeliest_recipe.en:pyridoxine_hydrochloride | 1 | number | - | 0.2058585500912344 |
| ecoscore_extended_data.impact.likeliest_recipe.en:raisin | 1 | number | - | 34.20161039820618 |
| ecoscore_extended_data.impact.likeliest_recipe.en:rapeseed | 3 | number | - | 0.834229081696382<br>1.738532220048979 |
| ecoscore_extended_data.impact.likeliest_recipe.en:red_and_green_bell_peppers | 1 | number | - | 0.10726650332254156 |
| ecoscore_extended_data.impact.likeliest_recipe.en:red_bell_pepper | 1 | number | - | 0.8237111553175797 |
| ecoscore_extended_data.impact.likeliest_recipe.en:reduced_iron | 4 | number | - | 3.5079911028699367<br>1.3475875008132698 |
| ecoscore_extended_data.impact.likeliest_recipe.en:resinous_glaze | 1 | number | - | 4.3837404652495335 |
| ecoscore_extended_data.impact.likeliest_recipe.en:retinyl_palmitate | 9 | number | - | 0.022348814916003844<br>0.1182646083892874 |
| ecoscore_extended_data.impact.likeliest_recipe.en:rice_flour | 1 | number | - | 0.1135908664632315 |
| ecoscore_extended_data.impact.likeliest_recipe.en:rice_starch | 2 | number | - | 3.1471038940143092<br>4.914029949409339 |
| ecoscore_extended_data.impact.likeliest_recipe.en:roasted_peanuts | 3 | number | - | 93.4333443234636<br>91.40286500790721 |
| ecoscore_extended_data.impact.likeliest_recipe.en:salt | 49 | number | - | 1.1441808517374483<br>2.2947825144450062 |
| ecoscore_extended_data.impact.likeliest_recipe.en:sea_salt | 7 | number | - | 4.0093152650485<br>3.3304804923777693 |
| ecoscore_extended_data.impact.likeliest_recipe.en:semi_skimmed_milk | 1 | number | - | 51.41572712485133 |
| ecoscore_extended_data.impact.likeliest_recipe.en:sesame_oil | 1 | number | - | 93.39084078290311 |
| ecoscore_extended_data.impact.likeliest_recipe.en:shea_oil | 1 | number | - | 1.2302918647720704 |
| ecoscore_extended_data.impact.likeliest_recipe.en:skimmed_milk | 25 | number | - | 3.578646915504999<br>4.438220856536807 |
| ecoscore_extended_data.impact.likeliest_recipe.en:skimmed_milk_powder | 4 | number | - | 5.4210617374864265<br>0.8334942024739 |
| ecoscore_extended_data.impact.likeliest_recipe.en:sodium_bicarbonate_as_leavening_agent | 5 | number | - | 0.0722873328893112<br>0.6282308750766782 |
| ecoscore_extended_data.impact.likeliest_recipe.en:sodium_citrate | 3 | number | - | 11.57301220869632<br>0.08583785823636923 |
| ecoscore_extended_data.impact.likeliest_recipe.en:soluble_corn_fiber | 1 | number | - | 2.0462525588380966 |
| ecoscore_extended_data.impact.likeliest_recipe.en:soya | 7 | number | - | 0.11909090504991976<br>2.419304811466001 |
| ecoscore_extended_data.impact.likeliest_recipe.en:soya_bean | 5 | number | - | 0.0930446621216578<br>0 |
| ecoscore_extended_data.impact.likeliest_recipe.en:soya_flour | 1 | number | - | 0.892241494768131 |
| ecoscore_extended_data.impact.likeliest_recipe.en:soya_lecithin | 8 | number | - | 0.10940634626401144<br>1.6953467234586141 |
| ecoscore_extended_data.impact.likeliest_recipe.en:soya_oil | 4 | number | - | 8.2412756083751<br>1.0807437414536714 |
| ecoscore_extended_data.impact.likeliest_recipe.en:Sparkling_filtered_water | 1 | number | - | 32.2233193612491 |
| ecoscore_extended_data.impact.likeliest_recipe.en:spice | 7 | number | - | 1.04448251129869<br>1.530162794855085 |
| ecoscore_extended_data.impact.likeliest_recipe.en:strawberry | 4 | number | - | 1.1420327325401685<br>0 |
| ecoscore_extended_data.impact.likeliest_recipe.en:sucralose_enzymes | 1 | number | - | 0.13564798029195205 |
| ecoscore_extended_data.impact.likeliest_recipe.en:sugar | 38 | number | - | 49.83786285608151<br>39.208235632712366 |
| ecoscore_extended_data.impact.likeliest_recipe.en:sugar_syrup | 2 | number | - | 7.647578423923598<br>16.609635093262007 |
| ecoscore_extended_data.impact.likeliest_recipe.en:sunflower_oil | 2 | number | - | 92.63619612086785<br>1.2246788568181834 |
| ecoscore_extended_data.impact.likeliest_recipe.en:sweetcorn | 1 | number | - | 24.87877113378704 |
| ecoscore_extended_data.impact.likeliest_recipe.en:sweetened_by_a_blend_of_canadian_white_water_clover_honey | 1 | number | - | 31.67613295716628 |
| ecoscore_extended_data.impact.likeliest_recipe.en:tapioca_dextrin | 2 | number | - | 0.8156549639698748<br>0 |
| ecoscore_extended_data.impact.likeliest_recipe.en:thiamin | 1 | number | - | 1.1371451942686601 |
| ecoscore_extended_data.impact.likeliest_recipe.en:thiamin_mononitrate | 6 | number | - | 3.507991102869827<br>0.1072566418767186 |
| ecoscore_extended_data.impact.likeliest_recipe.en:TOMATILLO | 1 | number | - | 46.6840054424054 |
| ecoscore_extended_data.impact.likeliest_recipe.en:tomato | 1 | number | - | 59.9375102573878 |
| ecoscore_extended_data.impact.likeliest_recipe.en:tomato_concentrate | 1 | number | - | 18.255643657237364 |
| ecoscore_extended_data.impact.likeliest_recipe.en:tricalcuim_phosphate | 1 | number | - | 0.0022808279770125898 |
| ecoscore_extended_data.impact.likeliest_recipe.en:turmeric_color | 1 | number | - | 0.2931566099676211 |
| ecoscore_extended_data.impact.likeliest_recipe.en:vanilla | 1 | number | - | 0.3988651182659324 |
| ecoscore_extended_data.impact.likeliest_recipe.en:vanilla_seeds | 2 | number | - | 0<br>0.5827496174275171 |
| ecoscore_extended_data.impact.likeliest_recipe.en:vanillin | 11 | number | - | 3.4780289652542047<br>0.05191007429628077 |
| ecoscore_extended_data.impact.likeliest_recipe.en:vegetable_fats_palm | 1 | number | - | 0.4277503385008758 |
| ecoscore_extended_data.impact.likeliest_recipe.en:vegetable_oil | 1 | number | - | 2.9526561440799304 |
| ecoscore_extended_data.impact.likeliest_recipe.en:vinegar | 10 | number | - | 4.440145879492772<br>24.097209471518017 |
| ecoscore_extended_data.impact.likeliest_recipe.en:vital_wheat_gluten | 1 | number | - | 1.2191825409357464 |
| ecoscore_extended_data.impact.likeliest_recipe.en:walnut | 1 | number | - | 1.939548915450835 |
| ecoscore_extended_data.impact.likeliest_recipe.en:water | 96 | number | - | 8.31654127019004<br>4.517731404409833 |
| ecoscore_extended_data.impact.likeliest_recipe.en:wheat_flour | 12 | number | - | 67.38520372663106<br>2.001752062913928 |
| ecoscore_extended_data.impact.likeliest_recipe.en:whey | 8 | number | - | 5.542023884384667e-7<br>0.3559316684815489 |
| ecoscore_extended_data.impact.likeliest_recipe.en:whey_protein | 1 | number | - | 3.1473325719667797 |
| ecoscore_extended_data.impact.likeliest_recipe.en:whole_milk | 2 | number | - | 6.443362544844658<br>0 |
| ecoscore_extended_data.impact.likeliest_recipe.en:yeast | 3 | number | - | 0.17658574070910332<br>3.1118357247384556 |
| ecoscore_extended_data.impact.likeliest_recipe.fr:Carbonate_de_t_calcium | 1 | number | - | 2.4851766333968848 |
| ecoscore_extended_data.impact.likeliest_recipe.fr:Farine_de_bl__ferment__d_shydrat_ | 1 | number | - | 0.009635087992805493 |
| ecoscore_extended_data.impact.mass_ratio_uncharacterized | 96 | number | - | 0.3758411911482487<br>0 |
| ecoscore_extended_data.impact.mean_confidence_interval_distribution | 6 | object | - | {"Climate_change":[[0.3005189425894843,0.3095447529401739]],"EF_single_score":[[0.027093136865174634,0.02786563641303079...<br>{"EF_single_score":[[0.027376131218597766,0.029260906064237185],[0.02743477688297713,0.02926129955695193],[0.02748604404... |
| ecoscore_extended_data.impact.mean_confidence_interval_distribution.Climate_change | 6 | array | array | [[0.3005189425894843,0.3095447529401739]]<br>[[0.3027656352060306,0.32692868626044325],[0.3035220181699284,0.3269456155746638],[0.3041880898766805,0.3268983532092351... |
| ecoscore_extended_data.impact.mean_confidence_interval_distribution.Climate_change[] | 22 | array | number | [0.3005189425894843,0.3095447529401739]<br>[0.3027656352060306,0.32692868626044325] |
| ecoscore_extended_data.impact.mean_confidence_interval_distribution.Climate_change[][] | 44 | number | - | 0.3005189425894843<br>0.3095447529401739 |
| ecoscore_extended_data.impact.mean_confidence_interval_distribution.EF_single_score | 6 | array | array | [[0.027093136865174634,0.027865636413030796]]<br>[[0.027376131218597766,0.029260906064237185],[0.02743477688297713,0.02926129955695193],[0.02748604404951993,0.0292563904... |
| ecoscore_extended_data.impact.mean_confidence_interval_distribution.EF_single_score[] | 22 | array | number | [0.027093136865174634,0.027865636413030796]<br>[0.027376131218597766,0.029260906064237185] |
| ecoscore_extended_data.impact.mean_confidence_interval_distribution.EF_single_score[][] | 44 | number | - | 0.027093136865174634<br>0.027865636413030796 |
| ecoscore_extended_data.impact.number_of_ingredients | 6 | number | - | 11<br>8 |
| ecoscore_extended_data.impact.number_of_runs | 6 | number | - | 30<br>46 |
| ecoscore_extended_data.impact.product_quantity | 6 | number | - | 100 |
| ecoscore_extended_data.impact.recipes | 6 | array | object | [{"en:e509":1.930607650573775,"en:e211":0.10024890579950534,"en:e415":1.6132356861527168,"en:cucumber":72.74018230221688...<br>[{"en:cucumber":38.89802883586307,"en:salt":3.532346794272867,"en:natural_flavouring":0.3988017439304098,"en:water":32.5... |
| ecoscore_extended_data.impact.recipes[] | 196 | object | - | {"en:e509":1.930607650573775,"en:e211":0.10024890579950534,"en:e415":1.6132356861527168,"en:cucumber":72.74018230221688,...<br>{"en:cucumber":49.39120650153603,"en:e415":0.6311899982176964,"en:e509":2.1052424314472367,"en:e211":0.1063745094560554,... |
| ecoscore_extended_data.impact.recipes[].en:celery_seed | 30 | number | - | 1.4451919386062912<br>0.15462817844274673 |
| ecoscore_extended_data.impact.recipes[].en:cream | 30 | number | - | 0.40146630531396865<br>2.0901394592537534 |
| ecoscore_extended_data.impact.recipes[].en:cucumber | 76 | number | - | 72.74018230221688<br>49.39120650153603 |
| ecoscore_extended_data.impact.recipes[].en:e202 | 30 | number | - | 0.07742687244779091<br>0.07599786488693733 |
| ecoscore_extended_data.impact.recipes[].en:e211 | 76 | number | - | 0.10024890579950534<br>0.1063745094560554 |
| ecoscore_extended_data.impact.recipes[].en:e270 | 30 | number | - | 0.3620025562059061<br>1.9900877496681246 |
| ecoscore_extended_data.impact.recipes[].en:e330 | 30 | number | - | 17.2065503233792<br>2.75890165806256 |
| ecoscore_extended_data.impact.recipes[].en:e407 | 30 | number | - | 2.283195755446259<br>0.22216414639394969 |
| ecoscore_extended_data.impact.recipes[].en:e415 | 60 | number | - | 1.6132356861527168<br>0.6311899982176964 |
| ecoscore_extended_data.impact.recipes[].en:e433 | 46 | number | - | 1.3327560996907395<br>1.3611602502530906 |
| ecoscore_extended_data.impact.recipes[].en:e440a | 30 | number | - | 0.856380270192693<br>1.64160307166611 |
| ecoscore_extended_data.impact.recipes[].en:e509 | 76 | number | - | 1.930607650573775<br>2.1052424314472367 |
| ecoscore_extended_data.impact.recipes[].en:e572 | 30 | number | - | 2.0029054245702946<br>0.17902913505786028 |
| ecoscore_extended_data.impact.recipes[].en:e621 | 30 | number | - | 12.104111839797177<br>7.226179596764408 |
| ecoscore_extended_data.impact.recipes[].en:e955 | 30 | number | - | 0.0963421320572152<br>0.021865602698283176 |
| ecoscore_extended_data.impact.recipes[].en:garlic | 30 | number | - | 0.6725031235267537<br>3.019750324925698 |
| ecoscore_extended_data.impact.recipes[].en:maltodextrins | 30 | number | - | 53.320994163310935<br>58.883885053619885 |
| ecoscore_extended_data.impact.recipes[].en:modified_corn_starch | 30 | number | - | 0.3423658591215178<br>1.582549607839327 |
| ecoscore_extended_data.impact.recipes[].en:mustard_seed | 30 | number | - | 1.9886704203355001<br>0.4985971647507711 |
| ecoscore_extended_data.impact.recipes[].en:natural_flavouring | 46 | number | - | 0.3988017439304098<br>1.740330231935159 |
| ecoscore_extended_data.impact.recipes[].en:onion | 60 | number | - | 1.987955068599054<br>0.25322643642975756 |
| ecoscore_extended_data.impact.recipes[].en:parsley | 30 | number | - | 2.0413879254179497<br>0.5640967062566127 |
| ecoscore_extended_data.impact.recipes[].en:pasteurized_skimmed_milk | 30 | number | - | 55.444080021479614<br>50.449896490220596 |
| ecoscore_extended_data.impact.recipes[].en:raspberry | 30 | number | - | 40.0388195557348<br>42.7813935688205 |
| ecoscore_extended_data.impact.recipes[].en:roasted_peanuts | 30 | number | - | 98.4999653691676<br>98.5598948136005 |
| ecoscore_extended_data.impact.recipes[].en:salt | 166 | number | - | 2.1307114149879927<br>1.05682737670709 |
| ecoscore_extended_data.impact.recipes[].en:sodium_citrate | 30 | number | - | 17.1103646912649<br>0.0861431957700812 |
| ecoscore_extended_data.impact.recipes[].en:spice | 30 | number | - | 2.268934864253782<br>0.2785758191655506 |
| ecoscore_extended_data.impact.recipes[].en:sugar | 60 | number | - | 41.1655107304528<br>50.0302959156163 |
| ecoscore_extended_data.impact.recipes[].en:vinegar | 76 | number | - | 8.05693235901043<br>15.768306219203744 |
| ecoscore_extended_data.impact.recipes[].en:water | 196 | number | - | 8.158827921165964<br>36.387045037165954 |
| ecoscore_extended_data.impact.recipes[].en:whey | 30 | number | - | 48.999029841127225<br>49.86075065692131 |
| ecoscore_extended_data.impact.reliability | 6 | number | - | 3<br>1 |
| ecoscore_extended_data.impact.total_used_mass_distribution | 6 | array | number | [100.24890579950532,106.37450945605538,100.01258644371025,116.06146977902522,99.88190331559743,100.03153561301205,99.603...<br>[109.39005216205365,99.61569363167906,99.34734963082794,126.62456430771448,117.23070425887465,100.5197650230955,100.3820... |
| ecoscore_extended_data.impact.total_used_mass_distribution[] | 196 | number | - | 100.24890579950532<br>106.37450945605538 |
| ecoscore_extended_data.impact.uncharacterized_ingredients | 99 | object | - | {"impact":["en:e521","en:e541","en:e415","en:reduced-iron","en:e282","en:thiamin-mononitrate","en:folic-acid","en:e297",...<br>{"nutrition":[],"impact":[]} |
| ecoscore_extended_data.impact.uncharacterized_ingredients_mass_proportion | 99 | object | - | {"impact":0.3758411911482487,"nutrition":0.016398179888794433}<br>{"nutrition":0,"impact":0} |
| ecoscore_extended_data.impact.uncharacterized_ingredients_mass_proportion.impact | 99 | number | - | 0.3758411911482487<br>0 |
| ecoscore_extended_data.impact.uncharacterized_ingredients_mass_proportion.nutrition | 99 | number | - | 0.016398179888794433<br>0 |
| ecoscore_extended_data.impact.uncharacterized_ingredients_ratio | 99 | object | - | {"impact":0.6923076923076923,"nutrition":0.1153846153846154}<br>{"nutrition":0,"impact":0} |
| ecoscore_extended_data.impact.uncharacterized_ingredients_ratio.impact | 99 | number | - | 0.6923076923076923<br>0 |
| ecoscore_extended_data.impact.uncharacterized_ingredients_ratio.nutrition | 99 | number | - | 0.1153846153846154<br>0 |
| ecoscore_extended_data.impact.uncharacterized_ingredients.impact | 99 | array | string | ["en:e521","en:e541","en:e415","en:reduced-iron","en:e282","en:thiamin-mononitrate","en:folic-acid","en:e297","en:e202",...<br>[] |
| ecoscore_extended_data.impact.uncharacterized_ingredients.impact[] | 550 | string | - | en:e521<br>en:e541 |
| ecoscore_extended_data.impact.uncharacterized_ingredients.nutrition | 99 | array | string | ["en:dextrose","en:e541","en:e521"]<br>[] |
| ecoscore_extended_data.impact.uncharacterized_ingredients.nutrition[] | 178 | string | - | en:dextrose<br>en:e541 |
| ecoscore_extended_data.impact.warnings | 99 | array | string | ["Fermentation agents are present in the product (en:yeast). Carbohydrates and sugars mass balance will not be considere...<br>[] |
| ecoscore_extended_data.impact.warnings[] | 321 | string | - | Fermentation agents are present in the product (en:yeast). Carbohydrates and sugars mass balance will not be considered ...<br>The product has a high number of impact uncharacterized ingredients: 69% |
| ecoscore_tags[] | 2998 | string | - | d<br>unknown |
| editors_tags[] | 13245 | string | - | kiliweb<br>moon-rabbit |
| editors[] | 222 | string | - | elttor<br>hangy |
| emb_codes_tags[] | 35 | string | - | fr-56-094-004-ec<br>080503190204 |
| entry_dates_tags[] | 9005 | string | - | 2018-02-22<br>2018-02 |
| environmental_score_data.adjustments | 2079 | object | - | {"packaging":{"non_recyclable_and_non_biodegradable_materials":0,"score":61,"warning":"unscored_shape","value":-4,"packa...<br>{"production_system":{"labels":[],"value":0,"warning":"no_label"},"origins_of_ingredients":{"transportation_scores":{"sk... |
| environmental_score_data.adjustments.origins_of_ingredients | 2079 | object | - | {"warning":"origins_are_100_percent_unknown","epi_score":0,"origins_from_categories":["en:unknown"],"transportation_scor...<br>{"transportation_scores":{"sk":0,"fr":0,"dk":0,"us":0,"ie":0,"world":0,"ee":0,"ax":0,"tn":0,"bg":0,"li":0,"gg":0,"tr":0,... |
| environmental_score_data.adjustments.origins_of_ingredients.aggregated_origins | 2079 | array | object | [{"origin":"en:unknown","percent":100}]<br>[{"percent":100,"origin":"en:unknown"}] |
| environmental_score_data.adjustments.origins_of_ingredients.aggregated_origins[] | 2095 | object | - | {"origin":"en:unknown","percent":100}<br>{"percent":100,"origin":"en:unknown"} |
| environmental_score_data.adjustments.origins_of_ingredients.aggregated_origins[].origin | 2095 | string | - | en:unknown<br>en:germany |
| environmental_score_data.adjustments.origins_of_ingredients.aggregated_origins[].percent | 2095 | number | - | 100<br>87.94642857142858 |
| environmental_score_data.adjustments.origins_of_ingredients.epi_score | 2079 | number | - | 0<br>85 |
| environmental_score_data.adjustments.origins_of_ingredients.epi_value | 2079 | number | - | -5<br>4 |
| environmental_score_data.adjustments.origins_of_ingredients.origins_from_categories | 2079 | array | string | ["en:unknown"]<br>["en:france"] |
| environmental_score_data.adjustments.origins_of_ingredients.origins_from_categories[] | 2079 | string | - | en:unknown<br>en:france |
| environmental_score_data.adjustments.origins_of_ingredients.origins_from_origins_field | 2079 | array | string | ["en:unknown"]<br>["en:germany"] |
| environmental_score_data.adjustments.origins_of_ingredients.origins_from_origins_field[] | 2081 | string | - | en:unknown<br>en:germany |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores | 2079 | object | - | {"rs":0,"us":0,"no":0,"al":0,"mt":0,"ly":0,"fr":0,"be":0,"tr":0,"gg":0,"eg":0,"is":0,"im":0,"ad":0,"ax":0,"nl":0,"ma":0,...<br>{"sk":0,"fr":0,"dk":0,"us":0,"ie":0,"world":0,"ee":0,"ax":0,"tn":0,"bg":0,"li":0,"gg":0,"tr":0,"sy":0,"im":0,"gr":0,"hr"... |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.ad | 2079 | number | - | 0<br>32 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.al | 2079 | number | - | 0<br>2 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.at | 2079 | number | - | 0<br>61 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.ax | 2079 | number | - | 0<br>56 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.ba | 2079 | number | - | 0<br>35 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.be | 2079 | number | - | 0<br>80 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.bg | 2079 | number | - | 0<br>13 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.ch | 2079 | number | - | 0<br>64 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.cy | 2079 | number | - | 0<br>24 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.cz | 2079 | number | - | 0<br>73 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.de | 2079 | number | - | 0<br>100 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.dk | 2079 | number | - | 0<br>63 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.dz | 2079 | number | - | 0<br>29 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.ee | 2079 | number | - | 0<br>2 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.eg | 2079 | number | - | 0<br>19 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.es | 2079 | number | - | 0<br>47 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.fi | 2079 | number | - | 0<br>59 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.fo | 2079 | number | - | 0<br>52 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.fr | 2079 | number | - | 0<br>63 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.gg | 2079 | number | - | 0<br>47 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.gi | 2079 | number | - | 0<br>57 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.gr | 2079 | number | - | 0<br>34 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.hr | 2079 | number | - | 0<br>53 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.hu | 2079 | number | - | 0<br>49 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.ie | 2079 | number | - | 0<br>30 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.il | 2079 | number | - | 0<br>19 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.im | 2079 | number | - | 0<br>33 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.is | 2079 | number | - | 0<br>42 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.it | 2079 | number | - | 0<br>52 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.je | 2079 | number | - | 0<br>45 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.lb | 2079 | number | - | 0<br>23 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.li | 2079 | number | - | 0<br>74 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.lt | 2079 | number | - | 0<br>30 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.lu | 2079 | number | - | 0<br>84 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.lv | 2079 | number | - | 0<br>17 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.ly | 2079 | number | - | 0<br>40 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.ma | 2079 | number | - | 0<br>44 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.mc | 2079 | number | - | 0<br>48 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.md | 2079 | number | - | 0<br>11 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.me | 2079 | number | - | 0<br>18 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.mk | 2079 | number | - | 0<br>9 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.mt | 2079 | number | - | 0<br>41 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.nl | 2079 | number | - | 0<br>82 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.no | 2079 | number | - | 0<br>44 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.pl | 2079 | number | - | 0<br>57 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.ps | 2079 | number | - | 0<br>26 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.pt | 2079 | number | - | 0<br>52 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.ro | 2079 | number | - | 0<br>8 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.rs | 2079 | number | - | 0<br>31 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.se | 2079 | number | - | 0<br>39 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.si | 2079 | number | - | 0<br>57 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.sj | 2079 | number | - | 0<br>43 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.sk | 2079 | number | - | 0<br>47 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.sm | 2079 | number | - | 0<br>45 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.sy | 2079 | number | - | 0<br>10 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.tn | 2079 | number | - | 0<br>12 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.tr | 2079 | number | - | 0<br>7 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.ua | 2079 | number | - | 0<br>7 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.uk | 2079 | number | - | 0<br>51 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.us | 2079 | number | - | 0<br>10.714285714285715 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.va | 2079 | number | - | 0<br>34 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.world | 2079 | number | - | 0 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_scores.xk | 2079 | number | - | 0<br>5 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values | 2079 | object | - | {"ly":0,"mt":0,"no":0,"al":0,"us":0,"rs":0,"is":0,"eg":0,"gg":0,"tr":0,"be":0,"fr":0,"ad":0,"im":0,"ee":0,"ch":0,"lu":0,...<br>{"ie":0,"fr":0,"sk":0,"us":0,"dk":0,"ax":0,"bg":0,"tn":0,"world":0,"ee":0,"hr":0,"gr":0,"es":0,"sy":0,"tr":0,"gg":0,"li"... |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.ad | 2079 | number | - | 0<br>5 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.al | 2079 | number | - | 0<br>8 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.at | 2079 | number | - | 0<br>9 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.ax | 2079 | number | - | 0<br>8 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.ba | 2079 | number | - | 0<br>5 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.be | 2079 | number | - | 0<br>12 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.bg | 2079 | number | - | 0<br>2 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.ch | 2079 | number | - | 0<br>10 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.cy | 2079 | number | - | 0<br>4 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.cz | 2079 | number | - | 0<br>11 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.de | 2079 | number | - | 0<br>15 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.dk | 2079 | number | - | 0<br>9 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.dz | 2079 | number | - | 0<br>4 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.ee | 2079 | number | - | 0<br>11 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.eg | 2079 | number | - | 0<br>3 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.es | 2079 | number | - | 0<br>7 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.fi | 2079 | number | - | 0<br>9 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.fo | 2079 | number | - | 0<br>8 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.fr | 2079 | number | - | 0<br>9 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.gg | 2079 | number | - | 0<br>7 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.gi | 2079 | number | - | 0<br>9 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.gr | 2079 | number | - | 0<br>5 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.hr | 2079 | number | - | 0<br>8 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.hu | 2079 | number | - | 0<br>7 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.ie | 2079 | number | - | 0<br>5 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.il | 2079 | number | - | 0<br>3 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.im | 2079 | number | - | 0<br>5 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.is | 2079 | number | - | 0<br>6 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.it | 2079 | number | - | 0<br>8 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.je | 2079 | number | - | 0<br>7 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.lb | 2079 | number | - | 0<br>3 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.li | 2079 | number | - | 0<br>11 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.lt | 2079 | number | - | 0<br>5 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.lu | 2079 | number | - | 0<br>13 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.lv | 2079 | number | - | 0<br>3 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.ly | 2079 | number | - | 0<br>6 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.ma | 2079 | number | - | 0<br>7 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.mc | 2079 | number | - | 0<br>7 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.md | 2079 | number | - | 0<br>2 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.me | 2079 | number | - | 0<br>3 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.mk | 2079 | number | - | 0<br>1 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.mt | 2079 | number | - | 0<br>6 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.nl | 2079 | number | - | 0<br>12 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.no | 2079 | number | - | 0<br>7 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.pl | 2079 | number | - | 0<br>9 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.ps | 2079 | number | - | 0<br>4 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.pt | 2079 | number | - | 0<br>8 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.ro | 2079 | number | - | 0<br>1 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.rs | 2079 | number | - | 0<br>5 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.se | 2079 | number | - | 0<br>6 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.si | 2079 | number | - | 0<br>9 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.sj | 2079 | number | - | 0<br>6 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.sk | 2079 | number | - | 0<br>7 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.sm | 2079 | number | - | 0<br>7 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.sy | 2079 | number | - | 0<br>2 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.tn | 2079 | number | - | 0<br>2 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.tr | 2079 | number | - | 0<br>1 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.ua | 2079 | number | - | 0<br>1 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.uk | 2079 | number | - | 0<br>8 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.us | 2079 | number | - | 0<br>2 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.va | 2079 | number | - | 0<br>5 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.world | 2079 | number | - | 0 |
| environmental_score_data.adjustments.origins_of_ingredients.transportation_values.xk | 2079 | number | - | 0<br>1 |
| environmental_score_data.adjustments.origins_of_ingredients.values | 2079 | object | - | {"pt":-5,"il":-5,"world":-5,"mk":-5,"sy":-5,"cz":-5,"se":-5,"ba":-5,"ro":-5,"dz":-5,"sk":-5,"lt":-5,"lb":-5,"me":-5,"be"...<br>{"ie":-5,"dk":-5,"us":-5,"fr":-5,"sk":-5,"bg":-5,"tn":-5,"ax":-5,"ee":-5,"world":-5,"es":-5,"gr":-5,"hr":-5,"im":-5,"sy"... |
| environmental_score_data.adjustments.origins_of_ingredients.values.ad | 2079 | number | - | -5<br>9 |
| environmental_score_data.adjustments.origins_of_ingredients.values.al | 2079 | number | - | -5<br>4 |
| environmental_score_data.adjustments.origins_of_ingredients.values.at | 2079 | number | - | -5<br>13 |
| environmental_score_data.adjustments.origins_of_ingredients.values.ax | 2079 | number | - | -5<br>12 |
| environmental_score_data.adjustments.origins_of_ingredients.values.ba | 2079 | number | - | -5<br>9 |
| environmental_score_data.adjustments.origins_of_ingredients.values.be | 2079 | number | - | -5<br>16 |
| environmental_score_data.adjustments.origins_of_ingredients.values.bg | 2079 | number | - | -5<br>6 |
| environmental_score_data.adjustments.origins_of_ingredients.values.ch | 2079 | number | - | -5<br>14 |
| environmental_score_data.adjustments.origins_of_ingredients.values.cy | 2079 | number | - | -5<br>8 |
| environmental_score_data.adjustments.origins_of_ingredients.values.cz | 2079 | number | - | -5<br>15 |
| environmental_score_data.adjustments.origins_of_ingredients.values.de | 2079 | number | - | -5<br>19 |
| environmental_score_data.adjustments.origins_of_ingredients.values.dk | 2079 | number | - | -5<br>13 |
| environmental_score_data.adjustments.origins_of_ingredients.values.dz | 2079 | number | - | -5<br>8 |
| environmental_score_data.adjustments.origins_of_ingredients.values.ee | 2079 | number | - | -5<br>4 |
| environmental_score_data.adjustments.origins_of_ingredients.values.eg | 2079 | number | - | -5<br>7 |
| environmental_score_data.adjustments.origins_of_ingredients.values.es | 2079 | number | - | -5<br>11 |
| environmental_score_data.adjustments.origins_of_ingredients.values.fi | 2079 | number | - | -5<br>13 |
| environmental_score_data.adjustments.origins_of_ingredients.values.fo | 2079 | number | - | -5<br>12 |
| environmental_score_data.adjustments.origins_of_ingredients.values.fr | 2079 | number | - | -5<br>13 |
| environmental_score_data.adjustments.origins_of_ingredients.values.gg | 2079 | number | - | -5<br>11 |
| environmental_score_data.adjustments.origins_of_ingredients.values.gi | 2079 | number | - | -5<br>13 |
| environmental_score_data.adjustments.origins_of_ingredients.values.gr | 2079 | number | - | -5<br>9 |
| environmental_score_data.adjustments.origins_of_ingredients.values.hr | 2079 | number | - | -5<br>12 |
| environmental_score_data.adjustments.origins_of_ingredients.values.hu | 2079 | number | - | -5<br>11 |
| environmental_score_data.adjustments.origins_of_ingredients.values.ie | 2079 | number | - | -5<br>9 |
| environmental_score_data.adjustments.origins_of_ingredients.values.il | 2079 | number | - | -5<br>7 |
| environmental_score_data.adjustments.origins_of_ingredients.values.im | 2079 | number | - | -5<br>9 |
| environmental_score_data.adjustments.origins_of_ingredients.values.is | 2079 | number | - | -5<br>10 |
| environmental_score_data.adjustments.origins_of_ingredients.values.it | 2079 | number | - | -5<br>12 |
| environmental_score_data.adjustments.origins_of_ingredients.values.je | 2079 | number | - | -5<br>11 |
| environmental_score_data.adjustments.origins_of_ingredients.values.lb | 2079 | number | - | -5<br>7 |
| environmental_score_data.adjustments.origins_of_ingredients.values.li | 2079 | number | - | -5<br>15 |
| environmental_score_data.adjustments.origins_of_ingredients.values.lt | 2079 | number | - | -5<br>9 |
| environmental_score_data.adjustments.origins_of_ingredients.values.lu | 2079 | number | - | -5<br>17 |
| environmental_score_data.adjustments.origins_of_ingredients.values.lv | 2079 | number | - | -5<br>7 |
| environmental_score_data.adjustments.origins_of_ingredients.values.ly | 2079 | number | - | -5<br>10 |
| environmental_score_data.adjustments.origins_of_ingredients.values.ma | 2079 | number | - | -5<br>11 |
| environmental_score_data.adjustments.origins_of_ingredients.values.mc | 2079 | number | - | -5<br>11 |
| environmental_score_data.adjustments.origins_of_ingredients.values.md | 2079 | number | - | -5<br>6 |
| environmental_score_data.adjustments.origins_of_ingredients.values.me | 2079 | number | - | -5<br>7 |
| environmental_score_data.adjustments.origins_of_ingredients.values.mk | 2079 | number | - | -5<br>5 |
| environmental_score_data.adjustments.origins_of_ingredients.values.mt | 2079 | number | - | -5<br>10 |
| environmental_score_data.adjustments.origins_of_ingredients.values.nl | 2079 | number | - | -5<br>16 |
| environmental_score_data.adjustments.origins_of_ingredients.values.no | 2079 | number | - | -5<br>11 |
| environmental_score_data.adjustments.origins_of_ingredients.values.pl | 2079 | number | - | -5<br>13 |
| environmental_score_data.adjustments.origins_of_ingredients.values.ps | 2079 | number | - | -5<br>8 |
| environmental_score_data.adjustments.origins_of_ingredients.values.pt | 2079 | number | - | -5<br>12 |
| environmental_score_data.adjustments.origins_of_ingredients.values.ro | 2079 | number | - | -5<br>5 |
| environmental_score_data.adjustments.origins_of_ingredients.values.rs | 2079 | number | - | -5<br>9 |
| environmental_score_data.adjustments.origins_of_ingredients.values.se | 2079 | number | - | -5<br>10 |
| environmental_score_data.adjustments.origins_of_ingredients.values.si | 2079 | number | - | -5<br>13 |
| environmental_score_data.adjustments.origins_of_ingredients.values.sj | 2079 | number | - | -5<br>10 |
| environmental_score_data.adjustments.origins_of_ingredients.values.sk | 2079 | number | - | -5<br>11 |
| environmental_score_data.adjustments.origins_of_ingredients.values.sm | 2079 | number | - | -5<br>11 |
| environmental_score_data.adjustments.origins_of_ingredients.values.sy | 2079 | number | - | -5<br>6 |
| environmental_score_data.adjustments.origins_of_ingredients.values.tn | 2079 | number | - | -5<br>6 |
| environmental_score_data.adjustments.origins_of_ingredients.values.tr | 2079 | number | - | -5<br>4 |
| environmental_score_data.adjustments.origins_of_ingredients.values.ua | 2079 | number | - | -5<br>5 |
| environmental_score_data.adjustments.origins_of_ingredients.values.uk | 2079 | number | - | -5<br>12 |
| environmental_score_data.adjustments.origins_of_ingredients.values.us | 2079 | number | - | -5<br>4 |
| environmental_score_data.adjustments.origins_of_ingredients.values.va | 2079 | number | - | -5<br>9 |
| environmental_score_data.adjustments.origins_of_ingredients.values.world | 2079 | number | - | -5<br>4 |
| environmental_score_data.adjustments.origins_of_ingredients.values.xk | 2079 | number | - | -5<br>5 |
| environmental_score_data.adjustments.origins_of_ingredients.warning | 2017 | string | - | origins_are_100_percent_unknown |
| environmental_score_data.adjustments.packaging | 2079 | object | - | {"non_recyclable_and_non_biodegradable_materials":0,"score":61,"warning":"unscored_shape","value":-4,"packagings":[{"qua...<br>{"warning":"packaging_data_missing","value":-15} |
| environmental_score_data.adjustments.packaging.non_recyclable_and_non_biodegradable_materials | 169 | number | - | 0<br>1 |
| environmental_score_data.adjustments.packaging.packagings | 167 | array | object | [{"quantity_per_unit":"350","material":"en:glass","environmental_score_material_score":81,"number_of_units":1,"food_cont...<br>[{"food_contact":1,"environmental_score_material_score":0,"environmental_score_shape_ratio":1,"shape":"en:bucket","mater... |
| environmental_score_data.adjustments.packaging.packagings[] | 233 | object | - | {"quantity_per_unit":"350","material":"en:glass","environmental_score_material_score":81,"number_of_units":1,"food_conta...<br>{"food_contact":1,"environmental_score_material_score":0,"number_of_units":1,"material":"en:metal","shape":"en:lid","env... |
| environmental_score_data.adjustments.packaging.packagings[].environmental_score_material_score | 233 | number | - | 81<br>0 |
| environmental_score_data.adjustments.packaging.packagings[].environmental_score_shape_ratio | 233 | number | - | 1<br>0.2 |
| environmental_score_data.adjustments.packaging.packagings[].food_contact | 150 | number | - | 1<br>0 |
| environmental_score_data.adjustments.packaging.packagings[].material | 233 | string | - | en:glass<br>en:metal |
| environmental_score_data.adjustments.packaging.packagings[].material_shape | 11 | string | - | en:pet-1-polyethylene-terephthalate.en:bottle<br>en:hdpe-2-high-density-polyethylene.en:bottle |
| environmental_score_data.adjustments.packaging.packagings[].non_recyclable_and_non_biodegradable | 116 | string | - | maybe<br>no |
| environmental_score_data.adjustments.packaging.packagings[].number_of_units | 31 | number, string | - | 1<br>2 |
| environmental_score_data.adjustments.packaging.packagings[].quantity_per_unit | 5 | string | - | 350<br>1 oz |
| environmental_score_data.adjustments.packaging.packagings[].quantity_per_unit_unit | 1 | string | - | g |
| environmental_score_data.adjustments.packaging.packagings[].quantity_per_unit_value | 1 | string | - | 0 |
| environmental_score_data.adjustments.packaging.packagings[].recycling | 9 | string | - | en:recycle-in-sorting-bin<br>en:recycle |
| environmental_score_data.adjustments.packaging.packagings[].shape | 233 | string | - | en:jar<br>en:lid |
| environmental_score_data.adjustments.packaging.score | 167 | number | - | 61<br>0 |
| environmental_score_data.adjustments.packaging.value | 2079 | number | - | -4<br>-15 |
| environmental_score_data.adjustments.packaging.warning | 2009 | string | - | unscored_shape<br>packaging_data_missing |
| environmental_score_data.adjustments.production_system | 2079 | object | - | {"warning":"no_label","value":0,"labels":[]}<br>{"labels":[],"value":0,"warning":"no_label"} |
| environmental_score_data.adjustments.production_system.labels | 2079 | array | string | []<br>["fr:ab-agriculture-biologique","en:eu-organic"] |
| environmental_score_data.adjustments.production_system.labels[] | 33 | string | - | fr:ab-agriculture-biologique<br>en:eu-organic |
| environmental_score_data.adjustments.production_system.value | 2079 | number | - | 0<br>15 |
| environmental_score_data.adjustments.production_system.warning | 2058 | string | - | no_label |
| environmental_score_data.adjustments.threatened_species | 2079 | object | - | {"warning":"ingredients_missing"}<br>{} |
| environmental_score_data.adjustments.threatened_species.ingredient | 288 | string | - | en:palm-oil |
| environmental_score_data.adjustments.threatened_species.value | 288 | number | - | -10 |
| environmental_score_data.adjustments.threatened_species.warning | 241 | string | - | ingredients_missing |
| environmental_score_data.agribalyse | 2068 | object | - | {"code":"31032","ef_transportation":0.020486,"name_en":"Chocolate spread with hazelnuts","ef_processing":0.047606624,"ef...<br>{"warning":"missing_agribalyse_match"} |
| environmental_score_data.agribalyse.agribalyse_food_code | 246 | string | - | 31032<br>18020 |
| environmental_score_data.agribalyse.agribalyse_proxy_food_code | 156 | string | - | 31032<br>23880 |
| environmental_score_data.agribalyse.co2_agriculture | 317 | number | - | 6.8500101<br>0.022870449 |
| environmental_score_data.agribalyse.co2_consumption | 317 | number | - | 0<br>0.0112323 |
| environmental_score_data.agribalyse.co2_distribution | 317 | number | - | 0.017263204<br>0.0001567597 |
| environmental_score_data.agribalyse.co2_packaging | 317 | number | - | 0.17071537<br>0.0026323455 |
| environmental_score_data.agribalyse.co2_processing | 317 | number | - | 0.3052603<br>0 |
| environmental_score_data.agribalyse.co2_total | 317 | number | - | 7.5649401339999995<br>0.039161353499999996 |
| environmental_score_data.agribalyse.co2_transportation | 317 | number | - | 0.22169116<br>0.0022694993 |
| environmental_score_data.agribalyse.code | 317 | string | - | 31032<br>18020 |
| environmental_score_data.agribalyse.dqr | 317 | string | - | 2.54<br>2.98 |
| environmental_score_data.agribalyse.ef_agriculture | 317 | number | - | 0.44346677<br>0.0081036052 |
| environmental_score_data.agribalyse.ef_consumption | 317 | number | - | 0<br>0.0043474982 |
| environmental_score_data.agribalyse.ef_distribution | 317 | number | - | 0.0046101581<br>0.000044793367 |
| environmental_score_data.agribalyse.ef_packaging | 317 | number | - | 0.018565697<br>0.00021662681 |
| environmental_score_data.agribalyse.ef_processing | 317 | number | - | 0.047606624<br>0 |
| environmental_score_data.agribalyse.ef_total | 317 | number | - | 0.5347352491<br>0.012940544857 |
| environmental_score_data.agribalyse.ef_transportation | 317 | number | - | 0.020486<br>0.00022802128 |
| environmental_score_data.agribalyse.is_beverage | 317 | number | - | 0<br>1 |
| environmental_score_data.agribalyse.name_en | 317 | string | - | Chocolate spread with hazelnuts<br>Tea, brewed, without sugar |
| environmental_score_data.agribalyse.name_fr | 317 | string | - | Pâte à tartiner chocolat et noisette<br>Thé infusé, non sucré |
| environmental_score_data.agribalyse.score | 317 | number | - | 51<br>100 |
| environmental_score_data.agribalyse.version | 317 | string | - | 3.1.1<br>3.2 |
| environmental_score_data.agribalyse.warning | 1749 | string | - | missing_agribalyse_match |
| environmental_score_data.environmental_score_not_applicable_for_category | 11 | string | - | en:fresh-vegetables<br>en:sodas |
| environmental_score_data.grade | 2075 | string | - | d<br>unknown |
| environmental_score_data.grades | 317 | object | - | {"tr":"d","gg":"d","eg":"d","is":"d","fr":"d","be":"d","mt":"d","ly":"d","rs":"d","us":"d","no":"d","al":"d","ee":"d","n...<br>{"sj":"a","si":"a","xk":"a","de":"a","lv":"a","rs":"a","tr":"a","al":"a","lt":"a","tn":"a","pt":"a","sm":"a","mt":"a","h... |
| environmental_score_data.grades.ad | 317 | string | - | d<br>a |
| environmental_score_data.grades.al | 317 | string | - | d<br>a |
| environmental_score_data.grades.at | 317 | string | - | d<br>a |
| environmental_score_data.grades.ax | 317 | string | - | d<br>a |
| environmental_score_data.grades.ba | 317 | string | - | d<br>a |
| environmental_score_data.grades.be | 317 | string | - | d<br>a |
| environmental_score_data.grades.bg | 317 | string | - | d<br>a |
| environmental_score_data.grades.ch | 317 | string | - | d<br>a |
| environmental_score_data.grades.cy | 317 | string | - | d<br>a |
| environmental_score_data.grades.cz | 317 | string | - | d<br>a |
| environmental_score_data.grades.de | 317 | string | - | d<br>a |
| environmental_score_data.grades.dk | 317 | string | - | d<br>a |
| environmental_score_data.grades.dz | 317 | string | - | d<br>a |
| environmental_score_data.grades.ee | 317 | string | - | d<br>a |
| environmental_score_data.grades.eg | 317 | string | - | d<br>a |
| environmental_score_data.grades.es | 317 | string | - | d<br>a |
| environmental_score_data.grades.fi | 317 | string | - | d<br>a |
| environmental_score_data.grades.fo | 317 | string | - | d<br>a |
| environmental_score_data.grades.fr | 317 | string | - | d<br>a |
| environmental_score_data.grades.gg | 317 | string | - | d<br>a |
| environmental_score_data.grades.gi | 317 | string | - | d<br>a |
| environmental_score_data.grades.gr | 317 | string | - | d<br>a |
| environmental_score_data.grades.hr | 317 | string | - | d<br>a |
| environmental_score_data.grades.hu | 317 | string | - | d<br>a |
| environmental_score_data.grades.ie | 317 | string | - | d<br>a |
| environmental_score_data.grades.il | 317 | string | - | d<br>a |
| environmental_score_data.grades.im | 317 | string | - | d<br>a |
| environmental_score_data.grades.is | 317 | string | - | d<br>a |
| environmental_score_data.grades.it | 317 | string | - | d<br>a |
| environmental_score_data.grades.je | 317 | string | - | d<br>a |
| environmental_score_data.grades.lb | 317 | string | - | d<br>a |
| environmental_score_data.grades.li | 317 | string | - | d<br>a |
| environmental_score_data.grades.lt | 317 | string | - | d<br>a |
| environmental_score_data.grades.lu | 317 | string | - | d<br>a |
| environmental_score_data.grades.lv | 317 | string | - | d<br>a |
| environmental_score_data.grades.ly | 317 | string | - | d<br>a |
| environmental_score_data.grades.ma | 317 | string | - | d<br>a |
| environmental_score_data.grades.mc | 317 | string | - | d<br>a |
| environmental_score_data.grades.md | 317 | string | - | d<br>a |
| environmental_score_data.grades.me | 317 | string | - | d<br>a |
| environmental_score_data.grades.mk | 317 | string | - | d<br>a |
| environmental_score_data.grades.mt | 317 | string | - | d<br>a |
| environmental_score_data.grades.nl | 317 | string | - | d<br>a |
| environmental_score_data.grades.no | 317 | string | - | d<br>a |
| environmental_score_data.grades.pl | 317 | string | - | d<br>a |
| environmental_score_data.grades.ps | 317 | string | - | d<br>a |
| environmental_score_data.grades.pt | 317 | string | - | d<br>a |
| environmental_score_data.grades.ro | 317 | string | - | d<br>a |
| environmental_score_data.grades.rs | 317 | string | - | d<br>a |
| environmental_score_data.grades.se | 317 | string | - | d<br>a |
| environmental_score_data.grades.si | 317 | string | - | d<br>a |
| environmental_score_data.grades.sj | 317 | string | - | d<br>a |
| environmental_score_data.grades.sk | 317 | string | - | d<br>a |
| environmental_score_data.grades.sm | 317 | string | - | d<br>a |
| environmental_score_data.grades.sy | 317 | string | - | d<br>a |
| environmental_score_data.grades.tn | 317 | string | - | d<br>a |
| environmental_score_data.grades.tr | 317 | string | - | d<br>a |
| environmental_score_data.grades.ua | 317 | string | - | d<br>a |
| environmental_score_data.grades.uk | 317 | string | - | d<br>a |
| environmental_score_data.grades.us | 317 | string | - | d<br>a |
| environmental_score_data.grades.va | 317 | string | - | d<br>a |
| environmental_score_data.grades.world | 317 | string | - | d<br>a |
| environmental_score_data.grades.xk | 317 | string | - | d<br>a |
| environmental_score_data.missing | 2078 | object | - | {"ingredients":1,"labels":1,"origins":1,"packagings":1}<br>{"origins":1,"labels":1,"agb_category":1,"packagings":1} |
| environmental_score_data.missing_agribalyse_match_warning | 1751 | number | - | 1 |
| environmental_score_data.missing_data_warning | 316 | number | - | 1 |
| environmental_score_data.missing_key_data | 1912 | number | - | 1 |
| environmental_score_data.missing.agb_category | 1575 | number | - | 1 |
| environmental_score_data.missing.categories | 174 | number | - | 1 |
| environmental_score_data.missing.ingredients | 241 | number | - | 1 |
| environmental_score_data.missing.labels | 2058 | number | - | 1 |
| environmental_score_data.missing.origins | 2017 | number | - | 1 |
| environmental_score_data.missing.packagings | 2009 | number | - | 1 |
| environmental_score_data.previous_data | 151 | object | - | {"score":null,"agribalyse":{"warning":"missing_agribalyse_match"},"grade":"unknown"}<br>{"agribalyse":{"warning":"missing_agribalyse_match"},"grade":"unknown","score":null} |
| environmental_score_data.previous_data.agribalyse | 151 | object | - | {"warning":"missing_agribalyse_match"}<br>{"dqr":"2.13","co2_total":3.2485859,"ef_distribution":0.0098990521,"score":70,"ef_agriculture":0.26505504,"ef_consumptio... |
| environmental_score_data.previous_data.agribalyse.agribalyse_food_code | 40 | string | - | 23853<br>17270 |
| environmental_score_data.previous_data.agribalyse.agribalyse_proxy_food_code | 47 | string | - | 31005<br>31080 |
| environmental_score_data.previous_data.agribalyse.co2_agriculture | 78 | number | - | 2.5574237<br>0.47459847 |
| environmental_score_data.previous_data.agribalyse.co2_consumption | 78 | number | - | 0<br>0.086768136 |
| environmental_score_data.previous_data.agribalyse.co2_distribution | 78 | number | - | 0.029120657<br>0.017010291 |
| environmental_score_data.previous_data.agribalyse.co2_packaging | 78 | number | - | 0.30178726<br>0.17741769 |
| environmental_score_data.previous_data.agribalyse.co2_processing | 78 | number | - | 0.2358442<br>0.074772213 |
| environmental_score_data.previous_data.agribalyse.co2_total | 78 | number | - | 3.2485859<br>0.9829873939999999 |
| environmental_score_data.previous_data.agribalyse.co2_transportation | 78 | number | - | 0.12442695<br>0.23918873 |
| environmental_score_data.previous_data.agribalyse.code | 78 | string | - | 23853<br>17270 |
| environmental_score_data.previous_data.agribalyse.dqr | 78 | string | - | 2.13<br>1.61 |
| environmental_score_data.previous_data.agribalyse.ef_agriculture | 78 | number | - | 0.26505504<br>0.52010187 |
| environmental_score_data.previous_data.agribalyse.ef_consumption | 78 | number | - | 0<br>0.011306968 |
| environmental_score_data.previous_data.agribalyse.ef_distribution | 78 | number | - | 0.0098990521<br>0.0048664764 |
| environmental_score_data.previous_data.agribalyse.ef_packaging | 78 | number | - | 0.018692737<br>0.038778298 |
| environmental_score_data.previous_data.agribalyse.ef_processing | 78 | number | - | 0.042539804<br>0.007340458100000001 |
| environmental_score_data.previous_data.agribalyse.ef_total | 78 | number | - | 0.34590189<br>0.5900523384999999 |
| environmental_score_data.previous_data.agribalyse.ef_transportation | 78 | number | - | 0.0097170829<br>0.018965236 |
| environmental_score_data.previous_data.agribalyse.is_beverage | 78 | number | - | 0<br>1 |
| environmental_score_data.previous_data.agribalyse.name_en | 78 | string | - | Wafer biscuit, crunchy (thin or dry), plain or with sugar, prepacked<br>Olive oil, extra virgin |
| environmental_score_data.previous_data.agribalyse.name_fr | 78 | string | - | Gaufre croustillante (fine ou sèche), nature ou sucrée, préemballée<br>Huile d'olive vierge extra |
| environmental_score_data.previous_data.agribalyse.score | 78 | number | - | 70<br>47 |
| environmental_score_data.previous_data.agribalyse.version | 55 | string | - | 3.1.1<br>3.1 |
| environmental_score_data.previous_data.agribalyse.warning | 73 | string | - | missing_agribalyse_match |
| environmental_score_data.previous_data.grade | 151 | null, string | - | unknown<br>c |
| environmental_score_data.previous_data.score | 151 | null, number | - | null<br>40 |
| environmental_score_data.score | 317 | number | - | 42<br>80 |
| environmental_score_data.scores | 317 | object | - | {"is":42,"eg":42,"gg":42,"tr":42,"be":42,"fr":42,"ly":42,"mt":42,"al":42,"no":42,"us":42,"rs":42,"ee":42,"lu":42,"bg":42...<br>{"at":80,"pl":80,"ad":80,"is":80,"be":80,"eg":80,"cz":80,"me":80,"gr":80,"es":80,"mc":80,"im":80,"sy":80,"ch":80,"lb":80... |
| environmental_score_data.scores.ad | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.al | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.at | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.ax | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.ba | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.be | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.bg | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.ch | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.cy | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.cz | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.de | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.dk | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.dz | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.ee | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.eg | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.es | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.fi | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.fo | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.fr | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.gg | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.gi | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.gr | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.hr | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.hu | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.ie | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.il | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.im | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.is | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.it | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.je | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.lb | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.li | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.lt | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.lu | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.lv | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.ly | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.ma | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.mc | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.md | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.me | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.mk | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.mt | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.nl | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.no | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.pl | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.ps | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.pt | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.ro | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.rs | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.se | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.si | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.sj | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.sk | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.sm | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.sy | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.tn | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.tr | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.ua | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.uk | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.us | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.va | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.world | 317 | number | - | 42<br>80 |
| environmental_score_data.scores.xk | 317 | number | - | 42<br>80 |
| environmental_score_data.status | 2079 | string | - | known<br>unknown |
| environmental_score_tags[] | 2079 | string | - | d<br>unknown |
| food_groups_tags[] | 1967 | string | - | en:sugary-snacks<br>en:sweets |
| forest_footprint_data.footprint_per_kg | 345 | number | - | 1.8914540608723963e-8<br>0.000275462962962968 |
| forest_footprint_data.grade | 345 | string | - | a<br>e |
| forest_footprint_data.ingredients | 345 | array | object | [{"conditions_tags":[],"type":{"soy_feed_factor":0.035,"deforestation_risk":0.68,"soy_yield":0.3,"name":"Oeufs Importés"...<br>[{"percent_estimate":0.34722222222222854,"processing_factor":1,"type":{"name":"Oeufs Importés","soy_feed_factor":0.035,"... |
| forest_footprint_data.ingredients[] | 473 | object | - | {"conditions_tags":[],"type":{"soy_feed_factor":0.035,"deforestation_risk":0.68,"soy_yield":0.3,"name":"Oeufs Importés"}...<br>{"percent_estimate":0.34722222222222854,"processing_factor":1,"type":{"name":"Oeufs Importés","soy_feed_factor":0.035,"s... |
| forest_footprint_data.ingredients[].conditions_tags | 473 | array | array | []<br>[["labels","en:organic"]] |
| forest_footprint_data.ingredients[].conditions_tags[] | 5 | array | string | ["labels","en:organic"] |
| forest_footprint_data.ingredients[].conditions_tags[][] | 10 | string | - | labels<br>en:organic |
| forest_footprint_data.ingredients[].footprint_per_kg | 473 | number | - | 1.8914540608723963e-8<br>0.000275462962962968 |
| forest_footprint_data.ingredients[].matching_tag_id | 472 | string | - | en:egg<br>en:chicken-meat |
| forest_footprint_data.ingredients[].percent | 473 | number | - | 0.00002384185791015625<br>0.34722222222222854 |
| forest_footprint_data.ingredients[].percent_estimate | 460 | number | - | 0.00002384185791015625<br>0.34722222222222854 |
| forest_footprint_data.ingredients[].processing_factor | 473 | number, string | - | 1<br>0.75 |
| forest_footprint_data.ingredients[].tag_id | 473 | string | - | en:egg-powder<br>en:egg-white |
| forest_footprint_data.ingredients[].tag_type | 473 | string | - | ingredients<br>categories |
| forest_footprint_data.ingredients[].type | 473 | object | - | {"soy_feed_factor":0.035,"deforestation_risk":0.68,"soy_yield":0.3,"name":"Oeufs Importés"}<br>{"name":"Oeufs Importés","soy_feed_factor":0.035,"soy_yield":0.3,"deforestation_risk":0.68} |
| forest_footprint_data.ingredients[].type.deforestation_risk | 473 | number, string | - | 0.68<br>0.1 |
| forest_footprint_data.ingredients[].type.name | 473 | string | - | Oeufs Importés<br>Oeufs Bio |
| forest_footprint_data.ingredients[].type.soy_feed_factor | 473 | number, string | - | 0.035<br>0.028 |
| forest_footprint_data.ingredients[].type.soy_yield | 473 | number, string | - | 0.3<br>0.18 |
| images.1 | 786 | object | - | {"uploader":"kiliweb","uploaded_t":"1519297019","sizes":{"100":{"w":75,"h":100},"400":{"w":300,"h":400},"full":{"w":901,...<br>{"uploader":"openfoodfacts-contributors","uploaded_t":1632611836,"sizes":{"100":{"h":100,"w":93},"400":{"h":400,"w":373}... |
| images.1.sizes | 786 | object | - | {"100":{"w":75,"h":100},"400":{"w":300,"h":400},"full":{"w":901,"h":1200}}<br>{"100":{"h":100,"w":93},"400":{"h":400,"w":373},"full":{"h":1668,"w":1555}} |
| images.1.sizes.100 | 786 | object | - | {"w":75,"h":100}<br>{"h":100,"w":93} |
| images.1.sizes.100.h | 786 | number | - | 100<br>67 |
| images.1.sizes.100.w | 786 | number | - | 75<br>93 |
| images.1.sizes.400 | 786 | object | - | {"w":300,"h":400}<br>{"h":400,"w":373} |
| images.1.sizes.400.h | 786 | number | - | 400<br>266 |
| images.1.sizes.400.w | 786 | number | - | 300<br>373 |
| images.1.sizes.full | 786 | object | - | {"w":901,"h":1200}<br>{"h":1668,"w":1555} |
| images.1.sizes.full.h | 786 | number | - | 1200<br>1668 |
| images.1.sizes.full.w | 786 | number | - | 901<br>1555 |
| images.1.uploaded_t | 786 | number, string | - | 1519297019<br>1632611836 |
| images.1.uploader | 786 | string | - | kiliweb<br>openfoodfacts-contributors |
| images.10 | 9 | object | - | {"uploaded_t":1564930042,"uploader":"kiliweb","sizes":{"100":{"h":94,"w":100},"400":{"w":400,"h":375},"full":{"h":1200,"...<br>{"uploader":"dunindewood","uploaded_t":1736724319,"sizes":{"100":{"h":51,"w":100},"400":{"w":400,"h":205},"full":{"h":15... |
| images.10.sizes | 9 | object | - | {"100":{"h":94,"w":100},"400":{"w":400,"h":375},"full":{"h":1200,"w":1281}}<br>{"100":{"h":51,"w":100},"400":{"w":400,"h":205},"full":{"h":1548,"w":3024}} |
| images.10.sizes.100 | 9 | object | - | {"h":94,"w":100}<br>{"h":51,"w":100} |
| images.10.sizes.100.h | 9 | number | - | 94<br>51 |
| images.10.sizes.100.w | 9 | number | - | 100<br>75 |
| images.10.sizes.400 | 9 | object | - | {"w":400,"h":375}<br>{"w":400,"h":205} |
| images.10.sizes.400.h | 9 | number | - | 375<br>205 |
| images.10.sizes.400.w | 9 | number | - | 400<br>300 |
| images.10.sizes.full | 9 | object | - | {"h":1200,"w":1281}<br>{"h":1548,"w":3024} |
| images.10.sizes.full.h | 9 | number | - | 1200<br>1548 |
| images.10.sizes.full.w | 9 | number | - | 1281<br>3024 |
| images.10.uploaded_t | 9 | number, string | - | 1564930042<br>1736724319 |
| images.10.uploader | 9 | string | - | kiliweb<br>dunindewood |
| images.11 | 7 | object | - | {"sizes":{"100":{"w":100,"h":44},"400":{"w":400,"h":177},"full":{"w":1561,"h":692}},"uploader":"aleene","uploaded_t":156...<br>{"uploaded_t":1736724357,"uploader":"dunindewood","sizes":{"100":{"w":100,"h":29},"400":{"w":400,"h":115},"full":{"w":18... |
| images.11.sizes | 7 | object | - | {"100":{"w":100,"h":44},"400":{"w":400,"h":177},"full":{"w":1561,"h":692}}<br>{"100":{"w":100,"h":29},"400":{"w":400,"h":115},"full":{"w":1804,"h":517}} |
| images.11.sizes.100 | 7 | object | - | {"w":100,"h":44}<br>{"w":100,"h":29} |
| images.11.sizes.100.h | 7 | number | - | 44<br>29 |
| images.11.sizes.100.w | 7 | number | - | 100<br>75 |
| images.11.sizes.400 | 7 | object | - | {"w":400,"h":177}<br>{"w":400,"h":115} |
| images.11.sizes.400.h | 7 | number | - | 177<br>115 |
| images.11.sizes.400.w | 7 | number | - | 400<br>300 |
| images.11.sizes.full | 7 | object | - | {"w":1561,"h":692}<br>{"w":1804,"h":517} |
| images.11.sizes.full.h | 7 | number | - | 692<br>517 |
| images.11.sizes.full.w | 7 | number | - | 1561<br>1804 |
| images.11.uploaded_t | 7 | number | - | 1569231375<br>1736724357 |
| images.11.uploader | 7 | string | - | aleene<br>dunindewood |
| images.12 | 4 | object | - | {"sizes":{"100":{"h":43,"w":100},"400":{"h":173,"w":400},"full":{"w":2080,"h":897}},"uploaded_t":1569231429,"uploader":"...<br>{"sizes":{"100":{"h":81,"w":100},"400":{"h":326,"w":400},"full":{"w":1659,"h":1352}},"uploader":"dunindewood","uploaded_... |
| images.12.sizes | 4 | object | - | {"100":{"h":43,"w":100},"400":{"h":173,"w":400},"full":{"w":2080,"h":897}}<br>{"100":{"h":81,"w":100},"400":{"h":326,"w":400},"full":{"w":1659,"h":1352}} |
| images.12.sizes.100 | 4 | object | - | {"h":43,"w":100}<br>{"h":81,"w":100} |
| images.12.sizes.100.h | 4 | number | - | 43<br>81 |
| images.12.sizes.100.w | 4 | number | - | 100<br>75 |
| images.12.sizes.400 | 4 | object | - | {"h":173,"w":400}<br>{"h":326,"w":400} |
| images.12.sizes.400.h | 4 | number | - | 173<br>326 |
| images.12.sizes.400.w | 4 | number | - | 400<br>300 |
| images.12.sizes.full | 4 | object | - | {"w":2080,"h":897}<br>{"w":1659,"h":1352} |
| images.12.sizes.full.h | 4 | number | - | 897<br>1352 |
| images.12.sizes.full.w | 4 | number | - | 2080<br>1659 |
| images.12.uploaded_t | 4 | number | - | 1569231429<br>1736724375 |
| images.12.uploader | 4 | string | - | aleene<br>dunindewood |
| images.13 | 4 | object | - | {"sizes":{"100":{"w":100,"h":43},"400":{"h":172,"w":400},"full":{"h":893,"w":2078}},"uploaded_t":1569231564,"uploader":"...<br>{"uploader":"dunindewood","uploaded_t":1736724385,"sizes":{"100":{"h":70,"w":100},"400":{"w":400,"h":280},"full":{"w":10... |
| images.13.sizes | 4 | object | - | {"100":{"w":100,"h":43},"400":{"h":172,"w":400},"full":{"h":893,"w":2078}}<br>{"100":{"h":70,"w":100},"400":{"w":400,"h":280},"full":{"w":1016,"h":711}} |
| images.13.sizes.100 | 4 | object | - | {"w":100,"h":43}<br>{"h":70,"w":100} |
| images.13.sizes.100.h | 4 | number | - | 43<br>70 |
| images.13.sizes.100.w | 4 | number | - | 100<br>75 |
| images.13.sizes.400 | 4 | object | - | {"h":172,"w":400}<br>{"w":400,"h":280} |
| images.13.sizes.400.h | 4 | number | - | 172<br>280 |
| images.13.sizes.400.w | 4 | number | - | 400<br>298 |
| images.13.sizes.full | 4 | object | - | {"h":893,"w":2078}<br>{"w":1016,"h":711} |
| images.13.sizes.full.h | 4 | number | - | 893<br>711 |
| images.13.sizes.full.w | 4 | number | - | 2078<br>1016 |
| images.13.uploaded_t | 4 | number | - | 1569231564<br>1736724385 |
| images.13.uploader | 4 | string | - | aleene<br>dunindewood |
| images.14 | 3 | object | - | {"uploaded_t":1736724447,"uploader":"dunindewood","sizes":{"100":{"h":61,"w":100},"400":{"w":400,"h":245},"full":{"h":91...<br>{"uploader":"kiliweb","uploaded_t":1628250277,"sizes":{"100":{"w":100,"h":71},"400":{"h":284,"w":400},"full":{"h":1200,"... |
| images.14.sizes | 3 | object | - | {"100":{"h":61,"w":100},"400":{"w":400,"h":245},"full":{"h":910,"w":1487}}<br>{"100":{"w":100,"h":71},"400":{"h":284,"w":400},"full":{"h":1200,"w":1691}} |
| images.14.sizes.100 | 3 | object | - | {"h":61,"w":100}<br>{"w":100,"h":71} |
| images.14.sizes.100.h | 3 | number | - | 61<br>71 |
| images.14.sizes.100.w | 3 | number | - | 100<br>75 |
| images.14.sizes.400 | 3 | object | - | {"w":400,"h":245}<br>{"h":284,"w":400} |
| images.14.sizes.400.h | 3 | number | - | 245<br>284 |
| images.14.sizes.400.w | 3 | number | - | 400<br>300 |
| images.14.sizes.full | 3 | object | - | {"h":910,"w":1487}<br>{"h":1200,"w":1691} |
| images.14.sizes.full.h | 3 | number | - | 910<br>1200 |
| images.14.sizes.full.w | 3 | number | - | 1487<br>1691 |
| images.14.uploaded_t | 3 | number | - | 1736724447<br>1628250277 |
| images.14.uploader | 3 | string | - | dunindewood<br>kiliweb |
| images.15 | 1 | object | - | {"sizes":{"100":{"h":100,"w":75},"400":{"w":300,"h":400},"full":{"w":3024,"h":4032}},"uploader":"jud","uploaded_t":16236... |
| images.15.sizes | 1 | object | - | {"100":{"h":100,"w":75},"400":{"w":300,"h":400},"full":{"w":3024,"h":4032}} |
| images.15.sizes.100 | 1 | object | - | {"h":100,"w":75} |
| images.15.sizes.100.h | 1 | number | - | 100 |
| images.15.sizes.100.w | 1 | number | - | 75 |
| images.15.sizes.400 | 1 | object | - | {"w":300,"h":400} |
| images.15.sizes.400.h | 1 | number | - | 400 |
| images.15.sizes.400.w | 1 | number | - | 300 |
| images.15.sizes.full | 1 | object | - | {"w":3024,"h":4032} |
| images.15.sizes.full.h | 1 | number | - | 4032 |
| images.15.sizes.full.w | 1 | number | - | 3024 |
| images.15.uploaded_t | 1 | number | - | 1623669070 |
| images.15.uploader | 1 | string | - | jud |
| images.16 | 2 | object | - | {"uploader":"stephane","uploaded_t":"1374767122","sizes":{"100":{"h":100,"w":75},"400":{"h":400,"w":300},"full":{"w":244...<br>{"sizes":{"100":{"w":100,"h":100},"400":{"w":400,"h":400},"full":{"h":600,"w":600}},"uploaded_t":1627834912,"uploader":"... |
| images.16.sizes | 2 | object | - | {"100":{"h":100,"w":75},"400":{"h":400,"w":300},"full":{"w":2448,"h":3264}}<br>{"100":{"w":100,"h":100},"400":{"w":400,"h":400},"full":{"h":600,"w":600}} |
| images.16.sizes.100 | 2 | object | - | {"h":100,"w":75}<br>{"w":100,"h":100} |
| images.16.sizes.100.h | 2 | number | - | 100 |
| images.16.sizes.100.w | 2 | number | - | 75<br>100 |
| images.16.sizes.400 | 2 | object | - | {"h":400,"w":300}<br>{"w":400,"h":400} |
| images.16.sizes.400.h | 2 | number | - | 400 |
| images.16.sizes.400.w | 2 | number | - | 300<br>400 |
| images.16.sizes.full | 2 | object | - | {"w":2448,"h":3264}<br>{"h":600,"w":600} |
| images.16.sizes.full.h | 2 | number | - | 3264<br>600 |
| images.16.sizes.full.w | 2 | number | - | 2448<br>600 |
| images.16.uploaded_t | 2 | number, string | - | 1374767122<br>1627834912 |
| images.16.uploader | 2 | string | - | stephane<br>foodvisor |
| images.2 | 555 | object | - | {"uploader":"kiliweb","uploaded_t":"1519297021","sizes":{"100":{"w":100,"h":75},"400":{"h":300,"w":400},"full":{"w":1599...<br>{"sizes":{"100":{"w":100,"h":57},"400":{"h":229,"w":400},"full":{"w":2095,"h":1200}},"uploader":"kiliweb","uploaded_t":1... |
| images.2.sizes | 555 | object | - | {"100":{"w":100,"h":75},"400":{"h":300,"w":400},"full":{"w":1599,"h":1200}}<br>{"100":{"w":100,"h":57},"400":{"h":229,"w":400},"full":{"w":2095,"h":1200}} |
| images.2.sizes.100 | 555 | object | - | {"w":100,"h":75}<br>{"w":100,"h":57} |
| images.2.sizes.100.h | 555 | number | - | 75<br>57 |
| images.2.sizes.100.w | 555 | number | - | 100<br>19 |
| images.2.sizes.400 | 555 | object | - | {"h":300,"w":400}<br>{"h":229,"w":400} |
| images.2.sizes.400.h | 555 | number | - | 300<br>229 |
| images.2.sizes.400.w | 555 | number | - | 400<br>78 |
| images.2.sizes.full | 555 | object | - | {"w":1599,"h":1200}<br>{"w":2095,"h":1200} |
| images.2.sizes.full.h | 555 | number | - | 1200<br>875 |
| images.2.sizes.full.w | 555 | number | - | 1599<br>2095 |
| images.2.uploaded_t | 555 | number, string | - | 1519297021<br>1535364792 |
| images.2.uploader | 555 | string | - | kiliweb<br>smoothie-app |
| images.3 | 270 | object | - | {"uploader":"kiliweb","uploaded_t":1579374831,"sizes":{"100":{"h":94,"w":100},"400":{"h":376,"w":400},"full":{"h":1200,"...<br>{"uploaded_t":1530962993,"uploader":"kiliweb","sizes":{"100":{"h":63,"w":100},"400":{"h":253,"w":400},"full":{"h":1200,"... |
| images.3.sizes | 270 | object | - | {"100":{"h":94,"w":100},"400":{"h":376,"w":400},"full":{"h":1200,"w":1278}}<br>{"100":{"h":63,"w":100},"400":{"h":253,"w":400},"full":{"h":1200,"w":1895}} |
| images.3.sizes.100 | 270 | object | - | {"h":94,"w":100}<br>{"h":63,"w":100} |
| images.3.sizes.100.h | 270 | number | - | 94<br>63 |
| images.3.sizes.100.w | 270 | number | - | 100<br>88 |
| images.3.sizes.400 | 270 | object | - | {"h":376,"w":400}<br>{"h":253,"w":400} |
| images.3.sizes.400.h | 270 | number | - | 376<br>253 |
| images.3.sizes.400.w | 270 | number | - | 400<br>353 |
| images.3.sizes.full | 270 | object | - | {"h":1200,"w":1278}<br>{"h":1200,"w":1895} |
| images.3.sizes.full.h | 270 | number | - | 1200<br>1148 |
| images.3.sizes.full.w | 270 | number | - | 1278<br>1895 |
| images.3.uploaded_t | 270 | number, string | - | 1579374831<br>1530962993 |
| images.3.uploader | 270 | string | - | kiliweb<br>malikele |
| images.4 | 147 | object | - | {"sizes":{"100":{"w":100,"h":60},"400":{"w":400,"h":238},"full":{"w":2364,"h":1407}},"uploader":"malikele","uploaded_t":...<br>{"uploaded_t":1388661799,"uploader":"malikele","sizes":{"100":{"h":100,"w":48},"400":{"h":400,"w":192},"full":{"w":812,"... |
| images.4.sizes | 147 | object | - | {"100":{"w":100,"h":60},"400":{"w":400,"h":238},"full":{"w":2364,"h":1407}}<br>{"100":{"h":100,"w":48},"400":{"h":400,"w":192},"full":{"w":812,"h":1693}} |
| images.4.sizes.100 | 147 | object | - | {"w":100,"h":60}<br>{"h":100,"w":48} |
| images.4.sizes.100.h | 147 | number | - | 60<br>100 |
| images.4.sizes.100.w | 147 | number | - | 100<br>48 |
| images.4.sizes.400 | 147 | object | - | {"w":400,"h":238}<br>{"h":400,"w":192} |
| images.4.sizes.400.h | 147 | number | - | 238<br>400 |
| images.4.sizes.400.w | 147 | number | - | 400<br>192 |
| images.4.sizes.full | 147 | object | - | {"w":2364,"h":1407}<br>{"w":812,"h":1693} |
| images.4.sizes.full.h | 147 | number | - | 1407<br>1693 |
| images.4.sizes.full.w | 147 | number | - | 2364<br>812 |
| images.4.uploaded_t | 147 | number, string | - | 1388682244<br>1388661799 |
| images.4.uploader | 147 | string | - | malikele<br>kiliweb |
| images.5 | 104 | object | - | {"uploader":"malikele","uploaded_t":1388661836,"sizes":{"100":{"h":59,"w":100},"400":{"h":237,"w":400},"full":{"h":1217,...<br>{"sizes":{"100":{"w":100,"h":59},"400":{"w":400,"h":237},"full":{"w":1001,"h":594}},"uploader":"malikele","uploaded_t":1... |
| images.5.sizes | 104 | object | - | {"100":{"h":59,"w":100},"400":{"h":237,"w":400},"full":{"h":1217,"w":2052}}<br>{"100":{"w":100,"h":59},"400":{"w":400,"h":237},"full":{"w":1001,"h":594}} |
| images.5.sizes.100 | 104 | object | - | {"h":59,"w":100}<br>{"w":100,"h":59} |
| images.5.sizes.100.h | 104 | number | - | 59<br>50 |
| images.5.sizes.100.w | 104 | number | - | 100<br>76 |
| images.5.sizes.400 | 104 | object | - | {"h":237,"w":400}<br>{"w":400,"h":237} |
| images.5.sizes.400.h | 104 | number | - | 237<br>199 |
| images.5.sizes.400.w | 104 | number | - | 400<br>302 |
| images.5.sizes.full | 104 | object | - | {"h":1217,"w":2052}<br>{"w":1001,"h":594} |
| images.5.sizes.full.h | 104 | number | - | 1217<br>594 |
| images.5.sizes.full.w | 104 | number | - | 2052<br>1001 |
| images.5.uploaded_t | 104 | number, string | - | 1388661836<br>1388681948 |
| images.5.uploader | 104 | string | - | malikele<br>kiliweb |
| images.6 | 69 | object | - | {"sizes":{"100":{"h":100,"w":84},"400":{"h":400,"w":336},"full":{"w":796,"h":948}},"uploader":"kiliweb","uploaded_t":166...<br>{"uploader":"kiliweb","uploaded_t":1661292966,"sizes":{"100":{"h":100,"w":75},"400":{"w":299,"h":400},"full":{"h":501,"w... |
| images.6.sizes | 69 | object | - | {"100":{"h":100,"w":84},"400":{"h":400,"w":336},"full":{"w":796,"h":948}}<br>{"100":{"h":100,"w":75},"400":{"w":299,"h":400},"full":{"h":501,"w":375}} |
| images.6.sizes.100 | 69 | object | - | {"h":100,"w":84}<br>{"h":100,"w":75} |
| images.6.sizes.100.h | 69 | number | - | 100<br>54 |
| images.6.sizes.100.w | 69 | number | - | 84<br>75 |
| images.6.sizes.400 | 69 | object | - | {"h":400,"w":336}<br>{"w":299,"h":400} |
| images.6.sizes.400.h | 69 | number | - | 400<br>215 |
| images.6.sizes.400.w | 69 | number | - | 336<br>299 |
| images.6.sizes.full | 69 | object | - | {"w":796,"h":948}<br>{"h":501,"w":375} |
| images.6.sizes.full.h | 69 | number | - | 948<br>501 |
| images.6.sizes.full.w | 69 | number | - | 796<br>375 |
| images.6.uploaded_t | 69 | number, string | - | 1661180111<br>1661292966 |
| images.6.uploader | 69 | string | - | kiliweb<br>paulvb6 |
| images.7 | 38 | object | - | {"sizes":{"100":{"h":100,"w":74},"400":{"w":298,"h":400},"full":{"w":517,"h":694}},"uploaded_t":1661180113,"uploader":"k...<br>{"sizes":{"100":{"h":100,"w":83},"400":{"h":400,"w":333},"full":{"w":500,"h":600}},"uploader":"foodvisor","uploaded_t":1... |
| images.7.sizes | 38 | object | - | {"100":{"h":100,"w":74},"400":{"w":298,"h":400},"full":{"w":517,"h":694}}<br>{"100":{"h":100,"w":83},"400":{"h":400,"w":333},"full":{"w":500,"h":600}} |
| images.7.sizes.100 | 38 | object | - | {"h":100,"w":74}<br>{"h":100,"w":83} |
| images.7.sizes.100.h | 38 | number | - | 100<br>32 |
| images.7.sizes.100.w | 38 | number | - | 74<br>83 |
| images.7.sizes.400 | 38 | object | - | {"w":298,"h":400}<br>{"h":400,"w":333} |
| images.7.sizes.400.h | 38 | number | - | 400<br>129 |
| images.7.sizes.400.w | 38 | number | - | 298<br>333 |
| images.7.sizes.full | 38 | object | - | {"w":517,"h":694}<br>{"w":500,"h":600} |
| images.7.sizes.full.h | 38 | number | - | 694<br>600 |
| images.7.sizes.full.w | 38 | number | - | 517<br>500 |
| images.7.uploaded_t | 38 | number, string | - | 1661180113<br>1669673078 |
| images.7.uploader | 38 | string | - | kiliweb<br>foodvisor |
| images.8 | 17 | object | - | {"uploaded_t":1644973286,"uploader":"foodvisor","sizes":{"100":{"h":100,"w":100},"400":{"w":400,"h":400},"full":{"h":600...<br>{"uploaded_t":"1497381792","uploader":"openfoodfacts-contributors","sizes":{"100":{"w":56,"h":100},"400":{"w":226,"h":40... |
| images.8.sizes | 17 | object | - | {"100":{"h":100,"w":100},"400":{"w":400,"h":400},"full":{"h":600,"w":600}}<br>{"100":{"w":56,"h":100},"400":{"w":226,"h":400},"full":{"h":580,"w":327}} |
| images.8.sizes.100 | 17 | object | - | {"h":100,"w":100}<br>{"w":56,"h":100} |
| images.8.sizes.100.h | 17 | number | - | 100<br>29 |
| images.8.sizes.100.w | 17 | number | - | 100<br>56 |
| images.8.sizes.400 | 17 | object | - | {"w":400,"h":400}<br>{"w":226,"h":400} |
| images.8.sizes.400.h | 17 | number | - | 400<br>117 |
| images.8.sizes.400.w | 17 | number | - | 400<br>226 |
| images.8.sizes.full | 17 | object | - | {"h":600,"w":600}<br>{"h":580,"w":327} |
| images.8.sizes.full.h | 17 | number | - | 600<br>580 |
| images.8.sizes.full.w | 17 | number | - | 600<br>327 |
| images.8.uploaded_t | 17 | number, string | - | 1644973286<br>1497381792 |
| images.8.uploader | 17 | string | - | foodvisor<br>openfoodfacts-contributors |
| images.9 | 11 | object | - | {"sizes":{"100":{"h":56,"w":100},"400":{"w":400,"h":226},"full":{"h":327,"w":580}},"uploaded_t":"1497381792","uploader":...<br>{"sizes":{"100":{"w":50,"h":100},"400":{"h":400,"w":200},"full":{"w":1962,"h":3928}},"uploader":"bcd4e6","uploaded_t":15... |
| images.9.sizes | 11 | object | - | {"100":{"h":56,"w":100},"400":{"w":400,"h":226},"full":{"h":327,"w":580}}<br>{"100":{"w":50,"h":100},"400":{"h":400,"w":200},"full":{"w":1962,"h":3928}} |
| images.9.sizes.100 | 11 | object | - | {"h":56,"w":100}<br>{"w":50,"h":100} |
| images.9.sizes.100.h | 11 | number | - | 56<br>100 |
| images.9.sizes.100.w | 11 | number | - | 100<br>50 |
| images.9.sizes.400 | 11 | object | - | {"w":400,"h":226}<br>{"h":400,"w":200} |
| images.9.sizes.400.h | 11 | number | - | 226<br>400 |
| images.9.sizes.400.w | 11 | number | - | 400<br>200 |
| images.9.sizes.full | 11 | object | - | {"h":327,"w":580}<br>{"w":1962,"h":3928} |
| images.9.sizes.full.h | 11 | number | - | 327<br>3928 |
| images.9.sizes.full.w | 11 | number | - | 580<br>1962 |
| images.9.uploaded_t | 11 | number, string | - | 1497381792<br>1556602355 |
| images.9.uploader | 11 | string | - | openfoodfacts-contributors<br>bcd4e6 |
| images.front | 100 | object | - | {"white_magic":null,"sizes":{"100":{"w":100,"h":60},"200":{"w":200,"h":119},"400":{"h":238,"w":400},"full":{"h":1407,"w"...<br>{"white_magic":null,"sizes":{"100":{"h":59,"w":100},"200":{"h":119,"w":200},"400":{"w":400,"h":237},"full":{"h":1217,"w"... |
| images.front_de | 11 | object | - | {"sizes":{"100":{"w":100,"h":67},"200":{"h":133,"w":200},"400":{"w":400,"h":266},"full":{"w":500,"h":333}},"white_magic"...<br>{"sizes":{"100":{"h":67,"w":100},"200":{"w":200,"h":133},"400":{"w":400,"h":266},"full":{"h":333,"w":500}},"white_magic"... |
| images.front_de.angle | 11 | number, string | - | 0 |
| images.front_de.coordinates_image_size | 1 | string | - | full |
| images.front_de.geometry | 11 | string | - | 0x0--1--1<br>0x0--2--2 |
| images.front_de.imgid | 11 | string | - | 1<br>2 |
| images.front_de.normalize | 11 | null, string | - | null<br>false |
| images.front_de.rev | 11 | string | - | 3<br>4 |
| images.front_de.sizes | 11 | object | - | {"100":{"w":100,"h":67},"200":{"h":133,"w":200},"400":{"w":400,"h":266},"full":{"w":500,"h":333}}<br>{"100":{"h":67,"w":100},"200":{"w":200,"h":133},"400":{"w":400,"h":266},"full":{"h":333,"w":500}} |
| images.front_de.sizes.100 | 11 | object | - | {"w":100,"h":67}<br>{"h":67,"w":100} |
| images.front_de.sizes.100.h | 11 | number | - | 67<br>66 |
| images.front_de.sizes.100.w | 11 | number | - | 100<br>67 |
| images.front_de.sizes.200 | 11 | object | - | {"h":133,"w":200}<br>{"w":200,"h":133} |
| images.front_de.sizes.200.h | 11 | number | - | 133<br>200 |
| images.front_de.sizes.200.w | 11 | number | - | 200<br>133 |
| images.front_de.sizes.400 | 11 | object | - | {"w":400,"h":266}<br>{"h":266,"w":400} |
| images.front_de.sizes.400.h | 11 | number | - | 266<br>400 |
| images.front_de.sizes.400.w | 11 | number | - | 400<br>267 |
| images.front_de.sizes.full | 11 | object | - | {"w":500,"h":333}<br>{"h":333,"w":500} |
| images.front_de.sizes.full.h | 11 | number | - | 333<br>1050 |
| images.front_de.sizes.full.w | 11 | number | - | 500<br>501 |
| images.front_de.white_magic | 11 | null, string | - | null<br>false |
| images.front_de.x1 | 11 | number, string | - | -1<br>0 |
| images.front_de.x2 | 11 | number, string | - | -1<br>0 |
| images.front_de.y1 | 11 | number, string | - | -1<br>0 |
| images.front_de.y2 | 11 | number, string | - | -1<br>0 |
| images.front_en | 454 | object | - | {"normalize":null,"y1":"-1","white_magic":null,"angle":0,"sizes":{"100":{"w":75,"h":100},"200":{"w":150,"h":200},"400":{...<br>{"normalize":null,"y2":"-1","angle":0,"y1":"-1","geometry":"0x0--1--1","x2":"-1","white_magic":null,"coordinates_image_s... |
| images.front_en.angle | 400 | null, number, string | - | 0<br>null |
| images.front_en.coordinates_image_size | 324 | string | - | full<br>400 |
| images.front_en.geometry | 454 | string | - | 0x0--10--10<br>0x0--1--1 |
| images.front_en.imgid | 454 | number, string | - | 1<br>4 |
| images.front_en.normalize | 454 | null, string | - | null<br>true |
| images.front_en.rev | 454 | number, string | - | 3<br>5 |
| images.front_en.sizes | 454 | object | - | {"100":{"w":75,"h":100},"200":{"w":150,"h":200},"400":{"h":400,"w":300},"full":{"h":4032,"w":3024}}<br>{"100":{"w":38,"h":100},"200":{"h":200,"w":75},"400":{"w":150,"h":400},"full":{"h":1200,"w":450}} |
| images.front_en.sizes.100 | 454 | object | - | {"w":75,"h":100}<br>{"w":38,"h":100} |
| images.front_en.sizes.100.h | 454 | number | - | 100<br>96 |
| images.front_en.sizes.100.w | 454 | number | - | 75<br>38 |
| images.front_en.sizes.200 | 454 | object | - | {"w":150,"h":200}<br>{"h":200,"w":75} |
| images.front_en.sizes.200.h | 454 | number | - | 200<br>192 |
| images.front_en.sizes.200.w | 454 | number | - | 150<br>75 |
| images.front_en.sizes.400 | 454 | object | - | {"h":400,"w":300}<br>{"w":150,"h":400} |
| images.front_en.sizes.400.h | 454 | number | - | 400<br>385 |
| images.front_en.sizes.400.w | 454 | number | - | 300<br>150 |
| images.front_en.sizes.full | 454 | object | - | {"h":4032,"w":3024}<br>{"h":1200,"w":450} |
| images.front_en.sizes.full.h | 454 | number | - | 4032<br>1200 |
| images.front_en.sizes.full.w | 454 | number | - | 3024<br>450 |
| images.front_en.white_magic | 454 | null, string | - | null<br>false |
| images.front_en.x1 | 400 | null, number, string | - | -1<br>null |
| images.front_en.x2 | 400 | null, number, string | - | -1<br>null |
| images.front_en.y1 | 400 | null, number, string | - | -1<br>null |
| images.front_en.y2 | 400 | null, number, string | - | -1<br>null |
| images.front_es | 1 | object | - | {"white_magic":null,"x2":-1,"rev":"3","sizes":{"100":{"h":100,"w":75},"200":{"h":200,"w":150},"400":{"w":300,"h":400},"f... |
| images.front_es.angle | 1 | number | - | 0 |
| images.front_es.geometry | 1 | string | - | 0x0--5--5 |
| images.front_es.imgid | 1 | string | - | 1 |
| images.front_es.normalize | 1 | null | - | null |
| images.front_es.rev | 1 | string | - | 3 |
| images.front_es.sizes | 1 | object | - | {"100":{"h":100,"w":75},"200":{"h":200,"w":150},"400":{"w":300,"h":400},"full":{"h":2000,"w":1500}} |
| images.front_es.sizes.100 | 1 | object | - | {"h":100,"w":75} |
| images.front_es.sizes.100.h | 1 | number | - | 100 |
| images.front_es.sizes.100.w | 1 | number | - | 75 |
| images.front_es.sizes.200 | 1 | object | - | {"h":200,"w":150} |
| images.front_es.sizes.200.h | 1 | number | - | 200 |
| images.front_es.sizes.200.w | 1 | number | - | 150 |
| images.front_es.sizes.400 | 1 | object | - | {"w":300,"h":400} |
| images.front_es.sizes.400.h | 1 | number | - | 400 |
| images.front_es.sizes.400.w | 1 | number | - | 300 |
| images.front_es.sizes.full | 1 | object | - | {"h":2000,"w":1500} |
| images.front_es.sizes.full.h | 1 | number | - | 2000 |
| images.front_es.sizes.full.w | 1 | number | - | 1500 |
| images.front_es.white_magic | 1 | null | - | null |
| images.front_es.x1 | 1 | number | - | -1 |
| images.front_es.x2 | 1 | number | - | -1 |
| images.front_es.y1 | 1 | number | - | -1 |
| images.front_es.y2 | 1 | number | - | -1 |
| images.front_fr | 330 | object | - | {"x1":null,"y2":null,"geometry":"0x0-0-0","imgid":"1","normalize":"0","white_magic":"0","sizes":{"100":{"h":100,"w":75},...<br>{"rev":"4","y1":null,"x2":null,"x1":null,"y2":null,"geometry":"0x0-0-0","white_magic":"0","sizes":{"100":{"w":84,"h":100... |
| images.front_fr.angle | 308 | null, number, string | - | null<br>270 |
| images.front_fr.coordinates_image_size | 52 | string | - | full<br>400 |
| images.front_fr.geometry | 330 | string | - | 0x0-0-0<br>0x0--4--4 |
| images.front_fr.imgid | 330 | string | - | 1<br>2 |
| images.front_fr.normalize | 330 | null, string | - | 0<br>null |
| images.front_fr.rev | 330 | number, string | - | 4<br>10 |
| images.front_fr.sizes | 330 | object | - | {"100":{"h":100,"w":75},"200":{"w":150,"h":200},"400":{"w":300,"h":400},"full":{"w":901,"h":1200}}<br>{"100":{"w":84,"h":100},"200":{"h":200,"w":168},"400":{"h":400,"w":336},"full":{"w":1007,"h":1200}} |
| images.front_fr.sizes.100 | 330 | object | - | {"h":100,"w":75}<br>{"w":84,"h":100} |
| images.front_fr.sizes.100.h | 330 | number | - | 100<br>75 |
| images.front_fr.sizes.100.w | 330 | number | - | 75<br>84 |
| images.front_fr.sizes.200 | 330 | object | - | {"w":150,"h":200}<br>{"h":200,"w":168} |
| images.front_fr.sizes.200.h | 330 | number | - | 200<br>150 |
| images.front_fr.sizes.200.w | 330 | number | - | 150<br>168 |
| images.front_fr.sizes.400 | 330 | object | - | {"w":300,"h":400}<br>{"h":400,"w":336} |
| images.front_fr.sizes.400.h | 330 | number | - | 400<br>300 |
| images.front_fr.sizes.400.w | 330 | number | - | 300<br>336 |
| images.front_fr.sizes.full | 330 | object | - | {"w":901,"h":1200}<br>{"w":1007,"h":1200} |
| images.front_fr.sizes.full.h | 330 | number | - | 1200<br>901 |
| images.front_fr.sizes.full.w | 330 | number | - | 901<br>1007 |
| images.front_fr.white_magic | 330 | null, string | - | 0<br>null |
| images.front_fr.x1 | 308 | null, number, string | - | null<br>-1 |
| images.front_fr.x2 | 308 | null, number, string | - | null<br>-1 |
| images.front_fr.y1 | 308 | null, number, string | - | null<br>-1 |
| images.front_fr.y2 | 308 | null, number, string | - | null<br>-1 |
| images.front_it | 1 | object | - | {"y1":"19.260009765625","x2":"209.22003173828125","rev":"13","normalize":"false","imgid":"1","sizes":{"100":{"h":100,"w"... |
| images.front_it.angle | 1 | string | - | 0 |
| images.front_it.geometry | 1 | string | - | 901x3076-806-157 |
| images.front_it.imgid | 1 | string | - | 1 |
| images.front_it.normalize | 1 | string | - | false |
| images.front_it.rev | 1 | string | - | 13 |
| images.front_it.sizes | 1 | object | - | {"100":{"h":100,"w":29},"200":{"w":59,"h":200},"400":{"w":117,"h":400},"full":{"h":3076,"w":901}} |
| images.front_it.sizes.100 | 1 | object | - | {"h":100,"w":29} |
| images.front_it.sizes.100.h | 1 | number | - | 100 |
| images.front_it.sizes.100.w | 1 | number | - | 29 |
| images.front_it.sizes.200 | 1 | object | - | {"w":59,"h":200} |
| images.front_it.sizes.200.h | 1 | number | - | 200 |
| images.front_it.sizes.200.w | 1 | number | - | 59 |
| images.front_it.sizes.400 | 1 | object | - | {"w":117,"h":400} |
| images.front_it.sizes.400.h | 1 | number | - | 400 |
| images.front_it.sizes.400.w | 1 | number | - | 117 |
| images.front_it.sizes.full | 1 | object | - | {"h":3076,"w":901} |
| images.front_it.sizes.full.h | 1 | number | - | 3076 |
| images.front_it.sizes.full.w | 1 | number | - | 901 |
| images.front_it.white_magic | 1 | string | - | false |
| images.front_it.x1 | 1 | string | - | 98.85003662109375 |
| images.front_it.x2 | 1 | string | - | 209.22003173828125 |
| images.front_it.y1 | 1 | string | - | 19.260009765625 |
| images.front_it.y2 | 1 | string | - | 396.300048828125 |
| images.front_la | 1 | object | - | {"x1":"-1","sizes":{"100":{"h":100,"w":78},"200":{"h":200,"w":155},"400":{"h":400,"w":311},"full":{"w":740,"h":952}},"re... |
| images.front_la.angle | 1 | number | - | 0 |
| images.front_la.coordinates_image_size | 1 | string | - | full |
| images.front_la.geometry | 1 | string | - | 0x0--1--1 |
| images.front_la.imgid | 1 | string | - | 1 |
| images.front_la.normalize | 1 | null | - | null |
| images.front_la.rev | 1 | string | - | 6 |
| images.front_la.sizes | 1 | object | - | {"100":{"h":100,"w":78},"200":{"h":200,"w":155},"400":{"h":400,"w":311},"full":{"w":740,"h":952}} |
| images.front_la.sizes.100 | 1 | object | - | {"h":100,"w":78} |
| images.front_la.sizes.100.h | 1 | number | - | 100 |
| images.front_la.sizes.100.w | 1 | number | - | 78 |
| images.front_la.sizes.200 | 1 | object | - | {"h":200,"w":155} |
| images.front_la.sizes.200.h | 1 | number | - | 200 |
| images.front_la.sizes.200.w | 1 | number | - | 155 |
| images.front_la.sizes.400 | 1 | object | - | {"h":400,"w":311} |
| images.front_la.sizes.400.h | 1 | number | - | 400 |
| images.front_la.sizes.400.w | 1 | number | - | 311 |
| images.front_la.sizes.full | 1 | object | - | {"w":740,"h":952} |
| images.front_la.sizes.full.h | 1 | number | - | 952 |
| images.front_la.sizes.full.w | 1 | number | - | 740 |
| images.front_la.white_magic | 1 | null | - | null |
| images.front_la.x1 | 1 | string | - | -1 |
| images.front_la.x2 | 1 | string | - | -1 |
| images.front_la.y1 | 1 | string | - | -1 |
| images.front_la.y2 | 1 | string | - | -1 |
| images.front_nl | 3 | object | - | {"geometry":"955x3264-682-0","rev":"5","white_magic":"false","x2":"200.65625","imgid":"2","x1":"83.65625","sizes":{"100"...<br>{"normalize":"true","angle":"0","white_magic":"false","rev":"14","y2":"400","geometry":"699x2469-461-123","y1":"19","x1"... |
| images.front_nl.angle | 3 | number, string | - | 0 |
| images.front_nl.geometry | 3 | string | - | 955x3264-682-0<br>699x2469-461-123 |
| images.front_nl.imgid | 3 | string | - | 2<br>1 |
| images.front_nl.normalize | 3 | null, string | - | false<br>true |
| images.front_nl.rev | 3 | string | - | 5<br>14 |
| images.front_nl.sizes | 3 | object | - | {"100":{"h":100,"w":29},"200":{"h":200,"w":59},"400":{"h":400,"w":117},"full":{"w":955,"h":3264}}<br>{"100":{"h":100,"w":28},"200":{"w":57,"h":200},"400":{"w":113,"h":400},"full":{"h":2469,"w":699}} |
| images.front_nl.sizes.100 | 3 | object | - | {"h":100,"w":29}<br>{"h":100,"w":28} |
| images.front_nl.sizes.100.h | 3 | number | - | 100 |
| images.front_nl.sizes.100.w | 3 | number | - | 29<br>28 |
| images.front_nl.sizes.200 | 3 | object | - | {"h":200,"w":59}<br>{"w":57,"h":200} |
| images.front_nl.sizes.200.h | 3 | number | - | 200 |
| images.front_nl.sizes.200.w | 3 | number | - | 59<br>57 |
| images.front_nl.sizes.400 | 3 | object | - | {"h":400,"w":117}<br>{"w":113,"h":400} |
| images.front_nl.sizes.400.h | 3 | number | - | 400 |
| images.front_nl.sizes.400.w | 3 | number | - | 117<br>113 |
| images.front_nl.sizes.full | 3 | object | - | {"w":955,"h":3264}<br>{"h":2469,"w":699} |
| images.front_nl.sizes.full.h | 3 | number | - | 3264<br>2469 |
| images.front_nl.sizes.full.w | 3 | number | - | 955<br>699 |
| images.front_nl.white_magic | 3 | null, string | - | false<br>null |
| images.front_nl.x1 | 3 | number, string | - | 83.65625<br>71.25 |
| images.front_nl.x2 | 3 | number, string | - | 200.65625<br>179.25 |
| images.front_nl.y1 | 3 | number, string | - | 0<br>19 |
| images.front_nl.y2 | 3 | number, string | - | 400<br>-1 |
| images.front_ru | 1 | object | - | {"y2":"-1","y1":"-1","angle":0,"normalize":null,"rev":"3","x2":"-1","white_magic":null,"coordinates_image_size":"full","... |
| images.front_ru.angle | 1 | number | - | 0 |
| images.front_ru.coordinates_image_size | 1 | string | - | full |
| images.front_ru.geometry | 1 | string | - | 0x0--1--1 |
| images.front_ru.imgid | 1 | string | - | 1 |
| images.front_ru.normalize | 1 | null | - | null |
| images.front_ru.rev | 1 | string | - | 3 |
| images.front_ru.sizes | 1 | object | - | {"100":{"w":75,"h":100},"200":{"h":200,"w":150},"400":{"h":400,"w":300},"full":{"h":4032,"w":3024}} |
| images.front_ru.sizes.100 | 1 | object | - | {"w":75,"h":100} |
| images.front_ru.sizes.100.h | 1 | number | - | 100 |
| images.front_ru.sizes.100.w | 1 | number | - | 75 |
| images.front_ru.sizes.200 | 1 | object | - | {"h":200,"w":150} |
| images.front_ru.sizes.200.h | 1 | number | - | 200 |
| images.front_ru.sizes.200.w | 1 | number | - | 150 |
| images.front_ru.sizes.400 | 1 | object | - | {"h":400,"w":300} |
| images.front_ru.sizes.400.h | 1 | number | - | 400 |
| images.front_ru.sizes.400.w | 1 | number | - | 300 |
| images.front_ru.sizes.full | 1 | object | - | {"h":4032,"w":3024} |
| images.front_ru.sizes.full.h | 1 | number | - | 4032 |
| images.front_ru.sizes.full.w | 1 | number | - | 3024 |
| images.front_ru.white_magic | 1 | null | - | null |
| images.front_ru.x1 | 1 | string | - | -1 |
| images.front_ru.x2 | 1 | string | - | -1 |
| images.front_ru.y1 | 1 | string | - | -1 |
| images.front_ru.y2 | 1 | string | - | -1 |
| images.front_sv | 1 | object | - | {"angle":90,"white_magic":null,"y2":null,"x1":null,"rev":7,"normalize":null,"geometry":"0x0-0-0","imgid":"1","sizes":{"1... |
| images.front_sv.angle | 1 | number | - | 90 |
| images.front_sv.coordinates_image_size | 1 | string | - | full |
| images.front_sv.geometry | 1 | string | - | 0x0-0-0 |
| images.front_sv.imgid | 1 | string | - | 1 |
| images.front_sv.normalize | 1 | null | - | null |
| images.front_sv.rev | 1 | number | - | 7 |
| images.front_sv.sizes | 1 | object | - | {"100":{"h":100,"w":75},"200":{"h":200,"w":150},"400":{"w":300,"h":400},"full":{"h":2000,"w":1500}} |
| images.front_sv.sizes.100 | 1 | object | - | {"h":100,"w":75} |
| images.front_sv.sizes.100.h | 1 | number | - | 100 |
| images.front_sv.sizes.100.w | 1 | number | - | 75 |
| images.front_sv.sizes.200 | 1 | object | - | {"h":200,"w":150} |
| images.front_sv.sizes.200.h | 1 | number | - | 200 |
| images.front_sv.sizes.200.w | 1 | number | - | 150 |
| images.front_sv.sizes.400 | 1 | object | - | {"w":300,"h":400} |
| images.front_sv.sizes.400.h | 1 | number | - | 400 |
| images.front_sv.sizes.400.w | 1 | number | - | 300 |
| images.front_sv.sizes.full | 1 | object | - | {"h":2000,"w":1500} |
| images.front_sv.sizes.full.h | 1 | number | - | 2000 |
| images.front_sv.sizes.full.w | 1 | number | - | 1500 |
| images.front_sv.white_magic | 1 | null | - | null |
| images.front_sv.x1 | 1 | null | - | null |
| images.front_sv.x2 | 1 | null | - | null |
| images.front_sv.y1 | 1 | null | - | null |
| images.front_sv.y2 | 1 | null | - | null |
| images.front.geometry | 100 | string | - | 0x0--5--5<br>0x0--4--4 |
| images.front.imgid | 100 | string | - | 4<br>5 |
| images.front.normalize | 100 | null, string | - | null<br>true |
| images.front.rev | 100 | string | - | 7<br>8 |
| images.front.sizes | 100 | object | - | {"100":{"w":100,"h":60},"200":{"w":200,"h":119},"400":{"h":238,"w":400},"full":{"h":1407,"w":2364}}<br>{"100":{"h":59,"w":100},"200":{"h":119,"w":200},"400":{"w":400,"h":237},"full":{"h":1217,"w":2052}} |
| images.front.sizes.100 | 100 | object | - | {"w":100,"h":60}<br>{"h":59,"w":100} |
| images.front.sizes.100.h | 100 | number | - | 60<br>59 |
| images.front.sizes.100.w | 100 | number | - | 100<br>75 |
| images.front.sizes.200 | 100 | object | - | {"w":200,"h":119}<br>{"h":119,"w":200} |
| images.front.sizes.200.h | 100 | number | - | 119<br>116 |
| images.front.sizes.200.w | 100 | number | - | 200<br>149 |
| images.front.sizes.400 | 100 | object | - | {"h":238,"w":400}<br>{"w":400,"h":237} |
| images.front.sizes.400.h | 100 | number | - | 238<br>237 |
| images.front.sizes.400.w | 100 | number | - | 400<br>299 |
| images.front.sizes.full | 100 | object | - | {"h":1407,"w":2364}<br>{"h":1217,"w":2052} |
| images.front.sizes.full.h | 100 | number | - | 1407<br>1217 |
| images.front.sizes.full.w | 100 | number | - | 2364<br>2052 |
| images.front.white_magic | 100 | null, string | - | null<br>false |
| images.ingredients | 30 | object | - | {"rev":"8","normalize":null,"geometry":"0x0--3--3","ocr":1,"imgid":"3","white_magic":null,"sizes":{"100":{"h":72,"w":100...<br>{"sizes":{"100":{"w":100,"h":54},"200":{"w":200,"h":109},"400":{"w":400,"h":217},"full":{"h":471,"w":867}},"orientation"... |
| images.ingredients_de | 1 | object | - | {"rev":"13","x2":-1,"y1":-1,"ocr":1,"y2":-1,"x1":-1,"geometry":"0x0--10--10","imgid":"6","orientation":"0","normalize":n... |
| images.ingredients_de.angle | 1 | number | - | 0 |
| images.ingredients_de.geometry | 1 | string | - | 0x0--10--10 |
| images.ingredients_de.imgid | 1 | string | - | 6 |
| images.ingredients_de.normalize | 1 | null | - | null |
| images.ingredients_de.ocr | 1 | number | - | 1 |
| images.ingredients_de.orientation | 1 | string | - | 0 |
| images.ingredients_de.rev | 1 | string | - | 13 |
| images.ingredients_de.sizes | 1 | object | - | {"100":{"h":100,"w":75},"200":{"h":200,"w":150},"400":{"h":400,"w":300},"full":{"w":3024,"h":4030}} |
| images.ingredients_de.sizes.100 | 1 | object | - | {"h":100,"w":75} |
| images.ingredients_de.sizes.100.h | 1 | number | - | 100 |
| images.ingredients_de.sizes.100.w | 1 | number | - | 75 |
| images.ingredients_de.sizes.200 | 1 | object | - | {"h":200,"w":150} |
| images.ingredients_de.sizes.200.h | 1 | number | - | 200 |
| images.ingredients_de.sizes.200.w | 1 | number | - | 150 |
| images.ingredients_de.sizes.400 | 1 | object | - | {"h":400,"w":300} |
| images.ingredients_de.sizes.400.h | 1 | number | - | 400 |
| images.ingredients_de.sizes.400.w | 1 | number | - | 300 |
| images.ingredients_de.sizes.full | 1 | object | - | {"w":3024,"h":4030} |
| images.ingredients_de.sizes.full.h | 1 | number | - | 4030 |
| images.ingredients_de.sizes.full.w | 1 | number | - | 3024 |
| images.ingredients_de.white_magic | 1 | null | - | null |
| images.ingredients_de.x1 | 1 | number | - | -1 |
| images.ingredients_de.x2 | 1 | number | - | -1 |
| images.ingredients_de.y1 | 1 | number | - | -1 |
| images.ingredients_de.y2 | 1 | number | - | -1 |
| images.ingredients_en | 103 | object | - | {"white_magic":null,"y1":"-1","normalize":null,"x1":"-1","angle":0,"rev":"5","sizes":{"100":{"h":100,"w":93},"200":{"h":...<br>{"rev":"8","normalize":null,"geometry":"0x0--3--3","ocr":1,"imgid":"3","white_magic":null,"sizes":{"100":{"h":72,"w":100... |
| images.ingredients_en.angle | 81 | null, number, string | - | 0<br>-270 |
| images.ingredients_en.coordinates_image_size | 27 | string | - | full<br>400 |
| images.ingredients_en.geometry | 103 | string | - | 0x0--1--1<br>0x0--3--3 |
| images.ingredients_en.imgid | 103 | string | - | 1<br>3 |
| images.ingredients_en.normalize | 103 | null, string | - | null<br>false |
| images.ingredients_en.ocr | 59 | number | - | 1 |
| images.ingredients_en.orientation | 59 | null, string | - | 0<br>null |
| images.ingredients_en.rev | 103 | string | - | 5<br>8 |
| images.ingredients_en.sizes | 103 | object | - | {"100":{"h":100,"w":93},"200":{"h":200,"w":186},"400":{"h":400,"w":373},"full":{"w":1555,"h":1668}}<br>{"100":{"h":72,"w":100},"200":{"h":143,"w":200},"400":{"h":287,"w":400},"full":{"w":1316,"h":944}} |
| images.ingredients_en.sizes.100 | 103 | object | - | {"h":100,"w":93}<br>{"h":72,"w":100} |
| images.ingredients_en.sizes.100.h | 103 | number | - | 100<br>72 |
| images.ingredients_en.sizes.100.w | 103 | number | - | 93<br>100 |
| images.ingredients_en.sizes.200 | 103 | object | - | {"h":200,"w":186}<br>{"h":143,"w":200} |
| images.ingredients_en.sizes.200.h | 103 | number | - | 200<br>143 |
| images.ingredients_en.sizes.200.w | 103 | number | - | 186<br>200 |
| images.ingredients_en.sizes.400 | 103 | object | - | {"h":400,"w":373}<br>{"h":287,"w":400} |
| images.ingredients_en.sizes.400.h | 103 | number | - | 400<br>287 |
| images.ingredients_en.sizes.400.w | 103 | number | - | 373<br>400 |
| images.ingredients_en.sizes.full | 103 | object | - | {"w":1555,"h":1668}<br>{"w":1316,"h":944} |
| images.ingredients_en.sizes.full.h | 103 | number | - | 1668<br>944 |
| images.ingredients_en.sizes.full.w | 103 | number | - | 1555<br>1316 |
| images.ingredients_en.white_magic | 103 | null, string | - | null<br>false |
| images.ingredients_en.x1 | 81 | null, number, string | - | -1<br>133.10546875 |
| images.ingredients_en.x2 | 81 | null, number, string | - | -1<br>257.078125 |
| images.ingredients_en.y1 | 81 | null, number, string | - | -1<br>165.9296875 |
| images.ingredients_en.y2 | 81 | null, number, string | - | -1<br>209.14453125 |
| images.ingredients_fr | 280 | object | - | {"y1":"186.61997985839847","x2":"294.6699523925782","rev":"10","sizes":{"100":{"h":50,"w":100},"200":{"w":200,"h":100},"...<br>{"imgid":"2","orientation":null,"normalize":"0","white_magic":"0","angle":null,"sizes":{"100":{"h":57,"w":100},"200":{"w... |
| images.ingredients_fr.angle | 276 | null, number, string | - | 90<br>null |
| images.ingredients_fr.coordinates_image_size | 26 | string | - | full<br>400 |
| images.ingredients_fr.geometry | 280 | string | - | 1095x545-83-746<br>0x0-0-0 |
| images.ingredients_fr.imgid | 280 | string | - | 2<br>1 |
| images.ingredients_fr.normalize | 280 | null, string | - | false<br>0 |
| images.ingredients_fr.ocr | 238 | number | - | 1 |
| images.ingredients_fr.orientation | 238 | null, string | - | 0<br>null |
| images.ingredients_fr.rev | 280 | number, string | - | 10<br>7 |
| images.ingredients_fr.sizes | 280 | object | - | {"100":{"h":50,"w":100},"200":{"w":200,"h":100},"400":{"w":400,"h":199},"full":{"w":1095,"h":545}}<br>{"100":{"h":57,"w":100},"200":{"w":200,"h":115},"400":{"h":229,"w":400},"full":{"h":1200,"w":2095}} |
| images.ingredients_fr.sizes.100 | 280 | object | - | {"h":50,"w":100}<br>{"h":57,"w":100} |
| images.ingredients_fr.sizes.100.h | 280 | number | - | 50<br>57 |
| images.ingredients_fr.sizes.100.w | 280 | number | - | 100<br>75 |
| images.ingredients_fr.sizes.200 | 280 | object | - | {"w":200,"h":100}<br>{"w":200,"h":115} |
| images.ingredients_fr.sizes.200.h | 280 | number | - | 100<br>115 |
| images.ingredients_fr.sizes.200.w | 280 | number | - | 200<br>150 |
| images.ingredients_fr.sizes.400 | 280 | object | - | {"w":400,"h":199}<br>{"h":229,"w":400} |
| images.ingredients_fr.sizes.400.h | 280 | number | - | 199<br>229 |
| images.ingredients_fr.sizes.400.w | 280 | number | - | 400<br>300 |
| images.ingredients_fr.sizes.full | 280 | object | - | {"w":1095,"h":545}<br>{"h":1200,"w":2095} |
| images.ingredients_fr.sizes.full.h | 280 | number | - | 545<br>1200 |
| images.ingredients_fr.sizes.full.w | 280 | number | - | 1095<br>2095 |
| images.ingredients_fr.white_magic | 280 | null, string | - | false<br>0 |
| images.ingredients_fr.x1 | 276 | null, string | - | 20.869995117187503<br>null |
| images.ingredients_fr.x2 | 276 | null, string | - | 294.6699523925782<br>null |
| images.ingredients_fr.y1 | 276 | null, string | - | 186.61997985839847<br>null |
| images.ingredients_fr.y2 | 276 | null, string | - | 323.1697845458985<br>null |
| images.ingredients_it | 1 | object | - | {"white_magic":null,"sizes":{"100":{"h":100,"w":75},"200":{"w":150,"h":200},"400":{"w":300,"h":400},"full":{"w":2448,"h"... |
| images.ingredients_it.geometry | 1 | string | - | 0x0--8--8 |
| images.ingredients_it.imgid | 1 | string | - | 2 |
| images.ingredients_it.normalize | 1 | string | - | checked |
| images.ingredients_it.ocr | 1 | number | - | 1 |
| images.ingredients_it.orientation | 1 | string | - | 0 |
| images.ingredients_it.rev | 1 | string | - | 8 |
| images.ingredients_it.sizes | 1 | object | - | {"100":{"h":100,"w":75},"200":{"w":150,"h":200},"400":{"w":300,"h":400},"full":{"w":2448,"h":3264}} |
| images.ingredients_it.sizes.100 | 1 | object | - | {"h":100,"w":75} |
| images.ingredients_it.sizes.100.h | 1 | number | - | 100 |
| images.ingredients_it.sizes.100.w | 1 | number | - | 75 |
| images.ingredients_it.sizes.200 | 1 | object | - | {"w":150,"h":200} |
| images.ingredients_it.sizes.200.h | 1 | number | - | 200 |
| images.ingredients_it.sizes.200.w | 1 | number | - | 150 |
| images.ingredients_it.sizes.400 | 1 | object | - | {"w":300,"h":400} |
| images.ingredients_it.sizes.400.h | 1 | number | - | 400 |
| images.ingredients_it.sizes.400.w | 1 | number | - | 300 |
| images.ingredients_it.sizes.full | 1 | object | - | {"w":2448,"h":3264} |
| images.ingredients_it.sizes.full.h | 1 | number | - | 3264 |
| images.ingredients_it.sizes.full.w | 1 | number | - | 2448 |
| images.ingredients_it.white_magic | 1 | null | - | null |
| images.ingredients_nl | 5 | object | - | {"rev":"35","x2":"-1","y1":"-1","y2":"-1","x1":"-1","geometry":"0x0--3--3","imgid":"11","normalize":null,"white_magic":n...<br>{"x2":"3626.125291511194","y1":"2060.2651031949626","rev":"17","angle":"270","sizes":{"100":{"h":10,"w":100},"200":{"w":... |
| images.ingredients_nl.angle | 4 | number, string | - | 0<br>270 |
| images.ingredients_nl.geometry | 5 | string | - | 0x0--3--3<br>3210x321-416-2060 |
| images.ingredients_nl.imgid | 5 | string | - | 11<br>2 |
| images.ingredients_nl.normalize | 5 | null, string | - | null<br>false |
| images.ingredients_nl.ocr | 2 | number | - | 1 |
| images.ingredients_nl.orientation | 2 | string | - | 0 |
| images.ingredients_nl.rev | 5 | string | - | 35<br>17 |
| images.ingredients_nl.sizes | 5 | object | - | {"100":{"h":44,"w":100},"200":{"h":89,"w":200},"400":{"h":177,"w":400},"full":{"w":1561,"h":692}}<br>{"100":{"h":10,"w":100},"200":{"w":200,"h":20},"400":{"h":40,"w":400},"full":{"w":3210,"h":321}} |
| images.ingredients_nl.sizes.100 | 5 | object | - | {"h":44,"w":100}<br>{"h":10,"w":100} |
| images.ingredients_nl.sizes.100.h | 5 | number | - | 44<br>10 |
| images.ingredients_nl.sizes.100.w | 5 | number | - | 100 |
| images.ingredients_nl.sizes.200 | 5 | object | - | {"h":89,"w":200}<br>{"w":200,"h":20} |
| images.ingredients_nl.sizes.200.h | 5 | number | - | 89<br>20 |
| images.ingredients_nl.sizes.200.w | 5 | number | - | 200 |
| images.ingredients_nl.sizes.400 | 5 | object | - | {"h":177,"w":400}<br>{"h":40,"w":400} |
| images.ingredients_nl.sizes.400.h | 5 | number | - | 177<br>40 |
| images.ingredients_nl.sizes.400.w | 5 | number | - | 400 |
| images.ingredients_nl.sizes.full | 5 | object | - | {"w":1561,"h":692}<br>{"w":3210,"h":321} |
| images.ingredients_nl.sizes.full.h | 5 | number | - | 692<br>321 |
| images.ingredients_nl.sizes.full.w | 5 | number | - | 1561<br>3210 |
| images.ingredients_nl.white_magic | 5 | null, string | - | null<br>false |
| images.ingredients_nl.x1 | 4 | string | - | -1<br>416.57305270522386 |
| images.ingredients_nl.x2 | 4 | string | - | -1<br>3626.125291511194 |
| images.ingredients_nl.y1 | 4 | string | - | -1<br>2060.2651031949626 |
| images.ingredients_nl.y2 | 4 | string | - | -1<br>2381.22032707556 |
| images.ingredients_ru | 1 | object | - | {"normalize":null,"y2":"-1","y1":"-1","angle":0,"geometry":"0x0--1--1","rev":"5","x2":"-1","coordinates_image_size":"ful... |
| images.ingredients_ru.angle | 1 | number | - | 0 |
| images.ingredients_ru.coordinates_image_size | 1 | string | - | full |
| images.ingredients_ru.geometry | 1 | string | - | 0x0--1--1 |
| images.ingredients_ru.imgid | 1 | string | - | 2 |
| images.ingredients_ru.normalize | 1 | null | - | null |
| images.ingredients_ru.rev | 1 | string | - | 5 |
| images.ingredients_ru.sizes | 1 | object | - | {"100":{"h":100,"w":75},"200":{"w":150,"h":200},"400":{"w":300,"h":400},"full":{"w":3024,"h":4032}} |
| images.ingredients_ru.sizes.100 | 1 | object | - | {"h":100,"w":75} |
| images.ingredients_ru.sizes.100.h | 1 | number | - | 100 |
| images.ingredients_ru.sizes.100.w | 1 | number | - | 75 |
| images.ingredients_ru.sizes.200 | 1 | object | - | {"w":150,"h":200} |
| images.ingredients_ru.sizes.200.h | 1 | number | - | 200 |
| images.ingredients_ru.sizes.200.w | 1 | number | - | 150 |
| images.ingredients_ru.sizes.400 | 1 | object | - | {"w":300,"h":400} |
| images.ingredients_ru.sizes.400.h | 1 | number | - | 400 |
| images.ingredients_ru.sizes.400.w | 1 | number | - | 300 |
| images.ingredients_ru.sizes.full | 1 | object | - | {"w":3024,"h":4032} |
| images.ingredients_ru.sizes.full.h | 1 | number | - | 4032 |
| images.ingredients_ru.sizes.full.w | 1 | number | - | 3024 |
| images.ingredients_ru.white_magic | 1 | null | - | null |
| images.ingredients_ru.x1 | 1 | string | - | -1 |
| images.ingredients_ru.x2 | 1 | string | - | -1 |
| images.ingredients_ru.y1 | 1 | string | - | -1 |
| images.ingredients_ru.y2 | 1 | string | - | -1 |
| images.ingredients.geometry | 30 | string | - | 0x0--3--3<br>0x0--2--2 |
| images.ingredients.imgid | 30 | string | - | 3<br>2 |
| images.ingredients.normalize | 30 | null, string | - | null<br>checked |
| images.ingredients.ocr | 29 | number | - | 1 |
| images.ingredients.orientation | 29 | string | - | 0<br>90 |
| images.ingredients.rev | 30 | string | - | 8<br>9 |
| images.ingredients.sizes | 30 | object | - | {"100":{"h":72,"w":100},"200":{"h":143,"w":200},"400":{"h":287,"w":400},"full":{"w":1316,"h":944}}<br>{"100":{"w":100,"h":54},"200":{"w":200,"h":109},"400":{"w":400,"h":217},"full":{"h":471,"w":867}} |
| images.ingredients.sizes.100 | 30 | object | - | {"h":72,"w":100}<br>{"w":100,"h":54} |
| images.ingredients.sizes.100.h | 30 | number | - | 72<br>54 |
| images.ingredients.sizes.100.w | 30 | number | - | 100<br>75 |
| images.ingredients.sizes.200 | 30 | object | - | {"h":143,"w":200}<br>{"w":200,"h":109} |
| images.ingredients.sizes.200.h | 30 | number | - | 143<br>109 |
| images.ingredients.sizes.200.w | 30 | number | - | 200<br>150 |
| images.ingredients.sizes.400 | 30 | object | - | {"h":287,"w":400}<br>{"w":400,"h":217} |
| images.ingredients.sizes.400.h | 30 | number | - | 287<br>217 |
| images.ingredients.sizes.400.w | 30 | number | - | 400<br>300 |
| images.ingredients.sizes.full | 30 | object | - | {"w":1316,"h":944}<br>{"h":471,"w":867} |
| images.ingredients.sizes.full.h | 30 | number | - | 944<br>471 |
| images.ingredients.sizes.full.w | 30 | number | - | 1316<br>867 |
| images.ingredients.white_magic | 30 | null, string | - | null<br>false |
| images.nutrition | 33 | object | - | {"ocr":1,"normalize":null,"geometry":"0x0--3--3","rev":"11","imgid":"2","white_magic":null,"orientation":"0","sizes":{"1...<br>{"sizes":{"100":{"h":100,"w":48},"200":{"h":200,"w":96},"400":{"w":192,"h":400},"full":{"w":812,"h":1693}},"orientation"... |
| images.nutrition_de | 3 | object | - | {"rev":"10","y1":-1,"x2":-1,"ocr":1,"geometry":"0x0--3--3","y2":-1,"x1":-1,"orientation":"0","normalize":null,"imgid":"5...<br>{"x2":"-1","coordinates_image_size":"full","angle":0,"y1":"-1","x1":"-1","rev":"5","geometry":"0x0--1--1","y2":"-1","whi... |
| images.nutrition_de.angle | 3 | number | - | 0 |
| images.nutrition_de.coordinates_image_size | 1 | string | - | full |
| images.nutrition_de.geometry | 3 | string | - | 0x0--3--3<br>0x0--1--1 |
| images.nutrition_de.imgid | 3 | string | - | 5<br>2 |
| images.nutrition_de.normalize | 3 | null | - | null |
| images.nutrition_de.ocr | 2 | number | - | 1 |
| images.nutrition_de.orientation | 2 | string | - | 0 |
| images.nutrition_de.rev | 3 | string | - | 10<br>5 |
| images.nutrition_de.sizes | 3 | object | - | {"100":{"h":100,"w":71},"200":{"w":142,"h":200},"400":{"w":284,"h":400},"full":{"h":1360,"w":966}}<br>{"100":{"w":80,"h":100},"200":{"w":160,"h":200},"400":{"w":320,"h":400},"full":{"h":764,"w":611}} |
| images.nutrition_de.sizes.100 | 3 | object | - | {"h":100,"w":71}<br>{"w":80,"h":100} |
| images.nutrition_de.sizes.100.h | 3 | number | - | 100 |
| images.nutrition_de.sizes.100.w | 3 | number | - | 71<br>80 |
| images.nutrition_de.sizes.200 | 3 | object | - | {"w":142,"h":200}<br>{"w":160,"h":200} |
| images.nutrition_de.sizes.200.h | 3 | number | - | 200 |
| images.nutrition_de.sizes.200.w | 3 | number | - | 142<br>160 |
| images.nutrition_de.sizes.400 | 3 | object | - | {"w":284,"h":400}<br>{"w":320,"h":400} |
| images.nutrition_de.sizes.400.h | 3 | number | - | 400 |
| images.nutrition_de.sizes.400.w | 3 | number | - | 284<br>320 |
| images.nutrition_de.sizes.full | 3 | object | - | {"h":1360,"w":966}<br>{"h":764,"w":611} |
| images.nutrition_de.sizes.full.h | 3 | number | - | 1360<br>764 |
| images.nutrition_de.sizes.full.w | 3 | number | - | 966<br>611 |
| images.nutrition_de.white_magic | 3 | null | - | null |
| images.nutrition_de.x1 | 3 | number, string | - | -1 |
| images.nutrition_de.x2 | 3 | number, string | - | -1 |
| images.nutrition_de.y1 | 3 | number, string | - | -1 |
| images.nutrition_de.y2 | 3 | number, string | - | -1 |
| images.nutrition_en | 236 | object | - | {"normalize":null,"angle":0,"y1":"-1","y2":"-1","geometry":"0x0--1--1","sizes":{"100":{"h":100,"w":88},"200":{"w":177,"h...<br>{"ocr":1,"normalize":null,"geometry":"0x0--3--3","rev":"11","imgid":"2","white_magic":null,"orientation":"0","sizes":{"1... |
| images.nutrition_en.angle | 215 | null, number, string | - | 0<br>-90 |
| images.nutrition_en.coordinates_image_size | 165 | string | - | full<br>400 |
| images.nutrition_en.geometry | 236 | string | - | 0x0--1--1<br>0x0--3--3 |
| images.nutrition_en.imgid | 236 | number, string | - | 3<br>2 |
| images.nutrition_en.normalize | 236 | null, string | - | null<br>true |
| images.nutrition_en.ocr | 41 | number | - | 1 |
| images.nutrition_en.orientation | 41 | null, string | - | 0<br>null |
| images.nutrition_en.rev | 236 | number, string | - | 9<br>11 |
| images.nutrition_en.sizes | 236 | object | - | {"100":{"h":100,"w":88},"200":{"w":177,"h":200},"400":{"w":353,"h":400},"full":{"w":1014,"h":1148}}<br>{"100":{"h":100,"w":50},"200":{"h":200,"w":100},"400":{"h":400,"w":200},"full":{"h":1437,"w":718}} |
| images.nutrition_en.sizes.100 | 236 | object | - | {"h":100,"w":88}<br>{"h":100,"w":50} |
| images.nutrition_en.sizes.100.h | 236 | number | - | 100<br>18 |
| images.nutrition_en.sizes.100.w | 236 | number | - | 88<br>50 |
| images.nutrition_en.sizes.200 | 236 | object | - | {"w":177,"h":200}<br>{"h":200,"w":100} |
| images.nutrition_en.sizes.200.h | 236 | number | - | 200<br>37 |
| images.nutrition_en.sizes.200.w | 236 | number | - | 177<br>100 |
| images.nutrition_en.sizes.400 | 236 | object | - | {"w":353,"h":400}<br>{"h":400,"w":200} |
| images.nutrition_en.sizes.400.h | 236 | number | - | 400<br>74 |
| images.nutrition_en.sizes.400.w | 236 | number | - | 353<br>200 |
| images.nutrition_en.sizes.full | 236 | object | - | {"w":1014,"h":1148}<br>{"h":1437,"w":718} |
| images.nutrition_en.sizes.full.h | 236 | number | - | 1148<br>1437 |
| images.nutrition_en.sizes.full.w | 236 | number | - | 1014<br>718 |
| images.nutrition_en.white_magic | 236 | null, string | - | null<br>false |
| images.nutrition_en.x1 | 215 | null, number, string | - | -1<br>52.92452830188679 |
| images.nutrition_en.x2 | 215 | null, number, string | - | -1<br>394.35849056603774 |
| images.nutrition_en.y1 | 215 | null, number, string | - | -1<br>20.481128332749854 |
| images.nutrition_en.y2 | 215 | null, number, string | - | -1<br>429.00000000000006 |
| images.nutrition_fr | 125 | object | - | {"imgid":"3","normalize":null,"sizes":{"100":{"h":94,"w":100},"200":{"h":188,"w":200},"400":{"h":376,"w":400},"full":{"h...<br>{"rev":"10","x2":null,"y1":null,"y2":null,"x1":null,"geometry":"0x0-0-0","ocr":1,"sizes":{"100":{"h":63,"w":100},"200":{... |
| images.nutrition_fr.angle | 121 | null, number, string | - | 0<br>null |
| images.nutrition_fr.coordinates_image_size | 31 | string | - | full<br>400 |
| images.nutrition_fr.geometry | 125 | string | - | 0x0--3--3<br>0x0-0-0 |
| images.nutrition_fr.imgid | 125 | number, string | - | 3<br>2 |
| images.nutrition_fr.normalize | 125 | null, string | - | null<br>0 |
| images.nutrition_fr.ocr | 77 | number | - | 1<br>0 |
| images.nutrition_fr.orientation | 76 | null, string | - | 0<br>null |
| images.nutrition_fr.rev | 125 | number, string | - | 15<br>10 |
| images.nutrition_fr.sizes | 125 | object | - | {"100":{"h":94,"w":100},"200":{"h":188,"w":200},"400":{"h":376,"w":400},"full":{"h":1200,"w":1278}}<br>{"100":{"h":63,"w":100},"200":{"h":127,"w":200},"400":{"w":400,"h":253},"full":{"h":1200,"w":1895}} |
| images.nutrition_fr.sizes.100 | 125 | object | - | {"h":94,"w":100}<br>{"h":63,"w":100} |
| images.nutrition_fr.sizes.100.h | 125 | number | - | 94<br>63 |
| images.nutrition_fr.sizes.100.w | 125 | number | - | 100<br>75 |
| images.nutrition_fr.sizes.200 | 125 | object | - | {"h":188,"w":200}<br>{"h":127,"w":200} |
| images.nutrition_fr.sizes.200.h | 125 | number | - | 188<br>127 |
| images.nutrition_fr.sizes.200.w | 125 | number | - | 200<br>150 |
| images.nutrition_fr.sizes.400 | 125 | object | - | {"h":376,"w":400}<br>{"w":400,"h":253} |
| images.nutrition_fr.sizes.400.h | 125 | number | - | 376<br>253 |
| images.nutrition_fr.sizes.400.w | 125 | number | - | 400<br>300 |
| images.nutrition_fr.sizes.full | 125 | object | - | {"h":1200,"w":1278}<br>{"h":1200,"w":1895} |
| images.nutrition_fr.sizes.full.h | 125 | number | - | 1200<br>1164 |
| images.nutrition_fr.sizes.full.w | 125 | number | - | 1278<br>1895 |
| images.nutrition_fr.white_magic | 125 | null, string | - | null<br>0 |
| images.nutrition_fr.x1 | 121 | null, number, string | - | -1<br>null |
| images.nutrition_fr.x2 | 121 | null, number, string | - | -1<br>null |
| images.nutrition_fr.y1 | 121 | null, number, string | - | -1<br>null |
| images.nutrition_fr.y2 | 121 | null, number, string | - | -1<br>null |
| images.nutrition_it | 2 | object | - | {"sizes":{"100":{"h":100,"w":75},"200":{"w":150,"h":200},"400":{"w":300,"h":400},"full":{"h":3264,"w":2448}},"white_magi...<br>{"y2":-1,"imgid":3,"coordinates_image_size":"full","x1":-1,"angle":0,"normalize":null,"geometry":"0x0--1--1","white_magi... |
| images.nutrition_it.angle | 1 | number | - | 0 |
| images.nutrition_it.coordinates_image_size | 1 | string | - | full |
| images.nutrition_it.geometry | 2 | string | - | 0x0--8--8<br>0x0--1--1 |
| images.nutrition_it.imgid | 2 | number, string | - | 2<br>3 |
| images.nutrition_it.normalize | 2 | null, string | - | checked<br>null |
| images.nutrition_it.ocr | 1 | number | - | 1 |
| images.nutrition_it.orientation | 1 | string | - | 0 |
| images.nutrition_it.rev | 2 | number, string | - | 9<br>13 |
| images.nutrition_it.sizes | 2 | object | - | {"100":{"h":100,"w":75},"200":{"w":150,"h":200},"400":{"w":300,"h":400},"full":{"h":3264,"w":2448}}<br>{"100":{"h":100,"w":75},"200":{"w":150,"h":200},"400":{"h":400,"w":300},"full":{"h":1700,"w":1275}} |
| images.nutrition_it.sizes.100 | 2 | object | - | {"h":100,"w":75} |
| images.nutrition_it.sizes.100.h | 2 | number | - | 100 |
| images.nutrition_it.sizes.100.w | 2 | number | - | 75 |
| images.nutrition_it.sizes.200 | 2 | object | - | {"w":150,"h":200} |
| images.nutrition_it.sizes.200.h | 2 | number | - | 200 |
| images.nutrition_it.sizes.200.w | 2 | number | - | 150 |
| images.nutrition_it.sizes.400 | 2 | object | - | {"w":300,"h":400}<br>{"h":400,"w":300} |
| images.nutrition_it.sizes.400.h | 2 | number | - | 400 |
| images.nutrition_it.sizes.400.w | 2 | number | - | 300 |
| images.nutrition_it.sizes.full | 2 | object | - | {"h":3264,"w":2448}<br>{"h":1700,"w":1275} |
| images.nutrition_it.sizes.full.h | 2 | number | - | 3264<br>1700 |
| images.nutrition_it.sizes.full.w | 2 | number | - | 2448<br>1275 |
| images.nutrition_it.white_magic | 2 | null | - | null |
| images.nutrition_it.x1 | 1 | number | - | -1 |
| images.nutrition_it.x2 | 1 | number | - | -1 |
| images.nutrition_it.y1 | 1 | number | - | -1 |
| images.nutrition_it.y2 | 1 | number | - | -1 |
| images.nutrition_nl | 1 | object | - | {"ocr":1,"geometry":"800x660-916-516","x1":"137.5","y2":"176.566650390625","orientation":"0","normalize":"true","imgid":... |
| images.nutrition_nl.angle | 1 | string | - | 0 |
| images.nutrition_nl.geometry | 1 | string | - | 800x660-916-516 |
| images.nutrition_nl.imgid | 1 | string | - | 1 |
| images.nutrition_nl.normalize | 1 | string | - | true |
| images.nutrition_nl.ocr | 1 | number | - | 1 |
| images.nutrition_nl.orientation | 1 | string | - | 0 |
| images.nutrition_nl.rev | 1 | string | - | 30 |
| images.nutrition_nl.sizes | 1 | object | - | {"100":{"w":100,"h":83},"200":{"h":165,"w":200},"400":{"w":400,"h":330},"full":{"w":800,"h":660}} |
| images.nutrition_nl.sizes.100 | 1 | object | - | {"w":100,"h":83} |
| images.nutrition_nl.sizes.100.h | 1 | number | - | 83 |
| images.nutrition_nl.sizes.100.w | 1 | number | - | 100 |
| images.nutrition_nl.sizes.200 | 1 | object | - | {"h":165,"w":200} |
| images.nutrition_nl.sizes.200.h | 1 | number | - | 165 |
| images.nutrition_nl.sizes.200.w | 1 | number | - | 200 |
| images.nutrition_nl.sizes.400 | 1 | object | - | {"w":400,"h":330} |
| images.nutrition_nl.sizes.400.h | 1 | number | - | 330 |
| images.nutrition_nl.sizes.400.w | 1 | number | - | 400 |
| images.nutrition_nl.sizes.full | 1 | object | - | {"w":800,"h":660} |
| images.nutrition_nl.sizes.full.h | 1 | number | - | 660 |
| images.nutrition_nl.sizes.full.w | 1 | number | - | 800 |
| images.nutrition_nl.white_magic | 1 | string | - | false |
| images.nutrition_nl.x1 | 1 | string | - | 137.5 |
| images.nutrition_nl.x2 | 1 | string | - | 257.5 |
| images.nutrition_nl.y1 | 1 | string | - | 77.566650390625 |
| images.nutrition_nl.y2 | 1 | string | - | 176.566650390625 |
| images.nutrition.geometry | 33 | string | - | 0x0--3--3<br>0x0--4--4 |
| images.nutrition.imgid | 33 | string | - | 2<br>4 |
| images.nutrition.normalize | 33 | null, string | - | null<br>true |
| images.nutrition.ocr | 32 | number | - | 1 |
| images.nutrition.orientation | 32 | null, string | - | 0<br>null |
| images.nutrition.rev | 33 | string | - | 11<br>10 |
| images.nutrition.sizes | 33 | object | - | {"100":{"h":100,"w":50},"200":{"h":200,"w":100},"400":{"h":400,"w":200},"full":{"h":1437,"w":718}}<br>{"100":{"h":100,"w":48},"200":{"h":200,"w":96},"400":{"w":192,"h":400},"full":{"w":812,"h":1693}} |
| images.nutrition.sizes.100 | 33 | object | - | {"h":100,"w":50}<br>{"h":100,"w":48} |
| images.nutrition.sizes.100.h | 33 | number | - | 100<br>36 |
| images.nutrition.sizes.100.w | 33 | number | - | 50<br>48 |
| images.nutrition.sizes.200 | 33 | object | - | {"h":200,"w":100}<br>{"h":200,"w":96} |
| images.nutrition.sizes.200.h | 33 | number | - | 200<br>71 |
| images.nutrition.sizes.200.w | 33 | number | - | 100<br>96 |
| images.nutrition.sizes.400 | 33 | object | - | {"h":400,"w":200}<br>{"w":192,"h":400} |
| images.nutrition.sizes.400.h | 33 | number | - | 400<br>142 |
| images.nutrition.sizes.400.w | 33 | number | - | 200<br>192 |
| images.nutrition.sizes.full | 33 | object | - | {"h":1437,"w":718}<br>{"w":812,"h":1693} |
| images.nutrition.sizes.full.h | 33 | number | - | 1437<br>1693 |
| images.nutrition.sizes.full.w | 33 | number | - | 718<br>812 |
| images.nutrition.white_magic | 33 | null, string | - | null<br>false |
| images.packaging_en | 4 | object | - | {"x2":"-1","imgid":"2","coordinates_image_size":"full","geometry":"0x0--1--1","y2":"-1","angle":0,"sizes":{"100":{"h":10...<br>{"y1":"-1","x2":"-1","coordinates_image_size":"full","rev":"44","normalize":null,"imgid":"13","angle":0,"sizes":{"100":{... |
| images.packaging_en.angle | 4 | number | - | 0 |
| images.packaging_en.coordinates_image_size | 3 | string | - | full |
| images.packaging_en.geometry | 4 | string | - | 0x0--1--1 |
| images.packaging_en.imgid | 4 | string | - | 2<br>13 |
| images.packaging_en.normalize | 4 | null | - | null |
| images.packaging_en.rev | 4 | string | - | 8<br>44 |
| images.packaging_en.sizes | 4 | object | - | {"100":{"h":100,"w":99},"200":{"h":200,"w":199},"400":{"w":397,"h":400},"full":{"w":400,"h":403}}<br>{"100":{"w":100,"h":70},"200":{"w":200,"h":140},"400":{"w":400,"h":280},"full":{"w":1016,"h":711}} |
| images.packaging_en.sizes.100 | 4 | object | - | {"h":100,"w":99}<br>{"w":100,"h":70} |
| images.packaging_en.sizes.100.h | 4 | number | - | 100<br>70 |
| images.packaging_en.sizes.100.w | 4 | number | - | 99<br>100 |
| images.packaging_en.sizes.200 | 4 | object | - | {"h":200,"w":199}<br>{"w":200,"h":140} |
| images.packaging_en.sizes.200.h | 4 | number | - | 200<br>140 |
| images.packaging_en.sizes.200.w | 4 | number | - | 199<br>200 |
| images.packaging_en.sizes.400 | 4 | object | - | {"w":397,"h":400}<br>{"w":400,"h":280} |
| images.packaging_en.sizes.400.h | 4 | number | - | 400<br>280 |
| images.packaging_en.sizes.400.w | 4 | number | - | 397<br>400 |
| images.packaging_en.sizes.full | 4 | object | - | {"w":400,"h":403}<br>{"w":1016,"h":711} |
| images.packaging_en.sizes.full.h | 4 | number | - | 403<br>711 |
| images.packaging_en.sizes.full.w | 4 | number | - | 400<br>1016 |
| images.packaging_en.white_magic | 4 | null | - | null |
| images.packaging_en.x1 | 4 | string | - | -1 |
| images.packaging_en.x2 | 4 | string | - | -1 |
| images.packaging_en.y1 | 4 | string | - | -1 |
| images.packaging_en.y2 | 4 | string | - | -1 |
| images.packaging_fr | 2 | object | - | {"y2":"-1","x1":"-1","geometry":"0x0--1--1","white_magic":null,"angle":0,"sizes":{"100":{"w":100,"h":61},"200":{"w":200,...<br>{"geometry":"0x0--1--1","x1":"-1","y2":"-1","white_magic":null,"angle":0,"sizes":{"100":{"h":100,"w":75},"200":{"h":200,... |
| images.packaging_fr.angle | 2 | number | - | 0 |
| images.packaging_fr.coordinates_image_size | 2 | string | - | full |
| images.packaging_fr.geometry | 2 | string | - | 0x0--1--1 |
| images.packaging_fr.imgid | 2 | string | - | 5<br>12 |
| images.packaging_fr.normalize | 2 | null | - | null |
| images.packaging_fr.rev | 2 | string | - | 23<br>28 |
| images.packaging_fr.sizes | 2 | object | - | {"100":{"w":100,"h":61},"200":{"w":200,"h":123},"400":{"h":246,"w":400},"full":{"h":1335,"w":2173}}<br>{"100":{"h":100,"w":75},"200":{"h":200,"w":150},"400":{"h":400,"w":300},"full":{"h":4032,"w":3024}} |
| images.packaging_fr.sizes.100 | 2 | object | - | {"w":100,"h":61}<br>{"h":100,"w":75} |
| images.packaging_fr.sizes.100.h | 2 | number | - | 61<br>100 |
| images.packaging_fr.sizes.100.w | 2 | number | - | 100<br>75 |
| images.packaging_fr.sizes.200 | 2 | object | - | {"w":200,"h":123}<br>{"h":200,"w":150} |
| images.packaging_fr.sizes.200.h | 2 | number | - | 123<br>200 |
| images.packaging_fr.sizes.200.w | 2 | number | - | 200<br>150 |
| images.packaging_fr.sizes.400 | 2 | object | - | {"h":246,"w":400}<br>{"h":400,"w":300} |
| images.packaging_fr.sizes.400.h | 2 | number | - | 246<br>400 |
| images.packaging_fr.sizes.400.w | 2 | number | - | 400<br>300 |
| images.packaging_fr.sizes.full | 2 | object | - | {"h":1335,"w":2173}<br>{"h":4032,"w":3024} |
| images.packaging_fr.sizes.full.h | 2 | number | - | 1335<br>4032 |
| images.packaging_fr.sizes.full.w | 2 | number | - | 2173<br>3024 |
| images.packaging_fr.white_magic | 2 | null | - | null |
| images.packaging_fr.x1 | 2 | string | - | -1 |
| images.packaging_fr.x2 | 2 | string | - | -1 |
| images.packaging_fr.y1 | 2 | string | - | -1 |
| images.packaging_fr.y2 | 2 | string | - | -1 |
| images.selected | 390 | object | - | {"front":{"en":{"sizes":{"100":{"w":77,"h":100},"200":{"h":200,"w":155},"400":{"w":310,"h":400},"full":{"w":789,"h":1019...<br>{"front":{"fr":{"sizes":{"100":{"w":100,"h":67},"200":{"h":135,"w":200},"400":{"w":400,"h":269},"full":{"h":1200,"w":178... |
| images.selected.front | 353 | object | - | {"en":{"sizes":{"100":{"w":77,"h":100},"200":{"h":200,"w":155},"400":{"w":310,"h":400},"full":{"w":789,"h":1019}},"imgid...<br>{"fr":{"sizes":{"100":{"w":100,"h":67},"200":{"h":135,"w":200},"400":{"w":400,"h":269},"full":{"h":1200,"w":1782}},"gene... |
| images.selected.front.ar | 1 | object | - | {"rev":"3","sizes":{"100":{"h":100,"w":75},"200":{"w":150,"h":200},"400":{"w":300,"h":400},"full":{"h":4032,"w":3024}},"... |
| images.selected.front.ar.generation | 1 | object | - | {} |
| images.selected.front.ar.imgid | 1 | string | - | 1 |
| images.selected.front.ar.rev | 1 | string | - | 3 |
| images.selected.front.ar.sizes | 1 | object | - | {"100":{"h":100,"w":75},"200":{"w":150,"h":200},"400":{"w":300,"h":400},"full":{"h":4032,"w":3024}} |
| images.selected.front.ar.sizes.100 | 1 | object | - | {"h":100,"w":75} |
| images.selected.front.ar.sizes.200 | 1 | object | - | {"w":150,"h":200} |
| images.selected.front.ar.sizes.400 | 1 | object | - | {"w":300,"h":400} |
| images.selected.front.ar.sizes.full | 1 | object | - | {"h":4032,"w":3024} |
| images.selected.front.cs | 1 | object | - | {"imgid":"7","generation":{},"sizes":{"100":{"h":100,"w":76},"200":{"h":200,"w":152},"400":{"w":304,"h":400},"full":{"w"... |
| images.selected.front.cs.generation | 1 | object | - | {} |
| images.selected.front.cs.imgid | 1 | string | - | 7 |
| images.selected.front.cs.rev | 1 | string | - | 23 |
| images.selected.front.cs.sizes | 1 | object | - | {"100":{"h":100,"w":76},"200":{"h":200,"w":152},"400":{"w":304,"h":400},"full":{"w":2815,"h":3705}} |
| images.selected.front.cs.sizes.100 | 1 | object | - | {"h":100,"w":76} |
| images.selected.front.cs.sizes.200 | 1 | object | - | {"h":200,"w":152} |
| images.selected.front.cs.sizes.400 | 1 | object | - | {"w":304,"h":400} |
| images.selected.front.cs.sizes.full | 1 | object | - | {"w":2815,"h":3705} |
| images.selected.front.da | 2 | object | - | {"rev":11,"sizes":{"100":{"h":100,"w":70},"200":{"h":200,"w":140},"400":{"w":280,"h":400},"full":{"w":1017,"h":1453}},"i...<br>{"imgid":"1","generation":{},"rev":"7","sizes":{"100":{"h":100,"w":75},"200":{"w":150,"h":200},"400":{"w":300,"h":400},"... |
| images.selected.front.da.generation | 2 | object | - | {} |
| images.selected.front.da.imgid | 2 | number, string | - | 2<br>1 |
| images.selected.front.da.rev | 2 | number, string | - | 11<br>7 |
| images.selected.front.da.sizes | 2 | object | - | {"100":{"h":100,"w":70},"200":{"h":200,"w":140},"400":{"w":280,"h":400},"full":{"w":1017,"h":1453}}<br>{"100":{"h":100,"w":75},"200":{"w":150,"h":200},"400":{"w":300,"h":400},"full":{"h":1698,"w":1275}} |
| images.selected.front.da.sizes.100 | 2 | object | - | {"h":100,"w":70}<br>{"h":100,"w":75} |
| images.selected.front.da.sizes.200 | 2 | object | - | {"h":200,"w":140}<br>{"w":150,"h":200} |
| images.selected.front.da.sizes.400 | 2 | object | - | {"w":280,"h":400}<br>{"w":300,"h":400} |
| images.selected.front.da.sizes.full | 2 | object | - | {"w":1017,"h":1453}<br>{"h":1698,"w":1275} |
| images.selected.front.en | 302 | object | - | {"sizes":{"100":{"w":77,"h":100},"200":{"h":200,"w":155},"400":{"w":310,"h":400},"full":{"w":789,"h":1019}},"imgid":"1",...<br>{"rev":"5","sizes":{"100":{"h":100,"w":77},"200":{"w":153,"h":200},"400":{"h":400,"w":307},"full":{"w":440,"h":574}},"im... |
| images.selected.front.en.generation | 297 | object | - | {}<br>{"angle":270} |
| images.selected.front.en.generation.angle | 9 | number | - | 270<br>90 |
| images.selected.front.en.generation.coordinates_image_size | 2 | string | - | 400 |
| images.selected.front.en.generation.x1 | 2 | number | - | 23<br>5 |
| images.selected.front.en.generation.x2 | 2 | number | - | 278<br>290 |
| images.selected.front.en.generation.y1 | 2 | number | - | 101<br>98 |
| images.selected.front.en.generation.y2 | 2 | number | - | 322<br>369 |
| images.selected.front.en.imgid | 302 | number, string | - | 1<br>5 |
| images.selected.front.en.rev | 302 | number, string | - | 5<br>4 |
| images.selected.front.en.sizes | 302 | object | - | {"100":{"w":77,"h":100},"200":{"h":200,"w":155},"400":{"w":310,"h":400},"full":{"w":789,"h":1019}}<br>{"100":{"h":100,"w":77},"200":{"w":153,"h":200},"400":{"h":400,"w":307},"full":{"w":440,"h":574}} |
| images.selected.front.en.sizes.100 | 302 | object | - | {"w":77,"h":100}<br>{"h":100,"w":77} |
| images.selected.front.en.sizes.200 | 302 | object | - | {"h":200,"w":155}<br>{"w":153,"h":200} |
| images.selected.front.en.sizes.400 | 302 | object | - | {"w":310,"h":400}<br>{"h":400,"w":307} |
| images.selected.front.en.sizes.full | 302 | object | - | {"w":789,"h":1019}<br>{"w":440,"h":574} |
| images.selected.front.es | 7 | object | - | {"imgid":"1","rev":"8","sizes":{"100":{"w":56,"h":100},"200":{"h":200,"w":113},"400":{"w":225,"h":400},"full":{"w":1127,...<br>{"sizes":{"100":{"w":100,"h":45},"200":{"w":200,"h":89},"400":{"w":400,"h":179},"full":{"w":1364,"h":609}},"generation":... |
| images.selected.front.es.generation | 7 | object | - | {}<br>{"x1":31,"y1":80,"y2":233,"coordinates_image_size":"400","x2":374} |
| images.selected.front.es.generation.coordinates_image_size | 1 | string | - | 400 |
| images.selected.front.es.generation.x1 | 1 | number | - | 31 |
| images.selected.front.es.generation.x2 | 1 | number | - | 374 |
| images.selected.front.es.generation.y1 | 1 | number | - | 80 |
| images.selected.front.es.generation.y2 | 1 | number | - | 233 |
| images.selected.front.es.imgid | 7 | string | - | 1<br>9 |
| images.selected.front.es.rev | 7 | string | - | 8<br>39 |
| images.selected.front.es.sizes | 7 | object | - | {"100":{"w":56,"h":100},"200":{"h":200,"w":113},"400":{"w":225,"h":400},"full":{"w":1127,"h":2000}}<br>{"100":{"w":100,"h":45},"200":{"w":200,"h":89},"400":{"w":400,"h":179},"full":{"w":1364,"h":609}} |
| images.selected.front.es.sizes.100 | 7 | object | - | {"w":56,"h":100}<br>{"w":100,"h":45} |
| images.selected.front.es.sizes.200 | 7 | object | - | {"h":200,"w":113}<br>{"w":200,"h":89} |
| images.selected.front.es.sizes.400 | 7 | object | - | {"w":225,"h":400}<br>{"w":400,"h":179} |
| images.selected.front.es.sizes.full | 7 | object | - | {"w":1127,"h":2000}<br>{"w":1364,"h":609} |
| images.selected.front.fr | 86 | object | - | {"sizes":{"100":{"w":100,"h":67},"200":{"h":135,"w":200},"400":{"w":400,"h":269},"full":{"h":1200,"w":1782}},"generation...<br>{"imgid":"1","sizes":{"100":{"h":100,"w":79},"200":{"h":200,"w":158},"400":{"w":316,"h":400},"full":{"h":1360,"w":1073}}... |
| images.selected.front.fr.generation | 81 | object | - | {}<br>{"y2":277,"coordinates_image_size":"400","x2":153,"x1":47,"y1":63} |
| images.selected.front.fr.generation.angle | 6 | number | - | 270<br>90 |
| images.selected.front.fr.generation.coordinates_image_size | 4 | string | - | 400<br>full |
| images.selected.front.fr.generation.x1 | 4 | number | - | 47<br>10 |
| images.selected.front.fr.generation.x2 | 4 | number | - | 153<br>387 |
| images.selected.front.fr.generation.y1 | 4 | number | - | 63<br>37 |
| images.selected.front.fr.generation.y2 | 4 | number | - | 277<br>278 |
| images.selected.front.fr.imgid | 86 | number, string | - | 1<br>3 |
| images.selected.front.fr.rev | 86 | number, string | - | 4<br>3 |
| images.selected.front.fr.sizes | 86 | object | - | {"100":{"w":100,"h":67},"200":{"h":135,"w":200},"400":{"w":400,"h":269},"full":{"h":1200,"w":1782}}<br>{"100":{"h":100,"w":79},"200":{"h":200,"w":158},"400":{"w":316,"h":400},"full":{"h":1360,"w":1073}} |
| images.selected.front.fr.sizes.100 | 86 | object | - | {"w":100,"h":67}<br>{"h":100,"w":79} |
| images.selected.front.fr.sizes.200 | 86 | object | - | {"h":135,"w":200}<br>{"h":200,"w":158} |
| images.selected.front.fr.sizes.400 | 86 | object | - | {"w":400,"h":269}<br>{"w":316,"h":400} |
| images.selected.front.fr.sizes.full | 86 | object | - | {"h":1200,"w":1782}<br>{"h":1360,"w":1073} |
| images.selected.front.it | 4 | object | - | {"imgid":"1","rev":"5","generation":{"x2":228,"y1":79,"y2":379,"coordinates_image_size":"400","x1":46},"sizes":{"100":{"...<br>{"imgid":"14","rev":"51","generation":{},"sizes":{"100":{"h":100,"w":75},"200":{"w":150,"h":200},"400":{"w":300,"h":400}... |
| images.selected.front.it.generation | 4 | object | - | {"x2":228,"y1":79,"y2":379,"coordinates_image_size":"400","x1":46}<br>{} |
| images.selected.front.it.generation.coordinates_image_size | 1 | string | - | 400 |
| images.selected.front.it.generation.x1 | 1 | number | - | 46 |
| images.selected.front.it.generation.x2 | 1 | number | - | 228 |
| images.selected.front.it.generation.y1 | 1 | number | - | 79 |
| images.selected.front.it.generation.y2 | 1 | number | - | 379 |
| images.selected.front.it.imgid | 4 | string | - | 1<br>14 |
| images.selected.front.it.rev | 4 | string | - | 5<br>51 |
| images.selected.front.it.sizes | 4 | object | - | {"100":{"h":100,"w":61},"200":{"w":121,"h":200},"400":{"w":242,"h":400},"full":{"w":1178,"h":1944}}<br>{"100":{"h":100,"w":75},"200":{"w":150,"h":200},"400":{"w":300,"h":400},"full":{"h":1700,"w":1275}} |
| images.selected.front.it.sizes.100 | 4 | object | - | {"h":100,"w":61}<br>{"h":100,"w":75} |
| images.selected.front.it.sizes.200 | 4 | object | - | {"w":121,"h":200}<br>{"w":150,"h":200} |
| images.selected.front.it.sizes.400 | 4 | object | - | {"w":242,"h":400}<br>{"w":300,"h":400} |
| images.selected.front.it.sizes.full | 4 | object | - | {"w":1178,"h":1944}<br>{"h":1700,"w":1275} |
| images.selected.front.la | 3 | object | - | {"generation":{},"sizes":{"100":{"h":100,"w":54},"200":{"h":200,"w":108},"400":{"h":400,"w":216},"full":{"h":1200,"w":64...<br>{"sizes":{"100":{"h":100,"w":59},"200":{"w":118,"h":200},"400":{"h":400,"w":235},"full":{"h":894,"w":526}},"rev":"6","ge... |
| images.selected.front.la.generation | 3 | object | - | {} |
| images.selected.front.la.imgid | 3 | string | - | 8<br>1 |
| images.selected.front.la.rev | 3 | string | - | 23<br>6 |
| images.selected.front.la.sizes | 3 | object | - | {"100":{"h":100,"w":54},"200":{"h":200,"w":108},"400":{"h":400,"w":216},"full":{"h":1200,"w":648}}<br>{"100":{"h":100,"w":59},"200":{"w":118,"h":200},"400":{"h":400,"w":235},"full":{"h":894,"w":526}} |
| images.selected.front.la.sizes.100 | 3 | object | - | {"h":100,"w":54}<br>{"h":100,"w":59} |
| images.selected.front.la.sizes.200 | 3 | object | - | {"h":200,"w":108}<br>{"w":118,"h":200} |
| images.selected.front.la.sizes.400 | 3 | object | - | {"h":400,"w":216}<br>{"h":400,"w":235} |
| images.selected.front.la.sizes.full | 3 | object | - | {"h":1200,"w":648}<br>{"h":894,"w":526} |
| images.selected.front.pt | 1 | object | - | {"imgid":"1","generation":{},"sizes":{"100":{"h":100,"w":75},"200":{"w":150,"h":200},"400":{"h":400,"w":300},"full":{"h"... |
| images.selected.front.pt.generation | 1 | object | - | {} |
| images.selected.front.pt.imgid | 1 | string | - | 1 |
| images.selected.front.pt.rev | 1 | string | - | 7 |
| images.selected.front.pt.sizes | 1 | object | - | {"100":{"h":100,"w":75},"200":{"w":150,"h":200},"400":{"h":400,"w":300},"full":{"h":1700,"w":1275}} |
| images.selected.front.pt.sizes.100 | 1 | object | - | {"h":100,"w":75} |
| images.selected.front.pt.sizes.200 | 1 | object | - | {"w":150,"h":200} |
| images.selected.front.pt.sizes.400 | 1 | object | - | {"h":400,"w":300} |
| images.selected.front.pt.sizes.full | 1 | object | - | {"h":1700,"w":1275} |
| images.selected.front.th | 1 | object | - | {"generation":{"coordinates_image_size":"400","y2":387,"x1":12,"x2":288,"y1":0},"imgid":"3","rev":"17","sizes":{"100":{"... |
| images.selected.front.th.generation | 1 | object | - | {"coordinates_image_size":"400","y2":387,"x1":12,"x2":288,"y1":0} |
| images.selected.front.th.generation.coordinates_image_size | 1 | string | - | 400 |
| images.selected.front.th.generation.x1 | 1 | number | - | 12 |
| images.selected.front.th.generation.x2 | 1 | number | - | 288 |
| images.selected.front.th.generation.y1 | 1 | number | - | 0 |
| images.selected.front.th.generation.y2 | 1 | number | - | 387 |
| images.selected.front.th.imgid | 1 | string | - | 3 |
| images.selected.front.th.rev | 1 | string | - | 17 |
| images.selected.front.th.sizes | 1 | object | - | {"100":{"w":71,"h":100},"200":{"w":143,"h":200},"400":{"h":400,"w":285},"full":{"h":1428,"w":1019}} |
| images.selected.front.th.sizes.100 | 1 | object | - | {"w":71,"h":100} |
| images.selected.front.th.sizes.200 | 1 | object | - | {"w":143,"h":200} |
| images.selected.front.th.sizes.400 | 1 | object | - | {"h":400,"w":285} |
| images.selected.front.th.sizes.full | 1 | object | - | {"h":1428,"w":1019} |
| images.selected.ingredients | 242 | object | - | {"fr":{"generation":{},"sizes":{"100":{"w":100,"h":81},"200":{"w":200,"h":161},"400":{"h":323,"w":400},"full":{"h":1200,...<br>{"fr":{"imgid":"3","sizes":{"100":{"w":100,"h":44},"200":{"h":88,"w":200},"400":{"h":175,"w":400},"full":{"w":2018,"h":8... |
| images.selected.ingredients.cs | 1 | object | - | {"generation":{"x1":0,"y2":1648,"y1":0,"x2":1984,"coordinates_image_size":"full"},"imgid":"4","rev":"17","sizes":{"100":... |
| images.selected.ingredients.cs.generation | 1 | object | - | {"x1":0,"y2":1648,"y1":0,"x2":1984,"coordinates_image_size":"full"} |
| images.selected.ingredients.cs.generation.coordinates_image_size | 1 | string | - | full |
| images.selected.ingredients.cs.generation.x1 | 1 | number | - | 0 |
| images.selected.ingredients.cs.generation.x2 | 1 | number | - | 1984 |
| images.selected.ingredients.cs.generation.y1 | 1 | number | - | 0 |
| images.selected.ingredients.cs.generation.y2 | 1 | number | - | 1648 |
| images.selected.ingredients.cs.imgid | 1 | string | - | 4 |
| images.selected.ingredients.cs.rev | 1 | string | - | 17 |
| images.selected.ingredients.cs.sizes | 1 | object | - | {"100":{"h":83,"w":100},"200":{"h":166,"w":200},"400":{"h":332,"w":400},"full":{"w":1984,"h":1648}} |
| images.selected.ingredients.cs.sizes.100 | 1 | object | - | {"h":83,"w":100} |
| images.selected.ingredients.cs.sizes.200 | 1 | object | - | {"h":166,"w":200} |
| images.selected.ingredients.cs.sizes.400 | 1 | object | - | {"h":332,"w":400} |
| images.selected.ingredients.cs.sizes.full | 1 | object | - | {"w":1984,"h":1648} |
| images.selected.ingredients.en | 91 | object | - | {"sizes":{"100":{"h":100,"w":75},"200":{"h":200,"w":149},"400":{"w":299,"h":400},"full":{"h":1296,"w":968}},"imgid":"1",...<br>{"sizes":{"100":{"w":100,"h":94},"200":{"w":200,"h":188},"400":{"h":376,"w":400},"full":{"h":456,"w":485}},"rev":"17","g... |
| images.selected.ingredients.en.generation | 89 | object | - | {}<br>{"coordinates_image_size":"full","x1":6,"y2":456,"x2":491,"y1":-1} |
| images.selected.ingredients.en.generation.angle | 7 | number | - | 90<br>270 |
| images.selected.ingredients.en.generation.coordinates_image_size | 20 | string | - | full<br>400 |
| images.selected.ingredients.en.generation.x1 | 20 | number | - | 6<br>736 |
| images.selected.ingredients.en.generation.x2 | 20 | number | - | 491<br>870 |
| images.selected.ingredients.en.generation.y1 | 20 | number | - | -1<br>0 |
| images.selected.ingredients.en.generation.y2 | 20 | number | - | 456<br>163 |
| images.selected.ingredients.en.imgid | 91 | number, string | - | 1<br>3 |
| images.selected.ingredients.en.rev | 91 | number, string | - | 7<br>17 |
| images.selected.ingredients.en.sizes | 91 | object | - | {"100":{"h":100,"w":75},"200":{"h":200,"w":149},"400":{"w":299,"h":400},"full":{"h":1296,"w":968}}<br>{"100":{"w":100,"h":94},"200":{"w":200,"h":188},"400":{"h":376,"w":400},"full":{"h":456,"w":485}} |
| images.selected.ingredients.en.sizes.100 | 91 | object | - | {"h":100,"w":75}<br>{"w":100,"h":94} |
| images.selected.ingredients.en.sizes.200 | 91 | object | - | {"h":200,"w":149}<br>{"w":200,"h":188} |
| images.selected.ingredients.en.sizes.400 | 91 | object | - | {"w":299,"h":400}<br>{"h":376,"w":400} |
| images.selected.ingredients.en.sizes.full | 91 | object | - | {"h":1296,"w":968}<br>{"h":456,"w":485} |
| images.selected.ingredients.es | 2 | object | - | {"sizes":{"100":{"w":100,"h":56},"200":{"w":200,"h":112},"400":{"w":400,"h":223},"full":{"w":1076,"h":600}},"generation"...<br>{"imgid":"8","rev":"40","generation":{"y2":154,"coordinates_image_size":"400","x2":210,"x1":54,"y1":87},"sizes":{"100":{... |
| images.selected.ingredients.es.generation | 2 | object | - | {"coordinates_image_size":"full","y2":863,"x1":22,"y1":263,"x2":1098}<br>{"y2":154,"coordinates_image_size":"400","x2":210,"x1":54,"y1":87} |
| images.selected.ingredients.es.generation.coordinates_image_size | 2 | string | - | full<br>400 |
| images.selected.ingredients.es.generation.x1 | 2 | number | - | 22<br>54 |
| images.selected.ingredients.es.generation.x2 | 2 | number | - | 1098<br>210 |
| images.selected.ingredients.es.generation.y1 | 2 | number | - | 263<br>87 |
| images.selected.ingredients.es.generation.y2 | 2 | number | - | 863<br>154 |
| images.selected.ingredients.es.imgid | 2 | string | - | 3<br>8 |
| images.selected.ingredients.es.rev | 2 | string | - | 31<br>40 |
| images.selected.ingredients.es.sizes | 2 | object | - | {"100":{"w":100,"h":56},"200":{"w":200,"h":112},"400":{"w":400,"h":223},"full":{"w":1076,"h":600}}<br>{"100":{"w":100,"h":43},"200":{"w":200,"h":86},"400":{"h":172,"w":400},"full":{"w":616,"h":265}} |
| images.selected.ingredients.es.sizes.100 | 2 | object | - | {"w":100,"h":56}<br>{"w":100,"h":43} |
| images.selected.ingredients.es.sizes.200 | 2 | object | - | {"w":200,"h":112}<br>{"w":200,"h":86} |
| images.selected.ingredients.es.sizes.400 | 2 | object | - | {"w":400,"h":223}<br>{"h":172,"w":400} |
| images.selected.ingredients.es.sizes.full | 2 | object | - | {"w":1076,"h":600}<br>{"w":616,"h":265} |
| images.selected.ingredients.fr | 77 | object | - | {"generation":{},"sizes":{"100":{"w":100,"h":81},"200":{"w":200,"h":161},"400":{"h":323,"w":400},"full":{"h":1200,"w":14...<br>{"imgid":"3","sizes":{"100":{"w":100,"h":44},"200":{"h":88,"w":200},"400":{"h":175,"w":400},"full":{"w":2018,"h":883}},"... |
| images.selected.ingredients.fr.generation | 73 | object | - | {}<br>{"angle":90} |
| images.selected.ingredients.fr.generation.angle | 21 | number | - | 90<br>270 |
| images.selected.ingredients.fr.generation.coordinates_image_size | 10 | string | - | full<br>400 |
| images.selected.ingredients.fr.generation.x1 | 10 | number | - | 15<br>6 |
| images.selected.ingredients.fr.generation.x2 | 10 | number | - | 665<br>119 |
| images.selected.ingredients.fr.generation.y1 | 10 | number | - | 603<br>11 |
| images.selected.ingredients.fr.generation.y2 | 10 | number | - | 727<br>60 |
| images.selected.ingredients.fr.imgid | 77 | number, string | - | 2<br>3 |
| images.selected.ingredients.fr.rev | 77 | number, string | - | 7<br>10 |
| images.selected.ingredients.fr.sizes | 77 | object | - | {"100":{"w":100,"h":81},"200":{"w":200,"h":161},"400":{"h":323,"w":400},"full":{"h":1200,"w":1487}}<br>{"100":{"w":100,"h":44},"200":{"h":88,"w":200},"400":{"h":175,"w":400},"full":{"w":2018,"h":883}} |
| images.selected.ingredients.fr.sizes.100 | 77 | object | - | {"w":100,"h":81}<br>{"w":100,"h":44} |
| images.selected.ingredients.fr.sizes.200 | 77 | object | - | {"w":200,"h":161}<br>{"h":88,"w":200} |
| images.selected.ingredients.fr.sizes.400 | 77 | object | - | {"h":323,"w":400}<br>{"h":175,"w":400} |
| images.selected.ingredients.fr.sizes.full | 77 | object | - | {"h":1200,"w":1487}<br>{"w":2018,"h":883} |
| images.selected.ingredients.nl | 2 | object | - | {"generation":{"coordinates_image_size":"full","y2":556,"x2":576,"y1":374,"x1":51},"rev":"28","sizes":{"100":{"w":100,"h...<br>{"sizes":{"100":{"h":21,"w":100},"200":{"h":42,"w":200},"400":{"h":84,"w":400},"full":{"h":235,"w":1125}},"rev":"26","ge... |
| images.selected.ingredients.nl.generation | 2 | object | - | {"coordinates_image_size":"full","y2":556,"x2":576,"y1":374,"x1":51}<br>{"x1":0,"angle":90,"y2":332,"y1":285,"coordinates_image_size":"400","x2":225} |
| images.selected.ingredients.nl.generation.angle | 1 | number | - | 90 |
| images.selected.ingredients.nl.generation.coordinates_image_size | 2 | string | - | full<br>400 |
| images.selected.ingredients.nl.generation.x1 | 2 | number | - | 51<br>0 |
| images.selected.ingredients.nl.generation.x2 | 2 | number | - | 576<br>225 |
| images.selected.ingredients.nl.generation.y1 | 2 | number | - | 374<br>285 |
| images.selected.ingredients.nl.generation.y2 | 2 | number | - | 556<br>332 |
| images.selected.ingredients.nl.imgid | 2 | string | - | 1<br>6 |
| images.selected.ingredients.nl.rev | 2 | string | - | 28<br>26 |
| images.selected.ingredients.nl.sizes | 2 | object | - | {"100":{"w":100,"h":35},"200":{"w":200,"h":69},"400":{"h":139,"w":400},"full":{"h":182,"w":525}}<br>{"100":{"h":21,"w":100},"200":{"h":42,"w":200},"400":{"h":84,"w":400},"full":{"h":235,"w":1125}} |
| images.selected.ingredients.nl.sizes.100 | 2 | object | - | {"w":100,"h":35}<br>{"h":21,"w":100} |
| images.selected.ingredients.nl.sizes.200 | 2 | object | - | {"w":200,"h":69}<br>{"h":42,"w":200} |
| images.selected.ingredients.nl.sizes.400 | 2 | object | - | {"h":139,"w":400}<br>{"h":84,"w":400} |
| images.selected.ingredients.nl.sizes.full | 2 | object | - | {"h":182,"w":525}<br>{"h":235,"w":1125} |
| images.selected.ingredients.th | 1 | object | - | {"generation":{"y1":94,"x2":186,"x1":22,"y2":138,"coordinates_image_size":"400"},"sizes":{"100":{"h":27,"w":100},"200":{... |
| images.selected.ingredients.th.generation | 1 | object | - | {"y1":94,"x2":186,"x1":22,"y2":138,"coordinates_image_size":"400"} |
| images.selected.ingredients.th.generation.coordinates_image_size | 1 | string | - | 400 |
| images.selected.ingredients.th.generation.x1 | 1 | number | - | 22 |
| images.selected.ingredients.th.generation.x2 | 1 | number | - | 186 |
| images.selected.ingredients.th.generation.y1 | 1 | number | - | 94 |
| images.selected.ingredients.th.generation.y2 | 1 | number | - | 138 |
| images.selected.ingredients.th.imgid | 1 | string | - | 4 |
| images.selected.ingredients.th.rev | 1 | string | - | 19 |
| images.selected.ingredients.th.sizes | 1 | object | - | {"100":{"h":27,"w":100},"200":{"w":200,"h":53},"400":{"w":400,"h":107},"full":{"w":606,"h":162}} |
| images.selected.ingredients.th.sizes.100 | 1 | object | - | {"h":27,"w":100} |
| images.selected.ingredients.th.sizes.200 | 1 | object | - | {"w":200,"h":53} |
| images.selected.ingredients.th.sizes.400 | 1 | object | - | {"w":400,"h":107} |
| images.selected.ingredients.th.sizes.full | 1 | object | - | {"w":606,"h":162} |
| images.selected.nutrition | 293 | object | - | {"fr":{"rev":"7","imgid":"2","sizes":{"100":{"w":70,"h":100},"200":{"h":200,"w":141},"400":{"h":400,"w":282},"full":{"w"...<br>{"en":{"rev":"6","generation":{},"imgid":"2","sizes":{"100":{"w":75,"h":100},"200":{"w":151,"h":200},"400":{"h":400,"w":... |
| images.selected.nutrition.cs | 1 | object | - | {"generation":{},"imgid":"3","sizes":{"100":{"h":75,"w":100},"200":{"w":200,"h":150},"400":{"w":400,"h":301},"full":{"h"... |
| images.selected.nutrition.cs.generation | 1 | object | - | {} |
| images.selected.nutrition.cs.imgid | 1 | string | - | 3 |
| images.selected.nutrition.cs.rev | 1 | string | - | 12 |
| images.selected.nutrition.cs.sizes | 1 | object | - | {"100":{"h":75,"w":100},"200":{"w":200,"h":150},"400":{"w":400,"h":301},"full":{"h":1612,"w":2143}} |
| images.selected.nutrition.cs.sizes.100 | 1 | object | - | {"h":75,"w":100} |
| images.selected.nutrition.cs.sizes.200 | 1 | object | - | {"w":200,"h":150} |
| images.selected.nutrition.cs.sizes.400 | 1 | object | - | {"w":400,"h":301} |
| images.selected.nutrition.cs.sizes.full | 1 | object | - | {"h":1612,"w":2143} |
| images.selected.nutrition.da | 2 | object | - | {"imgid":3,"sizes":{"100":{"w":75,"h":100},"200":{"w":150,"h":200},"400":{"w":300,"h":400},"full":{"h":1700,"w":1275}},"...<br>{"rev":"7","generation":{},"imgid":"1","sizes":{"100":{"w":62,"h":100},"200":{"h":200,"w":124},"400":{"w":249,"h":400},"... |
| images.selected.nutrition.da.generation | 2 | object | - | {} |
| images.selected.nutrition.da.imgid | 2 | number, string | - | 3<br>1 |
| images.selected.nutrition.da.rev | 2 | number, string | - | 13<br>7 |
| images.selected.nutrition.da.sizes | 2 | object | - | {"100":{"w":75,"h":100},"200":{"w":150,"h":200},"400":{"w":300,"h":400},"full":{"h":1700,"w":1275}}<br>{"100":{"w":62,"h":100},"200":{"h":200,"w":124},"400":{"w":249,"h":400},"full":{"h":1184,"w":737}} |
| images.selected.nutrition.da.sizes.100 | 2 | object | - | {"w":75,"h":100}<br>{"w":62,"h":100} |
| images.selected.nutrition.da.sizes.200 | 2 | object | - | {"w":150,"h":200}<br>{"h":200,"w":124} |
| images.selected.nutrition.da.sizes.400 | 2 | object | - | {"w":300,"h":400}<br>{"w":249,"h":400} |
| images.selected.nutrition.da.sizes.full | 2 | object | - | {"h":1700,"w":1275}<br>{"h":1184,"w":737} |
| images.selected.nutrition.en | 257 | object | - | {"rev":"6","generation":{},"imgid":"2","sizes":{"100":{"w":75,"h":100},"200":{"w":151,"h":200},"400":{"h":400,"w":301},"...<br>{"sizes":{"100":{"w":64,"h":100},"200":{"w":128,"h":200},"400":{"h":400,"w":257},"full":{"h":1076,"w":691}},"imgid":"6",... |
| images.selected.nutrition.en.generation | 254 | object | - | {}<br>{"angle":270} |
| images.selected.nutrition.en.generation.angle | 6 | number | - | 270<br>90 |
| images.selected.nutrition.en.generation.coordinates_image_size | 9 | string | - | full |
| images.selected.nutrition.en.generation.x1 | 9 | number | - | 531<br>324 |
| images.selected.nutrition.en.generation.x2 | 9 | number | - | 2236<br>1208 |
| images.selected.nutrition.en.generation.y1 | 9 | number | - | 1692<br>662 |
| images.selected.nutrition.en.generation.y2 | 9 | number | - | 2142<br>2104 |
| images.selected.nutrition.en.imgid | 257 | number, string | - | 2<br>6 |
| images.selected.nutrition.en.rev | 257 | number, string | - | 6<br>24 |
| images.selected.nutrition.en.sizes | 257 | object | - | {"100":{"w":75,"h":100},"200":{"w":151,"h":200},"400":{"h":400,"w":301},"full":{"w":357,"h":474}}<br>{"100":{"w":64,"h":100},"200":{"w":128,"h":200},"400":{"h":400,"w":257},"full":{"h":1076,"w":691}} |
| images.selected.nutrition.en.sizes.100 | 257 | object | - | {"w":75,"h":100}<br>{"w":64,"h":100} |
| images.selected.nutrition.en.sizes.200 | 257 | object | - | {"w":151,"h":200}<br>{"w":128,"h":200} |
| images.selected.nutrition.en.sizes.400 | 257 | object | - | {"h":400,"w":301}<br>{"h":400,"w":257} |
| images.selected.nutrition.en.sizes.full | 257 | object | - | {"w":357,"h":474}<br>{"h":1076,"w":691} |
| images.selected.nutrition.es | 7 | object | - | {"rev":"32","imgid":"9","generation":{"coordinates_image_size":"full","y2":386,"x1":285,"x2":766,"y1":0},"sizes":{"100":...<br>{"sizes":{"100":{"h":12,"w":100},"200":{"w":200,"h":23},"400":{"h":47,"w":400},"full":{"h":68,"w":580}},"generation":{"y... |
| images.selected.nutrition.es.generation | 7 | object | - | {"coordinates_image_size":"full","y2":386,"x1":285,"x2":766,"y1":0}<br>{"y2":164,"x2":285,"coordinates_image_size":"400","x1":139,"y1":147} |
| images.selected.nutrition.es.generation.coordinates_image_size | 2 | string | - | full<br>400 |
| images.selected.nutrition.es.generation.x1 | 2 | number | - | 285<br>139 |
| images.selected.nutrition.es.generation.x2 | 2 | number | - | 766<br>285 |
| images.selected.nutrition.es.generation.y1 | 2 | number | - | 0<br>147 |
| images.selected.nutrition.es.generation.y2 | 2 | number | - | 386<br>164 |
| images.selected.nutrition.es.imgid | 7 | number, string | - | 9<br>8 |
| images.selected.nutrition.es.rev | 7 | number, string | - | 32<br>41 |
| images.selected.nutrition.es.sizes | 7 | object | - | {"100":{"h":80,"w":100},"200":{"h":160,"w":200},"400":{"w":400,"h":321},"full":{"w":481,"h":386}}<br>{"100":{"h":12,"w":100},"200":{"w":200,"h":23},"400":{"h":47,"w":400},"full":{"h":68,"w":580}} |
| images.selected.nutrition.es.sizes.100 | 7 | object | - | {"h":80,"w":100}<br>{"h":12,"w":100} |
| images.selected.nutrition.es.sizes.200 | 7 | object | - | {"h":160,"w":200}<br>{"w":200,"h":23} |
| images.selected.nutrition.es.sizes.400 | 7 | object | - | {"w":400,"h":321}<br>{"h":47,"w":400} |
| images.selected.nutrition.es.sizes.full | 7 | object | - | {"w":481,"h":386}<br>{"h":68,"w":580} |
| images.selected.nutrition.fr | 49 | object | - | {"rev":"7","imgid":"2","sizes":{"100":{"w":70,"h":100},"200":{"h":200,"w":141},"400":{"h":400,"w":282},"full":{"w":958,"...<br>{"imgid":"3","generation":{},"rev":"10","sizes":{"100":{"w":75,"h":100},"200":{"w":150,"h":200},"400":{"w":300,"h":400},... |
| images.selected.nutrition.fr.generation | 47 | object | - | {}<br>{"angle":180,"x2":160,"coordinates_image_size":"400","y1":114,"x1":60,"y2":231} |
| images.selected.nutrition.fr.generation.angle | 5 | number | - | 180<br>90 |
| images.selected.nutrition.fr.generation.coordinates_image_size | 8 | string | - | 400<br>full |
| images.selected.nutrition.fr.generation.x1 | 8 | number | - | 60<br>53 |
| images.selected.nutrition.fr.generation.x2 | 8 | number | - | 160<br>830 |
| images.selected.nutrition.fr.generation.y1 | 8 | number | - | 114<br>201 |
| images.selected.nutrition.fr.generation.y2 | 8 | number | - | 231<br>531 |
| images.selected.nutrition.fr.imgid | 49 | number, string | - | 2<br>3 |
| images.selected.nutrition.fr.rev | 49 | number, string | - | 7<br>10 |
| images.selected.nutrition.fr.sizes | 49 | object | - | {"100":{"w":70,"h":100},"200":{"h":200,"w":141},"400":{"h":400,"w":282},"full":{"w":958,"h":1360}}<br>{"100":{"w":75,"h":100},"200":{"w":150,"h":200},"400":{"w":300,"h":400},"full":{"w":899,"h":1200}} |
| images.selected.nutrition.fr.sizes.100 | 49 | object | - | {"w":70,"h":100}<br>{"w":75,"h":100} |
| images.selected.nutrition.fr.sizes.200 | 49 | object | - | {"h":200,"w":141}<br>{"w":150,"h":200} |
| images.selected.nutrition.fr.sizes.400 | 49 | object | - | {"h":400,"w":282}<br>{"w":300,"h":400} |
| images.selected.nutrition.fr.sizes.full | 49 | object | - | {"w":958,"h":1360}<br>{"w":899,"h":1200} |
| images.selected.nutrition.it | 3 | object | - | {"rev":"53","imgid":"15","sizes":{"100":{"w":75,"h":100},"200":{"w":150,"h":200},"400":{"h":400,"w":300},"full":{"w":127...<br>{"rev":"26","generation":{},"imgid":"7","sizes":{"100":{"w":75,"h":100},"200":{"h":200,"w":150},"400":{"h":400,"w":300},... |
| images.selected.nutrition.it.generation | 3 | object | - | {} |
| images.selected.nutrition.it.imgid | 3 | string | - | 15<br>7 |
| images.selected.nutrition.it.rev | 3 | string | - | 53<br>26 |
| images.selected.nutrition.it.sizes | 3 | object | - | {"100":{"w":75,"h":100},"200":{"w":150,"h":200},"400":{"h":400,"w":300},"full":{"w":1275,"h":1700}}<br>{"100":{"w":75,"h":100},"200":{"h":200,"w":150},"400":{"h":400,"w":300},"full":{"w":1275,"h":1698}} |
| images.selected.nutrition.it.sizes.100 | 3 | object | - | {"w":75,"h":100}<br>{"w":90,"h":100} |
| images.selected.nutrition.it.sizes.200 | 3 | object | - | {"w":150,"h":200}<br>{"h":200,"w":150} |
| images.selected.nutrition.it.sizes.400 | 3 | object | - | {"h":400,"w":300}<br>{"h":400,"w":361} |
| images.selected.nutrition.it.sizes.full | 3 | object | - | {"w":1275,"h":1700}<br>{"w":1275,"h":1698} |
| images.selected.nutrition.la | 4 | object | - | {"rev":"25","imgid":"9","sizes":{"100":{"h":44,"w":100},"200":{"h":89,"w":200},"400":{"h":178,"w":400},"full":{"w":870,"...<br>{"imgid":"2","generation":{},"rev":"8","sizes":{"100":{"w":100,"h":94},"200":{"w":200,"h":187},"400":{"h":375,"w":400},"... |
| images.selected.nutrition.la.generation | 4 | object | - | {} |
| images.selected.nutrition.la.imgid | 4 | string | - | 9<br>2 |
| images.selected.nutrition.la.rev | 4 | string | - | 25<br>8 |
| images.selected.nutrition.la.sizes | 4 | object | - | {"100":{"h":44,"w":100},"200":{"h":89,"w":200},"400":{"h":178,"w":400},"full":{"w":870,"h":387}}<br>{"100":{"w":100,"h":94},"200":{"w":200,"h":187},"400":{"h":375,"w":400},"full":{"w":665,"h":623}} |
| images.selected.nutrition.la.sizes.100 | 4 | object | - | {"h":44,"w":100}<br>{"w":100,"h":94} |
| images.selected.nutrition.la.sizes.200 | 4 | object | - | {"h":89,"w":200}<br>{"w":200,"h":187} |
| images.selected.nutrition.la.sizes.400 | 4 | object | - | {"h":178,"w":400}<br>{"h":375,"w":400} |
| images.selected.nutrition.la.sizes.full | 4 | object | - | {"w":870,"h":387}<br>{"w":665,"h":623} |
| images.selected.nutrition.nl | 1 | object | - | {"imgid":"1","sizes":{"100":{"h":75,"w":100},"200":{"h":149,"w":200},"400":{"h":299,"w":400},"full":{"h":414,"w":554}},"... |
| images.selected.nutrition.nl.generation | 1 | object | - | {"x2":1945,"y2":762,"coordinates_image_size":"full","x1":1391,"y1":348} |
| images.selected.nutrition.nl.generation.coordinates_image_size | 1 | string | - | full |
| images.selected.nutrition.nl.generation.x1 | 1 | number | - | 1391 |
| images.selected.nutrition.nl.generation.x2 | 1 | number | - | 1945 |
| images.selected.nutrition.nl.generation.y1 | 1 | number | - | 348 |
| images.selected.nutrition.nl.generation.y2 | 1 | number | - | 762 |
| images.selected.nutrition.nl.imgid | 1 | string | - | 1 |
| images.selected.nutrition.nl.rev | 1 | string | - | 29 |
| images.selected.nutrition.nl.sizes | 1 | object | - | {"100":{"h":75,"w":100},"200":{"h":149,"w":200},"400":{"h":299,"w":400},"full":{"h":414,"w":554}} |
| images.selected.nutrition.nl.sizes.100 | 1 | object | - | {"h":75,"w":100} |
| images.selected.nutrition.nl.sizes.200 | 1 | object | - | {"h":149,"w":200} |
| images.selected.nutrition.nl.sizes.400 | 1 | object | - | {"h":299,"w":400} |
| images.selected.nutrition.nl.sizes.full | 1 | object | - | {"h":414,"w":554} |
| images.selected.nutrition.th | 1 | object | - | {"generation":{"coordinates_image_size":"400","y2":297,"x1":24,"x2":188,"y1":153},"imgid":"4","rev":"20","sizes":{"100":... |
| images.selected.nutrition.th.generation | 1 | object | - | {"coordinates_image_size":"400","y2":297,"x1":24,"x2":188,"y1":153} |
| images.selected.nutrition.th.generation.coordinates_image_size | 1 | string | - | 400 |
| images.selected.nutrition.th.generation.x1 | 1 | number | - | 24 |
| images.selected.nutrition.th.generation.x2 | 1 | number | - | 188 |
| images.selected.nutrition.th.generation.y1 | 1 | number | - | 153 |
| images.selected.nutrition.th.generation.y2 | 1 | number | - | 297 |
| images.selected.nutrition.th.imgid | 1 | string | - | 4 |
| images.selected.nutrition.th.rev | 1 | string | - | 20 |
| images.selected.nutrition.th.sizes | 1 | object | - | {"100":{"w":100,"h":88},"200":{"w":200,"h":176},"400":{"h":351,"w":400},"full":{"h":532,"w":606}} |
| images.selected.nutrition.th.sizes.100 | 1 | object | - | {"w":100,"h":88} |
| images.selected.nutrition.th.sizes.200 | 1 | object | - | {"w":200,"h":176} |
| images.selected.nutrition.th.sizes.400 | 1 | object | - | {"h":351,"w":400} |
| images.selected.nutrition.th.sizes.full | 1 | object | - | {"h":532,"w":606} |
| images.selected.packaging | 13 | object | - | {"en":{"imgid":"4","generation":{},"sizes":{"100":{"w":75,"h":100},"200":{"h":200,"w":150},"400":{"w":300,"h":400},"full...<br>{"en":{"rev":"48","imgid":"13","generation":{},"sizes":{"100":{"w":87,"h":100},"200":{"h":200,"w":173},"400":{"w":346,"h... |
| images.selected.packaging.cs | 1 | object | - | {"imgid":"5","generation":{},"sizes":{"100":{"w":75,"h":100},"200":{"h":200,"w":150},"400":{"w":300,"h":400},"full":{"h"... |
| images.selected.packaging.cs.generation | 1 | object | - | {} |
| images.selected.packaging.cs.imgid | 1 | string | - | 5 |
| images.selected.packaging.cs.rev | 1 | string | - | 21 |
| images.selected.packaging.cs.sizes | 1 | object | - | {"100":{"w":75,"h":100},"200":{"h":200,"w":150},"400":{"w":300,"h":400},"full":{"h":4032,"w":3024}} |
| images.selected.packaging.cs.sizes.100 | 1 | object | - | {"w":75,"h":100} |
| images.selected.packaging.cs.sizes.200 | 1 | object | - | {"h":200,"w":150} |
| images.selected.packaging.cs.sizes.400 | 1 | object | - | {"w":300,"h":400} |
| images.selected.packaging.cs.sizes.full | 1 | object | - | {"h":4032,"w":3024} |
| images.selected.packaging.en | 11 | object | - | {"imgid":"4","generation":{},"sizes":{"100":{"w":75,"h":100},"200":{"h":200,"w":150},"400":{"w":300,"h":400},"full":{"h"...<br>{"rev":"48","imgid":"13","generation":{},"sizes":{"100":{"w":87,"h":100},"200":{"h":200,"w":173},"400":{"w":346,"h":400}... |
| images.selected.packaging.en.generation | 11 | object | - | {}<br>{"angle":90} |
| images.selected.packaging.en.generation.angle | 1 | number | - | 90 |
| images.selected.packaging.en.generation.coordinates_image_size | 2 | string | - | full |
| images.selected.packaging.en.generation.x1 | 2 | number | - | 398<br>-1 |
| images.selected.packaging.en.generation.x2 | 2 | number | - | 1582<br>4151 |
| images.selected.packaging.en.generation.y1 | 2 | number | - | 1510<br>-1 |
| images.selected.packaging.en.generation.y2 | 2 | number | - | 1958<br>3061 |
| images.selected.packaging.en.imgid | 11 | string | - | 4<br>13 |
| images.selected.packaging.en.rev | 11 | number, string | - | 18<br>48 |
| images.selected.packaging.en.sizes | 11 | object | - | {"100":{"w":75,"h":100},"200":{"h":200,"w":150},"400":{"w":300,"h":400},"full":{"h":3264,"w":2448}}<br>{"100":{"w":87,"h":100},"200":{"h":200,"w":173},"400":{"w":346,"h":400},"full":{"h":507,"w":439}} |
| images.selected.packaging.en.sizes.100 | 11 | object | - | {"w":75,"h":100}<br>{"w":87,"h":100} |
| images.selected.packaging.en.sizes.200 | 11 | object | - | {"h":200,"w":150}<br>{"h":200,"w":173} |
| images.selected.packaging.en.sizes.400 | 11 | object | - | {"w":300,"h":400}<br>{"w":346,"h":400} |
| images.selected.packaging.en.sizes.full | 11 | object | - | {"h":3264,"w":2448}<br>{"h":507,"w":439} |
| images.selected.packaging.fr | 1 | object | - | {"generation":{},"rev":"26","sizes":{"100":{"w":100,"h":87},"200":{"w":200,"h":174},"400":{"h":347,"w":400},"full":{"w":... |
| images.selected.packaging.fr.generation | 1 | object | - | {} |
| images.selected.packaging.fr.imgid | 1 | string | - | 8 |
| images.selected.packaging.fr.rev | 1 | string | - | 26 |
| images.selected.packaging.fr.sizes | 1 | object | - | {"100":{"w":100,"h":87},"200":{"w":200,"h":174},"400":{"h":347,"w":400},"full":{"w":3024,"h":2625}} |
| images.selected.packaging.fr.sizes.100 | 1 | object | - | {"w":100,"h":87} |
| images.selected.packaging.fr.sizes.200 | 1 | object | - | {"w":200,"h":174} |
| images.selected.packaging.fr.sizes.400 | 1 | object | - | {"h":347,"w":400} |
| images.selected.packaging.fr.sizes.full | 1 | object | - | {"w":3024,"h":2625} |
| images.uploaded | 358 | object | - | {"1":{"uploaded_t":1649283378,"sizes":{"100":{"h":100,"w":77},"400":{"h":400,"w":310},"full":{"h":1019,"w":789}},"upload...<br>{"1":{"uploader":"kiliweb","uploaded_t":1536492891,"sizes":{"100":{"w":100,"h":67},"400":{"h":269,"w":400},"full":{"w":1... |
| images.uploaded.1 | 356 | object | - | {"uploaded_t":1649283378,"sizes":{"100":{"h":100,"w":77},"400":{"h":400,"w":310},"full":{"h":1019,"w":789}},"uploader":"...<br>{"uploader":"kiliweb","uploaded_t":1536492891,"sizes":{"100":{"w":100,"h":67},"400":{"h":269,"w":400},"full":{"w":1782,"... |
| images.uploaded.1.sizes | 356 | object | - | {"100":{"h":100,"w":77},"400":{"h":400,"w":310},"full":{"h":1019,"w":789}}<br>{"100":{"w":100,"h":67},"400":{"h":269,"w":400},"full":{"w":1782,"h":1200}} |
| images.uploaded.1.sizes.100 | 356 | object | - | {"h":100,"w":77}<br>{"w":100,"h":67} |
| images.uploaded.1.sizes.100.h | 356 | number | - | 100<br>67 |
| images.uploaded.1.sizes.100.w | 356 | number | - | 77<br>100 |
| images.uploaded.1.sizes.400 | 356 | object | - | {"h":400,"w":310}<br>{"h":269,"w":400} |
| images.uploaded.1.sizes.400.h | 356 | number | - | 400<br>269 |
| images.uploaded.1.sizes.400.w | 356 | number | - | 310<br>400 |
| images.uploaded.1.sizes.full | 356 | object | - | {"h":1019,"w":789}<br>{"w":1782,"h":1200} |
| images.uploaded.1.sizes.full.h | 356 | number | - | 1019<br>1200 |
| images.uploaded.1.sizes.full.w | 356 | number | - | 789<br>1782 |
| images.uploaded.1.uploaded_t | 356 | number, string | - | 1649283378<br>1536492891 |
| images.uploaded.1.uploader | 356 | string | - | kiliweb<br>ysculo |
| images.uploaded.10 | 40 | object | - | {"uploaded_t":1759704524,"uploader":"municorn-calorie-counter-app","sizes":{"100":{"w":46,"h":100},"400":{"h":400,"w":18...<br>{"sizes":{"100":{"h":100,"w":46},"400":{"w":185,"h":400},"full":{"h":1280,"w":592}},"uploader":"municorn-calorie-counter... |
| images.uploaded.10.sizes | 40 | object | - | {"100":{"w":46,"h":100},"400":{"h":400,"w":185},"full":{"w":592,"h":1280}}<br>{"100":{"h":100,"w":46},"400":{"w":185,"h":400},"full":{"h":1280,"w":592}} |
| images.uploaded.10.sizes.100 | 40 | object | - | {"w":46,"h":100}<br>{"h":100,"w":46} |
| images.uploaded.10.sizes.100.h | 40 | number | - | 100<br>14 |
| images.uploaded.10.sizes.100.w | 40 | number | - | 46<br>75 |
| images.uploaded.10.sizes.400 | 40 | object | - | {"h":400,"w":185}<br>{"w":185,"h":400} |
| images.uploaded.10.sizes.400.h | 40 | number | - | 400<br>54 |
| images.uploaded.10.sizes.400.w | 40 | number | - | 185<br>300 |
| images.uploaded.10.sizes.full | 40 | object | - | {"w":592,"h":1280}<br>{"h":1280,"w":592} |
| images.uploaded.10.sizes.full.h | 40 | number | - | 1280<br>4032 |
| images.uploaded.10.sizes.full.w | 40 | number | - | 592<br>3024 |
| images.uploaded.10.uploaded_t | 40 | number | - | 1759704524<br>1760721526 |
| images.uploaded.10.uploader | 40 | string | - | municorn-calorie-counter-app<br>smoothie-app |
| images.uploaded.11 | 29 | object | - | {"uploader":"municorn-calorie-counter-app","sizes":{"100":{"h":100,"w":46},"400":{"h":400,"w":185},"full":{"w":592,"h":1...<br>{"sizes":{"100":{"h":100,"w":46},"400":{"w":185,"h":400},"full":{"h":1280,"w":592}},"uploaded_t":1760721527,"uploader":"... |
| images.uploaded.11.sizes | 29 | object | - | {"100":{"h":100,"w":46},"400":{"h":400,"w":185},"full":{"w":592,"h":1280}}<br>{"100":{"h":100,"w":46},"400":{"w":185,"h":400},"full":{"h":1280,"w":592}} |
| images.uploaded.11.sizes.100 | 29 | object | - | {"h":100,"w":46}<br>{"w":46,"h":100} |
| images.uploaded.11.sizes.100.h | 29 | number | - | 100<br>18 |
| images.uploaded.11.sizes.100.w | 29 | number | - | 46<br>80 |
| images.uploaded.11.sizes.400 | 29 | object | - | {"h":400,"w":185}<br>{"w":185,"h":400} |
| images.uploaded.11.sizes.400.h | 29 | number | - | 400<br>71 |
| images.uploaded.11.sizes.400.w | 29 | number | - | 185<br>321 |
| images.uploaded.11.sizes.full | 29 | object | - | {"w":592,"h":1280}<br>{"h":1280,"w":592} |
| images.uploaded.11.sizes.full.h | 29 | number | - | 1280<br>2839 |
| images.uploaded.11.sizes.full.w | 29 | number | - | 592<br>2279 |
| images.uploaded.11.uploaded_t | 29 | number | - | 1759704526<br>1760721527 |
| images.uploaded.11.uploader | 29 | string | - | municorn-calorie-counter-app<br>tmbe7 |
| images.uploaded.12 | 15 | object | - | {"sizes":{"100":{"h":100,"w":93},"400":{"h":400,"w":372},"full":{"h":3074,"w":2862}},"uploader":"tmbe7","uploaded_t":169...<br>{"sizes":{"100":{"h":100,"w":46},"400":{"h":400,"w":184},"full":{"h":1280,"w":590}},"uploaded_t":1761749336,"uploader":"... |
| images.uploaded.12.sizes | 15 | object | - | {"100":{"h":100,"w":93},"400":{"h":400,"w":372},"full":{"h":3074,"w":2862}}<br>{"100":{"h":100,"w":46},"400":{"h":400,"w":184},"full":{"h":1280,"w":590}} |
| images.uploaded.12.sizes.100 | 15 | object | - | {"h":100,"w":93}<br>{"h":100,"w":46} |
| images.uploaded.12.sizes.100.h | 15 | number | - | 100<br>34 |
| images.uploaded.12.sizes.100.w | 15 | number | - | 93<br>46 |
| images.uploaded.12.sizes.400 | 15 | object | - | {"h":400,"w":372}<br>{"h":400,"w":184} |
| images.uploaded.12.sizes.400.h | 15 | number | - | 400<br>136 |
| images.uploaded.12.sizes.400.w | 15 | number | - | 372<br>184 |
| images.uploaded.12.sizes.full | 15 | object | - | {"h":3074,"w":2862}<br>{"h":1280,"w":590} |
| images.uploaded.12.sizes.full.h | 15 | number | - | 3074<br>1280 |
| images.uploaded.12.sizes.full.w | 15 | number | - | 2862<br>590 |
| images.uploaded.12.uploaded_t | 15 | number | - | 1696202861<br>1761749336 |
| images.uploaded.12.uploader | 15 | string | - | tmbe7<br>municorn-calorie-counter-app |
| images.uploaded.13 | 13 | object | - | {"sizes":{"100":{"h":100,"w":55},"400":{"w":219,"h":400},"full":{"h":4000,"w":2186}},"uploader":"foodless","uploaded_t":...<br>{"uploaded_t":1761749338,"uploader":"municorn-calorie-counter-app","sizes":{"100":{"h":100,"w":46},"400":{"h":400,"w":18... |
| images.uploaded.13.sizes | 13 | object | - | {"100":{"h":100,"w":55},"400":{"w":219,"h":400},"full":{"h":4000,"w":2186}}<br>{"100":{"h":100,"w":46},"400":{"h":400,"w":184},"full":{"w":590,"h":1280}} |
| images.uploaded.13.sizes.100 | 13 | object | - | {"h":100,"w":55}<br>{"h":100,"w":46} |
| images.uploaded.13.sizes.100.h | 13 | number | - | 100 |
| images.uploaded.13.sizes.100.w | 13 | number | - | 55<br>46 |
| images.uploaded.13.sizes.400 | 13 | object | - | {"w":219,"h":400}<br>{"h":400,"w":184} |
| images.uploaded.13.sizes.400.h | 13 | number | - | 400 |
| images.uploaded.13.sizes.400.w | 13 | number | - | 219<br>184 |
| images.uploaded.13.sizes.full | 13 | object | - | {"h":4000,"w":2186}<br>{"w":590,"h":1280} |
| images.uploaded.13.sizes.full.h | 13 | number | - | 4000<br>1280 |
| images.uploaded.13.sizes.full.w | 13 | number | - | 2186<br>590 |
| images.uploaded.13.uploaded_t | 13 | number | - | 1713709888<br>1761749338 |
| images.uploaded.13.uploader | 13 | string | - | foodless<br>municorn-calorie-counter-app |
| images.uploaded.14 | 12 | object | - | {"uploaded_t":1754193764,"uploader":"municorn-calorie-counter-app","sizes":{"100":{"w":46,"h":100},"400":{"h":400,"w":18...<br>{"sizes":{"100":{"h":100,"w":46},"400":{"h":400,"w":185},"full":{"h":1280,"w":592}},"uploaded_t":1762190313,"uploader":"... |
| images.uploaded.14.sizes | 12 | object | - | {"100":{"w":46,"h":100},"400":{"h":400,"w":185},"full":{"h":1280,"w":592}}<br>{"100":{"h":100,"w":46},"400":{"h":400,"w":185},"full":{"h":1280,"w":592}} |
| images.uploaded.14.sizes.100 | 12 | object | - | {"w":46,"h":100}<br>{"h":100,"w":46} |
| images.uploaded.14.sizes.100.h | 12 | number | - | 100 |
| images.uploaded.14.sizes.100.w | 12 | number | - | 46<br>75 |
| images.uploaded.14.sizes.400 | 12 | object | - | {"h":400,"w":185}<br>{"w":185,"h":400} |
| images.uploaded.14.sizes.400.h | 12 | number | - | 400 |
| images.uploaded.14.sizes.400.w | 12 | number | - | 185<br>300 |
| images.uploaded.14.sizes.full | 12 | object | - | {"h":1280,"w":592}<br>{"w":592,"h":1280} |
| images.uploaded.14.sizes.full.h | 12 | number | - | 1280<br>1700 |
| images.uploaded.14.sizes.full.w | 12 | number | - | 592<br>1275 |
| images.uploaded.14.uploaded_t | 12 | number | - | 1754193764<br>1762190313 |
| images.uploaded.14.uploader | 12 | string | - | municorn-calorie-counter-app<br>macrofactor |
| images.uploaded.15 | 8 | object | - | {"uploaded_t":1754193767,"uploader":"municorn-calorie-counter-app","sizes":{"100":{"h":100,"w":46},"400":{"w":185,"h":40...<br>{"uploaded_t":1762190315,"uploader":"municorn-calorie-counter-app","sizes":{"100":{"w":46,"h":100},"400":{"w":185,"h":40... |
| images.uploaded.15.sizes | 8 | object | - | {"100":{"h":100,"w":46},"400":{"w":185,"h":400},"full":{"w":592,"h":1280}}<br>{"100":{"w":46,"h":100},"400":{"w":185,"h":400},"full":{"h":1280,"w":592}} |
| images.uploaded.15.sizes.100 | 8 | object | - | {"h":100,"w":46}<br>{"w":46,"h":100} |
| images.uploaded.15.sizes.100.h | 8 | number | - | 100 |
| images.uploaded.15.sizes.100.w | 8 | number | - | 46<br>75 |
| images.uploaded.15.sizes.400 | 8 | object | - | {"w":185,"h":400}<br>{"h":400,"w":185} |
| images.uploaded.15.sizes.400.h | 8 | number | - | 400 |
| images.uploaded.15.sizes.400.w | 8 | number | - | 185<br>300 |
| images.uploaded.15.sizes.full | 8 | object | - | {"w":592,"h":1280}<br>{"h":1280,"w":592} |
| images.uploaded.15.sizes.full.h | 8 | number | - | 1280<br>1700 |
| images.uploaded.15.sizes.full.w | 8 | number | - | 592<br>1275 |
| images.uploaded.15.uploaded_t | 8 | number | - | 1754193767<br>1762190315 |
| images.uploaded.15.uploader | 8 | string | - | municorn-calorie-counter-app<br>macrofactor |
| images.uploaded.16 | 7 | object | - | {"sizes":{"100":{"w":75,"h":100},"400":{"h":400,"w":300},"full":{"h":1698,"w":1275}},"uploader":"macrofactor","uploaded_...<br>{"uploaded_t":1763416635,"uploader":"municorn-calorie-counter-app","sizes":{"100":{"w":46,"h":100},"400":{"w":185,"h":40... |
| images.uploaded.16.sizes | 7 | object | - | {"100":{"w":75,"h":100},"400":{"h":400,"w":300},"full":{"h":1698,"w":1275}}<br>{"100":{"w":46,"h":100},"400":{"w":185,"h":400},"full":{"w":592,"h":1280}} |
| images.uploaded.16.sizes.100 | 7 | object | - | {"w":75,"h":100}<br>{"w":46,"h":100} |
| images.uploaded.16.sizes.100.h | 7 | number | - | 100<br>72 |
| images.uploaded.16.sizes.100.w | 7 | number | - | 75<br>46 |
| images.uploaded.16.sizes.400 | 7 | object | - | {"h":400,"w":300}<br>{"w":185,"h":400} |
| images.uploaded.16.sizes.400.h | 7 | number | - | 400<br>289 |
| images.uploaded.16.sizes.400.w | 7 | number | - | 300<br>185 |
| images.uploaded.16.sizes.full | 7 | object | - | {"h":1698,"w":1275}<br>{"w":592,"h":1280} |
| images.uploaded.16.sizes.full.h | 7 | number | - | 1698<br>1280 |
| images.uploaded.16.sizes.full.w | 7 | number | - | 1275<br>592 |
| images.uploaded.16.uploaded_t | 7 | number | - | 1755154029<br>1763416635 |
| images.uploaded.16.uploader | 7 | string | - | macrofactor<br>municorn-calorie-counter-app |
| images.uploaded.17 | 7 | object | - | {"sizes":{"100":{"w":100,"h":34},"400":{"h":137,"w":400},"full":{"h":335,"w":975}},"uploader":"macrofactor","uploaded_t"...<br>{"uploaded_t":1763416637,"uploader":"municorn-calorie-counter-app","sizes":{"100":{"h":100,"w":46},"400":{"h":400,"w":18... |
| images.uploaded.17.sizes | 7 | object | - | {"100":{"w":100,"h":34},"400":{"h":137,"w":400},"full":{"h":335,"w":975}}<br>{"100":{"h":100,"w":46},"400":{"h":400,"w":185},"full":{"w":592,"h":1280}} |
| images.uploaded.17.sizes.100 | 7 | object | - | {"w":100,"h":34}<br>{"h":100,"w":46} |
| images.uploaded.17.sizes.100.h | 7 | number | - | 34<br>100 |
| images.uploaded.17.sizes.100.w | 7 | number | - | 100<br>46 |
| images.uploaded.17.sizes.400 | 7 | object | - | {"h":137,"w":400}<br>{"h":400,"w":185} |
| images.uploaded.17.sizes.400.h | 7 | number | - | 137<br>400 |
| images.uploaded.17.sizes.400.w | 7 | number | - | 400<br>185 |
| images.uploaded.17.sizes.full | 7 | object | - | {"h":335,"w":975}<br>{"w":592,"h":1280} |
| images.uploaded.17.sizes.full.h | 7 | number | - | 335<br>1280 |
| images.uploaded.17.sizes.full.w | 7 | number | - | 975<br>592 |
| images.uploaded.17.uploaded_t | 7 | number | - | 1755154033<br>1763416637 |
| images.uploaded.17.uploader | 7 | string | - | macrofactor<br>municorn-calorie-counter-app |
| images.uploaded.18 | 5 | object | - | {"uploader":"municorn-calorie-counter-app","uploaded_t":1757009548,"sizes":{"100":{"w":46,"h":100},"400":{"w":185,"h":40...<br>{"sizes":{"100":{"w":100,"h":100},"400":{"w":200,"h":200},"full":{"h":200,"w":200}},"uploader":"prepperapp","uploaded_t"... |
| images.uploaded.18.sizes | 5 | object | - | {"100":{"w":46,"h":100},"400":{"w":185,"h":400},"full":{"h":1280,"w":592}}<br>{"100":{"w":100,"h":100},"400":{"w":200,"h":200},"full":{"h":200,"w":200}} |
| images.uploaded.18.sizes.100 | 5 | object | - | {"w":46,"h":100}<br>{"w":100,"h":100} |
| images.uploaded.18.sizes.100.h | 5 | number | - | 100<br>72 |
| images.uploaded.18.sizes.100.w | 5 | number | - | 46<br>100 |
| images.uploaded.18.sizes.400 | 5 | object | - | {"w":185,"h":400}<br>{"w":200,"h":200} |
| images.uploaded.18.sizes.400.h | 5 | number | - | 400<br>200 |
| images.uploaded.18.sizes.400.w | 5 | number | - | 185<br>200 |
| images.uploaded.18.sizes.full | 5 | object | - | {"h":1280,"w":592}<br>{"h":200,"w":200} |
| images.uploaded.18.sizes.full.h | 5 | number | - | 1280<br>200 |
| images.uploaded.18.sizes.full.w | 5 | number | - | 592<br>200 |
| images.uploaded.18.uploaded_t | 5 | number | - | 1757009548<br>1769669270 |
| images.uploaded.18.uploader | 5 | string | - | municorn-calorie-counter-app<br>prepperapp |
| images.uploaded.19 | 4 | object | - | {"sizes":{"100":{"h":100,"w":46},"400":{"h":400,"w":185},"full":{"w":592,"h":1280}},"uploaded_t":1757009550,"uploader":"...<br>{"sizes":{"100":{"h":100,"w":75},"400":{"w":300,"h":400},"full":{"w":1275,"h":1700}},"uploader":"macrofactor","uploaded_... |
| images.uploaded.19.sizes | 4 | object | - | {"100":{"h":100,"w":46},"400":{"h":400,"w":185},"full":{"w":592,"h":1280}}<br>{"100":{"h":100,"w":75},"400":{"w":300,"h":400},"full":{"w":1275,"h":1700}} |
| images.uploaded.19.sizes.100 | 4 | object | - | {"h":100,"w":46}<br>{"h":100,"w":75} |
| images.uploaded.19.sizes.100.h | 4 | number | - | 100 |
| images.uploaded.19.sizes.100.w | 4 | number | - | 46<br>75 |
| images.uploaded.19.sizes.400 | 4 | object | - | {"h":400,"w":185}<br>{"w":300,"h":400} |
| images.uploaded.19.sizes.400.h | 4 | number | - | 400 |
| images.uploaded.19.sizes.400.w | 4 | number | - | 185<br>300 |
| images.uploaded.19.sizes.full | 4 | object | - | {"w":592,"h":1280}<br>{"w":1275,"h":1700} |
| images.uploaded.19.sizes.full.h | 4 | number | - | 1280<br>1700 |
| images.uploaded.19.sizes.full.w | 4 | number | - | 592<br>1275 |
| images.uploaded.19.uploaded_t | 4 | number | - | 1757009550<br>1745846601 |
| images.uploaded.19.uploader | 4 | string | - | municorn-calorie-counter-app<br>macrofactor |
| images.uploaded.2 | 316 | object | - | {"sizes":{"100":{"w":100,"h":81},"400":{"w":400,"h":323},"full":{"h":1200,"w":1487}},"uploaded_t":1536492893,"uploader":...<br>{"uploader":"kiliweb","uploaded_t":"1518439767","sizes":{"100":{"h":100,"w":70},"400":{"h":400,"w":282},"full":{"w":958,... |
| images.uploaded.2.sizes | 316 | object | - | {"100":{"w":100,"h":81},"400":{"w":400,"h":323},"full":{"h":1200,"w":1487}}<br>{"100":{"h":100,"w":70},"400":{"h":400,"w":282},"full":{"w":958,"h":1360}} |
| images.uploaded.2.sizes.100 | 316 | object | - | {"w":100,"h":81}<br>{"h":100,"w":70} |
| images.uploaded.2.sizes.100.h | 316 | number | - | 81<br>100 |
| images.uploaded.2.sizes.100.w | 316 | number | - | 100<br>70 |
| images.uploaded.2.sizes.400 | 316 | object | - | {"w":400,"h":323}<br>{"h":400,"w":282} |
| images.uploaded.2.sizes.400.h | 316 | number | - | 323<br>400 |
| images.uploaded.2.sizes.400.w | 316 | number | - | 400<br>282 |
| images.uploaded.2.sizes.full | 316 | object | - | {"h":1200,"w":1487}<br>{"w":958,"h":1360} |
| images.uploaded.2.sizes.full.h | 316 | number | - | 1200<br>1360 |
| images.uploaded.2.sizes.full.w | 316 | number | - | 1487<br>958 |
| images.uploaded.2.uploaded_t | 316 | number, string | - | 1536492893<br>1518439767 |
| images.uploaded.2.uploader | 316 | string | - | kiliweb<br>ysculo |
| images.uploaded.20 | 3 | object | - | {"sizes":{"100":{"w":46,"h":100},"400":{"h":400,"w":185},"full":{"w":592,"h":1280}},"uploader":"municorn-calorie-counter...<br>{"uploaded_t":1755540330,"uploader":"municorn-calorie-counter-app","sizes":{"100":{"w":46,"h":100},"400":{"w":185,"h":40... |
| images.uploaded.20.sizes | 3 | object | - | {"100":{"w":46,"h":100},"400":{"h":400,"w":185},"full":{"w":592,"h":1280}}<br>{"100":{"w":46,"h":100},"400":{"w":185,"h":400},"full":{"w":592,"h":1280}} |
| images.uploaded.20.sizes.100 | 3 | object | - | {"w":46,"h":100}<br>{"h":100,"w":60} |
| images.uploaded.20.sizes.100.h | 3 | number | - | 100 |
| images.uploaded.20.sizes.100.w | 3 | number | - | 46<br>60 |
| images.uploaded.20.sizes.400 | 3 | object | - | {"h":400,"w":185}<br>{"w":185,"h":400} |
| images.uploaded.20.sizes.400.h | 3 | number | - | 400 |
| images.uploaded.20.sizes.400.w | 3 | number | - | 185<br>238 |
| images.uploaded.20.sizes.full | 3 | object | - | {"w":592,"h":1280}<br>{"h":1200,"w":714} |
| images.uploaded.20.sizes.full.h | 3 | number | - | 1280<br>1200 |
| images.uploaded.20.sizes.full.w | 3 | number | - | 592<br>714 |
| images.uploaded.20.uploaded_t | 3 | number | - | 1757024001<br>1755540330 |
| images.uploaded.20.uploader | 3 | string | - | municorn-calorie-counter-app<br>kiliweb |
| images.uploaded.21 | 3 | object | - | {"sizes":{"100":{"h":100,"w":46},"400":{"w":185,"h":400},"full":{"w":592,"h":1280}},"uploader":"municorn-calorie-counter...<br>{"uploaded_t":1755540334,"uploader":"municorn-calorie-counter-app","sizes":{"100":{"w":46,"h":100},"400":{"h":400,"w":18... |
| images.uploaded.21.sizes | 3 | object | - | {"100":{"h":100,"w":46},"400":{"w":185,"h":400},"full":{"w":592,"h":1280}}<br>{"100":{"w":46,"h":100},"400":{"h":400,"w":185},"full":{"h":1280,"w":592}} |
| images.uploaded.21.sizes.100 | 3 | object | - | {"h":100,"w":46}<br>{"w":46,"h":100} |
| images.uploaded.21.sizes.100.h | 3 | number | - | 100 |
| images.uploaded.21.sizes.100.w | 3 | number | - | 46<br>75 |
| images.uploaded.21.sizes.400 | 3 | object | - | {"w":185,"h":400}<br>{"h":400,"w":185} |
| images.uploaded.21.sizes.400.h | 3 | number | - | 400 |
| images.uploaded.21.sizes.400.w | 3 | number | - | 185<br>300 |
| images.uploaded.21.sizes.full | 3 | object | - | {"w":592,"h":1280}<br>{"h":1280,"w":592} |
| images.uploaded.21.sizes.full.h | 3 | number | - | 1280<br>1698 |
| images.uploaded.21.sizes.full.w | 3 | number | - | 592<br>1275 |
| images.uploaded.21.uploaded_t | 3 | number | - | 1757024003<br>1755540334 |
| images.uploaded.21.uploader | 3 | string | - | municorn-calorie-counter-app<br>macrofactor |
| images.uploaded.22 | 2 | object | - | {"uploader":"municorn-calorie-counter-app","uploaded_t":1758224021,"sizes":{"100":{"w":46,"h":100},"400":{"w":185,"h":40...<br>{"uploader":"macrofactor","uploaded_t":1726151265,"sizes":{"100":{"w":75,"h":100},"400":{"h":400,"w":300},"full":{"w":12... |
| images.uploaded.22.sizes | 2 | object | - | {"100":{"w":46,"h":100},"400":{"w":185,"h":400},"full":{"h":1280,"w":592}}<br>{"100":{"w":75,"h":100},"400":{"h":400,"w":300},"full":{"w":1275,"h":1698}} |
| images.uploaded.22.sizes.100 | 2 | object | - | {"w":46,"h":100}<br>{"w":75,"h":100} |
| images.uploaded.22.sizes.100.h | 2 | number | - | 100 |
| images.uploaded.22.sizes.100.w | 2 | number | - | 46<br>75 |
| images.uploaded.22.sizes.400 | 2 | object | - | {"w":185,"h":400}<br>{"h":400,"w":300} |
| images.uploaded.22.sizes.400.h | 2 | number | - | 400 |
| images.uploaded.22.sizes.400.w | 2 | number | - | 185<br>300 |
| images.uploaded.22.sizes.full | 2 | object | - | {"h":1280,"w":592}<br>{"w":1275,"h":1698} |
| images.uploaded.22.sizes.full.h | 2 | number | - | 1280<br>1698 |
| images.uploaded.22.sizes.full.w | 2 | number | - | 592<br>1275 |
| images.uploaded.22.uploaded_t | 2 | number | - | 1758224021<br>1726151265 |
| images.uploaded.22.uploader | 2 | string | - | municorn-calorie-counter-app<br>macrofactor |
| images.uploaded.23 | 1 | object | - | {"uploaded_t":1758224024,"uploader":"municorn-calorie-counter-app","sizes":{"100":{"h":100,"w":46},"400":{"h":400,"w":18... |
| images.uploaded.23.sizes | 1 | object | - | {"100":{"h":100,"w":46},"400":{"h":400,"w":185},"full":{"w":592,"h":1280}} |
| images.uploaded.23.sizes.100 | 1 | object | - | {"h":100,"w":46} |
| images.uploaded.23.sizes.100.h | 1 | number | - | 100 |
| images.uploaded.23.sizes.100.w | 1 | number | - | 46 |
| images.uploaded.23.sizes.400 | 1 | object | - | {"h":400,"w":185} |
| images.uploaded.23.sizes.400.h | 1 | number | - | 400 |
| images.uploaded.23.sizes.400.w | 1 | number | - | 185 |
| images.uploaded.23.sizes.full | 1 | object | - | {"w":592,"h":1280} |
| images.uploaded.23.sizes.full.h | 1 | number | - | 1280 |
| images.uploaded.23.sizes.full.w | 1 | number | - | 592 |
| images.uploaded.23.uploaded_t | 1 | number | - | 1758224024 |
| images.uploaded.23.uploader | 1 | string | - | municorn-calorie-counter-app |
| images.uploaded.3 | 231 | object | - | {"uploader":"kiliweb","sizes":{"100":{"h":44,"w":100},"400":{"w":400,"h":175},"full":{"w":2018,"h":883}},"uploaded_t":"1...<br>{"sizes":{"100":{"w":75,"h":100},"400":{"h":400,"w":300},"full":{"h":1200,"w":901}},"uploaded_t":"1523494357","uploader"... |
| images.uploaded.3.sizes | 231 | object | - | {"100":{"h":44,"w":100},"400":{"w":400,"h":175},"full":{"w":2018,"h":883}}<br>{"100":{"w":75,"h":100},"400":{"h":400,"w":300},"full":{"h":1200,"w":901}} |
| images.uploaded.3.sizes.100 | 231 | object | - | {"h":44,"w":100}<br>{"w":75,"h":100} |
| images.uploaded.3.sizes.100.h | 231 | number | - | 44<br>100 |
| images.uploaded.3.sizes.100.w | 231 | number | - | 100<br>75 |
| images.uploaded.3.sizes.400 | 231 | object | - | {"w":400,"h":175}<br>{"h":400,"w":300} |
| images.uploaded.3.sizes.400.h | 231 | number | - | 175<br>400 |
| images.uploaded.3.sizes.400.w | 231 | number | - | 400<br>300 |
| images.uploaded.3.sizes.full | 231 | object | - | {"w":2018,"h":883}<br>{"h":1200,"w":901} |
| images.uploaded.3.sizes.full.h | 231 | number | - | 883<br>1200 |
| images.uploaded.3.sizes.full.w | 231 | number | - | 2018<br>901 |
| images.uploaded.3.uploaded_t | 231 | number, string | - | 1518439770<br>1523494357 |
| images.uploaded.3.uploader | 231 | string | - | kiliweb<br>macrofactor |
| images.uploaded.4 | 178 | object | - | {"sizes":{"100":{"h":75,"w":100},"400":{"w":400,"h":300},"full":{"w":1600,"h":1200}},"uploader":"kiliweb","uploaded_t":"...<br>{"uploader":"macrofactor","uploaded_t":1763319671,"sizes":{"100":{"h":100,"w":75},"400":{"h":400,"w":300},"full":{"h":16... |
| images.uploaded.4.sizes | 178 | object | - | {"100":{"h":75,"w":100},"400":{"w":400,"h":300},"full":{"w":1600,"h":1200}}<br>{"100":{"h":100,"w":75},"400":{"h":400,"w":300},"full":{"h":1698,"w":1275}} |
| images.uploaded.4.sizes.100 | 178 | object | - | {"h":75,"w":100}<br>{"h":100,"w":75} |
| images.uploaded.4.sizes.100.h | 178 | number | - | 75<br>100 |
| images.uploaded.4.sizes.100.w | 178 | number | - | 100<br>75 |
| images.uploaded.4.sizes.400 | 178 | object | - | {"w":400,"h":300}<br>{"h":400,"w":300} |
| images.uploaded.4.sizes.400.h | 178 | number | - | 300<br>400 |
| images.uploaded.4.sizes.400.w | 178 | number | - | 400<br>300 |
| images.uploaded.4.sizes.full | 178 | object | - | {"w":1600,"h":1200}<br>{"h":1698,"w":1275} |
| images.uploaded.4.sizes.full.h | 178 | number | - | 1200<br>1698 |
| images.uploaded.4.sizes.full.w | 178 | number | - | 1600<br>1275 |
| images.uploaded.4.uploaded_t | 178 | number, string | - | 1523494360<br>1763319671 |
| images.uploaded.4.uploader | 178 | string | - | kiliweb<br>macrofactor |
| images.uploaded.5 | 123 | object | - | {"sizes":{"100":{"w":88,"h":100},"400":{"w":351,"h":400},"full":{"h":629,"w":552}},"uploaded_t":1663118849,"uploader":"k...<br>{"uploaded_t":1758830245,"sizes":{"100":{"w":75,"h":100},"400":{"h":400,"w":300},"full":{"w":2448,"h":3264}},"uploader":... |
| images.uploaded.5.sizes | 123 | object | - | {"100":{"w":88,"h":100},"400":{"w":351,"h":400},"full":{"h":629,"w":552}}<br>{"100":{"w":75,"h":100},"400":{"h":400,"w":300},"full":{"w":2448,"h":3264}} |
| images.uploaded.5.sizes.100 | 123 | object | - | {"w":88,"h":100}<br>{"w":75,"h":100} |
| images.uploaded.5.sizes.100.h | 123 | number | - | 100<br>79 |
| images.uploaded.5.sizes.100.w | 123 | number | - | 88<br>75 |
| images.uploaded.5.sizes.400 | 123 | object | - | {"w":351,"h":400}<br>{"h":400,"w":300} |
| images.uploaded.5.sizes.400.h | 123 | number | - | 400<br>317 |
| images.uploaded.5.sizes.400.w | 123 | number | - | 351<br>300 |
| images.uploaded.5.sizes.full | 123 | object | - | {"h":629,"w":552}<br>{"w":2448,"h":3264} |
| images.uploaded.5.sizes.full.h | 123 | number | - | 629<br>3264 |
| images.uploaded.5.sizes.full.w | 123 | number | - | 552<br>2448 |
| images.uploaded.5.uploaded_t | 123 | number, string | - | 1663118849<br>1758830245 |
| images.uploaded.5.uploader | 123 | string | - | kiliweb<br>scipsintel |
| images.uploaded.6 | 94 | object | - | {"sizes":{"100":{"w":64,"h":100},"400":{"w":257,"h":400},"full":{"h":1076,"w":691}},"uploaded_t":1663118850,"uploader":"...<br>{"sizes":{"100":{"w":46,"h":100},"400":{"w":184,"h":400},"full":{"h":1280,"w":590}},"uploader":"municorn-calorie-counter... |
| images.uploaded.6.sizes | 94 | object | - | {"100":{"w":64,"h":100},"400":{"w":257,"h":400},"full":{"h":1076,"w":691}}<br>{"100":{"w":46,"h":100},"400":{"w":184,"h":400},"full":{"h":1280,"w":590}} |
| images.uploaded.6.sizes.100 | 94 | object | - | {"w":64,"h":100}<br>{"w":46,"h":100} |
| images.uploaded.6.sizes.100.h | 94 | number | - | 100<br>77 |
| images.uploaded.6.sizes.100.w | 94 | number | - | 64<br>46 |
| images.uploaded.6.sizes.400 | 94 | object | - | {"w":257,"h":400}<br>{"w":184,"h":400} |
| images.uploaded.6.sizes.400.h | 94 | number | - | 400<br>307 |
| images.uploaded.6.sizes.400.w | 94 | number | - | 257<br>184 |
| images.uploaded.6.sizes.full | 94 | object | - | {"h":1076,"w":691}<br>{"h":1280,"w":590} |
| images.uploaded.6.sizes.full.h | 94 | number | - | 1076<br>1280 |
| images.uploaded.6.sizes.full.w | 94 | number | - | 691<br>590 |
| images.uploaded.6.uploaded_t | 94 | number, string | - | 1663118850<br>1759334738 |
| images.uploaded.6.uploader | 94 | string | - | kiliweb<br>municorn-calorie-counter-app |
| images.uploaded.7 | 76 | object | - | {"uploaded_t":1759334739,"uploader":"municorn-calorie-counter-app","sizes":{"100":{"h":100,"w":46},"400":{"w":184,"h":40...<br>{"uploaded_t":1615023162,"uploader":"kiliweb","sizes":{"100":{"h":100,"w":63},"400":{"h":400,"w":252},"full":{"w":538,"h... |
| images.uploaded.7.sizes | 76 | object | - | {"100":{"h":100,"w":46},"400":{"w":184,"h":400},"full":{"h":1280,"w":590}}<br>{"100":{"h":100,"w":63},"400":{"h":400,"w":252},"full":{"w":538,"h":854}} |
| images.uploaded.7.sizes.100 | 76 | object | - | {"h":100,"w":46}<br>{"h":100,"w":63} |
| images.uploaded.7.sizes.100.h | 76 | number | - | 100<br>86 |
| images.uploaded.7.sizes.100.w | 76 | number | - | 46<br>63 |
| images.uploaded.7.sizes.400 | 76 | object | - | {"w":184,"h":400}<br>{"h":400,"w":252} |
| images.uploaded.7.sizes.400.h | 76 | number | - | 400<br>344 |
| images.uploaded.7.sizes.400.w | 76 | number | - | 184<br>252 |
| images.uploaded.7.sizes.full | 76 | object | - | {"h":1280,"w":590}<br>{"w":538,"h":854} |
| images.uploaded.7.sizes.full.h | 76 | number | - | 1280<br>854 |
| images.uploaded.7.sizes.full.w | 76 | number | - | 590<br>538 |
| images.uploaded.7.uploaded_t | 76 | number, string | - | 1759334739<br>1615023162 |
| images.uploaded.7.uploader | 76 | string | - | municorn-calorie-counter-app<br>kiliweb |
| images.uploaded.8 | 60 | object | - | {"sizes":{"100":{"h":100,"w":54},"400":{"h":400,"w":216},"full":{"w":648,"h":1200}},"uploader":"kiliweb","uploaded_t":16...<br>{"uploaded_t":1759705979,"uploader":"municorn-calorie-counter-app","sizes":{"100":{"h":100,"w":46},"400":{"h":400,"w":18... |
| images.uploaded.8.sizes | 60 | object | - | {"100":{"h":100,"w":54},"400":{"h":400,"w":216},"full":{"w":648,"h":1200}}<br>{"100":{"h":100,"w":46},"400":{"h":400,"w":185},"full":{"h":1280,"w":592}} |
| images.uploaded.8.sizes.100 | 60 | object | - | {"h":100,"w":54}<br>{"h":100,"w":46} |
| images.uploaded.8.sizes.100.h | 60 | number | - | 100<br>83 |
| images.uploaded.8.sizes.100.w | 60 | number | - | 54<br>46 |
| images.uploaded.8.sizes.400 | 60 | object | - | {"h":400,"w":216}<br>{"h":400,"w":185} |
| images.uploaded.8.sizes.400.h | 60 | number | - | 400<br>331 |
| images.uploaded.8.sizes.400.w | 60 | number | - | 216<br>185 |
| images.uploaded.8.sizes.full | 60 | object | - | {"w":648,"h":1200}<br>{"h":1280,"w":592} |
| images.uploaded.8.sizes.full.h | 60 | number | - | 1200<br>1280 |
| images.uploaded.8.sizes.full.w | 60 | number | - | 648<br>592 |
| images.uploaded.8.uploaded_t | 60 | number, string | - | 1639431369<br>1759705979 |
| images.uploaded.8.uploader | 60 | string | - | kiliweb<br>municorn-calorie-counter-app |
| images.uploaded.9 | 50 | object | - | {"uploaded_t":1639431369,"sizes":{"100":{"h":44,"w":100},"400":{"w":400,"h":178},"full":{"w":870,"h":387}},"uploader":"k...<br>{"sizes":{"100":{"w":46,"h":100},"400":{"w":185,"h":400},"full":{"w":592,"h":1280}},"uploader":"municorn-calorie-counter... |
| images.uploaded.9.sizes | 50 | object | - | {"100":{"h":44,"w":100},"400":{"w":400,"h":178},"full":{"w":870,"h":387}}<br>{"100":{"w":46,"h":100},"400":{"w":185,"h":400},"full":{"w":592,"h":1280}} |
| images.uploaded.9.sizes.100 | 50 | object | - | {"h":44,"w":100}<br>{"w":46,"h":100} |
| images.uploaded.9.sizes.100.h | 50 | number | - | 44<br>100 |
| images.uploaded.9.sizes.100.w | 50 | number | - | 100<br>46 |
| images.uploaded.9.sizes.400 | 50 | object | - | {"w":400,"h":178}<br>{"w":185,"h":400} |
| images.uploaded.9.sizes.400.h | 50 | number | - | 178<br>400 |
| images.uploaded.9.sizes.400.w | 50 | number | - | 400<br>185 |
| images.uploaded.9.sizes.full | 50 | object | - | {"w":870,"h":387}<br>{"w":592,"h":1280} |
| images.uploaded.9.sizes.full.h | 50 | number | - | 387<br>1280 |
| images.uploaded.9.sizes.full.w | 50 | number | - | 870<br>592 |
| images.uploaded.9.uploaded_t | 50 | number, string | - | 1639431369<br>1759705980 |
| images.uploaded.9.uploader | 50 | string | - | kiliweb<br>municorn-calorie-counter-app |
| informers_tags[] | 11475 | string | - | yuka.SGJvbVRKUXpoT2tVaHZCaDNEUEl4NHdrbDdpNVcwR3FEc0E2SVE9PQ<br>kiliweb |
| informers[] | 1 | string | - | javichu |
| ingredients_analysis_tags[] | 8169 | string | - | en:palm-oil-free<br>en:vegan |
| ingredients_analysis.en:may-contain-palm-oil | 343 | array | string | ["en:vegetable-oil"]<br>["en:e472e"] |
| ingredients_analysis.en:may-contain-palm-oil[] | 444 | string | - | en:vegetable-oil<br>en:e472e |
| ingredients_analysis.en:maybe-vegan | 188 | array | string | ["en:natural-apple-flavouring"]<br>["en:e472e"] |
| ingredients_analysis.en:maybe-vegan[] | 280 | string | - | en:natural-apple-flavouring<br>en:e472e |
| ingredients_analysis.en:maybe-vegetarian | 365 | array | string | ["en:natural-apple-flavouring"]<br>["en:whey-powder"] |
| ingredients_analysis.en:maybe-vegetarian[] | 539 | string | - | en:natural-apple-flavouring<br>en:whey-powder |
| ingredients_analysis.en:non-vegan | 1540 | array | string | ["en:whey-powder"]<br>["en:skimmed-milk-powder","en:whey-powder","en:whey-powder","en:lactose","en:milkfat"] |
| ingredients_analysis.en:non-vegan[] | 4661 | string | - | en:whey-powder<br>en:skimmed-milk-powder |
| ingredients_analysis.en:non-vegetarian | 276 | array | string | ["en:e120"]<br>["en:e904"] |
| ingredients_analysis.en:non-vegetarian[] | 387 | string | - | en:e120<br>en:e904 |
| ingredients_analysis.en:palm-oil | 485 | array | string | ["en:palm-oil","en:palm-kernel-oil"]<br>["en:palm-oil"] |
| ingredients_analysis.en:palm-oil-content-unknown | 1110 | array | string | ["en:linden-flowers"]<br>["en:shave-grass"] |
| ingredients_analysis.en:palm-oil-content-unknown[] | 2740 | string | - | en:linden-flowers<br>en:shave-grass |
| ingredients_analysis.en:palm-oil[] | 667 | string | - | en:palm-oil<br>en:palm-kernel-oil |
| ingredients_analysis.en:vegan-status-unknown | 1975 | array | string | ["en:linden-flowers"]<br>["en:shave-grass"] |
| ingredients_analysis.en:vegan-status-unknown[] | 5980 | string | - | en:linden-flowers<br>en:shave-grass |
| ingredients_analysis.en:vegetarian-status-unknown | 1975 | array | string | ["en:linden-flowers"]<br>["en:shave-grass"] |
| ingredients_analysis.en:vegetarian-status-unknown[] | 5977 | string | - | en:linden-flowers<br>en:shave-grass |
| ingredients_debug[] | 148 | null, string | - | Milk chocolate <br>( |
| ingredients_from_palm_oil_tags[] | 12 | string | - | huile-de-palme |
| ingredients_hierarchy[] | 61138 | string | - | en:camomile-flower<br>en:herb |
| ingredients_ids_debug[] | 31 | string | - | milk-chocolate<br>sugar |
| ingredients_n_tags[] | 5440 | string | - | 1<br>1-10 |
| ingredients_original_tags[] | 45095 | string | - | en:camomile-flower<br>en:peppermint |
| ingredients_tags[] | 75993 | string | - | en:camomile-flower<br>en:herb |
| ingredients_that_may_be_from_palm_oil_tags[] | 337 | string | - | e160a-beta-carotene<br>e433-monooleate-de-polyoxyethylene-de-sorbitane |
| ingredients_without_ciqual_codes[] | 22152 | string | - | en:camomile-flower<br>en:linden-flowers |
| ingredients_without_ecobalyse_ids[] | 30119 | string | - | en:camomile-flower<br>en:peppermint |
| ingredients[] | 29334 | object | - | {"is_in_taxonomy":1,"percent_min":100,"vegan":"yes","percent_max":100,"text":"CHAMOMILE FLOWERS","vegetarian":"yes","per...<br>{"id":"en:peppermint","percent_estimate":100,"percent_max":100,"vegan":"yes","vegetarian":"yes","is_in_taxonomy":1,"perc... |
| ingredients[].ciqual_food_code | 9208 | string | - | 11027<br>18020 |
| ingredients[].ciqual_proxy_food_code | 5423 | string | - | 9532<br>9410 |
| ingredients[].ecobalyse_code | 6442 | string | - | 96b301d9-d21b-4cea-8903-bd7917e95a30<br>36b3ffec-51e7-4e26-b1b5-7d52554e0aa6 |
| ingredients[].ecobalyse_proxy_code | 1 | string | - | flour |
| ingredients[].from_palm_oil | 1956 | string | - | no<br>yes |
| ingredients[].id | 29334 | string | - | en:camomile-flower<br>en:peppermint |
| ingredients[].ingredients | 4455 | array | object | [{"is_in_taxonomy":1,"percent_min":0,"percent_max":11.11111111111111,"text":"PRESERVATIVE","id":"en:preservative","perce...<br>[{"percent_estimate":0.022786458333328596,"id":"en:dl-alpha-tocopheryl-acetate","text":"DL-ALPHA-TOCOPHEROL ACETATE","pe... |
| ingredients[].ingredients[] | 14183 | object | - | {"is_in_taxonomy":1,"percent_min":0,"percent_max":11.11111111111111,"text":"PRESERVATIVE","id":"en:preservative","percen...<br>{"percent_estimate":0.022786458333328596,"id":"en:dl-alpha-tocopheryl-acetate","text":"DL-ALPHA-TOCOPHEROL ACETATE","per... |
| ingredients[].ingredients[].ciqual_food_code | 4468 | string | - | 42200<br>16030 |
| ingredients[].ingredients[].ciqual_proxy_food_code | 2127 | string | - | 9410<br>31016 |
| ingredients[].ingredients[].ecobalyse_code | 3091 | string | - | flour<br>sugar |
| ingredients[].ingredients[].from_palm_oil | 1240 | string | - | maybe<br>no |
| ingredients[].ingredients[].id | 14183 | string | - | en:preservative<br>en:dl-alpha-tocopheryl-acetate |
| ingredients[].ingredients[].ingredients | 899 | array | object | [{"ciqual_food_code":"42200","text":"soya lecithin","vegetarian":"yes","is_in_taxonomy":1,"percent_min":0,"id":"en:soya-...<br>[{"percent_estimate":2.6785714285714306,"id":"en:emulsifier","text":"AN EMULSIFIER","percent_max":20,"is_in_taxonomy":1,... |
| ingredients[].ingredients[].ingredients[] | 1522 | object | - | {"ciqual_food_code":"42200","text":"soya lecithin","vegetarian":"yes","is_in_taxonomy":1,"percent_min":0,"id":"en:soya-l...<br>{"percent_estimate":2.6785714285714306,"id":"en:emulsifier","text":"AN EMULSIFIER","percent_max":20,"is_in_taxonomy":1,"... |
| ingredients[].ingredients[].is_in_taxonomy | 13558 | number | - | 1<br>0 |
| ingredients[].ingredients[].labels | 63 | string | - | en:vegan<br>en:organic |
| ingredients[].ingredients[].origins | 6 | string | - | fr:c bicarbonate de sodium<br>fr:France et UE |
| ingredients[].ingredients[].percent | 20 | number | - | 35<br>30 |
| ingredients[].ingredients[].percent_estimate | 14183 | number | - | 0.1822916666666643<br>0.022786458333328596 |
| ingredients[].ingredients[].percent_max | 13562 | number, string | - | 11.11111111111111<br>5 |
| ingredients[].ingredients[].percent_min | 13562 | number | - | 0<br>1.6666666666666667 |
| ingredients[].ingredients[].processing | 505 | string | - | en:dried<br>en:unbleached |
| ingredients[].ingredients[].text | 14183 | string | - | PRESERVATIVE<br>DL-ALPHA-TOCOPHEROL ACETATE |
| ingredients[].ingredients[].vegan | 11441 | string | - | no<br>yes |
| ingredients[].ingredients[].vegetarian | 11441 | string | - | maybe<br>yes |
| ingredients[].is_in_taxonomy | 27451 | number | - | 1<br>0 |
| ingredients[].labels | 326 | string | - | en:organic<br>en:no-gluten |
| ingredients[].origins | 17 | string | - | en:california<br>en:madagascar |
| ingredients[].percent | 481 | number | - | 50<br>14 |
| ingredients[].percent_estimate | 29334 | number | - | 100<br>72.5 |
| ingredients[].percent_max | 28671 | number, string | - | 100<br>50 |
| ingredients[].percent_min | 28671 | number | - | 100<br>45 |
| ingredients[].processing | 1584 | string | - | en:dried<br>en:enriched,en:bleached |
| ingredients[].quantity | 9 | string | - | 5 g<br>10.0 g |
| ingredients[].quantity_g | 9 | number | - | 5<br>10 |
| ingredients[].text | 29334 | string | - | CHAMOMILE FLOWERS<br>Peppermint |
| ingredients[].vegan | 24706 | string | - | yes<br>maybe |
| ingredients[].vegetarian | 24709 | string | - | yes<br>maybe |
| labels_hierarchy[] | 801 | string | - | en:no-gluten<br>en:no-palm-oil |
| labels_prev_hierarchy[] | 8 | string | - | en:organic<br>en:vegetarian |
| labels_prev_tags[] | 8 | string | - | en:organic<br>en:vegetarian |
| labels_tags[] | 801 | string | - | en:no-gluten<br>en:no-palm-oil |
| languages_codes.ar | 1 | number | - | 1 |
| languages_codes.cs | 1 | number | - | 5 |
| languages_codes.da | 10 | number | - | 1<br>3 |
| languages_codes.de | 21 | number | - | 4<br>1 |
| languages_codes.en | 2681 | number | - | 2<br>3 |
| languages_codes.es | 13 | number | - | 2<br>6 |
| languages_codes.fr | 444 | number | - | 4<br>1 |
| languages_codes.it | 12 | number | - | 5<br>3 |
| languages_codes.la | 6 | number | - | 1<br>3 |
| languages_codes.nl | 10 | number | - | 2<br>3 |
| languages_codes.pt | 2 | number | - | 1<br>2 |
| languages_codes.ro | 3 | number | - | 1 |
| languages_codes.ru | 1 | number | - | 2 |
| languages_codes.sv | 1 | number | - | 2 |
| languages_codes.th | 1 | number | - | 5 |
| languages_hierarchy[] | 3207 | string | - | en:french<br>en:english |
| languages_tags[] | 6401 | string | - | en:french<br>en:1 |
| languages.en:arabic | 1 | number | - | 1 |
| languages.en:czech | 1 | number | - | 5 |
| languages.en:danish | 10 | number | - | 1<br>3 |
| languages.en:dutch | 10 | number | - | 2<br>3 |
| languages.en:english | 2681 | number | - | 2<br>3 |
| languages.en:french | 444 | number | - | 4<br>1 |
| languages.en:german | 21 | number | - | 4<br>1 |
| languages.en:italian | 12 | number | - | 5<br>3 |
| languages.en:latin | 6 | number | - | 1<br>3 |
| languages.en:portuguese | 2 | number | - | 1<br>2 |
| languages.en:romanian | 3 | number | - | 1 |
| languages.en:russian | 1 | number | - | 2 |
| languages.en:spanish | 13 | number | - | 2<br>6 |
| languages.en:swedish | 1 | number | - | 2 |
| languages.en:thai | 1 | number | - | 5 |
| last_check_dates_tags[] | 9 | string | - | 2019-09-23<br>2019-09 |
| last_edit_dates_tags[] | 9000 | string | - | 2024-11-14<br>2024-11 |
| last_image_dates_tags[] | 3432 | string | - | 2020-01-18<br>2020-01 |
| manufacturing_places_tags[] | 120 | string | - | germany<br>japon |
| minerals_prev_tags[] | 486 | string | - | en:iron<br>en:ferrous-sulphate |
| minerals_tags[] | 1031 | string | - | en:calcium<br>en:iron |
| misc_tags[] | 39528 | string | - | en:environmental-score-computed<br>en:environmental-score-missing-data-labels |
| nova_groups_markers.2 | 35 | array | array | [["categories","en:fats"]]<br>[["categories","en:honeys"]] |
| nova_groups_markers.2[] | 35 | array | string | ["categories","en:fats"]<br>["categories","en:honeys"] |
| nova_groups_markers.2[][] | 70 | string | - | categories<br>en:fats |
| nova_groups_markers.3 | 2240 | array | array | [["additives","en:e202"],["ingredients","en:preservative"],["ingredients","en:salt"]]<br>[["ingredients","en:salt"],["ingredients","en:sugar"]] |
| nova_groups_markers.3[] | 6822 | array | string | ["additives","en:e202"]<br>["ingredients","en:preservative"] |
| nova_groups_markers.3[][] | 13644 | string | - | additives<br>en:e202 |
| nova_groups_markers.4 | 2020 | array | array | [["ingredients","en:flavouring"]]<br>[["additives","en:e322"],["additives","en:e471"],["ingredients","en:flavouring"],["ingredients","en:whey"]] |
| nova_groups_markers.4[] | 10078 | array | string | ["ingredients","en:flavouring"]<br>["additives","en:e322"] |
| nova_groups_markers.4[][] | 20156 | string | - | ingredients<br>en:flavouring |
| nova_groups_tags[] | 3000 | string | - | unknown<br>en:1-unprocessed-or-minimally-processed-foods |
| nutrient_levels_tags[] | 9485 | string | - | en:fat-in-high-quantity<br>en:saturated-fat-in-high-quantity |
| nutrient_levels.fat | 2489 | string | - | high<br>low |
| nutrient_levels.salt | 2452 | string | - | low<br>high |
| nutrient_levels.saturated-fat | 2180 | string | - | high<br>low |
| nutrient_levels.sugars | 2364 | string | - | high<br>low |
| nutriments_estimated.alcohol_100g | 691 | number | - | 0<br>3.458 |
| nutriments_estimated.beta-carotene_100g | 682 | number | - | 0.00074<br>0.0000025 |
| nutriments_estimated.calcium_100g | 691 | number | - | 0.221<br>0.00378 |
| nutriments_estimated.carbohydrates_100g | 691 | number | - | 5.3<br>1.09 |
| nutriments_estimated.chloride_100g | 35 | number | - | 0.005311111111111111<br>0.0039051586538461553 |
| nutriments_estimated.cholesterol_100g | 690 | number | - | 0<br>6.214488636363703e-7 |
| nutriments_estimated.copper_100g | 691 | number | - | 0.00028000000000000003<br>0.000029999999999999997 |
| nutriments_estimated.energy_100g | 690 | number | - | 240<br>21.7 |
| nutriments_estimated.energy-kcal_100g | 682 | number | - | 57.6<br>5.1 |
| nutriments_estimated.energy-kj_100g | 682 | number | - | 240<br>21.7 |
| nutriments_estimated.fat_100g | 691 | number | - | 0.84<br>0 |
| nutriments_estimated.fiber_100g | 691 | number | - | 7.4<br>0 |
| nutriments_estimated.fructose_100g | 685 | number | - | 0.25<br>0 |
| nutriments_estimated.galactose_100g | 683 | number | - | 0.19<br>0 |
| nutriments_estimated.glucose_100g | 685 | number | - | 0.15<br>0 |
| nutriments_estimated.iodine_100g | 682 | number | - | 0.0000039<br>0.00001 |
| nutriments_estimated.iron_100g | 691 | number | - | 0.00848<br>0.000059999999999999995 |
| nutriments_estimated.lactose_100g | 685 | number | - | 0.1<br>0 |
| nutriments_estimated.magnesium_100g | 691 | number | - | 0.0715<br>0.0034899999999999996 |
| nutriments_estimated.maltose_100g | 685 | number | - | 0.1<br>0 |
| nutriments_estimated.manganese_100g | 691 | number | - | 0.00115<br>0.00149 |
| nutriments_estimated.pantothenic-acid_100g | 682 | number | - | 0.00029<br>0.00013000000000000002 |
| nutriments_estimated.phosphorus_100g | 691 | number | - | 0.0665<br>0.00368 |
| nutriments_estimated.phylloquinone_100g | 682 | number | - | 0.000152<br>4.0000000000000003e-7 |
| nutriments_estimated.polyols_100g | 690 | number | - | 0<br>0.0008877840909091006 |
| nutriments_estimated.potassium_100g | 691 | number | - | 0.514<br>0.0538 |
| nutriments_estimated.proteins_100g | 691 | number | - | 3.52<br>0 |
| nutriments_estimated.salt_100g | 691 | number | - | 0.076<br>0.011 |
| nutriments_estimated.saturated-fat_100g | 682 | number | - | 0.22<br>0 |
| nutriments_estimated.selenium_100g | 682 | number | - | 5e-7<br>0.00001 |
| nutriments_estimated.sodium_100g | 691 | number | - | 0.0305<br>0.00425 |
| nutriments_estimated.starch_100g | 686 | number | - | 0<br>10.115411931818178 |
| nutriments_estimated.sucrose_100g | 685 | number | - | 0.35<br>0 |
| nutriments_estimated.sugars_100g | 691 | number | - | 5.3<br>0 |
| nutriments_estimated.vitamin-a_100g | 682 | number | - | 0<br>1.8643465909091114e-8 |
| nutriments_estimated.vitamin-b1_100g | 682 | number | - | 0.00008<br>0.000007499999999999999 |
| nutriments_estimated.vitamin-b12_100g | 682 | number | - | 0<br>6.036931818181884e-10 |
| nutriments_estimated.vitamin-b2_100g | 682 | number | - | 0.00022000000000000003<br>0.000005 |
| nutriments_estimated.vitamin-b6_100g | 691 | number | - | 0.00014000000000000001<br>0.000005 |
| nutriments_estimated.vitamin-b9_100g | 682 | number | - | 0.00011000000000000002<br>0.00000699 |
| nutriments_estimated.vitamin-c_100g | 691 | number | - | 0.022600000000000002<br>0.00025 |
| nutriments_estimated.vitamin-d_100g | 682 | number | - | 0<br>5e-9 |
| nutriments_estimated.vitamin-e_100g | 691 | number | - | 0.005<br>0.00001 |
| nutriments_estimated.vitamin-pp_100g | 682 | number | - | 0.00133<br>0.00020999999999999998 |
| nutriments_estimated.water_100g | 691 | number | - | 82.1<br>98.5 |
| nutriments_estimated.zinc_100g | 691 | number | - | 0.0011<br>0.000025 |
| nutriments.added-sugars | 247 | number | - | 0<br>34 |
| nutriments.added-sugars_100g | 242 | number | - | 0<br>9.58 |
| nutriments.added-sugars_label | 3 | string | - | Added sugars |
| nutriments.added-sugars_serving | 247 | number | - | 0<br>34 |
| nutriments.added-sugars_unit | 247 | string | - | g |
| nutriments.added-sugars_value | 247 | number | - | 0<br>34 |
| nutriments.alcohol | 28 | number | - | 8.5<br>0 |
| nutriments.alcohol_100g | 28 | number | - | 8.5<br>0 |
| nutriments.alcohol_serving | 28 | number | - | 8.5<br>0 |
| nutriments.alcohol_unit | 28 | string | - | % vol<br>% vol / * |
| nutriments.alcohol_value | 28 | number | - | 8.5<br>0 |
| nutriments.alpha-linolenic-acid | 1 | number | - | 0.29 |
| nutriments.alpha-linolenic-acid_100g | 1 | number | - | 0.121 |
| nutriments.alpha-linolenic-acid_serving | 1 | number | - | 0.29 |
| nutriments.alpha-linolenic-acid_unit | 1 | string | - | mg |
| nutriments.alpha-linolenic-acid_value | 1 | number | - | 290 |
| nutriments.arachidic-acid | 1 | number | - | 0.035 |
| nutriments.arachidic-acid_100g | 1 | number | - | 0.0146 |
| nutriments.arachidic-acid_serving | 1 | number | - | 0.035 |
| nutriments.arachidic-acid_unit | 1 | string | - | mg |
| nutriments.arachidic-acid_value | 1 | number | - | 35 |
| nutriments.arachidonic-acid | 1 | number | - | 0 |
| nutriments.arachidonic-acid_100g | 1 | number | - | 0 |
| nutriments.arachidonic-acid_serving | 1 | number | - | 0 |
| nutriments.arachidonic-acid_unit | 1 | string | - | mg |
| nutriments.arachidonic-acid_value | 1 | number | - | 0 |
| nutriments.behenic-acid | 1 | number | - | 0.37 |
| nutriments.behenic-acid_100g | 1 | number | - | 0.154 |
| nutriments.behenic-acid_serving | 1 | number | - | 0.37 |
| nutriments.behenic-acid_unit | 1 | string | - | mg |
| nutriments.behenic-acid_value | 1 | number | - | 370 |
| nutriments.caffeine | 121 | number | - | 0<br>0.038 |
| nutriments.caffeine_100g | 117 | number | - | 0<br>0.0107 |
| nutriments.caffeine_serving | 121 | number | - | 0<br>0.038 |
| nutriments.caffeine_unit | 121 | string | - | mg<br>g |
| nutriments.caffeine_value | 121 | number | - | 0<br>0.038 |
| nutriments.calcium | 1882 | number | - | 0.035<br>0 |
| nutriments.calcium_100g | 1864 | number | - | 0.0614<br>0 |
| nutriments.calcium_label | 7 | string | - | Calcium<br>0 |
| nutriments.calcium_serving | 1876 | number | - | 0.035<br>0 |
| nutriments.calcium_unit | 1882 | string | - | mg<br>g |
| nutriments.calcium_value | 1882 | number | - | 35<br>0 |
| nutriments.carbohydrates | 2878 | number | - | 36<br>70 |
| nutriments.carbohydrates_100g | 2776 | number | - | 36<br>1.47 |
| nutriments.carbohydrates_modifier | 1 | string | - | < |
| nutriments.carbohydrates_prepared | 1 | number | - | 7.1 |
| nutriments.carbohydrates_prepared_100g | 1 | number | - | 7.1 |
| nutriments.carbohydrates_prepared_serving | 1 | number | - | 5.68 |
| nutriments.carbohydrates_prepared_unit | 2 | string | - | g |
| nutriments.carbohydrates_prepared_value | 1 | number | - | 7.1 |
| nutriments.carbohydrates_serving | 2590 | number | - | 70<br>0.661 |
| nutriments.carbohydrates_unit | 2878 | string | - | g |
| nutriments.carbohydrates_value | 2878 | number | - | 36<br>70 |
| nutriments.carbon-footprint-from-known-ingredients_100g | 65 | number | - | 0.6<br>50.949999999999996 |
| nutriments.carbon-footprint-from-known-ingredients_product | 36 | number | - | 3.15<br>46.9 |
| nutriments.carbon-footprint-from-known-ingredients_serving | 30 | number | - | 9.38<br>30.9 |
| nutriments.carbon-footprint-from-meat-or-fish_100g | 6 | number | - | 636.4<br>98 |
| nutriments.carbon-footprint-from-meat-or-fish_product | 5 | number | - | 0<br>392 |
| nutriments.carbon-footprint-from-meat-or-fish_serving | 4 | number | - | 392<br>1210 |
| nutriments.cholesterol | 1935 | number | - | 0<br>0.036 |
| nutriments.cholesterol_100g | 1918 | number | - | 0<br>0.129 |
| nutriments.cholesterol_label | 7 | string | - | Cholesterol<br>0 |
| nutriments.cholesterol_modifier | 1 | string | - | < |
| nutriments.cholesterol_serving | 1929 | number | - | 0<br>0.036 |
| nutriments.cholesterol_unit | 1935 | string | - | mg<br>g |
| nutriments.cholesterol_value | 1935 | number | - | 0<br>36 |
| nutriments.choline | 134 | number | - | 0 |
| nutriments.choline_100g | 131 | number | - | 0 |
| nutriments.choline_serving | 134 | number | - | 0 |
| nutriments.choline_unit | 134 | string | - | mg |
| nutriments.choline_value | 134 | number | - | 0 |
| nutriments.cocoa | 6 | number | - | 17.52<br>47 |
| nutriments.cocoa_100g | 6 | number | - | 17.52<br>47 |
| nutriments.cocoa_label | 6 | string | - | 0<br>Cocoa (minimum) |
| nutriments.cocoa_serving | 6 | number | - | 17.52<br>47 |
| nutriments.cocoa_unit | 6 | string | - | g |
| nutriments.cocoa_value | 6 | number | - | 17.52<br>47 |
| nutriments.copper | 137 | number | - | 0.000769<br>0.00007 |
| nutriments.copper_100g | 132 | number | - | 0.000769<br>0.000269 |
| nutriments.copper_label | 1 | string | - | 0 |
| nutriments.copper_serving | 137 | number | - | 0.0002<br>0.00007 |
| nutriments.copper_unit | 137 | string | - | mg<br>g |
| nutriments.copper_value | 137 | number | - | 0.769<br>0.00007 |
| nutriments.en-sucres-ajoutes | 1 | number | - | 15 |
| nutriments.en-sucres-ajoutes_label | 1 | string | - | Sucres-ajoutes |
| nutriments.en-sucres-ajoutes_serving | 1 | number | - | 15 |
| nutriments.en-sucres-ajoutes_unit | 1 | string | - | g |
| nutriments.en-sucres-ajoutes_value | 1 | number | - | 15 |
| nutriments.energy | 2888 | number | - | 2582<br>1172 |
| nutriments.energy_100g | 2785 | number | - | 2582<br>0 |
| nutriments.energy_prepared | 1 | number | - | 149 |
| nutriments.energy_prepared_100g | 1 | number | - | 149 |
| nutriments.energy_prepared_serving | 1 | number | - | 119 |
| nutriments.energy_prepared_unit | 1 | string | - | kJ |
| nutriments.energy_prepared_value | 1 | number | - | 149 |
| nutriments.energy_serving | 2593 | number | - | 1172<br>0 |
| nutriments.energy_unit | 2888 | string | - | kcal<br>kJ |
| nutriments.energy_value | 2888 | number | - | 617<br>280 |
| nutriments.energy-from-fat | 21 | number | - | 167<br>0 |
| nutriments.energy-from-fat_100g | 21 | number | - | 167<br>0 |
| nutriments.energy-from-fat_serving | 21 | number | - | 25<br>0 |
| nutriments.energy-from-fat_unit | 21 | string | - | kcal<br>Cal |
| nutriments.energy-from-fat_value | 21 | number | - | 40<br>0 |
| nutriments.energy-kcal | 2868 | number | - | 617<br>280 |
| nutriments.energy-kcal_100g | 2765 | number | - | 617<br>0 |
| nutriments.energy-kcal_prepared | 1 | number | - | 35 |
| nutriments.energy-kcal_prepared_100g | 1 | number | - | 35 |
| nutriments.energy-kcal_prepared_serving | 1 | number | - | 28 |
| nutriments.energy-kcal_prepared_unit | 1 | string | - | kcal |
| nutriments.energy-kcal_prepared_value | 1 | number | - | 35 |
| nutriments.energy-kcal_serving | 2576 | number | - | 280<br>0 |
| nutriments.energy-kcal_unit | 2868 | string | - | kcal |
| nutriments.energy-kcal_value | 2868 | number | - | 617<br>280 |
| nutriments.energy-kcal_value_computed | 2854 | number | - | 608<br>280 |
| nutriments.energy-kj | 52 | number | - | 1533<br>1590 |
| nutriments.energy-kj_100g | 51 | number | - | 1533<br>1590 |
| nutriments.energy-kj_prepared | 1 | number | - | 149 |
| nutriments.energy-kj_prepared_100g | 1 | number | - | 149 |
| nutriments.energy-kj_prepared_serving | 1 | number | - | 119 |
| nutriments.energy-kj_prepared_unit | 1 | string | - | kJ |
| nutriments.energy-kj_prepared_value | 1 | number | - | 149 |
| nutriments.energy-kj_serving | 36 | number | - | 307<br>398 |
| nutriments.energy-kj_unit | 52 | string | - | kJ |
| nutriments.energy-kj_value | 52 | number | - | 1533<br>1590 |
| nutriments.energy-kj_value_computed | 52 | number | - | 1533<br>1541.7 |
| nutriments.fat | 2880 | number | - | 48<br>0 |
| nutriments.fat_100g | 2778 | number | - | 48<br>0 |
| nutriments.fat_modifier | 2 | string | - | < |
| nutriments.fat_prepared | 1 | number | - | 0.3 |
| nutriments.fat_prepared_100g | 1 | number | - | 0.3 |
| nutriments.fat_prepared_serving | 1 | number | - | 0.24 |
| nutriments.fat_prepared_unit | 2 | string | - | g |
| nutriments.fat_prepared_value | 1 | number | - | 0.3 |
| nutriments.fat_serving | 2592 | number | - | 0<br>14 |
| nutriments.fat_unit | 2880 | string | - | g |
| nutriments.fat_value | 2880 | number | - | 48<br>0 |
| nutriments.fiber | 2178 | number | - | 0<br>1.8 |
| nutriments.fiber_100g | 2155 | number | - | 0<br>3.16 |
| nutriments.fiber_modifier | 10 | string | - | -<br>< |
| nutriments.fiber_prepared | 1 | number | - | 1.1 |
| nutriments.fiber_prepared_100g | 1 | number | - | 1.1 |
| nutriments.fiber_prepared_serving | 1 | number | - | 0.88 |
| nutriments.fiber_prepared_unit | 2 | string | - | g |
| nutriments.fiber_prepared_value | 1 | number | - | 1.1 |
| nutriments.fiber_serving | 2047 | number | - | 0<br>1.8 |
| nutriments.fiber_unit | 2178 | string | - | g |
| nutriments.fiber_value | 2178 | number | - | 0<br>1.8 |
| nutriments.fluoride | 3 | number | - | 0<br>0.000004 |
| nutriments.fluoride_100g | 2 | number | - | 0.000004<br>0.000007 |
| nutriments.fluoride_serving | 3 | number | - | 0<br>3e-7 |
| nutriments.fluoride_unit | 3 | string | - | µg |
| nutriments.fluoride_value | 3 | number | - | 0<br>4 |
| nutriments.folates | 64 | number | - | 0.000385<br>38.4615 |
| nutriments.folates_100g | 63 | number | - | 0.000385<br>38.4615 |
| nutriments.folates_serving | 64 | number | - | 0.0001<br>20 |
| nutriments.folates_unit | 64 | string | - | µg |
| nutriments.folates_value | 64 | number | - | 385<br>38461500 |
| nutriments.fructose | 2 | number | - | 0.37<br>0.12 |
| nutriments.fructose_100g | 2 | number | - | 0.37<br>0.12 |
| nutriments.fructose_serving | 2 | number | - | 0.0278<br>0.12 |
| nutriments.fructose_unit | 2 | string | - | g |
| nutriments.fructose_value | 2 | number | - | 0.37<br>0.12 |
| nutriments.fruits-vegetables-legumes-estimate-from-ingredients_100g | 2719 | number | - | 100<br>0 |
| nutriments.fruits-vegetables-legumes-estimate-from-ingredients_serving | 2719 | number | - | 100<br>0 |
| nutriments.fruits-vegetables-nuts | 3 | number | - | 12<br>38 |
| nutriments.fruits-vegetables-nuts_100g | 3 | number | - | 12<br>38 |
| nutriments.fruits-vegetables-nuts_label | 2 | string | - | 0<br>Fruits‚ vegetables‚ nuts and rapeseed‚ walnut and olive oils |
| nutriments.fruits-vegetables-nuts_serving | 3 | number | - | 12<br>38 |
| nutriments.fruits-vegetables-nuts_unit | 3 | string | - | g |
| nutriments.fruits-vegetables-nuts_value | 3 | number | - | 12<br>38 |
| nutriments.fruits-vegetables-nuts-estimate | 14 | number | - | 40<br>27 |
| nutriments.fruits-vegetables-nuts-estimate_100g | 14 | number | - | 40<br>27 |
| nutriments.fruits-vegetables-nuts-estimate_label | 14 | string | - | 0 |
| nutriments.fruits-vegetables-nuts-estimate_serving | 14 | number | - | 40<br>27 |
| nutriments.fruits-vegetables-nuts-estimate_unit | 14 | string | - | g |
| nutriments.fruits-vegetables-nuts-estimate_value | 14 | number | - | 40<br>27 |
| nutriments.fruits-vegetables-nuts-estimate-from-ingredients_100g | 2719 | number | - | 100<br>0 |
| nutriments.fruits-vegetables-nuts-estimate-from-ingredients_serving | 2719 | number | - | 100<br>0 |
| nutriments.glucose | 2 | number | - | 0.4<br>0.37 |
| nutriments.glucose_100g | 2 | number | - | 0.4<br>0.37 |
| nutriments.glucose_serving | 2 | number | - | 0.03<br>0.37 |
| nutriments.glucose_unit | 2 | string | - | g |
| nutriments.glucose_value | 2 | number | - | 0.4<br>0.37 |
| nutriments.insoluble-fiber | 2 | number | - | 5 |
| nutriments.insoluble-fiber_100g | 2 | number | - | 11.6<br>12.5 |
| nutriments.insoluble-fiber_serving | 2 | number | - | 5 |
| nutriments.insoluble-fiber_unit | 2 | string | - | g |
| nutriments.insoluble-fiber_value | 2 | number | - | 5 |
| nutriments.iodine | 6 | number | - | 0.000018<br>0.000014 |
| nutriments.iodine_100g | 5 | number | - | 0.000018<br>0.0000061 |
| nutriments.iodine_serving | 6 | number | - | 0.0000531<br>0.000018 |
| nutriments.iodine_unit | 6 | string | - | µg |
| nutriments.iodine_value | 6 | number | - | 18<br>14 |
| nutriments.iron | 1903 | number | - | 0.00253<br>0.00318 |
| nutriments.iron_100g | 1887 | number | - | 0.00444<br>0.00318 |
| nutriments.iron_label | 7 | string | - | Iron<br>0 |
| nutriments.iron_serving | 1897 | number | - | 0.00253<br>0.00108 |
| nutriments.iron_unit | 1903 | string | - | mg<br>g |
| nutriments.iron_value | 1903 | number | - | 2.5300000000000002<br>3.18 |
| nutriments.lactose | 2 | number | - | 0 |
| nutriments.lactose_100g | 2 | number | - | 0 |
| nutriments.lactose_serving | 2 | number | - | 0 |
| nutriments.lactose_unit | 2 | string | - | g |
| nutriments.lactose_value | 2 | number | - | 0 |
| nutriments.magnesium | 150 | number | - | 0.385<br>0.047 |
| nutriments.magnesium_100g | 145 | number | - | 0.385<br>0.047 |
| nutriments.magnesium_label | 1 | string | - | 0 |
| nutriments.magnesium_serving | 150 | number | - | 0.1<br>0.139 |
| nutriments.magnesium_unit | 150 | string | - | mg<br>g |
| nutriments.magnesium_value | 150 | number | - | 385<br>47 |
| nutriments.maltose | 2 | number | - | 0 |
| nutriments.maltose_100g | 2 | number | - | 0 |
| nutriments.maltose_serving | 2 | number | - | 0 |
| nutriments.maltose_unit | 2 | string | - | g |
| nutriments.maltose_value | 2 | number | - | 0 |
| nutriments.manganese | 137 | number | - | 0.003<br>0 |
| nutriments.manganese_100g | 132 | number | - | 0.003<br>0 |
| nutriments.manganese_serving | 137 | number | - | 0.00078<br>0 |
| nutriments.manganese_unit | 137 | string | - | mg<br>g |
| nutriments.manganese_value | 137 | number | - | 3<br>0 |
| nutriments.monounsaturated-fat | 358 | number | - | 64.29<br>42.9 |
| nutriments.monounsaturated-fat_100g | 355 | number | - | 64.29<br>306 |
| nutriments.monounsaturated-fat_label | 5 | string | - | Grasas monoinsaturadas<br>0 |
| nutriments.monounsaturated-fat_serving | 358 | number | - | 9<br>42.9 |
| nutriments.monounsaturated-fat_unit | 358 | string | - | g |
| nutriments.monounsaturated-fat_value | 358 | number | - | 64.29<br>42.9 |
| nutriments.nova-group | 2600 | number | - | 1<br>4 |
| nutriments.nova-group_100g | 2600 | number | - | 1<br>4 |
| nutriments.nova-group_serving | 2600 | number | - | 1<br>4 |
| nutriments.nutrition-score-fr | 2358 | number | - | 25<br>0 |
| nutriments.nutrition-score-fr_100g | 2358 | number | - | 25<br>0 |
| nutriments.omega-3-fat | 2 | number | - | 0<br>1.3 |
| nutriments.omega-3-fat_100g | 1 | number | - | 1.3 |
| nutriments.omega-3-fat_serving | 1 | number | - | 0 |
| nutriments.omega-3-fat_unit | 2 | string | - | g |
| nutriments.omega-3-fat_value | 2 | number | - | 0<br>1.3 |
| nutriments.omega-6-fat | 1 | number | - | 0 |
| nutriments.omega-6-fat_serving | 1 | number | - | 0 |
| nutriments.omega-6-fat_unit | 1 | string | - | g |
| nutriments.omega-6-fat_value | 1 | number | - | 0 |
| nutriments.pantothenic-acid | 18 | number | - | 0.015385<br>0.0043479999999999994 |
| nutriments.pantothenic-acid_100g | 16 | number | - | 0.015385<br>0.0189 |
| nutriments.pantothenic-acid_serving | 18 | number | - | 0.004<br>0.0043479999999999994 |
| nutriments.pantothenic-acid_unit | 18 | string | - | mg<br>g |
| nutriments.pantothenic-acid_value | 18 | number | - | 15.385<br>4.348 |
| nutriments.phosphorus | 150 | number | - | 0.2<br>0.22 |
| nutriments.phosphorus_100g | 145 | number | - | 0.667<br>0.22 |
| nutriments.phosphorus_label | 1 | string | - | 0 |
| nutriments.phosphorus_serving | 149 | number | - | 0.2<br>0.0998 |
| nutriments.phosphorus_unit | 150 | string | - | mg<br>g |
| nutriments.phosphorus_value | 150 | number | - | 200<br>220 |
| nutriments.phylloquinone | 8 | number | - | 0.0000308<br>0.0000068 |
| nutriments.phylloquinone_100g | 8 | number | - | 0.0000308<br>0.0000068 |
| nutriments.phylloquinone_serving | 8 | number | - | 0.000016<br>0.0000201 |
| nutriments.phylloquinone_unit | 8 | string | - | µg |
| nutriments.phylloquinone_value | 8 | number | - | 30.8<br>6.8 |
| nutriments.polyols | 23 | number | - | 40<br>0 |
| nutriments.polyols_100g | 23 | number | - | 40<br>0 |
| nutriments.polyols_label | 1 | string | - | Polyols (sugar alcohols) |
| nutriments.polyols_serving | 22 | number | - | 1<br>0 |
| nutriments.polyols_unit | 23 | string | - | g |
| nutriments.polyols_value | 23 | number | - | 40<br>0 |
| nutriments.polyunsaturated-fat | 355 | number | - | 25<br>17.9 |
| nutriments.polyunsaturated-fat_100g | 352 | number | - | 25<br>128 |
| nutriments.polyunsaturated-fat_label | 5 | string | - | Grasas poliinsaturadas<br>0 |
| nutriments.polyunsaturated-fat_serving | 355 | number | - | 3.5<br>17.9 |
| nutriments.polyunsaturated-fat_unit | 355 | string | - | g |
| nutriments.polyunsaturated-fat_value | 355 | number | - | 25<br>17.9 |
| nutriments.potassium | 442 | number | - | 3.2<br>0.02 |
| nutriments.potassium_100g | 432 | number | - | 0.02<br>1.533 |
| nutriments.potassium_label | 3 | string | - | Potassium<br>0 |
| nutriments.potassium_serving | 440 | number | - | 3.2<br>0.009 |
| nutriments.potassium_unit | 442 | string | - | mg<br>g |
| nutriments.potassium_value | 442 | number | - | 3200<br>20 |
| nutriments.protein-dry-substance | 1 | number | - | 88.5 |
| nutriments.protein-dry-substance_100g | 1 | number | - | 88.5 |
| nutriments.protein-dry-substance_label | 1 | string | - | Protein-dry-substance |
| nutriments.protein-dry-substance_serving | 1 | number | - | 17.7 |
| nutriments.protein-dry-substance_unit | 1 | string | - | g |
| nutriments.protein-dry-substance_value | 1 | number | - | 88.5 |
| nutriments.proteins | 2883 | number | - | 8<br>0 |
| nutriments.proteins_100g | 2781 | number | - | 8<br>0 |
| nutriments.proteins_modifier | 2 | string | - | < |
| nutriments.proteins_prepared | 1 | number | - | 0.5 |
| nutriments.proteins_prepared_100g | 1 | number | - | 0.5 |
| nutriments.proteins_prepared_serving | 1 | number | - | 0.4 |
| nutriments.proteins_prepared_unit | 2 | string | - | g |
| nutriments.proteins_prepared_value | 1 | number | - | 0.5 |
| nutriments.proteins_serving | 2587 | number | - | 0<br>1 |
| nutriments.proteins_unit | 2883 | string | - | g |
| nutriments.proteins_value | 2883 | number | - | 8<br>0 |
| nutriments.proteins-dry-substance | 4 | number | - | 88.5<br>90 |
| nutriments.proteins-dry-substance_100g | 4 | number | - | 88.5<br>90 |
| nutriments.proteins-dry-substance_label | 4 | string | - | Proteins-dry-substance |
| nutriments.proteins-dry-substance_serving | 4 | number | - | 17.7<br>22.5 |
| nutriments.proteins-dry-substance_unit | 4 | string | - | g |
| nutriments.proteins-dry-substance_value | 4 | number | - | 88.5<br>90 |
| nutriments.salt | 2827 | number | - | 0.01<br>0.75 |
| nutriments.salt_100g | 2728 | number | - | 0.01<br>0.33782 |
| nutriments.salt_modifier | 3 | string | - | < |
| nutriments.salt_prepared | 1 | number | - | 0.09 |
| nutriments.salt_prepared_100g | 1 | number | - | 0.09 |
| nutriments.salt_prepared_serving | 1 | number | - | 0.072 |
| nutriments.salt_prepared_unit | 2 | string | - | g |
| nutriments.salt_prepared_value | 1 | number | - | 0.09 |
| nutriments.salt_serving | 2540 | number | - | 0.75<br>0.0045 |
| nutriments.salt_unit | 2827 | string | - | g<br>mg |
| nutriments.salt_value | 2827 | number | - | 0.01<br>750 |
| nutriments.saturated-fat | 2473 | number | - | 10<br>7.14 |
| nutriments.saturated-fat_100g | 2435 | number | - | 10<br>7.14 |
| nutriments.saturated-fat_modifier | 7 | string | - | -<br>< |
| nutriments.saturated-fat_prepared | 1 | number | - | 0.1 |
| nutriments.saturated-fat_prepared_100g | 1 | number | - | 0.1 |
| nutriments.saturated-fat_prepared_serving | 1 | number | - | 0.08 |
| nutriments.saturated-fat_prepared_unit | 2 | string | - | g |
| nutriments.saturated-fat_prepared_value | 1 | number | - | 0.1 |
| nutriments.saturated-fat_serving | 2179 | number | - | 1<br>10.7 |
| nutriments.saturated-fat_unit | 2473 | string | - | g |
| nutriments.saturated-fat_value | 2473 | number | - | 10<br>7.14 |
| nutriments.selenium | 129 | number | - | 0.000067<br>0.000006 |
| nutriments.selenium_100g | 125 | number | - | 0.000067<br>0.000006 |
| nutriments.selenium_serving | 129 | number | - | 0.000017400000000000003<br>0.000017700000000000003 |
| nutriments.selenium_unit | 129 | string | - | µg<br>g |
| nutriments.selenium_value | 129 | number | - | 67<br>6 |
| nutriments.sodium | 2827 | number | - | 0.004<br>0.3 |
| nutriments.sodium_100g | 2728 | number | - | 0.004<br>0.135128 |
| nutriments.sodium_label | 1 | string | - | Sodium |
| nutriments.sodium_modifier | 3 | string | - | < |
| nutriments.sodium_prepared | 1 | number | - | 0.036 |
| nutriments.sodium_prepared_100g | 1 | number | - | 0.036 |
| nutriments.sodium_prepared_serving | 1 | number | - | 0.0288 |
| nutriments.sodium_prepared_unit | 2 | string | - | g |
| nutriments.sodium_prepared_value | 1 | number | - | 0.036 |
| nutriments.sodium_serving | 2540 | number | - | 0.3<br>0.0018 |
| nutriments.sodium_unit | 2827 | string | - | g<br>mg |
| nutriments.sodium_value | 2827 | number | - | 0.004<br>300 |
| nutriments.soluble-fiber | 5 | number | - | 5<br>14 |
| nutriments.soluble-fiber_100g | 5 | number | - | 11.6<br>33.3 |
| nutriments.soluble-fiber_serving | 5 | number | - | 5<br>14 |
| nutriments.soluble-fiber_unit | 5 | string | - | g |
| nutriments.soluble-fiber_value | 5 | number | - | 5<br>14 |
| nutriments.starch | 140 | number | - | 0<br>0.4 |
| nutriments.starch_100g | 137 | number | - | 0<br>0.4 |
| nutriments.starch_label | 3 | string | - | 0<br>Starch |
| nutriments.starch_serving | 138 | number | - | 0<br>43.1 |
| nutriments.starch_unit | 140 | string | - | g |
| nutriments.starch_value | 140 | number | - | 0<br>0.4 |
| nutriments.sucrose | 2 | number | - | 0.08<br>0.06 |
| nutriments.sucrose_100g | 2 | number | - | 0.08<br>0.06 |
| nutriments.sucrose_serving | 2 | number | - | 0.006<br>0.06 |
| nutriments.sucrose_unit | 2 | string | - | g |
| nutriments.sucrose_value | 2 | number | - | 0.08<br>0.06 |
| nutriments.sugars | 2710 | number | - | 32<br>0 |
| nutriments.sugars_100g | 2643 | number | - | 32<br>0 |
| nutriments.sugars_modifier | 5 | string | - | -<br>< |
| nutriments.sugars_prepared | 1 | number | - | 7.1 |
| nutriments.sugars_prepared_100g | 1 | number | - | 7.1 |
| nutriments.sugars_prepared_serving | 1 | number | - | 5.68 |
| nutriments.sugars_prepared_unit | 2 | string | - | g |
| nutriments.sugars_prepared_value | 1 | number | - | 7.1 |
| nutriments.sugars_serving | 2417 | number | - | 0<br>8.77 |
| nutriments.sugars_unit | 2710 | string | - | g |
| nutriments.sugars_value | 2710 | number | - | 32<br>0 |
| nutriments.trans-fat | 1841 | number | - | 0<br>2.4 |
| nutriments.trans-fat_100g | 1820 | number | - | 0<br>19.2 |
| nutriments.trans-fat_label | 6 | string | - | Trans-fat<br>0 |
| nutriments.trans-fat_serving | 1836 | number | - | 0<br>2.4 |
| nutriments.trans-fat_unit | 1841 | string | - | g |
| nutriments.trans-fat_value | 1841 | number | - | 0<br>2.4 |
| nutriments.vitamin-a | 1844 | number | - | 1.0713e-9<br>0.0010712999999999999 |
| nutriments.vitamin-a_100g | 1829 | number | - | 7.65e-9<br>0.0010712999999999999 |
| nutriments.vitamin-a_label | 6 | string | - | 0 |
| nutriments.vitamin-a_serving | 1838 | number | - | 1.0713e-9<br>0.00015 |
| nutriments.vitamin-a_unit | 1844 | string | - | µg<br>IU |
| nutriments.vitamin-a_value | 1844 | number | - | 0.0010713<br>3571 |
| nutriments.vitamin-b1 | 209 | number | - | 0<br>0.001 |
| nutriments.vitamin-b1_100g | 205 | number | - | 0<br>0.001 |
| nutriments.vitamin-b1_label | 2 | string | - | 0 |
| nutriments.vitamin-b1_serving | 208 | number | - | 0<br>0.000454 |
| nutriments.vitamin-b1_unit | 209 | string | - | mg<br>g |
| nutriments.vitamin-b1_value | 209 | number | - | 0<br>1 |
| nutriments.vitamin-b12 | 138 | number | - | 0.00000808<br>0.00000261 |
| nutriments.vitamin-b12_100g | 134 | number | - | 0.00000808<br>0.0000113 |
| nutriments.vitamin-b12_serving | 137 | number | - | 0.0000021<br>0.00000261 |
| nutriments.vitamin-b12_unit | 138 | string | - | µg<br>g |
| nutriments.vitamin-b12_value | 138 | number | - | 8.08<br>2.61 |
| nutriments.vitamin-b2 | 225 | number | - | 0.0004<br>0.000262 |
| nutriments.vitamin-b2_100g | 221 | number | - | 0.0004<br>0.000262 |
| nutriments.vitamin-b2_label | 3 | string | - | 0 |
| nutriments.vitamin-b2_serving | 224 | number | - | 0.000136<br>0.000102 |
| nutriments.vitamin-b2_unit | 225 | string | - | mg<br>g |
| nutriments.vitamin-b2_value | 225 | number | - | 0.4<br>0.262 |
| nutriments.vitamin-b6 | 143 | number | - | 0.000235<br>0.0023079999999999997 |
| nutriments.vitamin-b6_100g | 139 | number | - | 0.000235<br>0.0023079999999999997 |
| nutriments.vitamin-b6_serving | 142 | number | - | 0.0002<br>0.0006 |
| nutriments.vitamin-b6_unit | 143 | string | - | mg<br>g |
| nutriments.vitamin-b6_value | 143 | number | - | 0.235<br>2.308 |
| nutriments.vitamin-b9 | 138 | number | - | 0.0001<br>0 |
| nutriments.vitamin-b9_100g | 134 | number | - | 0.000385<br>0 |
| nutriments.vitamin-b9_label | 4 | string | - | 0 |
| nutriments.vitamin-b9_serving | 137 | number | - | 0.0001<br>0 |
| nutriments.vitamin-b9_unit | 138 | string | - | g<br>mcg |
| nutriments.vitamin-b9_value | 138 | number | - | 0.0001<br>0 |
| nutriments.vitamin-c | 1821 | number | - | 0.0021000000000000003<br>0 |
| nutriments.vitamin-c_100g | 1808 | number | - | 0.00368<br>0 |
| nutriments.vitamin-c_label | 7 | string | - | 0 |
| nutriments.vitamin-c_serving | 1814 | number | - | 0.0021000000000000003<br>0 |
| nutriments.vitamin-c_unit | 1821 | string | - | mg<br>g |
| nutriments.vitamin-c_value | 1821 | number | - | 2.1<br>0 |
| nutriments.vitamin-d | 214 | number | - | 1.0724999999999999e-11<br>0.000010725000000000001 |
| nutriments.vitamin-d_100g | 210 | number | - | 7.66e-11<br>0.000010725000000000001 |
| nutriments.vitamin-d_label | 3 | string | - | Vitamin-d<br>Vitamin D |
| nutriments.vitamin-d_serving | 212 | number | - | 1.0724999999999999e-11<br>0.0000015 |
| nutriments.vitamin-d_unit | 214 | string | - | µg<br>IU |
| nutriments.vitamin-d_value | 214 | number | - | 0.000010725<br>429 |
| nutriments.vitamin-e | 120 | number | - | 0.0135<br>0 |
| nutriments.vitamin-e_100g | 116 | number | - | 0.0519<br>0 |
| nutriments.vitamin-e_serving | 120 | number | - | 0.0135<br>0 |
| nutriments.vitamin-e_unit | 120 | string | - | g<br>mg |
| nutriments.vitamin-e_value | 120 | number | - | 0.0135<br>0 |
| nutriments.vitamin-k | 129 | number | - | 0.0000565<br>0.0000769 |
| nutriments.vitamin-k_100g | 125 | number | - | 0.0000565<br>0.0000769 |
| nutriments.vitamin-k_serving | 129 | number | - | 0.000048<br>0.00002 |
| nutriments.vitamin-k_unit | 129 | string | - | µg<br>g |
| nutriments.vitamin-k_value | 129 | number | - | 56.5<br>76.9 |
| nutriments.vitamin-pp | 114 | number | - | 0.003529<br>0.004103 |
| nutriments.vitamin-pp_100g | 112 | number | - | 0.003529<br>0.004103 |
| nutriments.vitamin-pp_label | 2 | string | - | 0 |
| nutriments.vitamin-pp_serving | 113 | number | - | 0.0012<br>0.0016 |
| nutriments.vitamin-pp_unit | 114 | string | - | mg<br>% DV |
| nutriments.vitamin-pp_value | 114 | number | - | 3.529<br>4.103 |
| nutriments.zinc | 142 | number | - | 0.01731<br>0.00076 |
| nutriments.zinc_100g | 137 | number | - | 0.01731<br>0.00076 |
| nutriments.zinc_label | 1 | string | - | 0 |
| nutriments.zinc_serving | 142 | number | - | 0.0045000000000000005<br>0.0022400000000000002 |
| nutriments.zinc_unit | 142 | string | - | mg<br>g |
| nutriments.zinc_value | 142 | number | - | 17.31<br>0.76 |
| nutriscore_2021_tags[] | 3000 | string | - | e<br>unknown |
| nutriscore_2023_tags[] | 3000 | string | - | e<br>unknown |
| nutriscore_data.components | 2358 | object | - | {"positive":[{"id":"fiber","points":0,"points_max":5,"unit":"g","value":null},{"id":"fruits_vegetables_legumes","points"...<br>{"negative":[{"value":0,"id":"energy","points":0,"points_max":10,"unit":"kJ"},{"points":0,"points_max":10,"unit":"g","id... |
| nutriscore_data.components.negative | 2358 | array | object | [{"value":2582,"id":"energy","points":7,"points_max":10,"unit":"kJ"},{"value":32,"points":9,"id":"sugars","points_max":1...<br>[{"value":0,"id":"energy","points":0,"points_max":10,"unit":"kJ"},{"points":0,"points_max":10,"unit":"g","id":"sugars","... |
| nutriscore_data.components.negative[] | 9555 | object | - | {"value":2582,"id":"energy","points":7,"points_max":10,"unit":"kJ"}<br>{"value":32,"points":9,"id":"sugars","points_max":15,"unit":"g"} |
| nutriscore_data.components.negative[].id | 9555 | string | - | energy<br>sugars |
| nutriscore_data.components.negative[].points | 9555 | number | - | 7<br>9 |
| nutriscore_data.components.negative[].points_max | 9555 | number | - | 10<br>15 |
| nutriscore_data.components.negative[].unit | 9555 | string | - | kJ<br>g |
| nutriscore_data.components.negative[].value | 9555 | null, number | - | 2582<br>32 |
| nutriscore_data.components.positive | 2358 | array | object | [{"id":"fiber","points":0,"points_max":5,"unit":"g","value":null},{"id":"fruits_vegetables_legumes","points":0,"points_m...<br>[{"value":0,"id":"proteins","points_max":7,"points":0,"unit":"g"},{"value":null,"points_max":5,"points":0,"unit":"g","id... |
| nutriscore_data.components.positive[] | 5484 | object | - | {"id":"fiber","points":0,"points_max":5,"unit":"g","value":null}<br>{"id":"fruits_vegetables_legumes","points":0,"points_max":5,"unit":"%","value":null} |
| nutriscore_data.components.positive[].id | 5484 | string | - | fiber<br>fruits_vegetables_legumes |
| nutriscore_data.components.positive[].points | 5484 | number | - | 0<br>1 |
| nutriscore_data.components.positive[].points_max | 5484 | number | - | 5<br>7 |
| nutriscore_data.components.positive[].unit | 5484 | string | - | g<br>% |
| nutriscore_data.components.positive[].value | 5484 | null, number | - | null<br>0 |
| nutriscore_data.count_proteins | 2358 | number | - | 0<br>1 |
| nutriscore_data.count_proteins_reason | 2358 | string | - | negative_points_greater_than_or_equal_to_11<br>beverage |
| nutriscore_data.grade | 2358 | string | - | e<br>b |
| nutriscore_data.is_beverage | 2358 | number | - | 0<br>1 |
| nutriscore_data.is_cheese | 2358 | number, string | - | 0<br>1 |
| nutriscore_data.is_fat_oil_nuts_seeds | 2358 | number | - | 0<br>1 |
| nutriscore_data.is_red_meat_product | 2358 | number | - | 0<br>1 |
| nutriscore_data.is_water | 2358 | number | - | 0 |
| nutriscore_data.negative_points | 2358 | number | - | 25<br>0 |
| nutriscore_data.negative_points_max | 2358 | number | - | 55<br>54 |
| nutriscore_data.nutriscore_not_applicable_for_category | 32 | string | - | en:dietary-supplements<br>en:chewing-gum |
| nutriscore_data.positive_nutrients | 2358 | array | string | ["fiber","fruits_vegetables_legumes"]<br>["proteins","fiber","fruits_vegetables_legumes"] |
| nutriscore_data.positive_nutrients[] | 5484 | string | - | fiber<br>fruits_vegetables_legumes |
| nutriscore_data.positive_points | 2358 | number | - | 0<br>1 |
| nutriscore_data.positive_points_max | 2358 | number | - | 10<br>18 |
| nutriscore_data.proteins_points_limited_reason | 41 | string | - | red_meat_product |
| nutriscore_data.score | 2358 | number | - | 25<br>0 |
| nutriscore_tags[] | 3000 | string | - | e<br>unknown |
| nutriscore.2021 | 3000 | object | - | {"nutriscore_computed":1,"category_available":1,"grade":"e","data":{"sugars_value":32,"energy_value":2582,"fiber_value":...<br>{"category_available":1,"grade":"unknown","data":{"fiber":0,"proteins":null,"energy":null,"is_water":0,"fruits_vegetable... |
| nutriscore.2021.category_available | 3000 | number | - | 1<br>0 |
| nutriscore.2021.data | 3000 | object | - | {"sugars_value":32,"energy_value":2582,"fiber_value":0,"proteins_points":4,"saturated_fat_value":10,"sugars_points":7,"e...<br>{"fiber":0,"proteins":null,"energy":null,"is_water":0,"fruits_vegetables_nuts_colza_walnut_olive_oils":100,"saturated_fa... |
| nutriscore.2021.data.energy | 3000 | null, number | - | 2582<br>null |
| nutriscore.2021.data.energy_points | 2358 | number | - | 7<br>0 |
| nutriscore.2021.data.energy_value | 2358 | number | - | 2582<br>0 |
| nutriscore.2021.data.fat | 17 | number | - | 100<br>57.14 |
| nutriscore.2021.data.fiber | 3000 | number | - | 0<br>3.16 |
| nutriscore.2021.data.fiber_points | 2358 | number | - | 0<br>3 |
| nutriscore.2021.data.fiber_value | 2358 | number | - | 0<br>3.16 |
| nutriscore.2021.data.fruits_vegetables_nuts_colza_walnut_olive_oils | 3000 | number, string | - | 40<br>100 |
| nutriscore.2021.data.fruits_vegetables_nuts_colza_walnut_olive_oils_points | 2358 | number | - | 0<br>1 |
| nutriscore.2021.data.fruits_vegetables_nuts_colza_walnut_olive_oils_value | 2358 | number | - | 40<br>0 |
| nutriscore.2021.data.is_beverage | 3000 | number | - | 0<br>1 |
| nutriscore.2021.data.is_cheese | 3000 | number, string | - | 0<br>1 |
| nutriscore.2021.data.is_fat | 3000 | number | - | 0<br>1 |
| nutriscore.2021.data.is_water | 3000 | number | - | 0 |
| nutriscore.2021.data.negative_points | 2358 | number | - | 23<br>0 |
| nutriscore.2021.data.positive_points | 2358 | number | - | 0<br>1 |
| nutriscore.2021.data.proteins | 3000 | null, number | - | 8<br>null |
| nutriscore.2021.data.proteins_points | 2358 | number | - | 4<br>0 |
| nutriscore.2021.data.proteins_value | 2358 | number | - | 8<br>0 |
| nutriscore.2021.data.saturated_fat | 3000 | null, number | - | 10<br>null |
| nutriscore.2021.data.saturated_fat_points | 2343 | number | - | 9<br>0 |
| nutriscore.2021.data.saturated_fat_ratio | 318 | number | - | 0<br>7.139999999999999 |
| nutriscore.2021.data.saturated_fat_ratio_points | 15 | number | - | 0<br>2 |
| nutriscore.2021.data.saturated_fat_ratio_value | 15 | number | - | 7.1<br>18.7 |
| nutriscore.2021.data.saturated_fat_value | 2343 | number | - | 10<br>0 |
| nutriscore.2021.data.sodium | 3000 | null, number | - | 4<br>null |
| nutriscore.2021.data.sodium_points | 2358 | number | - | 0<br>10 |
| nutriscore.2021.data.sodium_value | 2358 | number | - | 4<br>0 |
| nutriscore.2021.data.sugars | 3000 | null, number | - | 32<br>null |
| nutriscore.2021.data.sugars_points | 2358 | number | - | 7<br>0 |
| nutriscore.2021.data.sugars_value | 2358 | number | - | 32<br>0 |
| nutriscore.2021.grade | 3000 | string | - | e<br>unknown |
| nutriscore.2021.not_applicable_category | 32 | string | - | en:dietary-supplements<br>en:chewing-gum |
| nutriscore.2021.nutrients_available | 3000 | number | - | 1<br>0 |
| nutriscore.2021.nutriscore_applicable | 3000 | number | - | 1<br>0 |
| nutriscore.2021.nutriscore_computed | 3000 | number | - | 1<br>0 |
| nutriscore.2021.score | 2358 | number | - | 23<br>0 |
| nutriscore.2023 | 3000 | object | - | {"grade":"e","category_available":1,"nutriscore_computed":1,"nutrients_available":1,"score":25,"nutriscore_applicable":1...<br>{"category_available":1,"grade":"unknown","nutriscore_applicable":1,"nutrients_available":0,"data":{"fiber":null,"is_red... |
| nutriscore.2023.category_available | 3000 | number | - | 1<br>0 |
| nutriscore.2023.data | 3000 | object | - | {"is_red_meat_product":0,"components":{"positive":[{"id":"fiber","points":0,"unit":"g","points_max":5,"value":null},{"va...<br>{"fiber":null,"is_red_meat_product":0,"proteins":null,"fruits_vegetables_legumes":100,"salt":null,"is_fat_oil_nuts_seeds... |
| nutriscore.2023.data.components | 2358 | object | - | {"positive":[{"id":"fiber","points":0,"unit":"g","points_max":5,"value":null},{"value":null,"points_max":5,"unit":"%","p...<br>{"positive":[{"value":0,"id":"proteins","unit":"g","points_max":7,"points":0},{"value":null,"unit":"g","points":0,"point... |
| nutriscore.2023.data.components.negative | 2358 | array | object | [{"value":2582,"points_max":10,"unit":"kJ","points":7,"id":"energy"},{"unit":"g","points_max":15,"value":32,"id":"sugars...<br>[{"id":"energy","points_max":10,"points":0,"unit":"kJ","value":0},{"value":0,"id":"sugars","unit":"g","points":0,"points... |
| nutriscore.2023.data.components.negative[] | 9555 | object | - | {"value":2582,"points_max":10,"unit":"kJ","points":7,"id":"energy"}<br>{"unit":"g","points_max":15,"value":32,"id":"sugars","points":9} |
| nutriscore.2023.data.components.positive | 2358 | array | object | [{"id":"fiber","points":0,"unit":"g","points_max":5,"value":null},{"value":null,"points_max":5,"unit":"%","points":0,"id...<br>[{"value":0,"id":"proteins","unit":"g","points_max":7,"points":0},{"value":null,"unit":"g","points":0,"points_max":5,"id... |
| nutriscore.2023.data.components.positive[] | 5484 | object | - | {"id":"fiber","points":0,"unit":"g","points_max":5,"value":null}<br>{"value":null,"points_max":5,"unit":"%","points":0,"id":"fruits_vegetables_legumes"} |
| nutriscore.2023.data.count_proteins | 2358 | number | - | 0<br>1 |
| nutriscore.2023.data.count_proteins_reason | 2358 | string | - | negative_points_greater_than_or_equal_to_11<br>beverage |
| nutriscore.2023.data.energy | 642 | null, number | - | null<br>0 |
| nutriscore.2023.data.energy_from_saturated_fat | 4 | number | - | 492.1<br>288.96999999999997 |
| nutriscore.2023.data.fat | 5 | null, number | - | 93.3<br>50 |
| nutriscore.2023.data.fiber | 642 | null, number | - | null<br>0 |
| nutriscore.2023.data.fruits_vegetables_legumes | 642 | null, number | - | 100<br>0 |
| nutriscore.2023.data.is_beverage | 3000 | number | - | 0<br>1 |
| nutriscore.2023.data.is_cheese | 3000 | number, string | - | 0<br>1 |
| nutriscore.2023.data.is_fat_oil_nuts_seeds | 3000 | number | - | 0<br>1 |
| nutriscore.2023.data.is_red_meat_product | 3000 | number | - | 0<br>1 |
| nutriscore.2023.data.is_water | 3000 | number | - | 0 |
| nutriscore.2023.data.negative_points | 2358 | number | - | 25<br>0 |
| nutriscore.2023.data.negative_points_max | 2358 | number | - | 55<br>54 |
| nutriscore.2023.data.non_nutritive_sweeteners | 22 | null, number | - | 0<br>null |
| nutriscore.2023.data.positive_nutrients | 2358 | array | string | ["fiber","fruits_vegetables_legumes"]<br>["proteins","fiber","fruits_vegetables_legumes"] |
| nutriscore.2023.data.positive_nutrients[] | 5484 | string | - | fiber<br>fruits_vegetables_legumes |
| nutriscore.2023.data.positive_points | 2358 | number | - | 0<br>1 |
| nutriscore.2023.data.positive_points_max | 2358 | number | - | 10<br>18 |
| nutriscore.2023.data.proteins | 642 | null, number | - | null<br>0 |
| nutriscore.2023.data.proteins_points_limited_reason | 41 | string | - | red_meat_product |
| nutriscore.2023.data.salt | 642 | null, number | - | null<br>0.01 |
| nutriscore.2023.data.saturated_fat | 642 | null, number | - | null<br>0 |
| nutriscore.2023.data.saturated_fat_ratio | 82 | number | - | 0<br>14.3 |
| nutriscore.2023.data.sugars | 642 | null, number | - | null<br>53.6 |
| nutriscore.2023.data.with_non_nutritive_sweeteners | 3 | number | - | 1 |
| nutriscore.2023.grade | 3000 | string | - | e<br>unknown |
| nutriscore.2023.not_applicable_category | 32 | string | - | en:dietary-supplements<br>en:chewing-gum |
| nutriscore.2023.nutrients_available | 3000 | number | - | 1<br>0 |
| nutriscore.2023.nutriscore_applicable | 3000 | number | - | 1<br>0 |
| nutriscore.2023.nutriscore_computed | 3000 | number | - | 1<br>0 |
| nutriscore.2023.score | 2358 | number | - | 25<br>0 |
| nutrition_grades_tags[] | 3000 | string | - | e<br>unknown |
| origins_hierarchy[] | 63 | string | - | en:germany<br>en:canada |
| origins_tags[] | 63 | string | - | en:germany<br>en:canada |
| packaging_hierarchy[] | 380 | string | - | en:bucket<br>en:can |
| packaging_materials_tags[] | 246 | string | - | en:glass<br>en:metal |
| packaging_recycling_tags[] | 8 | string | - | en:recycle-in-sorting-bin<br>en:recycle |
| packaging_shapes_tags[] | 208 | string | - | en:jar<br>en:lid |
| packaging_tags[] | 384 | string | - | en:bucket<br>en:can |
| packagings_materials.all | 208 | object | - | {}<br>{"weight_percent":100} |
| packagings_materials.all.weight_percent | 2 | number | - | 100 |
| packagings_materials.en:glass | 24 | object | - | {} |
| packagings_materials.en:metal | 29 | object | - | {} |
| packagings_materials.en:paper-or-cardboard | 51 | object | - | {} |
| packagings_materials.en:plastic | 129 | object | - | {}<br>{"weight_percent":100} |
| packagings_materials.en:plastic.weight_percent | 1 | number | - | 100 |
| packagings_materials.en:unknown | 34 | object | - | {}<br>{"weight_percent":100} |
| packagings_materials.en:unknown.weight_percent | 1 | number | - | 100 |
| packagings[] | 287 | object | - | {"recycling":"en:recycle-in-sorting-bin","shape":"en:jar","number_of_units":1,"food_contact":1,"quantity_per_unit":"350"...<br>{"recycling":"en:recycle-in-sorting-bin","shape":"en:lid","material":"en:metal","number_of_units":1,"food_contact":1} |
| packagings[].food_contact | 165 | number | - | 1<br>0 |
| packagings[].material | 254 | string | - | en:glass<br>en:metal |
| packagings[].number_of_units | 34 | number, string | - | 1<br>2 |
| packagings[].quantity_per_unit | 5 | string | - | 350<br>1 oz |
| packagings[].quantity_per_unit_unit | 1 | string | - | g |
| packagings[].quantity_per_unit_value | 1 | string | - | 0 |
| packagings[].recycling | 9 | string | - | en:recycle-in-sorting-bin<br>en:recycle |
| packagings[].shape | 209 | string | - | en:jar<br>en:lid |
| photographers_tags[] | 1658 | string | - | kiliweb<br>openfoodfacts-contributors |
| photographers[] | 1 | string | - | javichu |
| pnns_groups_1_tags[] | 6000 | string | - | sugary-snacks<br>known |
| pnns_groups_2_tags[] | 6000 | string | - | sweets<br>known |
| popularity_tags[] | 11417 | string | - | top-75-percent-scans-2024<br>top-80-percent-scans-2024 |
| purchase_places_tags[] | 215 | string | - | germany<br>france |
| sources_fields.org-database-usda | 2128 | object | - | {"fdc_id":"366948","available_date":"2018-07-05T00:00:00Z","publication_date":"2019-04-01T00:00:00Z","fdc_category":"Tea...<br>{"publication_date":"2019-04-01T00:00:00Z","fdc_category":"Tea Bags","fdc_id":"366952","available_date":"2018-07-05T00:0... |
| sources_fields.org-database-usda.available_date | 2128 | string | - | 2018-07-05T00:00:00Z<br>2018-08-09T00:00:00Z |
| sources_fields.org-database-usda.fdc_category | 2128 | string | - | Tea Bags<br>Vegetable & Cooking Oils |
| sources_fields.org-database-usda.fdc_data_source | 2128 | string | - | LI |
| sources_fields.org-database-usda.fdc_id | 2128 | string | - | 366948<br>366952 |
| sources_fields.org-database-usda.modified_date | 2128 | string | - | 2018-07-05T00:00:00Z<br>2018-08-09T00:00:00Z |
| sources_fields.org-database-usda.publication_date | 2128 | string | - | 2019-04-01T00:00:00Z<br>2020-04-01T00:00:00Z |
| sources[] | 4616 | object | - | {"url":"https://api.nal.usda.gov/ndb/reports/?ndbno=45022269&type=f&format=json&api_key=DEMO_KEY","fields":["product_nam...<br>{"manufacturer":null,"name":"database-usda","url":null,"images":[],"import_t":1587573118,"id":"database-usda","fields":[... |
| sources[].fields | 4616 | array | string | ["product_name_en","brands","countries","serving_size","ingredients_text_en","nutrients.energy","nutrients.proteins","nu...<br>["product_name_en","categories","brand_owner","data_sources","serving_size","nutrients.salt_unit","nutrients.salt_value"... |
| sources[].fields[] | 60391 | string | - | product_name_en<br>brands |
| sources[].id | 4616 | string | - | usda-ndb<br>database-usda |
| sources[].images | 4616 | array | - | [] |
| sources[].import_t | 4616 | number | - | 1489055330<br>1587573118 |
| sources[].manufacturer | 2179 | null, number, string | - | null<br>0 |
| sources[].name | 2179 | string | - | database-usda<br>label-non-gmo-project |
| sources[].source_licence | 1 | string | - | Creative Commons Attribution 4.0 International License |
| sources[].source_licence_url | 1 | string | - | https://creativecommons.org/licenses/by/4.0/ |
| sources[].url | 4616 | null, string | - | https://api.nal.usda.gov/ndb/reports/?ndbno=45022269&type=f&format=json&api_key=DEMO_KEY<br>null |
| specific_ingredients[] | 4 | object | - | {"origins":"en:france","label":"en:french-meat","ingredient":"en:meat","id":"en:meat"}<br>{"id":"en:pork","label":"en:french-pork","origins":"en:france","ingredient":"en:pork"} |
| specific_ingredients[].id | 4 | string | - | en:meat<br>en:pork |
| specific_ingredients[].ingredient | 4 | string | - | en:meat<br>en:pork |
| specific_ingredients[].label | 4 | string | - | en:french-meat<br>en:french-pork |
| specific_ingredients[].origins | 4 | string | - | en:france |
| states_hierarchy[] | 44715 | string | - | en:to-be-completed<br>en:nutrition-facts-completed |
| states_tags[] | 44715 | string | - | en:to-be-completed<br>en:nutrition-facts-completed |
| stores_tags[] | 1120 | string | - | allfitnessfactory-de<br>intermarche |
| taxonomies_enhancer_tags[] | 4 | string | - | ingredients-nl-sinaasappelaroma-is-possible-typo-for-nl-sinaasappelsmaak<br>ingredients-taxonomy-between-acide-ascorbique-id-en-vitamin-c-and-ascorbic-acid-id-en-e300-should-be-same-id |
| teams_tags[] | 506 | string | - | chocolatine<br>la-robe-est-bleue |
| traces_hierarchy[] | 178 | string | - | en:gluten<br>en:milk |
| traces_tags[] | 178 | string | - | en:gluten<br>en:milk |
| unknown_nutrients_tags[] | 6 | string | - | proteins-dry-substance<br>protein-dry-substance |
| vitamins_prev_tags[] | 1017 | string | - | en:vitamin-e<br>en:cholecalciferol |
| vitamins_tags[] | 2139 | string | - | en:vitamin-e<br>en:dl-alpha-tocopheryl-acetate |

## Large fields likely expensive to store

| Path | Max bytes | Avg bytes |
|---|---:|---:|
| ingredients | 21046 | 3195.2 |
| ecoscore_extended_data | 20888 | 1830.2 |
| ecoscore_extended_data.impact | 20877 | 2073.5 |
| ingredients[] | 12545 | 295.2 |
| ingredients[].ingredients | 12366 | 670.0 |
| ecoscore_extended_data.impact.recipes | 11678 | 8193.3 |
| ingredients_analysis | 6375 | 254.0 |
| ingredients[].ingredients[] | 5990 | 209.1 |
| ingredients[].ingredients[].ingredients | 5723 | 309.8 |
| environmental_score_data | 5166 | 2399.4 |
| popularity_tags | 5083 | 383.5 |
| nutriments | 4886 | 1814.2 |
| ecoscore_data | 4665 | 2511.3 |
| images | 4463 | 967.3 |
| images.uploaded | 3404 | 643.3 |
| environmental_score_data.adjustments | 3310 | 1893.4 |
| environmental_score_data.adjustments.origins_of_ingredients | 2720 | 1684.1 |
| ecoscore_data.adjustments | 2396 | 1888.9 |
| ingredients_text_with_allergens | 2392 | 305.1 |
| ingredients_text_with_allergens_fr | 2392 | 253.8 |

## Candidate category-related fields

- added_countries_tags
- additives_debug_tags
- additives_debug_tags[]
- additives_old_tags
- additives_old_tags[]
- additives_original_tags
- additives_original_tags[]
- additives_prev_original_tags
- additives_prev_original_tags[]
- additives_tags
- additives_tags_n
- additives_tags[]
- allergens_debug_tags
- allergens_hierarchy
- allergens_hierarchy[]
- allergens_tags
- allergens_tags[]
- amino_acids_prev_tags
- amino_acids_tags
- amino_acids_tags[]
- brands_debug_tags
- brands_hierarchy
- brands_hierarchy[]
- brands_tags
- brands_tags[]
- categories
- categories_debug_tags
- categories_hierarchy
- categories_hierarchy[]
- categories_imported
- categories_lc
- categories_next_hierarchy
- categories_next_tags
- categories_old
- categories_prev_hierarchy
- categories_prev_tags
- categories_properties
- categories_properties_tags
- categories_properties_tags[]
- categories_properties.agribalyse_food_code:en
- categories_properties.agribalyse_proxy_food_code:en
- categories_properties.ciqual_food_code:en
- categories_tags
- categories_tags[]
- category_properties
- category_properties.ciqual_food_name:en
- category_properties.ciqual_food_name:fr
- checkers_tags
- checkers_tags[]
- ciqual_food_name_tags
- ciqual_food_name_tags[]
- cities_tags
- cities_tags[]
- codes_tags
- codes_tags[]
- compared_to_category
- correctors_tags
- correctors_tags[]
- countries_debug_tags
- countries_hierarchy
- countries_hierarchy[]
- countries_tags
- countries_tags[]
- data_quality_bugs_tags
- data_quality_completeness_tags
- data_quality_completeness_tags[]
- data_quality_errors_tags
- data_quality_errors_tags[]
- data_quality_info_tags
- data_quality_info_tags[]
- data_quality_tags
- data_quality_tags[]
- data_quality_warning_tags
- data_quality_warning_tags[]
- data_quality_warnings_tags
- data_quality_warnings_tags[]
- data_sources_tags
- data_sources_tags[]
- ecoscore_data.adjustments.origins_of_ingredients.origins_from_categories
- ecoscore_data.adjustments.origins_of_ingredients.origins_from_categories[]
- ecoscore_data.ecoscore_not_applicable_for_category
- ecoscore_data.missing.agb_category
- ecoscore_data.missing.categories
- ecoscore_tags
- ecoscore_tags[]
- editors_tags
- editors_tags[]
- emb_codes_debug_tags
- emb_codes_tags
- emb_codes_tags[]
- entry_dates_tags
- entry_dates_tags[]
- environment_impact_level_tags
- environmental_score_data.adjustments.origins_of_ingredients.origins_from_categories
- environmental_score_data.adjustments.origins_of_ingredients.origins_from_categories[]
- environmental_score_data.environmental_score_not_applicable_for_category
- environmental_score_data.missing.agb_category
- environmental_score_data.missing.categories
- environmental_score_tags
- environmental_score_tags[]
- expiration_date_debug_tags
- food_groups_tags
- food_groups_tags[]
- forest_footprint_data.ingredients[].conditions_tags
- forest_footprint_data.ingredients[].conditions_tags[]
- forest_footprint_data.ingredients[].conditions_tags[][]
- generic_name_de_debug_tags
- generic_name_en_debug_tags
- generic_name_es_debug_tags
- generic_name_fr_debug_tags
- generic_name_it_debug_tags
- generic_name_nl_debug_tags
- informers_tags
- informers_tags[]
- ingredients_analysis_tags
- ingredients_analysis_tags[]
- ingredients_from_palm_oil_tags
- ingredients_from_palm_oil_tags[]
- ingredients_hierarchy
- ingredients_hierarchy[]
- ingredients_n_tags
- ingredients_n_tags[]
- ingredients_original_tags
- ingredients_original_tags[]
- ingredients_tags
- ingredients_tags[]
- ingredients_text_de_debug_tags
- ingredients_text_debug_tags
- ingredients_text_en_debug_tags
- ingredients_text_es_debug_tags
- ingredients_text_fr_debug_tags
- ingredients_text_it_debug_tags
- ingredients_text_nl_debug_tags
- ingredients_that_may_be_from_palm_oil_tags
- ingredients_that_may_be_from_palm_oil_tags[]
- labels_debug_tags
- labels_hierarchy
- labels_hierarchy[]
- labels_next_hierarchy
- labels_next_tags
- labels_prev_hierarchy
- labels_prev_hierarchy[]
- labels_prev_tags
- labels_prev_tags[]
- labels_tags
- labels_tags[]
- lang_debug_tags
- languages_hierarchy
- languages_hierarchy[]
- languages_tags
- languages_tags[]
- last_check_dates_tags
- last_check_dates_tags[]
- last_edit_dates_tags
- last_edit_dates_tags[]
- last_image_dates_tags
- last_image_dates_tags[]
- link_debug_tags
- main_countries_tags
- manufacturing_places_debug_tags
- manufacturing_places_tags
- manufacturing_places_tags[]
- minerals_prev_tags
- minerals_prev_tags[]
- minerals_tags
- minerals_tags[]
- misc_tags
- misc_tags[]
- nova_groups_tags
- nova_groups_tags[]
- nucleotides_prev_tags
- nucleotides_tags
- nutrient_levels_tags
- nutrient_levels_tags[]
- nutriscore_2021_tags
- nutriscore_2021_tags[]
- nutriscore_2023_tags
- nutriscore_2023_tags[]
- nutriscore_data.nutriscore_not_applicable_for_category
- nutriscore_tags
- nutriscore_tags[]
- nutriscore.2021.category_available
- nutriscore.2021.not_applicable_category
- nutriscore.2023.category_available
- nutriscore.2023.not_applicable_category
- nutrition_data_per_debug_tags
- nutrition_data_prepared_per_debug_tags
- nutrition_grades_tags
- nutrition_grades_tags[]
- nutrition_score_warning_fruits_vegetables_legumes_from_category
- nutrition_score_warning_fruits_vegetables_legumes_from_category_value
- nutrition_score_warning_fruits_vegetables_nuts_from_category
- nutrition_score_warning_fruits_vegetables_nuts_from_category_value
- origins_debug_tags
- origins_hierarchy
- origins_hierarchy[]
- origins_tags
- origins_tags[]
- other_nutritional_substances_prev_tags
- other_nutritional_substances_tags
- packaging_debug_tags
- packaging_hierarchy
- packaging_hierarchy[]
- packaging_materials_tags
- packaging_materials_tags[]
- packaging_recycling_tags
- packaging_recycling_tags[]
- packaging_shapes_tags
- packaging_shapes_tags[]
- packaging_tags
- packaging_tags[]
- photographers_tags
- photographers_tags[]
- pnns_groups_1_tags
- pnns_groups_1_tags[]
- pnns_groups_2_tags
- pnns_groups_2_tags[]
- popularity_tags
- popularity_tags[]
- product_name_de_debug_tags
- product_name_debug_tags
- product_name_en_debug_tags
- product_name_es_debug_tags
- product_name_fr_debug_tags
- product_name_it_debug_tags
- product_name_nl_debug_tags
- purchase_places_debug_tags
- purchase_places_tags
- purchase_places_tags[]
- quantity_debug_tags
- removed_countries_tags
- serving_size_debug_tags
- sources_fields.org-database-usda.fdc_category
- states_hierarchy
- states_hierarchy[]
- states_tags
- states_tags[]
- stores_debug_tags
- stores_tags
- stores_tags[]
- taxonomies_enhancer_tags
- taxonomies_enhancer_tags[]
- teams_tags
- teams_tags[]
- traces_debug_tags
- traces_hierarchy
- traces_hierarchy[]
- traces_tags
- traces_tags[]
- unknown_nutrients_tags
- unknown_nutrients_tags[]
- vitamins_prev_tags
- vitamins_prev_tags[]
- vitamins_tags
- vitamins_tags[]
- weighers_tags
- weighters_tags

## Candidate nutrition fields

- data_quality_dimensions.completeness.nutrition
- ecoscore_extended_data.impact.data_sources.en:celery_seed.nutrition
- ecoscore_extended_data.impact.data_sources.en:celery_seed.nutrition[]
- ecoscore_extended_data.impact.data_sources.en:cream.nutrition
- ecoscore_extended_data.impact.data_sources.en:cream.nutrition[]
- ecoscore_extended_data.impact.data_sources.en:cucumber.nutrition
- ecoscore_extended_data.impact.data_sources.en:cucumber.nutrition[]
- ecoscore_extended_data.impact.data_sources.en:e202.nutrition
- ecoscore_extended_data.impact.data_sources.en:e202.nutrition[]
- ecoscore_extended_data.impact.data_sources.en:e211.nutrition
- ecoscore_extended_data.impact.data_sources.en:e211.nutrition[]
- ecoscore_extended_data.impact.data_sources.en:e270.nutrition
- ecoscore_extended_data.impact.data_sources.en:e270.nutrition[]
- ecoscore_extended_data.impact.data_sources.en:e330.nutrition
- ecoscore_extended_data.impact.data_sources.en:e330.nutrition[]
- ecoscore_extended_data.impact.data_sources.en:e415.nutrition
- ecoscore_extended_data.impact.data_sources.en:e415.nutrition[]
- ecoscore_extended_data.impact.data_sources.en:e433.nutrition
- ecoscore_extended_data.impact.data_sources.en:e433.nutrition[]
- ecoscore_extended_data.impact.data_sources.en:e440a.nutrition
- ecoscore_extended_data.impact.data_sources.en:e440a.nutrition[]
- ecoscore_extended_data.impact.data_sources.en:e509.nutrition
- ecoscore_extended_data.impact.data_sources.en:e509.nutrition[]
- ecoscore_extended_data.impact.data_sources.en:e572.nutrition
- ecoscore_extended_data.impact.data_sources.en:e572.nutrition[]
- ecoscore_extended_data.impact.data_sources.en:e621.nutrition
- ecoscore_extended_data.impact.data_sources.en:e621.nutrition[]
- ecoscore_extended_data.impact.data_sources.en:e955.nutrition
- ecoscore_extended_data.impact.data_sources.en:e955.nutrition[]
- ecoscore_extended_data.impact.data_sources.en:garlic.nutrition
- ecoscore_extended_data.impact.data_sources.en:garlic.nutrition[]
- ecoscore_extended_data.impact.data_sources.en:gelling_agent.nutrition
- ecoscore_extended_data.impact.data_sources.en:gelling_agent.nutrition[]
- ecoscore_extended_data.impact.data_sources.en:maltodextrins.nutrition
- ecoscore_extended_data.impact.data_sources.en:maltodextrins.nutrition[]
- ecoscore_extended_data.impact.data_sources.en:modified_corn_starch.nutrition
- ecoscore_extended_data.impact.data_sources.en:modified_corn_starch.nutrition[]
- ecoscore_extended_data.impact.data_sources.en:mustard_seed.nutrition
- ecoscore_extended_data.impact.data_sources.en:mustard_seed.nutrition[]
- ecoscore_extended_data.impact.data_sources.en:onion.nutrition
- ecoscore_extended_data.impact.data_sources.en:onion.nutrition[]
- ecoscore_extended_data.impact.data_sources.en:parsley.nutrition
- ecoscore_extended_data.impact.data_sources.en:parsley.nutrition[]
- ecoscore_extended_data.impact.data_sources.en:pasteurized_skimmed_milk.nutrition
- ecoscore_extended_data.impact.data_sources.en:pasteurized_skimmed_milk.nutrition[]
- ecoscore_extended_data.impact.data_sources.en:raspberry.nutrition
- ecoscore_extended_data.impact.data_sources.en:raspberry.nutrition[]
- ecoscore_extended_data.impact.data_sources.en:roasted_peanuts.nutrition
- ecoscore_extended_data.impact.data_sources.en:roasted_peanuts.nutrition[]
- ecoscore_extended_data.impact.data_sources.en:salt.nutrition
- ecoscore_extended_data.impact.data_sources.en:salt.nutrition[]
- ecoscore_extended_data.impact.data_sources.en:sodium_citrate.nutrition
- ecoscore_extended_data.impact.data_sources.en:sodium_citrate.nutrition[]
- ecoscore_extended_data.impact.data_sources.en:spice.nutrition
- ecoscore_extended_data.impact.data_sources.en:spice.nutrition[]
- ecoscore_extended_data.impact.data_sources.en:sugar.nutrition
- ecoscore_extended_data.impact.data_sources.en:sugar.nutrition[]
- ecoscore_extended_data.impact.data_sources.en:vinegar.nutrition
- ecoscore_extended_data.impact.data_sources.en:vinegar.nutrition[]
- ecoscore_extended_data.impact.data_sources.en:water.nutrition
- ecoscore_extended_data.impact.data_sources.en:water.nutrition[]
- ecoscore_extended_data.impact.data_sources.en:whey.nutrition
- ecoscore_extended_data.impact.data_sources.en:whey.nutrition[]
- ecoscore_extended_data.impact.uncharacterized_ingredients_mass_proportion.nutrition
- ecoscore_extended_data.impact.uncharacterized_ingredients_ratio.nutrition
- ecoscore_extended_data.impact.uncharacterized_ingredients.nutrition
- ecoscore_extended_data.impact.uncharacterized_ingredients.nutrition[]
- images.nutrition
- images.nutrition_de
- images.nutrition_de.angle
- images.nutrition_de.coordinates_image_size
- images.nutrition_de.geometry
- images.nutrition_de.imgid
- images.nutrition_de.normalize
- images.nutrition_de.ocr
- images.nutrition_de.orientation
- images.nutrition_de.rev
- images.nutrition_de.sizes
- images.nutrition_de.sizes.100
- images.nutrition_de.sizes.100.h
- images.nutrition_de.sizes.100.w
- images.nutrition_de.sizes.200
- images.nutrition_de.sizes.200.h
- images.nutrition_de.sizes.200.w
- images.nutrition_de.sizes.400
- images.nutrition_de.sizes.400.h
- images.nutrition_de.sizes.400.w
- images.nutrition_de.sizes.full
- images.nutrition_de.sizes.full.h
- images.nutrition_de.sizes.full.w
- images.nutrition_de.white_magic
- images.nutrition_de.x1
- images.nutrition_de.x2
- images.nutrition_de.y1
- images.nutrition_de.y2
- images.nutrition_en
- images.nutrition_en.angle
- images.nutrition_en.coordinates_image_size
- images.nutrition_en.geometry
- images.nutrition_en.imgid
- images.nutrition_en.normalize
- images.nutrition_en.ocr
- images.nutrition_en.orientation
- images.nutrition_en.rev
- images.nutrition_en.sizes
- images.nutrition_en.sizes.100
- images.nutrition_en.sizes.100.h
- images.nutrition_en.sizes.100.w
- images.nutrition_en.sizes.200
- images.nutrition_en.sizes.200.h
- images.nutrition_en.sizes.200.w
- images.nutrition_en.sizes.400
- images.nutrition_en.sizes.400.h
- images.nutrition_en.sizes.400.w
- images.nutrition_en.sizes.full
- images.nutrition_en.sizes.full.h
- images.nutrition_en.sizes.full.w
- images.nutrition_en.white_magic
- images.nutrition_en.x1
- images.nutrition_en.x2
- images.nutrition_en.y1
- images.nutrition_en.y2
- images.nutrition_fr
- images.nutrition_fr.angle
- images.nutrition_fr.coordinates_image_size
- images.nutrition_fr.geometry
- images.nutrition_fr.imgid
- images.nutrition_fr.normalize
- images.nutrition_fr.ocr
- images.nutrition_fr.orientation
- images.nutrition_fr.rev
- images.nutrition_fr.sizes
- images.nutrition_fr.sizes.100
- images.nutrition_fr.sizes.100.h
- images.nutrition_fr.sizes.100.w
- images.nutrition_fr.sizes.200
- images.nutrition_fr.sizes.200.h
- images.nutrition_fr.sizes.200.w
- images.nutrition_fr.sizes.400
- images.nutrition_fr.sizes.400.h
- images.nutrition_fr.sizes.400.w
- images.nutrition_fr.sizes.full
- images.nutrition_fr.sizes.full.h
- images.nutrition_fr.sizes.full.w
- images.nutrition_fr.white_magic
- images.nutrition_fr.x1
- images.nutrition_fr.x2
- images.nutrition_fr.y1
- images.nutrition_fr.y2
- images.nutrition_it
- images.nutrition_it.angle
- images.nutrition_it.coordinates_image_size
- images.nutrition_it.geometry
- images.nutrition_it.imgid
- images.nutrition_it.normalize
- images.nutrition_it.ocr
- images.nutrition_it.orientation
- images.nutrition_it.rev
- images.nutrition_it.sizes
- images.nutrition_it.sizes.100
- images.nutrition_it.sizes.100.h
- images.nutrition_it.sizes.100.w
- images.nutrition_it.sizes.200
- images.nutrition_it.sizes.200.h
- images.nutrition_it.sizes.200.w
- images.nutrition_it.sizes.400
- images.nutrition_it.sizes.400.h
- images.nutrition_it.sizes.400.w
- images.nutrition_it.sizes.full
- images.nutrition_it.sizes.full.h
- images.nutrition_it.sizes.full.w
- images.nutrition_it.white_magic
- images.nutrition_it.x1
- images.nutrition_it.x2
- images.nutrition_it.y1
- images.nutrition_it.y2
- images.nutrition_nl
- images.nutrition_nl.angle
- images.nutrition_nl.geometry
- images.nutrition_nl.imgid
- images.nutrition_nl.normalize
- images.nutrition_nl.ocr
- images.nutrition_nl.orientation
- images.nutrition_nl.rev
- images.nutrition_nl.sizes
- images.nutrition_nl.sizes.100
- images.nutrition_nl.sizes.100.h
- images.nutrition_nl.sizes.100.w
- images.nutrition_nl.sizes.200
- images.nutrition_nl.sizes.200.h
- images.nutrition_nl.sizes.200.w
- images.nutrition_nl.sizes.400
- images.nutrition_nl.sizes.400.h
- images.nutrition_nl.sizes.400.w
- images.nutrition_nl.sizes.full
- images.nutrition_nl.sizes.full.h
- images.nutrition_nl.sizes.full.w
- images.nutrition_nl.white_magic
- images.nutrition_nl.x1
- images.nutrition_nl.x2
- images.nutrition_nl.y1
- images.nutrition_nl.y2
- images.nutrition.geometry
- images.nutrition.imgid
- images.nutrition.normalize
- images.nutrition.ocr
- images.nutrition.orientation
- images.nutrition.rev
- images.nutrition.sizes
- images.nutrition.sizes.100
- images.nutrition.sizes.100.h
- images.nutrition.sizes.100.w
- images.nutrition.sizes.200
- images.nutrition.sizes.200.h
- images.nutrition.sizes.200.w
- images.nutrition.sizes.400
- images.nutrition.sizes.400.h
- images.nutrition.sizes.400.w
- images.nutrition.sizes.full
- images.nutrition.sizes.full.h
- images.nutrition.sizes.full.w
- images.nutrition.white_magic
- images.selected.nutrition
- images.selected.nutrition.cs
- images.selected.nutrition.cs.generation
- images.selected.nutrition.cs.imgid
- images.selected.nutrition.cs.rev
- images.selected.nutrition.cs.sizes
- images.selected.nutrition.cs.sizes.100
- images.selected.nutrition.cs.sizes.200
- images.selected.nutrition.cs.sizes.400
- images.selected.nutrition.cs.sizes.full
- images.selected.nutrition.da
- images.selected.nutrition.da.generation
- images.selected.nutrition.da.imgid
- images.selected.nutrition.da.rev
- images.selected.nutrition.da.sizes
- images.selected.nutrition.da.sizes.100
- images.selected.nutrition.da.sizes.200
- images.selected.nutrition.da.sizes.400
- images.selected.nutrition.da.sizes.full
- images.selected.nutrition.en
- images.selected.nutrition.en.generation
- images.selected.nutrition.en.generation.angle
- images.selected.nutrition.en.generation.coordinates_image_size
- images.selected.nutrition.en.generation.x1
- images.selected.nutrition.en.generation.x2
- images.selected.nutrition.en.generation.y1
- images.selected.nutrition.en.generation.y2
- images.selected.nutrition.en.imgid
- images.selected.nutrition.en.rev
- images.selected.nutrition.en.sizes
- images.selected.nutrition.en.sizes.100
- images.selected.nutrition.en.sizes.200
- images.selected.nutrition.en.sizes.400
- images.selected.nutrition.en.sizes.full
- images.selected.nutrition.es
- images.selected.nutrition.es.generation
- images.selected.nutrition.es.generation.coordinates_image_size
- images.selected.nutrition.es.generation.x1
- images.selected.nutrition.es.generation.x2
- images.selected.nutrition.es.generation.y1
- images.selected.nutrition.es.generation.y2
- images.selected.nutrition.es.imgid
- images.selected.nutrition.es.rev
- images.selected.nutrition.es.sizes
- images.selected.nutrition.es.sizes.100
- images.selected.nutrition.es.sizes.200
- images.selected.nutrition.es.sizes.400
- images.selected.nutrition.es.sizes.full
- images.selected.nutrition.fr
- images.selected.nutrition.fr.generation
- images.selected.nutrition.fr.generation.angle
- images.selected.nutrition.fr.generation.coordinates_image_size
- images.selected.nutrition.fr.generation.x1
- images.selected.nutrition.fr.generation.x2
- images.selected.nutrition.fr.generation.y1
- images.selected.nutrition.fr.generation.y2
- images.selected.nutrition.fr.imgid
- images.selected.nutrition.fr.rev
- images.selected.nutrition.fr.sizes
- images.selected.nutrition.fr.sizes.100
- images.selected.nutrition.fr.sizes.200
- images.selected.nutrition.fr.sizes.400
- images.selected.nutrition.fr.sizes.full
- images.selected.nutrition.it
- images.selected.nutrition.it.generation
- images.selected.nutrition.it.imgid
- images.selected.nutrition.it.rev
- images.selected.nutrition.it.sizes
- images.selected.nutrition.it.sizes.100
- images.selected.nutrition.it.sizes.200
- images.selected.nutrition.it.sizes.400
- images.selected.nutrition.it.sizes.full
- images.selected.nutrition.la
- images.selected.nutrition.la.generation
- images.selected.nutrition.la.imgid
- images.selected.nutrition.la.rev
- images.selected.nutrition.la.sizes
- images.selected.nutrition.la.sizes.100
- images.selected.nutrition.la.sizes.200
- images.selected.nutrition.la.sizes.400
- images.selected.nutrition.la.sizes.full
- images.selected.nutrition.nl
- images.selected.nutrition.nl.generation
- images.selected.nutrition.nl.generation.coordinates_image_size
- images.selected.nutrition.nl.generation.x1
- images.selected.nutrition.nl.generation.x2
- images.selected.nutrition.nl.generation.y1
- images.selected.nutrition.nl.generation.y2
- images.selected.nutrition.nl.imgid
- images.selected.nutrition.nl.rev
- images.selected.nutrition.nl.sizes
- images.selected.nutrition.nl.sizes.100
- images.selected.nutrition.nl.sizes.200
- images.selected.nutrition.nl.sizes.400
- images.selected.nutrition.nl.sizes.full
- images.selected.nutrition.th
- images.selected.nutrition.th.generation
- images.selected.nutrition.th.generation.coordinates_image_size
- images.selected.nutrition.th.generation.x1
- images.selected.nutrition.th.generation.x2
- images.selected.nutrition.th.generation.y1
- images.selected.nutrition.th.generation.y2
- images.selected.nutrition.th.imgid
- images.selected.nutrition.th.rev
- images.selected.nutrition.th.sizes
- images.selected.nutrition.th.sizes.100
- images.selected.nutrition.th.sizes.200
- images.selected.nutrition.th.sizes.400
- images.selected.nutrition.th.sizes.full
- ingredients_non_nutritive_sweeteners_n
- no_nutrition_data
- nutrient_levels
- nutrient_levels_tags
- nutrient_levels_tags[]
- nutrient_levels.fat
- nutrient_levels.salt
- nutrient_levels.saturated-fat
- nutrient_levels.sugars
- nutriments
- nutriments_estimated
- nutriments_estimated.alcohol_100g
- nutriments_estimated.beta-carotene_100g
- nutriments_estimated.calcium_100g
- nutriments_estimated.carbohydrates_100g
- nutriments_estimated.chloride_100g
- nutriments_estimated.cholesterol_100g
- nutriments_estimated.copper_100g
- nutriments_estimated.energy_100g
- nutriments_estimated.energy-kcal_100g
- nutriments_estimated.energy-kj_100g
- nutriments_estimated.fat_100g
- nutriments_estimated.fiber_100g
- nutriments_estimated.fructose_100g
- nutriments_estimated.galactose_100g
- nutriments_estimated.glucose_100g
- nutriments_estimated.iodine_100g
- nutriments_estimated.iron_100g
- nutriments_estimated.lactose_100g
- nutriments_estimated.magnesium_100g
- nutriments_estimated.maltose_100g
- nutriments_estimated.manganese_100g
- nutriments_estimated.pantothenic-acid_100g
- nutriments_estimated.phosphorus_100g
- nutriments_estimated.phylloquinone_100g
- nutriments_estimated.polyols_100g
- nutriments_estimated.potassium_100g
- nutriments_estimated.proteins_100g
- nutriments_estimated.salt_100g
- nutriments_estimated.saturated-fat_100g
- nutriments_estimated.selenium_100g
- nutriments_estimated.sodium_100g
- nutriments_estimated.starch_100g
- nutriments_estimated.sucrose_100g
- nutriments_estimated.sugars_100g
- nutriments_estimated.vitamin-a_100g
- nutriments_estimated.vitamin-b1_100g
- nutriments_estimated.vitamin-b12_100g
- nutriments_estimated.vitamin-b2_100g
- nutriments_estimated.vitamin-b6_100g
- nutriments_estimated.vitamin-b9_100g
- nutriments_estimated.vitamin-c_100g
- nutriments_estimated.vitamin-d_100g
- nutriments_estimated.vitamin-e_100g
- nutriments_estimated.vitamin-pp_100g
- nutriments_estimated.water_100g
- nutriments_estimated.zinc_100g
- nutriments.added-sugars
- nutriments.added-sugars_100g
- nutriments.added-sugars_label
- nutriments.added-sugars_serving
- nutriments.added-sugars_unit
- nutriments.added-sugars_value
- nutriments.alcohol
- nutriments.alcohol_100g
- nutriments.alcohol_serving
- nutriments.alcohol_unit
- nutriments.alcohol_value
- nutriments.alpha-linolenic-acid
- nutriments.alpha-linolenic-acid_100g
- nutriments.alpha-linolenic-acid_serving
- nutriments.alpha-linolenic-acid_unit
- nutriments.alpha-linolenic-acid_value
- nutriments.arachidic-acid
- nutriments.arachidic-acid_100g
- nutriments.arachidic-acid_serving
- nutriments.arachidic-acid_unit
- nutriments.arachidic-acid_value
- nutriments.arachidonic-acid
- nutriments.arachidonic-acid_100g
- nutriments.arachidonic-acid_serving
- nutriments.arachidonic-acid_unit
- nutriments.arachidonic-acid_value
- nutriments.behenic-acid
- nutriments.behenic-acid_100g
- nutriments.behenic-acid_serving
- nutriments.behenic-acid_unit
- nutriments.behenic-acid_value
- nutriments.caffeine
- nutriments.caffeine_100g
- nutriments.caffeine_serving
- nutriments.caffeine_unit
- nutriments.caffeine_value
- nutriments.calcium
- nutriments.calcium_100g
- nutriments.calcium_label
- nutriments.calcium_serving
- nutriments.calcium_unit
- nutriments.calcium_value
- nutriments.carbohydrates
- nutriments.carbohydrates_100g
- nutriments.carbohydrates_modifier
- nutriments.carbohydrates_prepared
- nutriments.carbohydrates_prepared_100g
- nutriments.carbohydrates_prepared_serving
- nutriments.carbohydrates_prepared_unit
- nutriments.carbohydrates_prepared_value
- nutriments.carbohydrates_serving
- nutriments.carbohydrates_unit
- nutriments.carbohydrates_value
- nutriments.carbon-footprint-from-known-ingredients_100g
- nutriments.carbon-footprint-from-known-ingredients_product
- nutriments.carbon-footprint-from-known-ingredients_serving
- nutriments.carbon-footprint-from-meat-or-fish_100g
- nutriments.carbon-footprint-from-meat-or-fish_product
- nutriments.carbon-footprint-from-meat-or-fish_serving
- nutriments.cholesterol
- nutriments.cholesterol_100g
- nutriments.cholesterol_label
- nutriments.cholesterol_modifier
- nutriments.cholesterol_serving
- nutriments.cholesterol_unit
- nutriments.cholesterol_value
- nutriments.choline
- nutriments.choline_100g
- nutriments.choline_serving
- nutriments.choline_unit
- nutriments.choline_value
- nutriments.cocoa
- nutriments.cocoa_100g
- nutriments.cocoa_label
- nutriments.cocoa_serving
- nutriments.cocoa_unit
- nutriments.cocoa_value
- nutriments.copper
- nutriments.copper_100g
- nutriments.copper_label
- nutriments.copper_serving
- nutriments.copper_unit
- nutriments.copper_value
- nutriments.en-sucres-ajoutes
- nutriments.en-sucres-ajoutes_label
- nutriments.en-sucres-ajoutes_serving
- nutriments.en-sucres-ajoutes_unit
- nutriments.en-sucres-ajoutes_value
- nutriments.energy
- nutriments.energy_100g
- nutriments.energy_prepared
- nutriments.energy_prepared_100g
- nutriments.energy_prepared_serving
- nutriments.energy_prepared_unit
- nutriments.energy_prepared_value
- nutriments.energy_serving
- nutriments.energy_unit
- nutriments.energy_value
- nutriments.energy-from-fat
- nutriments.energy-from-fat_100g
- nutriments.energy-from-fat_serving
- nutriments.energy-from-fat_unit
- nutriments.energy-from-fat_value
- nutriments.energy-kcal
- nutriments.energy-kcal_100g
- nutriments.energy-kcal_prepared
- nutriments.energy-kcal_prepared_100g
- nutriments.energy-kcal_prepared_serving
- nutriments.energy-kcal_prepared_unit
- nutriments.energy-kcal_prepared_value
- nutriments.energy-kcal_serving
- nutriments.energy-kcal_unit
- nutriments.energy-kcal_value
- nutriments.energy-kcal_value_computed
- nutriments.energy-kj
- nutriments.energy-kj_100g
- nutriments.energy-kj_prepared
- nutriments.energy-kj_prepared_100g
- nutriments.energy-kj_prepared_serving
- nutriments.energy-kj_prepared_unit
- nutriments.energy-kj_prepared_value
- nutriments.energy-kj_serving
- nutriments.energy-kj_unit
- nutriments.energy-kj_value
- nutriments.energy-kj_value_computed
- nutriments.fat
- nutriments.fat_100g
- nutriments.fat_modifier
- nutriments.fat_prepared
- nutriments.fat_prepared_100g
- nutriments.fat_prepared_serving
- nutriments.fat_prepared_unit
- nutriments.fat_prepared_value
- nutriments.fat_serving
- nutriments.fat_unit
- nutriments.fat_value
- nutriments.fiber
- nutriments.fiber_100g
- nutriments.fiber_modifier
- nutriments.fiber_prepared
- nutriments.fiber_prepared_100g
- nutriments.fiber_prepared_serving
- nutriments.fiber_prepared_unit
- nutriments.fiber_prepared_value
- nutriments.fiber_serving
- nutriments.fiber_unit
- nutriments.fiber_value
- nutriments.fluoride
- nutriments.fluoride_100g
- nutriments.fluoride_serving
- nutriments.fluoride_unit
- nutriments.fluoride_value
- nutriments.folates
- nutriments.folates_100g
- nutriments.folates_serving
- nutriments.folates_unit
- nutriments.folates_value
- nutriments.fructose
- nutriments.fructose_100g
- nutriments.fructose_serving
- nutriments.fructose_unit
- nutriments.fructose_value
- nutriments.fruits-vegetables-legumes-estimate-from-ingredients_100g
- nutriments.fruits-vegetables-legumes-estimate-from-ingredients_serving
- nutriments.fruits-vegetables-nuts
- nutriments.fruits-vegetables-nuts_100g
- nutriments.fruits-vegetables-nuts_label
- nutriments.fruits-vegetables-nuts_serving
- nutriments.fruits-vegetables-nuts_unit
- nutriments.fruits-vegetables-nuts_value
- nutriments.fruits-vegetables-nuts-estimate
- nutriments.fruits-vegetables-nuts-estimate_100g
- nutriments.fruits-vegetables-nuts-estimate_label
- nutriments.fruits-vegetables-nuts-estimate_serving
- nutriments.fruits-vegetables-nuts-estimate_unit
- nutriments.fruits-vegetables-nuts-estimate_value
- nutriments.fruits-vegetables-nuts-estimate-from-ingredients_100g
- nutriments.fruits-vegetables-nuts-estimate-from-ingredients_serving
- nutriments.glucose
- nutriments.glucose_100g
- nutriments.glucose_serving
- nutriments.glucose_unit
- nutriments.glucose_value
- nutriments.insoluble-fiber
- nutriments.insoluble-fiber_100g
- nutriments.insoluble-fiber_serving
- nutriments.insoluble-fiber_unit
- nutriments.insoluble-fiber_value
- nutriments.iodine
- nutriments.iodine_100g
- nutriments.iodine_serving
- nutriments.iodine_unit
- nutriments.iodine_value
- nutriments.iron
- nutriments.iron_100g
- nutriments.iron_label
- nutriments.iron_serving
- nutriments.iron_unit
- nutriments.iron_value
- nutriments.lactose
- nutriments.lactose_100g
- nutriments.lactose_serving
- nutriments.lactose_unit
- nutriments.lactose_value
- nutriments.magnesium
- nutriments.magnesium_100g
- nutriments.magnesium_label
- nutriments.magnesium_serving
- nutriments.magnesium_unit
- nutriments.magnesium_value
- nutriments.maltose
- nutriments.maltose_100g
- nutriments.maltose_serving
- nutriments.maltose_unit
- nutriments.maltose_value
- nutriments.manganese
- nutriments.manganese_100g
- nutriments.manganese_serving
- nutriments.manganese_unit
- nutriments.manganese_value
- nutriments.monounsaturated-fat
- nutriments.monounsaturated-fat_100g
- nutriments.monounsaturated-fat_label
- nutriments.monounsaturated-fat_serving
- nutriments.monounsaturated-fat_unit
- nutriments.monounsaturated-fat_value
- nutriments.nova-group
- nutriments.nova-group_100g
- nutriments.nova-group_serving
- nutriments.nutrition-score-fr
- nutriments.nutrition-score-fr_100g
- nutriments.omega-3-fat
- nutriments.omega-3-fat_100g
- nutriments.omega-3-fat_serving
- nutriments.omega-3-fat_unit
- nutriments.omega-3-fat_value
- nutriments.omega-6-fat
- nutriments.omega-6-fat_serving
- nutriments.omega-6-fat_unit
- nutriments.omega-6-fat_value
- nutriments.pantothenic-acid
- nutriments.pantothenic-acid_100g
- nutriments.pantothenic-acid_serving
- nutriments.pantothenic-acid_unit
- nutriments.pantothenic-acid_value
- nutriments.phosphorus
- nutriments.phosphorus_100g
- nutriments.phosphorus_label
- nutriments.phosphorus_serving
- nutriments.phosphorus_unit
- nutriments.phosphorus_value
- nutriments.phylloquinone
- nutriments.phylloquinone_100g
- nutriments.phylloquinone_serving
- nutriments.phylloquinone_unit
- nutriments.phylloquinone_value
- nutriments.polyols
- nutriments.polyols_100g
- nutriments.polyols_label
- nutriments.polyols_serving
- nutriments.polyols_unit
- nutriments.polyols_value
- nutriments.polyunsaturated-fat
- nutriments.polyunsaturated-fat_100g
- nutriments.polyunsaturated-fat_label
- nutriments.polyunsaturated-fat_serving
- nutriments.polyunsaturated-fat_unit
- nutriments.polyunsaturated-fat_value
- nutriments.potassium
- nutriments.potassium_100g
- nutriments.potassium_label
- nutriments.potassium_serving
- nutriments.potassium_unit
- nutriments.potassium_value
- nutriments.protein-dry-substance
- nutriments.protein-dry-substance_100g
- nutriments.protein-dry-substance_label
- nutriments.protein-dry-substance_serving
- nutriments.protein-dry-substance_unit
- nutriments.protein-dry-substance_value
- nutriments.proteins
- nutriments.proteins_100g
- nutriments.proteins_modifier
- nutriments.proteins_prepared
- nutriments.proteins_prepared_100g
- nutriments.proteins_prepared_serving
- nutriments.proteins_prepared_unit
- nutriments.proteins_prepared_value
- nutriments.proteins_serving
- nutriments.proteins_unit
- nutriments.proteins_value
- nutriments.proteins-dry-substance
- nutriments.proteins-dry-substance_100g
- nutriments.proteins-dry-substance_label
- nutriments.proteins-dry-substance_serving
- nutriments.proteins-dry-substance_unit
- nutriments.proteins-dry-substance_value
- nutriments.salt
- nutriments.salt_100g
- nutriments.salt_modifier
- nutriments.salt_prepared
- nutriments.salt_prepared_100g
- nutriments.salt_prepared_serving
- nutriments.salt_prepared_unit
- nutriments.salt_prepared_value
- nutriments.salt_serving
- nutriments.salt_unit
- nutriments.salt_value
- nutriments.saturated-fat
- nutriments.saturated-fat_100g
- nutriments.saturated-fat_modifier
- nutriments.saturated-fat_prepared
- nutriments.saturated-fat_prepared_100g
- nutriments.saturated-fat_prepared_serving
- nutriments.saturated-fat_prepared_unit
- nutriments.saturated-fat_prepared_value
- nutriments.saturated-fat_serving
- nutriments.saturated-fat_unit
- nutriments.saturated-fat_value
- nutriments.selenium
- nutriments.selenium_100g
- nutriments.selenium_serving
- nutriments.selenium_unit
- nutriments.selenium_value
- nutriments.sodium
- nutriments.sodium_100g
- nutriments.sodium_label
- nutriments.sodium_modifier
- nutriments.sodium_prepared
- nutriments.sodium_prepared_100g
- nutriments.sodium_prepared_serving
- nutriments.sodium_prepared_unit
- nutriments.sodium_prepared_value
- nutriments.sodium_serving
- nutriments.sodium_unit
- nutriments.sodium_value
- nutriments.soluble-fiber
- nutriments.soluble-fiber_100g
- nutriments.soluble-fiber_serving
- nutriments.soluble-fiber_unit
- nutriments.soluble-fiber_value
- nutriments.starch
- nutriments.starch_100g
- nutriments.starch_label
- nutriments.starch_serving
- nutriments.starch_unit
- nutriments.starch_value
- nutriments.sucrose
- nutriments.sucrose_100g
- nutriments.sucrose_serving
- nutriments.sucrose_unit
- nutriments.sucrose_value
- nutriments.sugars
- nutriments.sugars_100g
- nutriments.sugars_modifier
- nutriments.sugars_prepared
- nutriments.sugars_prepared_100g
- nutriments.sugars_prepared_serving
- nutriments.sugars_prepared_unit
- nutriments.sugars_prepared_value
- nutriments.sugars_serving
- nutriments.sugars_unit
- nutriments.sugars_value
- nutriments.trans-fat
- nutriments.trans-fat_100g
- nutriments.trans-fat_label
- nutriments.trans-fat_serving
- nutriments.trans-fat_unit
- nutriments.trans-fat_value
- nutriments.vitamin-a
- nutriments.vitamin-a_100g
- nutriments.vitamin-a_label
- nutriments.vitamin-a_serving
- nutriments.vitamin-a_unit
- nutriments.vitamin-a_value
- nutriments.vitamin-b1
- nutriments.vitamin-b1_100g
- nutriments.vitamin-b1_label
- nutriments.vitamin-b1_serving
- nutriments.vitamin-b1_unit
- nutriments.vitamin-b1_value
- nutriments.vitamin-b12
- nutriments.vitamin-b12_100g
- nutriments.vitamin-b12_serving
- nutriments.vitamin-b12_unit
- nutriments.vitamin-b12_value
- nutriments.vitamin-b2
- nutriments.vitamin-b2_100g
- nutriments.vitamin-b2_label
- nutriments.vitamin-b2_serving
- nutriments.vitamin-b2_unit
- nutriments.vitamin-b2_value
- nutriments.vitamin-b6
- nutriments.vitamin-b6_100g
- nutriments.vitamin-b6_serving
- nutriments.vitamin-b6_unit
- nutriments.vitamin-b6_value
- nutriments.vitamin-b9
- nutriments.vitamin-b9_100g
- nutriments.vitamin-b9_label
- nutriments.vitamin-b9_serving
- nutriments.vitamin-b9_unit
- nutriments.vitamin-b9_value
- nutriments.vitamin-c
- nutriments.vitamin-c_100g
- nutriments.vitamin-c_label
- nutriments.vitamin-c_serving
- nutriments.vitamin-c_unit
- nutriments.vitamin-c_value
- nutriments.vitamin-d
- nutriments.vitamin-d_100g
- nutriments.vitamin-d_label
- nutriments.vitamin-d_serving
- nutriments.vitamin-d_unit
- nutriments.vitamin-d_value
- nutriments.vitamin-e
- nutriments.vitamin-e_100g
- nutriments.vitamin-e_serving
- nutriments.vitamin-e_unit
- nutriments.vitamin-e_value
- nutriments.vitamin-k
- nutriments.vitamin-k_100g
- nutriments.vitamin-k_serving
- nutriments.vitamin-k_unit
- nutriments.vitamin-k_value
- nutriments.vitamin-pp
- nutriments.vitamin-pp_100g
- nutriments.vitamin-pp_label
- nutriments.vitamin-pp_serving
- nutriments.vitamin-pp_unit
- nutriments.vitamin-pp_value
- nutriments.zinc
- nutriments.zinc_100g
- nutriments.zinc_label
- nutriments.zinc_serving
- nutriments.zinc_unit
- nutriments.zinc_value
- nutriscore
- nutriscore_2021_tags
- nutriscore_2021_tags[]
- nutriscore_2023_tags
- nutriscore_2023_tags[]
- nutriscore_data
- nutriscore_data.components
- nutriscore_data.components.negative
- nutriscore_data.components.negative[]
- nutriscore_data.components.negative[].id
- nutriscore_data.components.negative[].points
- nutriscore_data.components.negative[].points_max
- nutriscore_data.components.negative[].unit
- nutriscore_data.components.negative[].value
- nutriscore_data.components.positive
- nutriscore_data.components.positive[]
- nutriscore_data.components.positive[].id
- nutriscore_data.components.positive[].points
- nutriscore_data.components.positive[].points_max
- nutriscore_data.components.positive[].unit
- nutriscore_data.components.positive[].value
- nutriscore_data.count_proteins
- nutriscore_data.count_proteins_reason
- nutriscore_data.grade
- nutriscore_data.is_beverage
- nutriscore_data.is_cheese
- nutriscore_data.is_fat_oil_nuts_seeds
- nutriscore_data.is_red_meat_product
- nutriscore_data.is_water
- nutriscore_data.negative_points
- nutriscore_data.negative_points_max
- nutriscore_data.nutriscore_not_applicable_for_category
- nutriscore_data.positive_nutrients
- nutriscore_data.positive_nutrients[]
- nutriscore_data.positive_points
- nutriscore_data.positive_points_max
- nutriscore_data.proteins_points_limited_reason
- nutriscore_data.score
- nutriscore_grade
- nutriscore_score
- nutriscore_score_opposite
- nutriscore_tags
- nutriscore_tags[]
- nutriscore_version
- nutriscore.2021
- nutriscore.2021.category_available
- nutriscore.2021.data
- nutriscore.2021.data.energy
- nutriscore.2021.data.energy_points
- nutriscore.2021.data.energy_value
- nutriscore.2021.data.fat
- nutriscore.2021.data.fiber
- nutriscore.2021.data.fiber_points
- nutriscore.2021.data.fiber_value
- nutriscore.2021.data.fruits_vegetables_nuts_colza_walnut_olive_oils
- nutriscore.2021.data.fruits_vegetables_nuts_colza_walnut_olive_oils_points
- nutriscore.2021.data.fruits_vegetables_nuts_colza_walnut_olive_oils_value
- nutriscore.2021.data.is_beverage
- nutriscore.2021.data.is_cheese
- nutriscore.2021.data.is_fat
- nutriscore.2021.data.is_water
- nutriscore.2021.data.negative_points
- nutriscore.2021.data.positive_points
- nutriscore.2021.data.proteins
- nutriscore.2021.data.proteins_points
- nutriscore.2021.data.proteins_value
- nutriscore.2021.data.saturated_fat
- nutriscore.2021.data.saturated_fat_points
- nutriscore.2021.data.saturated_fat_ratio
- nutriscore.2021.data.saturated_fat_ratio_points
- nutriscore.2021.data.saturated_fat_ratio_value
- nutriscore.2021.data.saturated_fat_value
- nutriscore.2021.data.sodium
- nutriscore.2021.data.sodium_points
- nutriscore.2021.data.sodium_value
- nutriscore.2021.data.sugars
- nutriscore.2021.data.sugars_points
- nutriscore.2021.data.sugars_value
- nutriscore.2021.grade
- nutriscore.2021.not_applicable_category
- nutriscore.2021.nutrients_available
- nutriscore.2021.nutriscore_applicable
- nutriscore.2021.nutriscore_computed
- nutriscore.2021.score
- nutriscore.2023
- nutriscore.2023.category_available
- nutriscore.2023.data
- nutriscore.2023.data.components
- nutriscore.2023.data.components.negative
- nutriscore.2023.data.components.negative[]
- nutriscore.2023.data.components.positive
- nutriscore.2023.data.components.positive[]
- nutriscore.2023.data.count_proteins
- nutriscore.2023.data.count_proteins_reason
- nutriscore.2023.data.energy
- nutriscore.2023.data.energy_from_saturated_fat
- nutriscore.2023.data.fat
- nutriscore.2023.data.fiber
- nutriscore.2023.data.fruits_vegetables_legumes
- nutriscore.2023.data.is_beverage
- nutriscore.2023.data.is_cheese
- nutriscore.2023.data.is_fat_oil_nuts_seeds
- nutriscore.2023.data.is_red_meat_product
- nutriscore.2023.data.is_water
- nutriscore.2023.data.negative_points
- nutriscore.2023.data.negative_points_max
- nutriscore.2023.data.non_nutritive_sweeteners
- nutriscore.2023.data.positive_nutrients
- nutriscore.2023.data.positive_nutrients[]
- nutriscore.2023.data.positive_points
- nutriscore.2023.data.positive_points_max
- nutriscore.2023.data.proteins
- nutriscore.2023.data.proteins_points_limited_reason
- nutriscore.2023.data.salt
- nutriscore.2023.data.saturated_fat
- nutriscore.2023.data.saturated_fat_ratio
- nutriscore.2023.data.sugars
- nutriscore.2023.data.with_non_nutritive_sweeteners
- nutriscore.2023.grade
- nutriscore.2023.not_applicable_category
- nutriscore.2023.nutrients_available
- nutriscore.2023.nutriscore_applicable
- nutriscore.2023.nutriscore_computed
- nutriscore.2023.score
- nutrition_data
- nutrition_data_per
- nutrition_data_per_debug_tags
- nutrition_data_per_imported
- nutrition_data_prepared
- nutrition_data_prepared_per
- nutrition_data_prepared_per_debug_tags
- nutrition_data_prepared_per_imported
- nutrition_grade_fr
- nutrition_grades
- nutrition_grades_tags
- nutrition_grades_tags[]
- nutrition_score_beverage
- nutrition_score_debug
- nutrition_score_warning_fruits_vegetables_legumes_estimate_from_ingredients
- nutrition_score_warning_fruits_vegetables_legumes_estimate_from_ingredients_value
- nutrition_score_warning_fruits_vegetables_legumes_from_category
- nutrition_score_warning_fruits_vegetables_legumes_from_category_value
- nutrition_score_warning_fruits_vegetables_nuts_estimate
- nutrition_score_warning_fruits_vegetables_nuts_estimate_from_ingredients
- nutrition_score_warning_fruits_vegetables_nuts_estimate_from_ingredients_value
- nutrition_score_warning_fruits_vegetables_nuts_from_category
- nutrition_score_warning_fruits_vegetables_nuts_from_category_value
- nutrition_score_warning_no_fiber
- nutrition_score_warning_no_fruits_vegetables_nuts
- nutrition_score_warning_nutriments_estimated
- other_nutritional_substances_prev_tags
- other_nutritional_substances_tags
- unknown_nutrients_tags
- unknown_nutrients_tags[]
- with_non_nutritive_sweeteners

## Candidate image fields

- images
- images.1
- images.1.sizes
- images.1.sizes.100
- images.1.sizes.100.h
- images.1.sizes.100.w
- images.1.sizes.400
- images.1.sizes.400.h
- images.1.sizes.400.w
- images.1.sizes.full
- images.1.sizes.full.h
- images.1.sizes.full.w
- images.1.uploaded_t
- images.1.uploader
- images.10
- images.10.sizes
- images.10.sizes.100
- images.10.sizes.100.h
- images.10.sizes.100.w
- images.10.sizes.400
- images.10.sizes.400.h
- images.10.sizes.400.w
- images.10.sizes.full
- images.10.sizes.full.h
- images.10.sizes.full.w
- images.10.uploaded_t
- images.10.uploader
- images.11
- images.11.sizes
- images.11.sizes.100
- images.11.sizes.100.h
- images.11.sizes.100.w
- images.11.sizes.400
- images.11.sizes.400.h
- images.11.sizes.400.w
- images.11.sizes.full
- images.11.sizes.full.h
- images.11.sizes.full.w
- images.11.uploaded_t
- images.11.uploader
- images.12
- images.12.sizes
- images.12.sizes.100
- images.12.sizes.100.h
- images.12.sizes.100.w
- images.12.sizes.400
- images.12.sizes.400.h
- images.12.sizes.400.w
- images.12.sizes.full
- images.12.sizes.full.h
- images.12.sizes.full.w
- images.12.uploaded_t
- images.12.uploader
- images.13
- images.13.sizes
- images.13.sizes.100
- images.13.sizes.100.h
- images.13.sizes.100.w
- images.13.sizes.400
- images.13.sizes.400.h
- images.13.sizes.400.w
- images.13.sizes.full
- images.13.sizes.full.h
- images.13.sizes.full.w
- images.13.uploaded_t
- images.13.uploader
- images.14
- images.14.sizes
- images.14.sizes.100
- images.14.sizes.100.h
- images.14.sizes.100.w
- images.14.sizes.400
- images.14.sizes.400.h
- images.14.sizes.400.w
- images.14.sizes.full
- images.14.sizes.full.h
- images.14.sizes.full.w
- images.14.uploaded_t
- images.14.uploader
- images.15
- images.15.sizes
- images.15.sizes.100
- images.15.sizes.100.h
- images.15.sizes.100.w
- images.15.sizes.400
- images.15.sizes.400.h
- images.15.sizes.400.w
- images.15.sizes.full
- images.15.sizes.full.h
- images.15.sizes.full.w
- images.15.uploaded_t
- images.15.uploader
- images.16
- images.16.sizes
- images.16.sizes.100
- images.16.sizes.100.h
- images.16.sizes.100.w
- images.16.sizes.400
- images.16.sizes.400.h
- images.16.sizes.400.w
- images.16.sizes.full
- images.16.sizes.full.h
- images.16.sizes.full.w
- images.16.uploaded_t
- images.16.uploader
- images.2
- images.2.sizes
- images.2.sizes.100
- images.2.sizes.100.h
- images.2.sizes.100.w
- images.2.sizes.400
- images.2.sizes.400.h
- images.2.sizes.400.w
- images.2.sizes.full
- images.2.sizes.full.h
- images.2.sizes.full.w
- images.2.uploaded_t
- images.2.uploader
- images.3
- images.3.sizes
- images.3.sizes.100
- images.3.sizes.100.h
- images.3.sizes.100.w
- images.3.sizes.400
- images.3.sizes.400.h
- images.3.sizes.400.w
- images.3.sizes.full
- images.3.sizes.full.h
- images.3.sizes.full.w
- images.3.uploaded_t
- images.3.uploader
- images.4
- images.4.sizes
- images.4.sizes.100
- images.4.sizes.100.h
- images.4.sizes.100.w
- images.4.sizes.400
- images.4.sizes.400.h
- images.4.sizes.400.w
- images.4.sizes.full
- images.4.sizes.full.h
- images.4.sizes.full.w
- images.4.uploaded_t
- images.4.uploader
- images.5
- images.5.sizes
- images.5.sizes.100
- images.5.sizes.100.h
- images.5.sizes.100.w
- images.5.sizes.400
- images.5.sizes.400.h
- images.5.sizes.400.w
- images.5.sizes.full
- images.5.sizes.full.h
- images.5.sizes.full.w
- images.5.uploaded_t
- images.5.uploader
- images.6
- images.6.sizes
- images.6.sizes.100
- images.6.sizes.100.h
- images.6.sizes.100.w
- images.6.sizes.400
- images.6.sizes.400.h
- images.6.sizes.400.w
- images.6.sizes.full
- images.6.sizes.full.h
- images.6.sizes.full.w
- images.6.uploaded_t
- images.6.uploader
- images.7
- images.7.sizes
- images.7.sizes.100
- images.7.sizes.100.h
- images.7.sizes.100.w
- images.7.sizes.400
- images.7.sizes.400.h
- images.7.sizes.400.w
- images.7.sizes.full
- images.7.sizes.full.h
- images.7.sizes.full.w
- images.7.uploaded_t
- images.7.uploader
- images.8
- images.8.sizes
- images.8.sizes.100
- images.8.sizes.100.h
- images.8.sizes.100.w
- images.8.sizes.400
- images.8.sizes.400.h
- images.8.sizes.400.w
- images.8.sizes.full
- images.8.sizes.full.h
- images.8.sizes.full.w
- images.8.uploaded_t
- images.8.uploader
- images.9
- images.9.sizes
- images.9.sizes.100
- images.9.sizes.100.h
- images.9.sizes.100.w
- images.9.sizes.400
- images.9.sizes.400.h
- images.9.sizes.400.w
- images.9.sizes.full
- images.9.sizes.full.h
- images.9.sizes.full.w
- images.9.uploaded_t
- images.9.uploader
- images.front
- images.front_de
- images.front_de.angle
- images.front_de.coordinates_image_size
- images.front_de.geometry
- images.front_de.imgid
- images.front_de.normalize
- images.front_de.rev
- images.front_de.sizes
- images.front_de.sizes.100
- images.front_de.sizes.100.h
- images.front_de.sizes.100.w
- images.front_de.sizes.200
- images.front_de.sizes.200.h
- images.front_de.sizes.200.w
- images.front_de.sizes.400
- images.front_de.sizes.400.h
- images.front_de.sizes.400.w
- images.front_de.sizes.full
- images.front_de.sizes.full.h
- images.front_de.sizes.full.w
- images.front_de.white_magic
- images.front_de.x1
- images.front_de.x2
- images.front_de.y1
- images.front_de.y2
- images.front_en
- images.front_en.angle
- images.front_en.coordinates_image_size
- images.front_en.geometry
- images.front_en.imgid
- images.front_en.normalize
- images.front_en.rev
- images.front_en.sizes
- images.front_en.sizes.100
- images.front_en.sizes.100.h
- images.front_en.sizes.100.w
- images.front_en.sizes.200
- images.front_en.sizes.200.h
- images.front_en.sizes.200.w
- images.front_en.sizes.400
- images.front_en.sizes.400.h
- images.front_en.sizes.400.w
- images.front_en.sizes.full
- images.front_en.sizes.full.h
- images.front_en.sizes.full.w
- images.front_en.white_magic
- images.front_en.x1
- images.front_en.x2
- images.front_en.y1
- images.front_en.y2
- images.front_es
- images.front_es.angle
- images.front_es.geometry
- images.front_es.imgid
- images.front_es.normalize
- images.front_es.rev
- images.front_es.sizes
- images.front_es.sizes.100
- images.front_es.sizes.100.h
- images.front_es.sizes.100.w
- images.front_es.sizes.200
- images.front_es.sizes.200.h
- images.front_es.sizes.200.w
- images.front_es.sizes.400
- images.front_es.sizes.400.h
- images.front_es.sizes.400.w
- images.front_es.sizes.full
- images.front_es.sizes.full.h
- images.front_es.sizes.full.w
- images.front_es.white_magic
- images.front_es.x1
- images.front_es.x2
- images.front_es.y1
- images.front_es.y2
- images.front_fr
- images.front_fr.angle
- images.front_fr.coordinates_image_size
- images.front_fr.geometry
- images.front_fr.imgid
- images.front_fr.normalize
- images.front_fr.rev
- images.front_fr.sizes
- images.front_fr.sizes.100
- images.front_fr.sizes.100.h
- images.front_fr.sizes.100.w
- images.front_fr.sizes.200
- images.front_fr.sizes.200.h
- images.front_fr.sizes.200.w
- images.front_fr.sizes.400
- images.front_fr.sizes.400.h
- images.front_fr.sizes.400.w
- images.front_fr.sizes.full
- images.front_fr.sizes.full.h
- images.front_fr.sizes.full.w
- images.front_fr.white_magic
- images.front_fr.x1
- images.front_fr.x2
- images.front_fr.y1
- images.front_fr.y2
- images.front_it
- images.front_it.angle
- images.front_it.geometry
- images.front_it.imgid
- images.front_it.normalize
- images.front_it.rev
- images.front_it.sizes
- images.front_it.sizes.100
- images.front_it.sizes.100.h
- images.front_it.sizes.100.w
- images.front_it.sizes.200
- images.front_it.sizes.200.h
- images.front_it.sizes.200.w
- images.front_it.sizes.400
- images.front_it.sizes.400.h
- images.front_it.sizes.400.w
- images.front_it.sizes.full
- images.front_it.sizes.full.h
- images.front_it.sizes.full.w
- images.front_it.white_magic
- images.front_it.x1
- images.front_it.x2
- images.front_it.y1
- images.front_it.y2
- images.front_la
- images.front_la.angle
- images.front_la.coordinates_image_size
- images.front_la.geometry
- images.front_la.imgid
- images.front_la.normalize
- images.front_la.rev
- images.front_la.sizes
- images.front_la.sizes.100
- images.front_la.sizes.100.h
- images.front_la.sizes.100.w
- images.front_la.sizes.200
- images.front_la.sizes.200.h
- images.front_la.sizes.200.w
- images.front_la.sizes.400
- images.front_la.sizes.400.h
- images.front_la.sizes.400.w
- images.front_la.sizes.full
- images.front_la.sizes.full.h
- images.front_la.sizes.full.w
- images.front_la.white_magic
- images.front_la.x1
- images.front_la.x2
- images.front_la.y1
- images.front_la.y2
- images.front_nl
- images.front_nl.angle
- images.front_nl.geometry
- images.front_nl.imgid
- images.front_nl.normalize
- images.front_nl.rev
- images.front_nl.sizes
- images.front_nl.sizes.100
- images.front_nl.sizes.100.h
- images.front_nl.sizes.100.w
- images.front_nl.sizes.200
- images.front_nl.sizes.200.h
- images.front_nl.sizes.200.w
- images.front_nl.sizes.400
- images.front_nl.sizes.400.h
- images.front_nl.sizes.400.w
- images.front_nl.sizes.full
- images.front_nl.sizes.full.h
- images.front_nl.sizes.full.w
- images.front_nl.white_magic
- images.front_nl.x1
- images.front_nl.x2
- images.front_nl.y1
- images.front_nl.y2
- images.front_ru
- images.front_ru.angle
- images.front_ru.coordinates_image_size
- images.front_ru.geometry
- images.front_ru.imgid
- images.front_ru.normalize
- images.front_ru.rev
- images.front_ru.sizes
- images.front_ru.sizes.100
- images.front_ru.sizes.100.h
- images.front_ru.sizes.100.w
- images.front_ru.sizes.200
- images.front_ru.sizes.200.h
- images.front_ru.sizes.200.w
- images.front_ru.sizes.400
- images.front_ru.sizes.400.h
- images.front_ru.sizes.400.w
- images.front_ru.sizes.full
- images.front_ru.sizes.full.h
- images.front_ru.sizes.full.w
- images.front_ru.white_magic
- images.front_ru.x1
- images.front_ru.x2
- images.front_ru.y1
- images.front_ru.y2
- images.front_sv
- images.front_sv.angle
- images.front_sv.coordinates_image_size
- images.front_sv.geometry
- images.front_sv.imgid
- images.front_sv.normalize
- images.front_sv.rev
- images.front_sv.sizes
- images.front_sv.sizes.100
- images.front_sv.sizes.100.h
- images.front_sv.sizes.100.w
- images.front_sv.sizes.200
- images.front_sv.sizes.200.h
- images.front_sv.sizes.200.w
- images.front_sv.sizes.400
- images.front_sv.sizes.400.h
- images.front_sv.sizes.400.w
- images.front_sv.sizes.full
- images.front_sv.sizes.full.h
- images.front_sv.sizes.full.w
- images.front_sv.white_magic
- images.front_sv.x1
- images.front_sv.x2
- images.front_sv.y1
- images.front_sv.y2
- images.front.geometry
- images.front.imgid
- images.front.normalize
- images.front.rev
- images.front.sizes
- images.front.sizes.100
- images.front.sizes.100.h
- images.front.sizes.100.w
- images.front.sizes.200
- images.front.sizes.200.h
- images.front.sizes.200.w
- images.front.sizes.400
- images.front.sizes.400.h
- images.front.sizes.400.w
- images.front.sizes.full
- images.front.sizes.full.h
- images.front.sizes.full.w
- images.front.white_magic
- images.ingredients
- images.ingredients_de
- images.ingredients_de.angle
- images.ingredients_de.geometry
- images.ingredients_de.imgid
- images.ingredients_de.normalize
- images.ingredients_de.ocr
- images.ingredients_de.orientation
- images.ingredients_de.rev
- images.ingredients_de.sizes
- images.ingredients_de.sizes.100
- images.ingredients_de.sizes.100.h
- images.ingredients_de.sizes.100.w
- images.ingredients_de.sizes.200
- images.ingredients_de.sizes.200.h
- images.ingredients_de.sizes.200.w
- images.ingredients_de.sizes.400
- images.ingredients_de.sizes.400.h
- images.ingredients_de.sizes.400.w
- images.ingredients_de.sizes.full
- images.ingredients_de.sizes.full.h
- images.ingredients_de.sizes.full.w
- images.ingredients_de.white_magic
- images.ingredients_de.x1
- images.ingredients_de.x2
- images.ingredients_de.y1
- images.ingredients_de.y2
- images.ingredients_en
- images.ingredients_en.angle
- images.ingredients_en.coordinates_image_size
- images.ingredients_en.geometry
- images.ingredients_en.imgid
- images.ingredients_en.normalize
- images.ingredients_en.ocr
- images.ingredients_en.orientation
- images.ingredients_en.rev
- images.ingredients_en.sizes
- images.ingredients_en.sizes.100
- images.ingredients_en.sizes.100.h
- images.ingredients_en.sizes.100.w
- images.ingredients_en.sizes.200
- images.ingredients_en.sizes.200.h
- images.ingredients_en.sizes.200.w
- images.ingredients_en.sizes.400
- images.ingredients_en.sizes.400.h
- images.ingredients_en.sizes.400.w
- images.ingredients_en.sizes.full
- images.ingredients_en.sizes.full.h
- images.ingredients_en.sizes.full.w
- images.ingredients_en.white_magic
- images.ingredients_en.x1
- images.ingredients_en.x2
- images.ingredients_en.y1
- images.ingredients_en.y2
- images.ingredients_fr
- images.ingredients_fr.angle
- images.ingredients_fr.coordinates_image_size
- images.ingredients_fr.geometry
- images.ingredients_fr.imgid
- images.ingredients_fr.normalize
- images.ingredients_fr.ocr
- images.ingredients_fr.orientation
- images.ingredients_fr.rev
- images.ingredients_fr.sizes
- images.ingredients_fr.sizes.100
- images.ingredients_fr.sizes.100.h
- images.ingredients_fr.sizes.100.w
- images.ingredients_fr.sizes.200
- images.ingredients_fr.sizes.200.h
- images.ingredients_fr.sizes.200.w
- images.ingredients_fr.sizes.400
- images.ingredients_fr.sizes.400.h
- images.ingredients_fr.sizes.400.w
- images.ingredients_fr.sizes.full
- images.ingredients_fr.sizes.full.h
- images.ingredients_fr.sizes.full.w
- images.ingredients_fr.white_magic
- images.ingredients_fr.x1
- images.ingredients_fr.x2
- images.ingredients_fr.y1
- images.ingredients_fr.y2
- images.ingredients_it
- images.ingredients_it.geometry
- images.ingredients_it.imgid
- images.ingredients_it.normalize
- images.ingredients_it.ocr
- images.ingredients_it.orientation
- images.ingredients_it.rev
- images.ingredients_it.sizes
- images.ingredients_it.sizes.100
- images.ingredients_it.sizes.100.h
- images.ingredients_it.sizes.100.w
- images.ingredients_it.sizes.200
- images.ingredients_it.sizes.200.h
- images.ingredients_it.sizes.200.w
- images.ingredients_it.sizes.400
- images.ingredients_it.sizes.400.h
- images.ingredients_it.sizes.400.w
- images.ingredients_it.sizes.full
- images.ingredients_it.sizes.full.h
- images.ingredients_it.sizes.full.w
- images.ingredients_it.white_magic
- images.ingredients_nl
- images.ingredients_nl.angle
- images.ingredients_nl.geometry
- images.ingredients_nl.imgid
- images.ingredients_nl.normalize
- images.ingredients_nl.ocr
- images.ingredients_nl.orientation
- images.ingredients_nl.rev
- images.ingredients_nl.sizes
- images.ingredients_nl.sizes.100
- images.ingredients_nl.sizes.100.h
- images.ingredients_nl.sizes.100.w
- images.ingredients_nl.sizes.200
- images.ingredients_nl.sizes.200.h
- images.ingredients_nl.sizes.200.w
- images.ingredients_nl.sizes.400
- images.ingredients_nl.sizes.400.h
- images.ingredients_nl.sizes.400.w
- images.ingredients_nl.sizes.full
- images.ingredients_nl.sizes.full.h
- images.ingredients_nl.sizes.full.w
- images.ingredients_nl.white_magic
- images.ingredients_nl.x1
- images.ingredients_nl.x2
- images.ingredients_nl.y1
- images.ingredients_nl.y2
- images.ingredients_ru
- images.ingredients_ru.angle
- images.ingredients_ru.coordinates_image_size
- images.ingredients_ru.geometry
- images.ingredients_ru.imgid
- images.ingredients_ru.normalize
- images.ingredients_ru.rev
- images.ingredients_ru.sizes
- images.ingredients_ru.sizes.100
- images.ingredients_ru.sizes.100.h
- images.ingredients_ru.sizes.100.w
- images.ingredients_ru.sizes.200
- images.ingredients_ru.sizes.200.h
- images.ingredients_ru.sizes.200.w
- images.ingredients_ru.sizes.400
- images.ingredients_ru.sizes.400.h
- images.ingredients_ru.sizes.400.w
- images.ingredients_ru.sizes.full
- images.ingredients_ru.sizes.full.h
- images.ingredients_ru.sizes.full.w
- images.ingredients_ru.white_magic
- images.ingredients_ru.x1
- images.ingredients_ru.x2
- images.ingredients_ru.y1
- images.ingredients_ru.y2
- images.ingredients.geometry
- images.ingredients.imgid
- images.ingredients.normalize
- images.ingredients.ocr
- images.ingredients.orientation
- images.ingredients.rev
- images.ingredients.sizes
- images.ingredients.sizes.100
- images.ingredients.sizes.100.h
- images.ingredients.sizes.100.w
- images.ingredients.sizes.200
- images.ingredients.sizes.200.h
- images.ingredients.sizes.200.w
- images.ingredients.sizes.400
- images.ingredients.sizes.400.h
- images.ingredients.sizes.400.w
- images.ingredients.sizes.full
- images.ingredients.sizes.full.h
- images.ingredients.sizes.full.w
- images.ingredients.white_magic
- images.nutrition
- images.nutrition_de
- images.nutrition_de.angle
- images.nutrition_de.coordinates_image_size
- images.nutrition_de.geometry
- images.nutrition_de.imgid
- images.nutrition_de.normalize
- images.nutrition_de.ocr
- images.nutrition_de.orientation
- images.nutrition_de.rev
- images.nutrition_de.sizes
- images.nutrition_de.sizes.100
- images.nutrition_de.sizes.100.h
- images.nutrition_de.sizes.100.w
- images.nutrition_de.sizes.200
- images.nutrition_de.sizes.200.h
- images.nutrition_de.sizes.200.w
- images.nutrition_de.sizes.400
- images.nutrition_de.sizes.400.h
- images.nutrition_de.sizes.400.w
- images.nutrition_de.sizes.full
- images.nutrition_de.sizes.full.h
- images.nutrition_de.sizes.full.w
- images.nutrition_de.white_magic
- images.nutrition_de.x1
- images.nutrition_de.x2
- images.nutrition_de.y1
- images.nutrition_de.y2
- images.nutrition_en
- images.nutrition_en.angle
- images.nutrition_en.coordinates_image_size
- images.nutrition_en.geometry
- images.nutrition_en.imgid
- images.nutrition_en.normalize
- images.nutrition_en.ocr
- images.nutrition_en.orientation
- images.nutrition_en.rev
- images.nutrition_en.sizes
- images.nutrition_en.sizes.100
- images.nutrition_en.sizes.100.h
- images.nutrition_en.sizes.100.w
- images.nutrition_en.sizes.200
- images.nutrition_en.sizes.200.h
- images.nutrition_en.sizes.200.w
- images.nutrition_en.sizes.400
- images.nutrition_en.sizes.400.h
- images.nutrition_en.sizes.400.w
- images.nutrition_en.sizes.full
- images.nutrition_en.sizes.full.h
- images.nutrition_en.sizes.full.w
- images.nutrition_en.white_magic
- images.nutrition_en.x1
- images.nutrition_en.x2
- images.nutrition_en.y1
- images.nutrition_en.y2
- images.nutrition_fr
- images.nutrition_fr.angle
- images.nutrition_fr.coordinates_image_size
- images.nutrition_fr.geometry
- images.nutrition_fr.imgid
- images.nutrition_fr.normalize
- images.nutrition_fr.ocr
- images.nutrition_fr.orientation
- images.nutrition_fr.rev
- images.nutrition_fr.sizes
- images.nutrition_fr.sizes.100
- images.nutrition_fr.sizes.100.h
- images.nutrition_fr.sizes.100.w
- images.nutrition_fr.sizes.200
- images.nutrition_fr.sizes.200.h
- images.nutrition_fr.sizes.200.w
- images.nutrition_fr.sizes.400
- images.nutrition_fr.sizes.400.h
- images.nutrition_fr.sizes.400.w
- images.nutrition_fr.sizes.full
- images.nutrition_fr.sizes.full.h
- images.nutrition_fr.sizes.full.w
- images.nutrition_fr.white_magic
- images.nutrition_fr.x1
- images.nutrition_fr.x2
- images.nutrition_fr.y1
- images.nutrition_fr.y2
- images.nutrition_it
- images.nutrition_it.angle
- images.nutrition_it.coordinates_image_size
- images.nutrition_it.geometry
- images.nutrition_it.imgid
- images.nutrition_it.normalize
- images.nutrition_it.ocr
- images.nutrition_it.orientation
- images.nutrition_it.rev
- images.nutrition_it.sizes
- images.nutrition_it.sizes.100
- images.nutrition_it.sizes.100.h
- images.nutrition_it.sizes.100.w
- images.nutrition_it.sizes.200
- images.nutrition_it.sizes.200.h
- images.nutrition_it.sizes.200.w
- images.nutrition_it.sizes.400
- images.nutrition_it.sizes.400.h
- images.nutrition_it.sizes.400.w
- images.nutrition_it.sizes.full
- images.nutrition_it.sizes.full.h
- images.nutrition_it.sizes.full.w
- images.nutrition_it.white_magic
- images.nutrition_it.x1
- images.nutrition_it.x2
- images.nutrition_it.y1
- images.nutrition_it.y2
- images.nutrition_nl
- images.nutrition_nl.angle
- images.nutrition_nl.geometry
- images.nutrition_nl.imgid
- images.nutrition_nl.normalize
- images.nutrition_nl.ocr
- images.nutrition_nl.orientation
- images.nutrition_nl.rev
- images.nutrition_nl.sizes
- images.nutrition_nl.sizes.100
- images.nutrition_nl.sizes.100.h
- images.nutrition_nl.sizes.100.w
- images.nutrition_nl.sizes.200
- images.nutrition_nl.sizes.200.h
- images.nutrition_nl.sizes.200.w
- images.nutrition_nl.sizes.400
- images.nutrition_nl.sizes.400.h
- images.nutrition_nl.sizes.400.w
- images.nutrition_nl.sizes.full
- images.nutrition_nl.sizes.full.h
- images.nutrition_nl.sizes.full.w
- images.nutrition_nl.white_magic
- images.nutrition_nl.x1
- images.nutrition_nl.x2
- images.nutrition_nl.y1
- images.nutrition_nl.y2
- images.nutrition.geometry
- images.nutrition.imgid
- images.nutrition.normalize
- images.nutrition.ocr
- images.nutrition.orientation
- images.nutrition.rev
- images.nutrition.sizes
- images.nutrition.sizes.100
- images.nutrition.sizes.100.h
- images.nutrition.sizes.100.w
- images.nutrition.sizes.200
- images.nutrition.sizes.200.h
- images.nutrition.sizes.200.w
- images.nutrition.sizes.400
- images.nutrition.sizes.400.h
- images.nutrition.sizes.400.w
- images.nutrition.sizes.full
- images.nutrition.sizes.full.h
- images.nutrition.sizes.full.w
- images.nutrition.white_magic
- images.packaging_en
- images.packaging_en.angle
- images.packaging_en.coordinates_image_size
- images.packaging_en.geometry
- images.packaging_en.imgid
- images.packaging_en.normalize
- images.packaging_en.rev
- images.packaging_en.sizes
- images.packaging_en.sizes.100
- images.packaging_en.sizes.100.h
- images.packaging_en.sizes.100.w
- images.packaging_en.sizes.200
- images.packaging_en.sizes.200.h
- images.packaging_en.sizes.200.w
- images.packaging_en.sizes.400
- images.packaging_en.sizes.400.h
- images.packaging_en.sizes.400.w
- images.packaging_en.sizes.full
- images.packaging_en.sizes.full.h
- images.packaging_en.sizes.full.w
- images.packaging_en.white_magic
- images.packaging_en.x1
- images.packaging_en.x2
- images.packaging_en.y1
- images.packaging_en.y2
- images.packaging_fr
- images.packaging_fr.angle
- images.packaging_fr.coordinates_image_size
- images.packaging_fr.geometry
- images.packaging_fr.imgid
- images.packaging_fr.normalize
- images.packaging_fr.rev
- images.packaging_fr.sizes
- images.packaging_fr.sizes.100
- images.packaging_fr.sizes.100.h
- images.packaging_fr.sizes.100.w
- images.packaging_fr.sizes.200
- images.packaging_fr.sizes.200.h
- images.packaging_fr.sizes.200.w
- images.packaging_fr.sizes.400
- images.packaging_fr.sizes.400.h
- images.packaging_fr.sizes.400.w
- images.packaging_fr.sizes.full
- images.packaging_fr.sizes.full.h
- images.packaging_fr.sizes.full.w
- images.packaging_fr.white_magic
- images.packaging_fr.x1
- images.packaging_fr.x2
- images.packaging_fr.y1
- images.packaging_fr.y2
- images.selected
- images.selected.front
- images.selected.front.ar
- images.selected.front.ar.generation
- images.selected.front.ar.imgid
- images.selected.front.ar.rev
- images.selected.front.ar.sizes
- images.selected.front.ar.sizes.100
- images.selected.front.ar.sizes.200
- images.selected.front.ar.sizes.400
- images.selected.front.ar.sizes.full
- images.selected.front.cs
- images.selected.front.cs.generation
- images.selected.front.cs.imgid
- images.selected.front.cs.rev
- images.selected.front.cs.sizes
- images.selected.front.cs.sizes.100
- images.selected.front.cs.sizes.200
- images.selected.front.cs.sizes.400
- images.selected.front.cs.sizes.full
- images.selected.front.da
- images.selected.front.da.generation
- images.selected.front.da.imgid
- images.selected.front.da.rev
- images.selected.front.da.sizes
- images.selected.front.da.sizes.100
- images.selected.front.da.sizes.200
- images.selected.front.da.sizes.400
- images.selected.front.da.sizes.full
- images.selected.front.en
- images.selected.front.en.generation
- images.selected.front.en.generation.angle
- images.selected.front.en.generation.coordinates_image_size
- images.selected.front.en.generation.x1
- images.selected.front.en.generation.x2
- images.selected.front.en.generation.y1
- images.selected.front.en.generation.y2
- images.selected.front.en.imgid
- images.selected.front.en.rev
- images.selected.front.en.sizes
- images.selected.front.en.sizes.100
- images.selected.front.en.sizes.200
- images.selected.front.en.sizes.400
- images.selected.front.en.sizes.full
- images.selected.front.es
- images.selected.front.es.generation
- images.selected.front.es.generation.coordinates_image_size
- images.selected.front.es.generation.x1
- images.selected.front.es.generation.x2
- images.selected.front.es.generation.y1
- images.selected.front.es.generation.y2
- images.selected.front.es.imgid
- images.selected.front.es.rev
- images.selected.front.es.sizes
- images.selected.front.es.sizes.100
- images.selected.front.es.sizes.200
- images.selected.front.es.sizes.400
- images.selected.front.es.sizes.full
- images.selected.front.fr
- images.selected.front.fr.generation
- images.selected.front.fr.generation.angle
- images.selected.front.fr.generation.coordinates_image_size
- images.selected.front.fr.generation.x1
- images.selected.front.fr.generation.x2
- images.selected.front.fr.generation.y1
- images.selected.front.fr.generation.y2
- images.selected.front.fr.imgid
- images.selected.front.fr.rev
- images.selected.front.fr.sizes
- images.selected.front.fr.sizes.100
- images.selected.front.fr.sizes.200
- images.selected.front.fr.sizes.400
- images.selected.front.fr.sizes.full
- images.selected.front.it
- images.selected.front.it.generation
- images.selected.front.it.generation.coordinates_image_size
- images.selected.front.it.generation.x1
- images.selected.front.it.generation.x2
- images.selected.front.it.generation.y1
- images.selected.front.it.generation.y2
- images.selected.front.it.imgid
- images.selected.front.it.rev
- images.selected.front.it.sizes
- images.selected.front.it.sizes.100
- images.selected.front.it.sizes.200
- images.selected.front.it.sizes.400
- images.selected.front.it.sizes.full
- images.selected.front.la
- images.selected.front.la.generation
- images.selected.front.la.imgid
- images.selected.front.la.rev
- images.selected.front.la.sizes
- images.selected.front.la.sizes.100
- images.selected.front.la.sizes.200
- images.selected.front.la.sizes.400
- images.selected.front.la.sizes.full
- images.selected.front.pt
- images.selected.front.pt.generation
- images.selected.front.pt.imgid
- images.selected.front.pt.rev
- images.selected.front.pt.sizes
- images.selected.front.pt.sizes.100
- images.selected.front.pt.sizes.200
- images.selected.front.pt.sizes.400
- images.selected.front.pt.sizes.full
- images.selected.front.th
- images.selected.front.th.generation
- images.selected.front.th.generation.coordinates_image_size
- images.selected.front.th.generation.x1
- images.selected.front.th.generation.x2
- images.selected.front.th.generation.y1
- images.selected.front.th.generation.y2
- images.selected.front.th.imgid
- images.selected.front.th.rev
- images.selected.front.th.sizes
- images.selected.front.th.sizes.100
- images.selected.front.th.sizes.200
- images.selected.front.th.sizes.400
- images.selected.front.th.sizes.full
- images.selected.ingredients
- images.selected.ingredients.cs
- images.selected.ingredients.cs.generation
- images.selected.ingredients.cs.generation.coordinates_image_size
- images.selected.ingredients.cs.generation.x1
- images.selected.ingredients.cs.generation.x2
- images.selected.ingredients.cs.generation.y1
- images.selected.ingredients.cs.generation.y2
- images.selected.ingredients.cs.imgid
- images.selected.ingredients.cs.rev
- images.selected.ingredients.cs.sizes
- images.selected.ingredients.cs.sizes.100
- images.selected.ingredients.cs.sizes.200
- images.selected.ingredients.cs.sizes.400
- images.selected.ingredients.cs.sizes.full
- images.selected.ingredients.en
- images.selected.ingredients.en.generation
- images.selected.ingredients.en.generation.angle
- images.selected.ingredients.en.generation.coordinates_image_size
- images.selected.ingredients.en.generation.x1
- images.selected.ingredients.en.generation.x2
- images.selected.ingredients.en.generation.y1
- images.selected.ingredients.en.generation.y2
- images.selected.ingredients.en.imgid
- images.selected.ingredients.en.rev
- images.selected.ingredients.en.sizes
- images.selected.ingredients.en.sizes.100
- images.selected.ingredients.en.sizes.200
- images.selected.ingredients.en.sizes.400
- images.selected.ingredients.en.sizes.full
- images.selected.ingredients.es
- images.selected.ingredients.es.generation
- images.selected.ingredients.es.generation.coordinates_image_size
- images.selected.ingredients.es.generation.x1
- images.selected.ingredients.es.generation.x2
- images.selected.ingredients.es.generation.y1
- images.selected.ingredients.es.generation.y2
- images.selected.ingredients.es.imgid
- images.selected.ingredients.es.rev
- images.selected.ingredients.es.sizes
- images.selected.ingredients.es.sizes.100
- images.selected.ingredients.es.sizes.200
- images.selected.ingredients.es.sizes.400
- images.selected.ingredients.es.sizes.full
- images.selected.ingredients.fr
- images.selected.ingredients.fr.generation
- images.selected.ingredients.fr.generation.angle
- images.selected.ingredients.fr.generation.coordinates_image_size
- images.selected.ingredients.fr.generation.x1
- images.selected.ingredients.fr.generation.x2
- images.selected.ingredients.fr.generation.y1
- images.selected.ingredients.fr.generation.y2
- images.selected.ingredients.fr.imgid
- images.selected.ingredients.fr.rev
- images.selected.ingredients.fr.sizes
- images.selected.ingredients.fr.sizes.100
- images.selected.ingredients.fr.sizes.200
- images.selected.ingredients.fr.sizes.400
- images.selected.ingredients.fr.sizes.full
- images.selected.ingredients.nl
- images.selected.ingredients.nl.generation
- images.selected.ingredients.nl.generation.angle
- images.selected.ingredients.nl.generation.coordinates_image_size
- images.selected.ingredients.nl.generation.x1
- images.selected.ingredients.nl.generation.x2
- images.selected.ingredients.nl.generation.y1
- images.selected.ingredients.nl.generation.y2
- images.selected.ingredients.nl.imgid
- images.selected.ingredients.nl.rev
- images.selected.ingredients.nl.sizes
- images.selected.ingredients.nl.sizes.100
- images.selected.ingredients.nl.sizes.200
- images.selected.ingredients.nl.sizes.400
- images.selected.ingredients.nl.sizes.full
- images.selected.ingredients.th
- images.selected.ingredients.th.generation
- images.selected.ingredients.th.generation.coordinates_image_size
- images.selected.ingredients.th.generation.x1
- images.selected.ingredients.th.generation.x2
- images.selected.ingredients.th.generation.y1
- images.selected.ingredients.th.generation.y2
- images.selected.ingredients.th.imgid
- images.selected.ingredients.th.rev
- images.selected.ingredients.th.sizes
- images.selected.ingredients.th.sizes.100
- images.selected.ingredients.th.sizes.200
- images.selected.ingredients.th.sizes.400
- images.selected.ingredients.th.sizes.full
- images.selected.nutrition
- images.selected.nutrition.cs
- images.selected.nutrition.cs.generation
- images.selected.nutrition.cs.imgid
- images.selected.nutrition.cs.rev
- images.selected.nutrition.cs.sizes
- images.selected.nutrition.cs.sizes.100
- images.selected.nutrition.cs.sizes.200
- images.selected.nutrition.cs.sizes.400
- images.selected.nutrition.cs.sizes.full
- images.selected.nutrition.da
- images.selected.nutrition.da.generation
- images.selected.nutrition.da.imgid
- images.selected.nutrition.da.rev
- images.selected.nutrition.da.sizes
- images.selected.nutrition.da.sizes.100
- images.selected.nutrition.da.sizes.200
- images.selected.nutrition.da.sizes.400
- images.selected.nutrition.da.sizes.full
- images.selected.nutrition.en
- images.selected.nutrition.en.generation
- images.selected.nutrition.en.generation.angle
- images.selected.nutrition.en.generation.coordinates_image_size
- images.selected.nutrition.en.generation.x1
- images.selected.nutrition.en.generation.x2
- images.selected.nutrition.en.generation.y1
- images.selected.nutrition.en.generation.y2
- images.selected.nutrition.en.imgid
- images.selected.nutrition.en.rev
- images.selected.nutrition.en.sizes
- images.selected.nutrition.en.sizes.100
- images.selected.nutrition.en.sizes.200
- images.selected.nutrition.en.sizes.400
- images.selected.nutrition.en.sizes.full
- images.selected.nutrition.es
- images.selected.nutrition.es.generation
- images.selected.nutrition.es.generation.coordinates_image_size
- images.selected.nutrition.es.generation.x1
- images.selected.nutrition.es.generation.x2
- images.selected.nutrition.es.generation.y1
- images.selected.nutrition.es.generation.y2
- images.selected.nutrition.es.imgid
- images.selected.nutrition.es.rev
- images.selected.nutrition.es.sizes
- images.selected.nutrition.es.sizes.100
- images.selected.nutrition.es.sizes.200
- images.selected.nutrition.es.sizes.400
- images.selected.nutrition.es.sizes.full
- images.selected.nutrition.fr
- images.selected.nutrition.fr.generation
- images.selected.nutrition.fr.generation.angle
- images.selected.nutrition.fr.generation.coordinates_image_size
- images.selected.nutrition.fr.generation.x1
- images.selected.nutrition.fr.generation.x2
- images.selected.nutrition.fr.generation.y1
- images.selected.nutrition.fr.generation.y2
- images.selected.nutrition.fr.imgid
- images.selected.nutrition.fr.rev
- images.selected.nutrition.fr.sizes
- images.selected.nutrition.fr.sizes.100
- images.selected.nutrition.fr.sizes.200
- images.selected.nutrition.fr.sizes.400
- images.selected.nutrition.fr.sizes.full
- images.selected.nutrition.it
- images.selected.nutrition.it.generation
- images.selected.nutrition.it.imgid
- images.selected.nutrition.it.rev
- images.selected.nutrition.it.sizes
- images.selected.nutrition.it.sizes.100
- images.selected.nutrition.it.sizes.200
- images.selected.nutrition.it.sizes.400
- images.selected.nutrition.it.sizes.full
- images.selected.nutrition.la
- images.selected.nutrition.la.generation
- images.selected.nutrition.la.imgid
- images.selected.nutrition.la.rev
- images.selected.nutrition.la.sizes
- images.selected.nutrition.la.sizes.100
- images.selected.nutrition.la.sizes.200
- images.selected.nutrition.la.sizes.400
- images.selected.nutrition.la.sizes.full
- images.selected.nutrition.nl
- images.selected.nutrition.nl.generation
- images.selected.nutrition.nl.generation.coordinates_image_size
- images.selected.nutrition.nl.generation.x1
- images.selected.nutrition.nl.generation.x2
- images.selected.nutrition.nl.generation.y1
- images.selected.nutrition.nl.generation.y2
- images.selected.nutrition.nl.imgid
- images.selected.nutrition.nl.rev
- images.selected.nutrition.nl.sizes
- images.selected.nutrition.nl.sizes.100
- images.selected.nutrition.nl.sizes.200
- images.selected.nutrition.nl.sizes.400
- images.selected.nutrition.nl.sizes.full
- images.selected.nutrition.th
- images.selected.nutrition.th.generation
- images.selected.nutrition.th.generation.coordinates_image_size
- images.selected.nutrition.th.generation.x1
- images.selected.nutrition.th.generation.x2
- images.selected.nutrition.th.generation.y1
- images.selected.nutrition.th.generation.y2
- images.selected.nutrition.th.imgid
- images.selected.nutrition.th.rev
- images.selected.nutrition.th.sizes
- images.selected.nutrition.th.sizes.100
- images.selected.nutrition.th.sizes.200
- images.selected.nutrition.th.sizes.400
- images.selected.nutrition.th.sizes.full
- images.selected.packaging
- images.selected.packaging.cs
- images.selected.packaging.cs.generation
- images.selected.packaging.cs.imgid
- images.selected.packaging.cs.rev
- images.selected.packaging.cs.sizes
- images.selected.packaging.cs.sizes.100
- images.selected.packaging.cs.sizes.200
- images.selected.packaging.cs.sizes.400
- images.selected.packaging.cs.sizes.full
- images.selected.packaging.en
- images.selected.packaging.en.generation
- images.selected.packaging.en.generation.angle
- images.selected.packaging.en.generation.coordinates_image_size
- images.selected.packaging.en.generation.x1
- images.selected.packaging.en.generation.x2
- images.selected.packaging.en.generation.y1
- images.selected.packaging.en.generation.y2
- images.selected.packaging.en.imgid
- images.selected.packaging.en.rev
- images.selected.packaging.en.sizes
- images.selected.packaging.en.sizes.100
- images.selected.packaging.en.sizes.200
- images.selected.packaging.en.sizes.400
- images.selected.packaging.en.sizes.full
- images.selected.packaging.fr
- images.selected.packaging.fr.generation
- images.selected.packaging.fr.imgid
- images.selected.packaging.fr.rev
- images.selected.packaging.fr.sizes
- images.selected.packaging.fr.sizes.100
- images.selected.packaging.fr.sizes.200
- images.selected.packaging.fr.sizes.400
- images.selected.packaging.fr.sizes.full
- images.uploaded
- images.uploaded.1
- images.uploaded.1.sizes
- images.uploaded.1.sizes.100
- images.uploaded.1.sizes.100.h
- images.uploaded.1.sizes.100.w
- images.uploaded.1.sizes.400
- images.uploaded.1.sizes.400.h
- images.uploaded.1.sizes.400.w
- images.uploaded.1.sizes.full
- images.uploaded.1.sizes.full.h
- images.uploaded.1.sizes.full.w
- images.uploaded.1.uploaded_t
- images.uploaded.1.uploader
- images.uploaded.10
- images.uploaded.10.sizes
- images.uploaded.10.sizes.100
- images.uploaded.10.sizes.100.h
- images.uploaded.10.sizes.100.w
- images.uploaded.10.sizes.400
- images.uploaded.10.sizes.400.h
- images.uploaded.10.sizes.400.w
- images.uploaded.10.sizes.full
- images.uploaded.10.sizes.full.h
- images.uploaded.10.sizes.full.w
- images.uploaded.10.uploaded_t
- images.uploaded.10.uploader
- images.uploaded.11
- images.uploaded.11.sizes
- images.uploaded.11.sizes.100
- images.uploaded.11.sizes.100.h
- images.uploaded.11.sizes.100.w
- images.uploaded.11.sizes.400
- images.uploaded.11.sizes.400.h
- images.uploaded.11.sizes.400.w
- images.uploaded.11.sizes.full
- images.uploaded.11.sizes.full.h
- images.uploaded.11.sizes.full.w
- images.uploaded.11.uploaded_t
- images.uploaded.11.uploader
- images.uploaded.12
- images.uploaded.12.sizes
- images.uploaded.12.sizes.100
- images.uploaded.12.sizes.100.h
- images.uploaded.12.sizes.100.w
- images.uploaded.12.sizes.400
- images.uploaded.12.sizes.400.h
- images.uploaded.12.sizes.400.w
- images.uploaded.12.sizes.full
- images.uploaded.12.sizes.full.h
- images.uploaded.12.sizes.full.w
- images.uploaded.12.uploaded_t
- images.uploaded.12.uploader
- images.uploaded.13
- images.uploaded.13.sizes
- images.uploaded.13.sizes.100
- images.uploaded.13.sizes.100.h
- images.uploaded.13.sizes.100.w
- images.uploaded.13.sizes.400
- images.uploaded.13.sizes.400.h
- images.uploaded.13.sizes.400.w
- images.uploaded.13.sizes.full
- images.uploaded.13.sizes.full.h
- images.uploaded.13.sizes.full.w
- images.uploaded.13.uploaded_t
- images.uploaded.13.uploader
- images.uploaded.14
- images.uploaded.14.sizes
- images.uploaded.14.sizes.100
- images.uploaded.14.sizes.100.h
- images.uploaded.14.sizes.100.w
- images.uploaded.14.sizes.400
- images.uploaded.14.sizes.400.h
- images.uploaded.14.sizes.400.w
- images.uploaded.14.sizes.full
- images.uploaded.14.sizes.full.h
- images.uploaded.14.sizes.full.w
- images.uploaded.14.uploaded_t
- images.uploaded.14.uploader
- images.uploaded.15
- images.uploaded.15.sizes
- images.uploaded.15.sizes.100
- images.uploaded.15.sizes.100.h
- images.uploaded.15.sizes.100.w
- images.uploaded.15.sizes.400
- images.uploaded.15.sizes.400.h
- images.uploaded.15.sizes.400.w
- images.uploaded.15.sizes.full
- images.uploaded.15.sizes.full.h
- images.uploaded.15.sizes.full.w
- images.uploaded.15.uploaded_t
- images.uploaded.15.uploader
- images.uploaded.16
- images.uploaded.16.sizes
- images.uploaded.16.sizes.100
- images.uploaded.16.sizes.100.h
- images.uploaded.16.sizes.100.w
- images.uploaded.16.sizes.400
- images.uploaded.16.sizes.400.h
- images.uploaded.16.sizes.400.w
- images.uploaded.16.sizes.full
- images.uploaded.16.sizes.full.h
- images.uploaded.16.sizes.full.w
- images.uploaded.16.uploaded_t
- images.uploaded.16.uploader
- images.uploaded.17
- images.uploaded.17.sizes
- images.uploaded.17.sizes.100
- images.uploaded.17.sizes.100.h
- images.uploaded.17.sizes.100.w
- images.uploaded.17.sizes.400
- images.uploaded.17.sizes.400.h
- images.uploaded.17.sizes.400.w
- images.uploaded.17.sizes.full
- images.uploaded.17.sizes.full.h
- images.uploaded.17.sizes.full.w
- images.uploaded.17.uploaded_t
- images.uploaded.17.uploader
- images.uploaded.18
- images.uploaded.18.sizes
- images.uploaded.18.sizes.100
- images.uploaded.18.sizes.100.h
- images.uploaded.18.sizes.100.w
- images.uploaded.18.sizes.400
- images.uploaded.18.sizes.400.h
- images.uploaded.18.sizes.400.w
- images.uploaded.18.sizes.full
- images.uploaded.18.sizes.full.h
- images.uploaded.18.sizes.full.w
- images.uploaded.18.uploaded_t
- images.uploaded.18.uploader
- images.uploaded.19
- images.uploaded.19.sizes
- images.uploaded.19.sizes.100
- images.uploaded.19.sizes.100.h
- images.uploaded.19.sizes.100.w
- images.uploaded.19.sizes.400
- images.uploaded.19.sizes.400.h
- images.uploaded.19.sizes.400.w
- images.uploaded.19.sizes.full
- images.uploaded.19.sizes.full.h
- images.uploaded.19.sizes.full.w
- images.uploaded.19.uploaded_t
- images.uploaded.19.uploader
- images.uploaded.2
- images.uploaded.2.sizes
- images.uploaded.2.sizes.100
- images.uploaded.2.sizes.100.h
- images.uploaded.2.sizes.100.w
- images.uploaded.2.sizes.400
- images.uploaded.2.sizes.400.h
- images.uploaded.2.sizes.400.w
- images.uploaded.2.sizes.full
- images.uploaded.2.sizes.full.h
- images.uploaded.2.sizes.full.w
- images.uploaded.2.uploaded_t
- images.uploaded.2.uploader
- images.uploaded.20
- images.uploaded.20.sizes
- images.uploaded.20.sizes.100
- images.uploaded.20.sizes.100.h
- images.uploaded.20.sizes.100.w
- images.uploaded.20.sizes.400
- images.uploaded.20.sizes.400.h
- images.uploaded.20.sizes.400.w
- images.uploaded.20.sizes.full
- images.uploaded.20.sizes.full.h
- images.uploaded.20.sizes.full.w
- images.uploaded.20.uploaded_t
- images.uploaded.20.uploader
- images.uploaded.21
- images.uploaded.21.sizes
- images.uploaded.21.sizes.100
- images.uploaded.21.sizes.100.h
- images.uploaded.21.sizes.100.w
- images.uploaded.21.sizes.400
- images.uploaded.21.sizes.400.h
- images.uploaded.21.sizes.400.w
- images.uploaded.21.sizes.full
- images.uploaded.21.sizes.full.h
- images.uploaded.21.sizes.full.w
- images.uploaded.21.uploaded_t
- images.uploaded.21.uploader
- images.uploaded.22
- images.uploaded.22.sizes
- images.uploaded.22.sizes.100
- images.uploaded.22.sizes.100.h
- images.uploaded.22.sizes.100.w
- images.uploaded.22.sizes.400
- images.uploaded.22.sizes.400.h
- images.uploaded.22.sizes.400.w
- images.uploaded.22.sizes.full
- images.uploaded.22.sizes.full.h
- images.uploaded.22.sizes.full.w
- images.uploaded.22.uploaded_t
- images.uploaded.22.uploader
- images.uploaded.23
- images.uploaded.23.sizes
- images.uploaded.23.sizes.100
- images.uploaded.23.sizes.100.h
- images.uploaded.23.sizes.100.w
- images.uploaded.23.sizes.400
- images.uploaded.23.sizes.400.h
- images.uploaded.23.sizes.400.w
- images.uploaded.23.sizes.full
- images.uploaded.23.sizes.full.h
- images.uploaded.23.sizes.full.w
- images.uploaded.23.uploaded_t
- images.uploaded.23.uploader
- images.uploaded.3
- images.uploaded.3.sizes
- images.uploaded.3.sizes.100
- images.uploaded.3.sizes.100.h
- images.uploaded.3.sizes.100.w
- images.uploaded.3.sizes.400
- images.uploaded.3.sizes.400.h
- images.uploaded.3.sizes.400.w
- images.uploaded.3.sizes.full
- images.uploaded.3.sizes.full.h
- images.uploaded.3.sizes.full.w
- images.uploaded.3.uploaded_t
- images.uploaded.3.uploader
- images.uploaded.4
- images.uploaded.4.sizes
- images.uploaded.4.sizes.100
- images.uploaded.4.sizes.100.h
- images.uploaded.4.sizes.100.w
- images.uploaded.4.sizes.400
- images.uploaded.4.sizes.400.h
- images.uploaded.4.sizes.400.w
- images.uploaded.4.sizes.full
- images.uploaded.4.sizes.full.h
- images.uploaded.4.sizes.full.w
- images.uploaded.4.uploaded_t
- images.uploaded.4.uploader
- images.uploaded.5
- images.uploaded.5.sizes
- images.uploaded.5.sizes.100
- images.uploaded.5.sizes.100.h
- images.uploaded.5.sizes.100.w
- images.uploaded.5.sizes.400
- images.uploaded.5.sizes.400.h
- images.uploaded.5.sizes.400.w
- images.uploaded.5.sizes.full
- images.uploaded.5.sizes.full.h
- images.uploaded.5.sizes.full.w
- images.uploaded.5.uploaded_t
- images.uploaded.5.uploader
- images.uploaded.6
- images.uploaded.6.sizes
- images.uploaded.6.sizes.100
- images.uploaded.6.sizes.100.h
- images.uploaded.6.sizes.100.w
- images.uploaded.6.sizes.400
- images.uploaded.6.sizes.400.h
- images.uploaded.6.sizes.400.w
- images.uploaded.6.sizes.full
- images.uploaded.6.sizes.full.h
- images.uploaded.6.sizes.full.w
- images.uploaded.6.uploaded_t
- images.uploaded.6.uploader
- images.uploaded.7
- images.uploaded.7.sizes
- images.uploaded.7.sizes.100
- images.uploaded.7.sizes.100.h
- images.uploaded.7.sizes.100.w
- images.uploaded.7.sizes.400
- images.uploaded.7.sizes.400.h
- images.uploaded.7.sizes.400.w
- images.uploaded.7.sizes.full
- images.uploaded.7.sizes.full.h
- images.uploaded.7.sizes.full.w
- images.uploaded.7.uploaded_t
- images.uploaded.7.uploader
- images.uploaded.8
- images.uploaded.8.sizes
- images.uploaded.8.sizes.100
- images.uploaded.8.sizes.100.h
- images.uploaded.8.sizes.100.w
- images.uploaded.8.sizes.400
- images.uploaded.8.sizes.400.h
- images.uploaded.8.sizes.400.w
- images.uploaded.8.sizes.full
- images.uploaded.8.sizes.full.h
- images.uploaded.8.sizes.full.w
- images.uploaded.8.uploaded_t
- images.uploaded.8.uploader
- images.uploaded.9
- images.uploaded.9.sizes
- images.uploaded.9.sizes.100
- images.uploaded.9.sizes.100.h
- images.uploaded.9.sizes.100.w
- images.uploaded.9.sizes.400
- images.uploaded.9.sizes.400.h
- images.uploaded.9.sizes.400.w
- images.uploaded.9.sizes.full
- images.uploaded.9.sizes.full.h
- images.uploaded.9.sizes.full.w
- images.uploaded.9.uploaded_t
- images.uploaded.9.uploader
- last_image_dates_tags
- last_image_dates_tags[]
- last_image_t
- max_imgid
- sources[].images

