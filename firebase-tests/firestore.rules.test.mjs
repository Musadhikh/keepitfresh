import assert from 'node:assert/strict';
import fs from 'node:fs/promises';
import path from 'node:path';
import {
  assertFails,
  assertSucceeds,
  initializeTestEnvironment
} from '@firebase/rules-unit-testing';
import { doc, getDoc, setDoc } from 'firebase/firestore';

const projectId = process.env.FIREBASE_PROJECT_ID ?? 'demo-keepitfresh';
const rulesPath = path.resolve(process.cwd(), '..', 'firestore.rules');

let testEnv;

async function setup() {
  const rules = await fs.readFile(rulesPath, 'utf8');
  testEnv = await initializeTestEnvironment({
    projectId,
    firestore: {
      rules,
      host: process.env.FIRESTORE_EMULATOR_HOST?.split(':')[0] ?? '127.0.0.1',
      port: Number(process.env.FIRESTORE_EMULATOR_HOST?.split(':')[1] ?? 8080)
    }
  });
}

async function teardown() {
  if (testEnv) {
    await testEnv.cleanup();
  }
}

async function clearData() {
  await testEnv.clearFirestore();
}

async function seedHouse({ houseId, ownerId, memberIds }) {
  await testEnv.withSecurityRulesDisabled(async (context) => {
    const adminDb = context.firestore();
    await setDoc(doc(adminDb, 'Houses', houseId), {
      id: houseId,
      ownerId,
      memberIds,
      name: 'Test House',
      createdAt: new Date(),
      updatedAt: new Date()
    });
  });
}

async function testProfileRules() {
  await clearData();

  const aliceDb = testEnv.authenticatedContext('alice').firestore();
  const bobDb = testEnv.authenticatedContext('bob').firestore();

  await assertSucceeds(
    setDoc(doc(aliceDb, 'Profiles', 'alice'), {
      userId: 'alice',
      fullName: 'Alice'
    })
  );

  await assertFails(getDoc(doc(aliceDb, 'Profiles', 'bob')));
  await assertFails(getDoc(doc(bobDb, 'Profiles', 'alice')));
}

async function testHousePurchaseRules() {
  await clearData();

  await seedHouse({
    houseId: 'house-1',
    ownerId: 'owner-1',
    memberIds: ['owner-1', 'member-1']
  });

  const memberDb = testEnv.authenticatedContext('member-1').firestore();
  const outsiderDb = testEnv.authenticatedContext('outsider-1').firestore();

  const purchaseRef = doc(memberDb, 'Houses', 'house-1', 'Purchases', 'batch-1');

  await assertSucceeds(
    setDoc(purchaseRef, {
      id: 'batch-1',
      householdId: 'house-1',
      status: 'active'
    })
  );

  const outsiderPurchaseRef = doc(outsiderDb, 'Houses', 'house-1', 'Purchases', 'batch-1');
  await assertFails(getDoc(outsiderPurchaseRef));
  await assertFails(
    setDoc(outsiderPurchaseRef, {
      id: 'batch-1',
      householdId: 'house-1',
      status: 'active'
    })
  );
}

async function testProductCatalogRules() {
  await clearData();

  const anonDb = testEnv.unauthenticatedContext().firestore();
  const userDb = testEnv.authenticatedContext('user-1').firestore();

  await assertFails(
    setDoc(doc(anonDb, 'ProductCatalog', 'prod-1'), {
      id: 'prod-1',
      barcode: '1234567890'
    })
  );

  await assertSucceeds(
    setDoc(doc(userDb, 'ProductCatalog', 'prod-1'), {
      id: 'prod-1',
      barcode: '1234567890',
      title: 'Milk'
    })
  );

  await assertFails(getDoc(doc(anonDb, 'ProductCatalog', 'prod-1')));
  await assertSucceeds(getDoc(doc(userDb, 'ProductCatalog', 'prod-1')));
}

async function testAppMetadataRules() {
  await clearData();

  const anonDb = testEnv.unauthenticatedContext().firestore();
  const userDb = testEnv.authenticatedContext('user-1').firestore();

  await testEnv.withSecurityRulesDisabled(async (context) => {
    const adminDb = context.firestore();
    await setDoc(doc(adminDb, 'AppMetadata', 'current'), {
      minimumVersion: '1.0.0',
      latestVersion: '1.1.0'
    });
  });

  await assertSucceeds(getDoc(doc(anonDb, 'AppMetadata', 'current')));
  await assertFails(
    setDoc(doc(userDb, 'AppMetadata', 'current'), {
      minimumVersion: '9.9.9'
    })
  );
}

async function run() {
  await setup();
  try {
    await testProfileRules();
    await testHousePurchaseRules();
    await testProductCatalogRules();
    await testAppMetadataRules();
    console.log('All Firestore rules tests passed.');
  } finally {
    await teardown();
  }
}

run().catch((error) => {
  console.error('Firestore rules tests failed.');
  console.error(error);
  process.exitCode = 1;
});
