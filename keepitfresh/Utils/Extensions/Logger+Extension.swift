//
//  Logger+Extension.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed K on 7/9/25.
//

import Foundation
import os.log

/// Global logger for the KeepItFresh app
let app = Logger(subsystem: Bundle.main.bundleIdentifier ?? "com.mus.keepitfresh", category: "app")

/// Authentication-specific logger
let auth = Logger(subsystem: Bundle.main.bundleIdentifier ?? "com.mus.keepitfresh", category: "auth")

/// Data layer logger
let data = Logger(subsystem: Bundle.main.bundleIdentifier ?? "com.mus.keepitfresh", category: "data")

/// UI layer logger
let ui = Logger(subsystem: Bundle.main.bundleIdentifier ?? "com.mus.keepitfresh", category: "ui")

/// Network-related logger
let network = Logger(subsystem: Bundle.main.bundleIdentifier ?? "com.mus.keepitfresh", category: "network")

/// Firebase-specific logger
let firebase = Logger(subsystem: Bundle.main.bundleIdentifier ?? "com.mus.keepitfresh", category: "firebase")


// MARK: - Convenience Methods

extension Logger {
    
    /// Log with additional context information
    func logWithContext(_ message: String, level: OSLogType = .default, file: String = #file, function: String = #function, line: Int = #line) {
        let fileName = URL(fileURLWithPath: file).lastPathComponent
        let contextMessage = "[\(fileName):\(line)] \(function) - \(message)"
        self.log(level: level, "\(contextMessage)")
    }
    
    /// Log debug information (only in debug builds)
    func debug(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
#if DEBUG
        logWithContext(message, level: .debug, file: file, function: function, line: line)
#endif
    }
    
    /// Log error with context
    func error(_ message: String, error: Error? = nil, file: String = #file, function: String = #function, line: Int = #line) {
        var errorMessage = message
        if let error = error {
            errorMessage += " Error: \(error.localizedDescription)"
        }
        logWithContext(errorMessage, level: .error, file: file, function: function, line: line)
    }
    
    /// Log warning with context
    func warning(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        logWithContext(message, level: .info, file: file, function: function, line: line)
    }
}
