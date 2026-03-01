#!/usr/bin/env node
import yargs, { type Argv } from "yargs";
import { hideBin } from "yargs/helpers";
import { logger } from "../core/logger.js";
import { runSampleCommand } from "./commands/sample.js";
import { runBuildCategoriesCommand } from "./commands/buildCategories.js";
import { runImportCategoriesCommand } from "./commands/importCategories.js";
import { runImportProductsCommand } from "./commands/importProducts.js";
import { runSchemaProbeCommand } from "./commands/schemaProbe.js";
import { runCompareContractCommand } from "./commands/compareContract.js";
import { runCategorySignalsCommand } from "./commands/categorySignals.js";
import { runTransformSampleCommand } from "./commands/transformSample.js";
import { runValidateProductsCommand } from "./commands/validateProducts.js";

function withDryRunFlags<T extends Record<string, unknown>>(command: Argv<T>) {
  return command
    .option("dry-run", {
      type: "boolean",
      default: true,
      describe: "Run in dry-run mode (default true)"
    })
    .option("execute", {
      type: "boolean",
      default: false,
      describe: "Disable dry-run and request execution mode"
    });
}

async function main() {
  await yargs(hideBin(process.argv))
    .scriptName("off-importer")
    .strict()
    .command(
      "sample",
      "Read first N valid JSONL objects and write sample + stats outputs",
      (cmd) =>
        cmd
          .option("file", { type: "string", default: "../openfoodfacts-products.jsonl" })
          .option("count", { type: "number", default: 100 })
          .option("max-lines", { type: "number" })
          .option("out", { type: "string", default: "output/off_sample_100.json" }),
      async (args) => {
        await runSampleCommand({
          file: args.file,
          count: args.count,
          maxLines: args["max-lines"],
          out: args.out
        });
      }
    )
    .command(
      "schema:probe",
      "Generate schema summary from sample output",
      (cmd) =>
        cmd
          .option("sample", { type: "string", default: "output/off_sample_100.json" })
          .option("out-json", { type: "string", default: "output/off_schema_summary.json" })
          .option("out-md", { type: "string", default: "output/off_schema_summary.md" }),
      async (args) => {
        await runSchemaProbeCommand({
          sample: args.sample,
          outJson: args["out-json"],
          outMd: args["out-md"]
        });
      }
    )
    .command(
      "compare:contract",
      "Compare observed OFF schema with canonical Product contract",
      (cmd) =>
        cmd
          .option("schema", { type: "string", default: "output/off_schema_summary.json" })
          .option("contract", { type: "string", default: "docs/product_storage_contract_v1.json" })
          .option("sample", { type: "string", default: "output/off_sample_100.json" })
          .option("out-diff", { type: "string", default: "output/model_diff.md" })
          .option("out-mapping", { type: "string", default: "output/off_to_product_mapping.md" }),
      async (args) => {
        await runCompareContractCommand({
          schema: args.schema,
          contract: args.contract,
          sample: args.sample,
          outDiff: args["out-diff"],
          outMapping: args["out-mapping"]
        });
      }
    )
    .command(
      "phase2",
      "Run sample -> schema:probe -> compare:contract",
      (cmd) =>
        cmd
          .option("file", { type: "string", default: "../openfoodfacts-products.jsonl" })
          .option("count", { type: "number", default: 100 })
          .option("max-lines", { type: "number" })
          .option("sample-out", { type: "string", default: "output/off_sample_100.json" }),
      async (args) => {
        await runSampleCommand({
          file: args.file,
          count: args.count,
          maxLines: args["max-lines"],
          out: args["sample-out"]
        });

        await runSchemaProbeCommand({
          sample: args["sample-out"],
          outJson: "output/off_schema_summary.json",
          outMd: "output/off_schema_summary.md"
        });

        await runCompareContractCommand({
          schema: "output/off_schema_summary.json",
          contract: "docs/product_storage_contract_v1.json",
          sample: args["sample-out"],
          outDiff: "output/model_diff.md",
          outMapping: "output/off_to_product_mapping.md"
        });
      }
    )
    .command(
      "categories:signals",
      "Extract category signals from JSONL using discovered schema paths",
      (cmd) =>
        cmd
          .option("file", { type: "string", default: "../openfoodfacts-products.jsonl" })
          .option("schema", { type: "string", default: "output/off_schema_summary.json" })
          .option("max-lines", { type: "number", default: 200000 })
          .option("min-count", { type: "number", default: 10 })
          .option("out", { type: "string", default: "output/category_signals.json" }),
      async (args) => {
        await runCategorySignalsCommand({
          file: args.file,
          schema: args.schema,
          maxLines: args["max-lines"],
          minCount: args["min-count"],
          out: args.out
        });
      }
    )
    .command(
      "categories:build",
      "Build curated taxonomy preview and editable mapping rules",
      (cmd) =>
        cmd
          .option("signals", { type: "string", default: "output/category_signals.json" })
          .option("contract", { type: "string", default: "docs/product_storage_contract_v1.json" })
          .option("min-count", { type: "number", default: 50 })
          .option("out", { type: "string", default: "output/categories_preview.json" }),
      async (args) => {
        await runBuildCategoriesCommand({
          signals: args.signals,
          contract: args.contract,
          minCount: args["min-count"],
          out: args.out
        });
      }
    )
    .command(
      "phase3",
      "Run categories:signals -> categories:build",
      (cmd) =>
        cmd
          .option("file", { type: "string", default: "../openfoodfacts-products.jsonl" })
          .option("schema", { type: "string", default: "output/off_schema_summary.json" })
          .option("max-lines", { type: "number", default: 200000 })
          .option("min-count", { type: "number", default: 10 }),
      async (args) => {
        await runCategorySignalsCommand({
          file: args.file,
          schema: args.schema,
          maxLines: args["max-lines"],
          minCount: args["min-count"],
          out: "output/category_signals.json"
        });

        await runBuildCategoriesCommand({
          signals: "output/category_signals.json",
          contract: "docs/product_storage_contract_v1.json",
          minCount: 50,
          out: "output/categories_preview.json"
        });
      }
    )
    .command(
      "transform:sample",
      "Transform OFF sample into canonical Product JSON and reports",
      (cmd) =>
        cmd
          .option("in", { type: "string", default: "output/off_sample_100.json" })
          .option("out", { type: "string", default: "output/product_sample_100.json" }),
      async (args) => {
        await runTransformSampleCommand({
          in: args.in,
          out: args.out
        });
      }
    )
    .command(
      "validate:products",
      "Validate transformed products against contract snapshot",
      (cmd) =>
        cmd
          .option("in", { type: "string", default: "output/product_sample_100.json" })
          .option("out", { type: "string", default: "output/validation_report.md" }),
      async (args) => {
        await runValidateProductsCommand({
          in: args.in,
          out: args.out
        });
      }
    )
    .command(
      "phase4",
      "Run transform:sample -> validate:products",
      (cmd) =>
        cmd
          .option("in", { type: "string", default: "output/off_sample_100.json" })
          .option("out", { type: "string", default: "output/product_sample_100.json" }),
      async (args) => {
        await runTransformSampleCommand({
          in: args.in,
          out: args.out
        });
        await runValidateProductsCommand({
          in: args.out,
          out: "output/validation_report.md"
        });
      }
    )
    .command(
      "importCategories",
      "Import curated categories to ProductCategories (dry-run default)",
      (cmd) =>
        withDryRunFlags(cmd)
          .option("in", { type: "string", default: "output/categories_preview.json" })
          .option("max-writes", { type: "number" }),
      async (args) => {
        await runImportCategoriesCommand({
          in: args.in,
          dryRun: args["dry-run"] as boolean,
          execute: args.execute as boolean,
          maxWrites: args["max-writes"]
        });
      }
    )
    .command(
      "importProducts",
      "Import products to ProductCatalog (dry-run default, streaming JSONL)",
      (cmd) =>
        withDryRunFlags(cmd)
          .option("file", { type: "string", default: "../openfoodfacts-products.jsonl" })
          .option("max-writes", { type: "number" })
          .option("max-lines", { type: "number" })
          .option("resume", { type: "boolean", default: true })
          .option("checkpoint-mode", { choices: ["file", "firestore"] as const })
          .option("skip-unchanged", { type: "boolean", default: false })
          .option("since-date", { type: "string" }),
      async (args) => {
        await runImportProductsCommand({
          file: args.file,
          dryRun: args["dry-run"] as boolean,
          execute: args.execute as boolean,
          maxWrites: args["max-writes"],
          maxLines: args["max-lines"],
          resume: args.resume as boolean,
          checkpointMode: args["checkpoint-mode"],
          skipUnchanged: args["skip-unchanged"] as boolean,
          sinceDate: args["since-date"]
        });
      }
    )
    .demandCommand(1)
    .help()
    .parseAsync();
}

main().catch((error) => {
  logger.error({ error }, "Importer command failed");
  process.exitCode = 1;
});
