# Firestore Rules Test Harness

This folder contains emulator-backed security rules tests using `@firebase/rules-unit-testing`.

## Prerequisites

- Node.js 20+
- Firebase CLI (`firebase`)

## Install

```bash
cd keepitfresh/firebase-tests
npm install
```

## Run tests (with emulator bootstrapped by Firebase CLI)

```bash
npm run test:emulator
```

## Alternative manual run

If Firestore emulator is already running on `127.0.0.1:8080`:

```bash
FIRESTORE_EMULATOR_HOST=127.0.0.1:8080 npm test
```

## What is covered

- `Profiles/{userId}`: users can only read/write their own profile.
- `Houses/{houseId}` and `Houses/{houseId}/Purchases/{purchaseId}`: only house members can read/write.
- `ProductCatalog/{productId}`: authenticated read/write only.
- `AppMetadata/{docId}`: public read, write denied.
