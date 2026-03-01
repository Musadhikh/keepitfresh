//
//  ProductSyncStrategy.swift
//  keepitfresh
//
//  Created by musadhikh on 27/2/26.
//  Summary: Defines policy knobs controlling product read/write sync behavior.
//

import Foundation

public struct ProductSyncStrategy: Sendable, Equatable {
    public var readPolicy: ProductReadPolicy
    public var writePolicy: ProductWritePolicy
    public var conflictPolicy: ProductConflictPolicy

    public init(
        readPolicy: ProductReadPolicy,
        writePolicy: ProductWritePolicy,
        conflictPolicy: ProductConflictPolicy
    ) {
        self.readPolicy = readPolicy
        self.writePolicy = writePolicy
        self.conflictPolicy = conflictPolicy
    }

    public static let offlineFirstDefault = ProductSyncStrategy(
        readPolicy: .localThenRemoteAlwaysBackground,
        writePolicy: .localThenRemoteImmediate,
        conflictPolicy: .lastWriteWins
    )
}

public enum ProductReadPolicy: Sendable, Equatable {
    case localOnly
    case localThenRemoteIfStale(staleAfter: Duration)
    case localThenRemoteAlwaysBackground
}

public enum ProductWritePolicy: Sendable, Equatable {
    case localThenRemoteImmediate
    case localThenEnqueue
}

public enum ProductConflictPolicy: Sendable, Equatable {
    case lastWriteWins
    case remoteWins
    case localWins
    case merge
}
