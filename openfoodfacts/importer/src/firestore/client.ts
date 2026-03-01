import { createRequire } from "node:module";
import { readFile } from "node:fs/promises";
import type { ImporterConfig } from "../core/types.js";
import type { FirestoreLike } from "./types.js";

let cachedReady = false;
const require = createRequire(import.meta.url);

interface ServiceAccountLike {
  project_id?: string;
  client_email?: string;
  private_key?: string;
}

interface FirebaseAppModuleLike {
  cert: (serviceAccount: ServiceAccountLike) => unknown;
  getApps: () => unknown[];
  initializeApp: (options: { credential: unknown; projectId?: string }) => unknown;
}

interface FirebaseFirestoreModuleLike {
  getFirestore: () => FirestoreLike;
}

function loadFirebaseModules(): {
  app: FirebaseAppModuleLike;
  firestore: FirebaseFirestoreModuleLike;
} {
  const app = require("firebase-admin/app") as FirebaseAppModuleLike;
  const firestore = require("firebase-admin/firestore") as FirebaseFirestoreModuleLike;
  return { app, firestore };
}

async function loadServiceAccount(config: ImporterConfig): Promise<ServiceAccountLike> {
  if (config.firebaseServiceAccountJson) {
    return JSON.parse(config.firebaseServiceAccountJson) as ServiceAccountLike;
  }

  if (config.firebaseServiceAccountPath) {
    const raw = await readFile(config.firebaseServiceAccountPath, "utf8");
    return JSON.parse(raw) as ServiceAccountLike;
  }

  throw new Error("Missing Firebase service account configuration.");
}

async function ensureInitialized(config: ImporterConfig): Promise<void> {
  if (cachedReady) return;
  const { app } = loadFirebaseModules();
  if (app.getApps().length > 0) {
    cachedReady = true;
    return;
  }

  if (!config.firebaseProjectId) {
    throw new Error("FIREBASE_PROJECT_ID is required for Firestore initialization.");
  }

  const serviceAccount = await loadServiceAccount(config);

  app.initializeApp({
    credential: app.cert(serviceAccount),
    projectId: config.firebaseProjectId
  });

  cachedReady = true;
}

export async function getFirestore(config: ImporterConfig): Promise<FirestoreLike> {
  await ensureInitialized(config);
  const { firestore } = loadFirebaseModules();
  return firestore.getFirestore();
}

export function isFirestoreReady(): boolean {
  if (cachedReady) return true;

  try {
    const { app } = loadFirebaseModules();
    return app.getApps().length > 0;
  } catch {
    return false;
  }
}
