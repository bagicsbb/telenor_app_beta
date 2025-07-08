//
//  StickerSelectionViewModel.swift
//  telenor_app
//
//  Created by Bagics Bence
//

import Foundation
import Combine

@MainActor
final class StickerSelectionViewModel: ObservableObject {
    @Published var selectedNationalVignette: HighwayVignette?

    private let coordinator: StickerSelectionCoordinatorInterface
    private let dataStore: HighwayDataStoreInterface
    private let vignetteOrder: VignetteOrderInterface
    private var cancellables = Set<AnyCancellable>()

    init(
        coordinator: StickerSelectionCoordinatorInterface,
        dataStore: HighwayDataStoreInterface,
        vignetteOrder: VignetteOrderInterface
    ) {
        self.coordinator = coordinator
        self.dataStore = dataStore
        self.vignetteOrder = vignetteOrder

        setupBindings()
        dataStore.loadAll()
    }

    var vehicleInfo: VehicleInfo? {
        dataStore.vehicleInfo
    }

    var availableNationalVignettes: [HighwayVignette] {
        dataStore.highwayVignettes
    }

    var canProceed: Bool {
        vignetteOrder.nationalVignette != nil
    }

    private func setupBindings() {
        vignetteOrder.nationalVignettePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] nationalVignette in
                self?.selectedNationalVignette = nationalVignette
            }
            .store(in: &cancellables)
    }

    func selectNationalVignette(_ vignette: HighwayVignette) {
        vignetteOrder.nationalVignette = vignette
    }

    func isNationalVignetteSelected(_ vignette: HighwayVignette) -> Bool {
        guard let selectedVignette = selectedNationalVignette else {
            return false
        }
        return selectedVignette.id == vignette.id
    }

    func vignetteCategory(for vignette: HighwayVignette) -> String {
        for category in dataStore.vehicleCategories {
            if category.category == vignette.vehicleCategory {
                return category.vignetteCategory
            }
        }
        return ""
    }

    func proceedToCountySelection() {
        coordinator.showCountySelection()
    }

    func proceedToSummary() {
        coordinator.showSummary(source: .national)
    }
}
