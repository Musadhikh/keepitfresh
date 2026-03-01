export function normalizeCategorySignal(value: string): string {
  return value
    .toLowerCase()
    .trim()
    .replace(/[|>\\]/g, "/")
    .replace(/\s*\/\s*/g, "/")
    .replace(/\s+/g, " ")
    .replace(/\/+/g, "/")
    .replace(/^\/+|\/+$/g, "");
}

export function extractValuesByPath(root: unknown, path: string): unknown[] {
  const segments = path.split(".");

  function walk(current: unknown, index: number): unknown[] {
    if (index >= segments.length) {
      return [current];
    }

    const segment = segments[index];
    const isArray = segment.endsWith("[]");
    const key = isArray ? segment.slice(0, -2) : segment;

    if (Array.isArray(current)) {
      const acc: unknown[] = [];
      for (const item of current) {
        acc.push(...walk(item, index));
      }
      return acc;
    }

    if (!current || typeof current !== "object") {
      return [];
    }

    const next = (current as Record<string, unknown>)[key];
    if (next === undefined) return [];

    if (isArray) {
      if (!Array.isArray(next)) return [];
      const acc: unknown[] = [];
      for (const item of next) {
        acc.push(...walk(item, index + 1));
      }
      return acc;
    }

    return walk(next, index + 1);
  }

  return walk(root, 0);
}

export function flattenStringSignals(value: unknown): string[] {
  if (typeof value === "string") {
    return [value];
  }

  if (Array.isArray(value)) {
    return value.flatMap(flattenStringSignals);
  }

  if (value && typeof value === "object") {
    return Object.values(value as Record<string, unknown>).flatMap(flattenStringSignals);
  }

  return [];
}

export function isLikelyPathSignal(value: string): boolean {
  return value.includes("/") || value.split(" ").length >= 2;
}
