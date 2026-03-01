import { readFile, writeFile } from "node:fs/promises";
import { logger } from "../../core/logger.js";
import { resolveFromImporterRoot } from "../../core/paths.js";
import { nowISO } from "../../utils/time.js";
import { validateProductAgainstContract, type ContractSnapshot } from "../../validation/productValidator.js";

interface Failure {
  index: number;
  productId?: string;
  field: string;
  reason: string;
}

export interface ValidateProductsArgs {
  in?: string;
  contract?: string;
  out?: string;
}

export async function runValidateProductsCommand(args: ValidateProductsArgs): Promise<void> {
  const inPath = resolveFromImporterRoot(args.in ?? "output/product_sample_100.json");
  const contractPath = resolveFromImporterRoot(args.contract ?? "docs/product_storage_contract_v1.json");
  const outPath = resolveFromImporterRoot(args.out ?? "output/validation_report.md");

  const products = JSON.parse(await readFile(inPath, "utf8")) as unknown[];
  const contract = JSON.parse(await readFile(contractPath, "utf8")) as ContractSnapshot;

  if (!Array.isArray(products)) {
    throw new Error(`Expected product array at ${inPath}`);
  }

  const failures: Failure[] = [];

  products.forEach((row, index) => {
    if (!row || typeof row !== "object" || Array.isArray(row)) {
      failures.push({ index, field: "$root", reason: "invalid_payload_shape" });
      return;
    }

    const product = row as Record<string, unknown>;
    const productId = typeof product.productId === "string" ? product.productId : undefined;

    validateProductAgainstContract(row as never, contract).forEach((issue) => {
      failures.push({ index, productId, field: issue.field, reason: issue.reason });
    });
  });

  const failureByField = failures.reduce<Record<string, number>>((acc, f) => {
    acc[f.field] = (acc[f.field] ?? 0) + 1;
    return acc;
  }, {});

  const lines: string[] = [];
  lines.push("# Validation Report");
  lines.push("");
  lines.push(`- Generated at: ${nowISO()}`);
  lines.push(`- Input products: ${products.length}`);
  lines.push(`- Pass count: ${products.length - failures.length}`);
  lines.push(`- Fail count: ${failures.length}`);
  lines.push("");

  lines.push("## Failures by field");
  lines.push("");
  lines.push("| Field | Count |");
  lines.push("|---|---:|");
  Object.entries(failureByField)
    .sort((a, b) => b[1] - a[1] || a[0].localeCompare(b[0]))
    .forEach(([field, count]) => lines.push(`| ${field} | ${count} |`));
  if (Object.keys(failureByField).length === 0) {
    lines.push("| (none) | 0 |");
  }
  lines.push("");

  lines.push("## Example failures (max 10)");
  lines.push("");
  lines.push("| Index | Product ID | Field | Reason |");
  lines.push("|---:|---|---|---|");
  failures.slice(0, 10).forEach((f) => {
    lines.push(`| ${f.index} | ${f.productId ?? "-"} | ${f.field} | ${f.reason} |`);
  });
  if (failures.length === 0) {
    lines.push("| - | - | - | - |");
  }

  await writeFile(outPath, `${lines.join("\n")}\n`, "utf8");

  logger.info({ inPath, outPath, products: products.length, failures: failures.length }, "Product validation complete");
}
