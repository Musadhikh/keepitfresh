//
//  CameraModule.swift
//  keepitfresh
//
//  Created by musadhikh on 15/2/26.
//  Summary: Exposes CameraModule public API entry points.
//

import Foundation

public enum CameraModule {}


public enum RecognizedType: String, Sendable, Equatable {
    case barcode
    case text
}

public protocol RecognizedDataProviding: Equatable, Sendable {
    var id: UUID { get set }
    var value: String { get set }
    var type: RecognizedType { get set }
}

public struct RecognizedDataProvider: Equatable, Sendable {
    public var id: UUID
    public var value: String
    public var type: RecognizedType
}

public struct RecognizedDataResult: Identifiable, Equatable, Sendable {
    public var id: UUID
    public var barcodes: [RecognizedDataProvider]
    public var texts: [RecognizedDataProvider]
}
