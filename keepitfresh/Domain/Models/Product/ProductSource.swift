//
//  ProductSource.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Origin of a product record used for audit and UX hints.
//

import Foundation

enum ProductSource: String, Codable, CaseIterable, Sendable {
    case scan
    case manual
    case `import`
    case unknown
}
