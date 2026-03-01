import { createReadStream } from "node:fs";
import { createInterface } from "node:readline";
import type { JsonlParseError } from "../core/types.js";

export interface JsonlReaderOptions {
  includeRawLineInErrors?: boolean;
  onParseError?: (error: JsonlParseError) => void;
}

export async function* createJsonlReader<T = Record<string, unknown>>(
  filePath: string,
  options: JsonlReaderOptions = {}
): AsyncGenerator<{ lineNumber: number; value: T; lineBytes: number }> {
  const stream = createReadStream(filePath, { encoding: "utf8" });
  const rl = createInterface({ input: stream, crlfDelay: Infinity });

  let lineNumber = 0;

  try {
    for await (const line of rl) {
      lineNumber += 1;
      const lineBytes = Buffer.byteLength(line, "utf8");

      if (line.trim() === "") {
        continue;
      }

      try {
        const parsed = JSON.parse(line) as T;
        yield { lineNumber, value: parsed, lineBytes };
      } catch (error) {
        options.onParseError?.({
          lineNumber,
          rawLine: options.includeRawLineInErrors ? line : undefined,
          error
        });
      }
    }
  } finally {
    rl.close();
    stream.destroy();
  }
}
