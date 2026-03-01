import { createReadStream } from "node:fs";
import { createInterface } from "node:readline";
import type { JsonlParseError } from "../core/types.js";

export interface JsonlReaderOptions {
  includeRawLineInErrors?: boolean;
  onLine?: (line: { lineNumber: number; lineBytes: number; isEmpty: boolean }) => void;
  onParseError?: (error: JsonlParseError) => void;
  shouldStop?: (line: { lineNumber: number; lineBytes: number; isEmpty: boolean }) => boolean;
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
      const isEmpty = line.trim() === "";
      const lineInfo = { lineNumber, lineBytes, isEmpty };

      options.onLine?.(lineInfo);

      if (options.shouldStop?.(lineInfo) === true) {
        break;
      }

      if (isEmpty) {
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
