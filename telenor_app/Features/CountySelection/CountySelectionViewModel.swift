//
//  CountySelectionViewModel.swift
//  telenor_app
//
//  Created by Bagics Bence
//

import Foundation
import Combine

struct CountyVignette: Identifiable, Hashable {
    let id: String
    let county: County
    let vignette: HighwayVignette
}

@MainActor
final class CountySelectionViewModel: ObservableObject {
    @Published var counties: [County] = []
    @Published var yearlyCountyPrice: Float = 0
    @Published var totalPrice: Float = 0
    @Published var selectedCountyIds: Set<String> = []
    @Published var contiguityWarning: String?

    private let dataStore: HighwayDataStoreInterface
    private let vignetteOrder: VignetteOrderInterface
    private let coordinator: StickerSelectionCoordinatorInterface
    private var cancellables = Set<AnyCancellable>()

    init(
        dataStore: HighwayDataStoreInterface,
        vignetteOrder: VignetteOrderInterface,
        coordinator: StickerSelectionCoordinatorInterface
    ) {
        self.dataStore = dataStore
        self.vignetteOrder = vignetteOrder
        self.coordinator = coordinator

        setupBindings()
        loadCounties()
        fetchYearlyCountyPrice()
    }

    private func loadCounties() {
        counties = dataStore.counties
    }

    private func fetchYearlyCountyPrice() {
        let yearlyVignette = dataStore.highwayVignettes.first { highwayVignette in
            highwayVignette.type == .year
        }

        yearlyCountyPrice = yearlyVignette?.price ?? 0
    }

    private func setupBindings() {
        vignetteOrder.countyVignettesPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] vignettes in
                self?.updateTotalPrice()
                self?.updateSelection(vignettes)
            }
            .store(in: &cancellables)
    }

    private func updateTotalPrice() {
        totalPrice = vignetteOrder.countyPrice
    }

    private func updateSelection(_ vignettes: [CountyVignette]) {
        selectedCountyIds = Set(vignettes.map { $0.county.id })
    }

    func toggleCountyById(_ apiId: String) {
        guard let county = counties.first(where: { $0.id == apiId }) else { return }
        toggleCounty(county)
    }

    func toggleCounty(_ county: County) {
        guard let yearlyVignette = dataStore.highwayVignettes.first(where: { highwayVignette in
            highwayVignette.type == .year
        }) else {
            return
        }

        let isSelecting = !vignetteOrder.isCountySelected(county)
        let countyVignette = CountyVignette(
            id: county.id,
            county: county,
            vignette: yearlyVignette
        )
        vignetteOrder.toggleCounty(countyVignette)

        contiguityWarning = isSelecting ? currentSelectionWarning() : nil
    }

    private func currentSelectionWarning() -> String? {
        let selectedIds = Set(vignetteOrder.countyVignettes.map { $0.county.id })
        let isConnected = CountyContiguity.isConnected(selectedIds)

        if isConnected {
            return nil
        } else {
            return Strings.CountySelection.warning
        }
    }

    func isSelected(_ county: County) -> Bool {
        return vignetteOrder.isCountySelected(county)
    }

    func proceedToNextStep() {
        coordinator.showSummary(source: .county)
    }
}
