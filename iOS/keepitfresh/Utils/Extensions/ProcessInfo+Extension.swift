//
//  ProcessInfo+Extension.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed on 12/11/25.
//

import Foundation

extension ProcessInfo {
    /// True when running SwiftUI previews
    static var isRunningForPreviews: Bool {
        // Xcode sets this to "1" for previews
        ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
    
    /// Optional extras you may want
    static var isRunningUnitTests: Bool {
        NSClassFromString("XCTestCase") != nil
    }
    
    static var isRunningUITests: Bool {
        ProcessInfo.processInfo.environment["UI_TESTING"] == "1"
    }
}
