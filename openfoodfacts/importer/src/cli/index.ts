#!/usr/bin/env node
import yargs from "yargs";
import { hideBin } from "yargs/helpers";
import { logger } from "../core/logger.js";
import { runSampleCommand } from "./commands/sample.js";
import { runBuildCategoriesCommand } from "./commands/buildCategories.js";
import { runImportCategoriesCommand } from "./commands/importCategories.js";
import { runImportProductsCommand } from "./commands/importProducts.js";

function withDryRunFlags<T extends Record<string, unknown>>(command: yargs.Argv<T>) {
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
          .option("out", { type: "string", default: "output/off_sample_100.json" }),
      async (args) => {
        await runSampleCommand({
          file: args.file,
          count: args.count,
          out: args.out
        });
      }
    )
    .command(
      "buildCategories",
      "Build placeholder category preview from sample output",
      (cmd) =>
        cmd
          .option("sample", { type: "string", default: "output/off_sample_100.json" })
          .option("out", { type: "string", default: "output/categories_preview.json" }),
      async (args) => {
        await runBuildCategoriesCommand({ sample: args.sample, out: args.out });
      }
    )
    .command(
      "importCategories",
      "Locked importer command (Phase 0, no writes)",
      (cmd) => withDryRunFlags(cmd),
      async (args) => {
        await runImportCategoriesCommand({
          dryRun: args["dry-run"] as boolean,
          execute: args.execute
        });
      }
    )
    .command(
      "importProducts",
      "Locked importer command (Phase 0, no writes)",
      (cmd) => withDryRunFlags(cmd),
      async (args) => {
        await runImportProductsCommand({
          dryRun: args["dry-run"] as boolean,
          execute: args.execute
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
