//
//  BarcodeScanning.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Barcode scanning stream abstraction for presentation adapters.
//

import Foundation

protocol BarcodeScanning: Sendable {
    func scanBarcodes() -> AsyncStream<Barcode>
}
