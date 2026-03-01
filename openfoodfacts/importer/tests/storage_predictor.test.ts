import test from "node:test";
import assert from "node:assert/strict";
import {
  predictStorageType,
  type StorageRules
} from "../src/mapping/storage_predictor.js";
import type { ProductJson } from "../src/mapping/off_to_product.js";

const rules: StorageRules = {
  version: 1,
  storageTypes: ["fridge", "freezer", "shelf", "pantry", "room_temp"],
  confidenceLevels: ["high", "medium", "low"],
  categoryRules: [
    {
      matchSubContains: ["frozen"],
      storageType: "freezer",
      confidence: "high",
      reason: "subcategory contains frozen"
    },
    {
      matchSubAny: ["grains pasta and rice"],
      storageType: "shelf",
      confidence: "medium",
      reason: "typical shelf-stable category"
    }
  ],
  textRules: {
    freezer: { high: ["keep frozen", "frozen"], medium: ["freezer"] },
    fridge: { high: ["keep refrigerated"], medium: ["fridge"] },
    shelf: { high: ["cool dry place"], medium: ["dry place"] }
  },
  fallback: { confidence: "low", reason: "no storage rule matched" },
  limits: { reasonMaxLength: 120 }
};

function baseProduct(overrides: Partial<ProductJson> = {}): ProductJson {
  return {
    productId: "test-1",
    title: "Test Product",
    images: [],
    attributes: {},
    qualitySignals: {
      needsManualReview: false,
      hasFrontImage: false,
      hasIngredientImage: false,
      hasNutritionImage: false
    },
    source: "importedFeed",
    status: "active",
    createdAt: "2026-03-01T00:00:00.000Z",
    updatedAt: "2026-03-01T00:00:00.000Z",
    version: 1,
    ...overrides
  };
}

test("title contains frozen -> freezer/high", () => {
  const product = baseProduct({ title: "Frozen Spinach" });
  const result = predictStorageType({ product }, rules);
  assert.equal(result.storageType, "freezer");
  assert.equal(result.confidence, "high");
});

test("storage instructions keep refrigerated -> fridge/high", () => {
  const product = baseProduct({ storageInstructions: "Keep refrigerated after opening" });
  const result = predictStorageType({ product }, rules);
  assert.equal(result.storageType, "fridge");
  assert.equal(result.confidence, "high");
});

test("subcategory Frozen Vegetables -> freezer/high", () => {
  const product = baseProduct({ category: { main: "food", sub: "Frozen Vegetables" } });
  const result = predictStorageType({ product }, rules);
  assert.equal(result.storageType, "freezer");
  assert.equal(result.confidence, "high");
});

test("subcategory grains pasta and rice -> shelf/medium", () => {
  const product = baseProduct({ category: { main: "food", sub: "grains pasta and rice" } });
  const result = predictStorageType({ product }, rules);
  assert.equal(result.storageType, "shelf");
  assert.equal(result.confidence, "medium");
});

test("no signals -> no prediction", () => {
  const product = baseProduct({ title: undefined, brand: undefined, category: undefined });
  const result = predictStorageType({ product }, rules);
  assert.equal(result.storageType, undefined);
  assert.equal(result.confidence, undefined);
});
