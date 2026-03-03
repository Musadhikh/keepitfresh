//
//
//  Barcode+Extension.swift
//  keepitfresh
//
//  Created by musadhikh on 3/3/26.
//  Summary: Barcode+Extension
//
    

import Foundation
import BarcodeScannerModule

extension ScannedBarcode {
    var toBarcode: Barcode {
        Barcode(value: self.payload, symbology: .init(value: symbology))
    }
}
