# OpenFoodFacts Importer Docs

## What this folder contains
- `product_storage_contract_v1.md`: Human-readable canonical Product storage contract.
- `product_storage_contract_v1.json`: Machine-readable contract snapshot for tooling/validation.
- `README_HANDOFF.md`: Operational handoff skeleton.

## Contract purpose
The Product storage contract is platform-agnostic and is the single source of truth for:
- Importer payload shaping
- Firestore JSON persistence shape
- Client parsing expectations (iOS/Android/Web)

Canonical model source in app code:
- `iOS/Packages/ProductModule/Sources/ProductDomain/Models/*`

## Change management
Any Product contract change must include all of:
1. Update `product_storage_contract_v1.md`
2. Update `product_storage_contract_v1.json`
3. Record the change in this README under Changelog
4. Add migration notes for importer/client compatibility

Breaking changes must create a new contract version (`product_storage_contract_v2.*`).

## Changelog
- 2026-03-01: Added `product_storage_contract_v1.md` and `product_storage_contract_v1.json` (Phase 1).

## Phase notes
- Phase 0: importer scaffold + safety guardrails (no uploads)
- Phase 1: canonical Product storage contract docs (no uploads)
