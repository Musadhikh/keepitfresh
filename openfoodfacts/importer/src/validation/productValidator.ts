import type { ProductJson } from "../mapping/off_to_product.js";

interface FieldDef {
  name: string;
  type: string;
  optional?: boolean;
  fields?: FieldDef[];
}

export interface ContractSnapshot {
  enums?: Record<string, string[]>;
  collections?: {
    ProductCatalog?: {
      fields?: FieldDef[];
    };
  };
}

export interface ValidationFailure {
  field: string;
  reason: string;
}

function isMissing(value: unknown): boolean {
  return value === undefined || value === null || (typeof value === "string" && value.trim() === "");
}

function enumNameFromType(type: string): string | undefined {
  const prefix = "enum:";
  return type.startsWith(prefix) ? type.slice(prefix.length) : undefined;
}

export function validateProductAgainstContract(
  product: ProductJson,
  contract: ContractSnapshot
): ValidationFailure[] {
  const failures: ValidationFailure[] = [];

  const fields = contract.collections?.ProductCatalog?.fields ?? [];
  const enums = contract.enums ?? {};

  const productRecord = product as unknown as Record<string, unknown>;

  for (const field of fields) {
    const value = productRecord[field.name];

    if (field.optional !== true && isMissing(value)) {
      failures.push({ field: field.name, reason: "required_missing" });
      continue;
    }

    const enumName = enumNameFromType(field.type);
    if (enumName && typeof value === "string") {
      const allowed = enums[enumName] ?? [];
      if (!allowed.includes(value)) {
        failures.push({ field: field.name, reason: `invalid_enum:${value}` });
      }
    }

    if (field.type === "object" && field.fields && value && typeof value === "object" && !Array.isArray(value)) {
      const obj = value as Record<string, unknown>;
      for (const child of field.fields) {
        const childValue = obj[child.name];
        if (child.optional !== true && isMissing(childValue)) {
          failures.push({ field: `${field.name}.${child.name}`, reason: "required_missing" });
        }

        const childEnum = enumNameFromType(child.type);
        if (childEnum && typeof childValue === "string") {
          const allowed = enums[childEnum] ?? [];
          if (!allowed.includes(childValue)) {
            failures.push({ field: `${field.name}.${child.name}`, reason: `invalid_enum:${childValue}` });
          }
        }
      }
    }
  }

  if (product.productDetails) {
    if (!product.productDetails.kind) {
      failures.push({ field: "productDetails.kind", reason: "required_missing" });
    }
    if (!("value" in product.productDetails)) {
      failures.push({ field: "productDetails.value", reason: "required_missing" });
    }
  }

  return failures;
}
