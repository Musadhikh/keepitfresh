//
//
//  ImageDataGeneratorService.swift
//  keepitfresh
//
//  Created by musadhikh on 22/2/26.
//  Summary: ImageDataGeneratorService
//
    

import Foundation
import FoundationModels

final class ImageDataGeneratorService: AIDataGenerating {
    let session: LanguageModelSession
    
    init(instruction: Instruction) {
        session = LanguageModelSession(instructions: instruction.instructions())
        
        session.prewarm()
    }
    
    func generateData<T>(from prompt: PromptType, type: T.Type) -> AsyncThrowingStream<T.PartiallyGenerated?, any Error>
    where T : Generable, T : Sendable, T.PartiallyGenerated: Sendable {
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
