//
//  RuntimeDependencies.swift
//  keepitfresh
//
//  Created by musadhikh on 27/2/26.
//  Summary: Declares runtime abstractions for connectivity and clock dependencies.
//

import Foundation

public protocol ConnectivityProviding: Sendable {
    func isOnline() async -> Bool
}

public protocol ClockProviding: Sendable {
    func now() -> Date
}

public struct SystemClock: ClockProviding {
    public init() {}

    public func now() -> Date {
        Date()
    }
}

public struct AssumeOnlineConnectivityProvider: ConnectivityProviding {
    public init() {}

    public func isOnline() async -> Bool {
        true
    }
}
