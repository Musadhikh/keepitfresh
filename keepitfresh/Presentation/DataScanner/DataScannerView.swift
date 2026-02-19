//
//
//  DataScannerView.swift
//  keepitfresh
//
//  Created by musadhikh on 17/2/26.
//  Summary: DataScannerView <#brief summary#>
//
    

import SwiftUI
import VisionKit

struct DataScannerView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var recognizedItems: [RecognizedItem] = []
    @State var isScanning: Bool = false
    
    var body: some View {
        ZStack {
            DataScannerController(
                recognizedItems: $recognizedItems,
                isScanning: $isScanning
            )
            .background(Color.black)
        }
        .toolbarVisibility(.hidden, for: .navigationBar)
    }
}

#Preview {
    DataScannerView()
}
