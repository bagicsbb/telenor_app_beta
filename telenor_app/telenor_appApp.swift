//
//  telenor_appApp.swift
//  telenor_app
//
//  Created by Bagics Bence
//

import SwiftUI

@main
struct telenor_appApp: App {
    @StateObject private var coordinator = StickerSelectionCoordinator()
    @StateObject private var dataStore = HighwayDataStore(apiClient: HighwayApiClient())
    @StateObject private var order = VignetteOrder()
    
    private let orderService: VignetteOrderServiceInterface

    init() {
        self.orderService = VignetteOrderService(apiClient: HighwayApiClient())
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.path) {
                StickerSelectionView(viewModel: StickerSelectionViewModel(coordinator: coordinator, dataStore: dataStore, vignetteOrder: order))
                    .navigationDestination(for: StickerSelectionCoordinator.Route.self) { route in
                        switch route {
                        case .summary(let source):
                            SummaryView(viewModel: SummaryViewModel(order: order, dataStore: dataStore, orderService: orderService, coordinator: coordinator, source: source))
                        case .countySelection:
                            CountySelectionView(viewModel: CountySelectionViewModel(dataStore: dataStore, vignetteOrder: order, coordinator: coordinator))
                        case .resultView(let success):
                            ResultView(isSuccess: success, coordinator: coordinator)
                        }
                    }
            }
        }
    }
}
