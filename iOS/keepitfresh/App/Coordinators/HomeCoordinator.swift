//
//
//  HomeCoordinator.swift
//  keepitfresh
//
//  Created by musadhikh on 3/3/26.
//  Summary: HomeCoordinator
//
    

import Foundation
import Observation
import SwiftUI


@MainActor
@Observable
final class HomeCoordinator: Coordinator {
    enum HomeRoute: Hashable {
        case home
        case productAdd
        case productReview([ImagesCaptured])
    }
    
    typealias Route = HomeRoute

    var path: NavigationPath = NavigationPath()
    
    private var product: Product? = nil
    
    private var assembler: AddProductModuleAssembler
    
    init() {
        assembler = AddProductModuleAssembler()
    }
    
    func makeRootView() -> some View {
        let viewModel = HomeViewModel(
            onNext: {[weak self] route in
                self?.navigate(to: route)
            }
        )
        return HomeView(viewModel: viewModel)
    }
    
    func makeProductAddFlowRootView() -> some View {
        let viewModel = AddProductFlowRootViewModel(
            useCase: assembler.makeUseCase(),
            type: .barcodeScanner,
            onNext: { [weak self] route in
                self?.navigate(to: route)
            },
            getProduct: {[weak self] in
                self?.product
            }
        )
        return AddProductFlowRootView(viewModel: viewModel)
    }
    
    func makeProductReviewView(images: [ImagesCaptured]) -> some View {
        let viewModel = ProductReviewViewModel(
            capturedImages: images,
            onAdd: { [weak self] product in
                self?.product = product
                self?.navigateBack()
            }
        )
        return ProductReviewView(viewModel: viewModel)
    }
    
    @ViewBuilder
    func build(route: HomeRoute) -> some View {
        switch route {
            case.home: makeRootView()
            case .productAdd: makeProductAddFlowRootView()
            case .productReview(let images): makeProductReviewView(images: images)
        }
    }
}

extension HomeCoordinator {
    private func onNextAction() {
        
    }
}
