//
//  SummaryViewModel.swift
//  telenor_app
//
//  Created by Bagics Bence
//

import Foundation

enum SummarySource {
    case national
    case county
}

@MainActor
final class SummaryViewModel: ObservableObject {
    let source: SummarySource
    private let order: VignetteOrderInterface
    private let dataStore: HighwayDataStoreInterface
    private let orderService: VignetteOrderServiceInterface
    private let coordinator: StickerSelectionCoordinatorInterface

    @Published var vignettes: [SummaryItem] = []
    @Published var totalPrice: Float = 0
    @Published var vehicleInfo: VehicleInfo?

    var onFinished: (() -> Void)?

    init(order: VignetteOrderInterface,
         dataStore: HighwayDataStoreInterface,
         orderService: VignetteOrderServiceInterface,
         coordinator: StickerSelectionCoordinatorInterface,
         source: SummarySource) {
        self.order = order
        self.dataStore = dataStore
        self.orderService = orderService
        self.coordinator = coordinator
        self.source = source
        loadItems()
    }

    private func loadItems() {
        vehicleInfo = dataStore.vehicleInfo

        switch source {
        case .national:
            if let vignette = order.nationalVignette {
                let item = SummaryItem(
                    name: categoryLabel(for: vignette),
                    price: vignette.price
                )
                vignettes = [item]
                totalPrice = vignette.price
            }

        case .county:
            let items = order.countyVignettes.map { countyVignette in
                SummaryItem(name: countyVignette.county.name, price: countyVignette.vignette.price)
            }
            vignettes = items

            totalPrice = order.countyVignettes.reduce(0) { currentTotal, countyVignette in
                currentTotal + countyVignette.vignette.price
            }
        }
    }

    private func categoryLabel(for vignette: HighwayVignette) -> String {
        let duration: String
        switch vignette.type {
        case .day:
            duration = Strings.Common.Period.daily
        case .week:
            duration = Strings.Common.Period.weekly
        case .month:
            duration = Strings.Common.Period.monthly
        case .year:
            duration = Strings.Common.Period.yearly
        }

        return "\(Strings.Summary.national) - \(duration)"
    }

    func confirmPurchase() {
        let items: [HighwayOrderItem]

        switch source {
        case .national:
            guard let vignette = order.nationalVignette else { return }

            let item = HighwayOrderItem(
                type: vignette.type.rawValue,
                category: vignette.vehicleCategory,
                cost: vignette.price
            )
            items = [item]

        case .county:
            items = order.countyVignettes.map { countyVignette in
                HighwayOrderItem(
                    type: countyVignette.vignette.type.rawValue,
                    category: countyVignette.vignette.vehicleCategory,
                    cost: countyVignette.vignette.price
                )
            }
        }

        Task { [weak self] in
            guard let self else { return }
            do {
                try await self.orderService.placeOrder(items: items)
                self.order.clear()
                self.coordinator.showResultView(success: true)
            } catch {
                self.coordinator.showResultView(success: false)
            }
            self.onFinished?()
        }
    }

    var plateNumber: String {
        dataStore.vehicleInfo?.plate ?? "-"
    }

    var vignetteTypeLabel: String {
        switch source {
        case .national:
            if let vignette = order.nationalVignette {
                return categoryLabel(for: vignette)
            } else {
                return "-"
            }
        case .county:
            return Strings.Summary.county
        }
    }

    func popToRoot() {
        coordinator.popToRoot()
    }
}

struct SummaryItem: Identifiable {
    var id: String { name }
    let name: String
    let price: Float
}
