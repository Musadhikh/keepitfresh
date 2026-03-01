//
//  DefaultImageDataGenerator.swift
//  keepitfresh
//
//  Created by musadhikh on 23/2/26.
//  Summary: Generates typed model data from extraction prompts using FoundationModels streaming.
//

import Foundation
import FoundationModels

public final class DefaultImageDataGenerator: ImageDataGenerating {
    private let session: LanguageModelSession

    public init(instruction: Instruction) {
        self.session = LanguageModelSession(instructions: instruction.instructions())
        session.prewarm()
    }

    public func generateData<T>(
        from prompt: any PromptProviding,
        type: T.Type
    ) -> AsyncThrowingStream<T.PartiallyGenerated?, any Error>
    where T: Generable, T: Sendable, T.PartiallyGenerated: Sendable {
        AsyncThrowingStream { continuation in
            let task = Task {
                let stream = session.streamResponse(to: prompt.prompt(), generating: T.self)
                for try await generated in stream {
                    continuation.yield(generated.content)
                }
                continuation.finish()
            }

            continuation.onTermination = { _ in
                task.cancel()
            }
        }
    }
}
