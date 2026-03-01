import { createHash } from "node:crypto";

function canonicalize(value: unknown): unknown {
  if (Array.isArray(value)) {
    return value.map(canonicalize);
  }

  if (value && typeof value === "object") {
    const sortedEntries = Object.entries(value as Record<string, unknown>)
      .sort(([a], [b]) => a.localeCompare(b))
      .map(([k, v]) => [k, canonicalize(v)] as const);

    return Object.fromEntries(sortedEntries);
  }

  return value;
}

export function stableHashObject(input: unknown): string {
  const canonical = canonicalize(input);
  const payload = JSON.stringify(canonical);
  return createHash("sha256").update(payload).digest("hex");
}
