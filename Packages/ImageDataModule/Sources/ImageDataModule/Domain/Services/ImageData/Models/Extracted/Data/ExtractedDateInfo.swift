//
//  ExtractedDateInfo.swift
//  ImageDataModule
//
//  Created by Musadhikh Muhammed K on 23/2/26.
//

import FoundationModels

@Generable
public struct ExtractedDateInfo: Sendable {
    @Guide(description: "Type of Date (Packed, Expiry, etc.) printed on the product")
    public let dateType: DateTypeEnum?

    @Guide(description: "Date printed on the product. Always convert to the format: dd/MM/yyyy")
    public let date: String?
}

extension ExtractedDateInfo.PartiallyGenerated: Sendable {}

@Generable(description: "Date type to infer from the label on the product. pkd, packed, packed on means => packed. prod, mfd, manufactured, manufactured on means => manufactured. exp, expiry, expiry on means => expiry. use by, useBy, useBy on means => useBy. bb, best before, bestBefore, bestBefore on means => bestBefore. use before, useBefore, useBefore on means => useBefore.")
public enum DateTypeEnum: String, CaseIterable, Sendable {
    case packed
    case manufactured
    case expiry
    case useBy
    case bestBefore
    case useBefore
}
