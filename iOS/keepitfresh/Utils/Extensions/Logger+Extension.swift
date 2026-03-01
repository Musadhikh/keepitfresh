//
//  Logger+Extension.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed K on 7/9/25.
//
import Foundation
import os.log

/// Global logger for the KeepItFresh app
let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "com.mus.keepitfresh", category: "app")
