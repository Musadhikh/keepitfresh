//
//
//  ProductReviewView.swift
//  keepitfresh
//
//  Created by musadhikh on 22/2/26.
//  Summary: ProductReviewView - View for reviewing product details before submission.
//
    

import SwiftUI

struct ProductReviewView: View {
    @State var viewModel: ProductReviewViewModel
    var onAdd: () -> Void
    
    
    @State private var selectedImageIndex: Int = 0
    
    var body: some View {
        VStack {
            ProductOverviewImageCard(images: viewModel.capturedImages.map(\.image), selectedImageIndex: $selectedImageIndex)
            Spacer()
            
            if viewModel.generatedData != nil {
                if let title = viewModel.generatedData?.title {
                    Text("\(title)")
                }
                
                if let category = viewModel.generatedData?.category {
                    VStack {
                        if let main = category.mainCategory {
                            Text("\(main.rawValue)")
                        }
                        
                        if let sub = category.subCategory {
                            Text("\(sub)")
                        }
                    }
                }
                
                if let description = viewModel.generatedData?.description {
                    Text("\(description)")
                }
                
                if let barcodeInfo = viewModel.generatedData?.barcodeInfo {
                    HStack {
                        if let barcode = barcodeInfo.barcode {
                            Text("Barcode: \(barcode)")
                            Spacer()
                        }
                        if let barcodeType = barcodeInfo.barcodeType {
                            Text("Barcode type: \(barcodeType)")
                        }
                    }
                }
                
                if let dateInfo = viewModel.generatedData?.dateInfo {
                    VStack {
                        ForEach(dateInfo, id: \.id) { date in
                            if let dateValue = date.date {
                                HStack {
                                    if let dateType = date.dateType {
                                        Text("\(dateType.rawValue)")
                                    }
                                    Text("\(dateValue)")
                                }
                            }
                        }
                    }
                }
                
                
                if let details = viewModel.generatedData?.productDetails {
                    switch details {
                    case .beverage(let beverage):
                        if let ingredients = beverage?.ingredients {
                            VStack {
                                ForEach(ingredients, id: \.self) { ing in
                                    Text(ing)
                                }
                            }
                        }
                        
                        if let numberOfItems = beverage?.numberOfItems {
                            Text(numberOfItems)
                        }
                        
                        if let quantity = beverage?.quantity {
                            Text(quantity)
                        }
                    case .food(let food):
                        if let ingredients = food?.ingredients {
                            VStack {
                                ForEach(ingredients, id: \.self) { ing in
                                    Text(ing)
                                }
                            }
                        }
                        
                        if let numberOfItems = food?.numberOfItems {
                            Text(numberOfItems)
                        }
                        
                        if let quantity = food?.quantity {
                            Text(quantity)
                        }
                        
                    case  .electronics:
                        Text("Electronic details not available")
                    case .household:
                        Text("Household details not available")
                    case .medicine:
                        Text("Medicine details not available")
                    case .personalCare:
                        Text("Personal Care details not available")
                    case .pet:
                        Text("Pet details not available")
                    case .other:
                        Text("Other details not available")
                    }
                
                }
                
                Spacer()
                
                Stepper("Number of items", value: $viewModel.numberOfItems)
            }
            
            Spacer()
            
            Button("Add") {
                viewModel.prepareData()
                
                onAdd()
            }
            .primaryButtonStyle()
            
        }
        .onAppear {
            Task { await viewModel.startReviewProcess() }
        }
    }
}

//#Preview {
//    ProductReviewView()
//}
