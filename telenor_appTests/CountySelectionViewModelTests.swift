//
//  CountySelectionViewModelTests.swift
//  telenor_app
//
//  Created by Bagics Bence
//

import Testing
import Combine
@testable import telenor_app

@MainActor
struct CountySelectionViewModelTests {

    @Test func selectingDisconnectingCountySetsWarning() {
        let viewModel = makeViewModel(counties: [
            County(id: "YEAR_23", name: "Pest"),
            County(id: "YEAR_27", name: "Vas")
        ])

        viewModel.toggleCounty(County(id: "YEAR_23", name: "Pest"))
        #expect(viewModel.contiguityWarning == nil)

        viewModel.toggleCounty(County(id: "YEAR_27", name: "Vas"))
        #expect(viewModel.contiguityWarning != nil)
    }

    @Test func deselectingDisconnectingCountyDoesNotSetWarning() {
        let viewModel = makeViewModel(counties: [
            County(id: "YEAR_23", name: "Pest"),
            County(id: "YEAR_19", name: "Heves"),
            County(id: "YEAR_14", name: "Borsod-Abaúj-Zemplén")
        ])

        viewModel.toggleCounty(County(id: "YEAR_23", name: "Pest"))
        viewModel.toggleCounty(County(id: "YEAR_19", name: "Heves"))
        viewModel.toggleCounty(County(id: "YEAR_14", name: "Borsod-Abaúj-Zemplén"))
        #expect(viewModel.contiguityWarning == nil)

        viewModel.toggleCounty(County(id: "YEAR_19", name: "Heves"))
        #expect(viewModel.contiguityWarning == nil)
    }
}

private extension CountySelectionViewModelTests {
    func makeViewModel(counties: [County]) -> CountySelectionViewModel {
        let dataStore = MockHighwayDataStore()
        dataStore.counties = counties
        dataStore.highwayVignettes = [HighwayVignette.year]

        return CountySelectionViewModel(
            dataStore: dataStore,
            vignetteOrder: MockVignetteOrder(),
            coordinator: MockCoordinator()
        )
    }
}

// MARK: - Mocks

private extension HighwayVignette {
    static let year = HighwayVignette(from: HighwayVignetteApiModel(
        vignetteType: ["YEAR"], vehicleCategory: "CAR",
        cost: 5000, trxFee: 200, sum: 5200
    ))!
}

@MainActor
private final class MockHighwayDataStore: HighwayDataStoreInterface {
    var counties: [County] = []
    var highwayVignettes: [HighwayVignette] = []
    var vehicleCategories: [VehicleCategory] = []
    var vehicleInfo: VehicleInfo?

    func loadHighwayInfo() {}
    func loadVehicleInfo() {}
    func loadAll() {}
}

@MainActor
private final class MockVignetteOrder: VignetteOrderInterface {
    @Published var nationalVignette: HighwayVignette?
    @Published var countyVignettes: [CountyVignette] = []

    var nationalVignettePublisher: Published<HighwayVignette?>.Publisher { $nationalVignette }
    var countyVignettesPublisher: Published<[CountyVignette]>.Publisher { $countyVignettes }

    var countyPrice: Float { countyVignettes.reduce(0) { $0 + $1.vignette.price } }

    func clear() {
        nationalVignette = nil
        countyVignettes = []
    }

    func toggleCounty(_ item: CountyVignette) {
        if let index = countyVignettes.firstIndex(where: { $0.county.id == item.county.id }) {
            countyVignettes.remove(at: index)
        } else {
            countyVignettes.append(item)
        }
    }

    func isCountySelected(_ county: County) -> Bool {
        countyVignettes.contains { $0.county.id == county.id }
    }
}

@MainActor
private final class MockCoordinator: StickerSelectionCoordinatorInterface {
    func showCountySelection() {}
    func showSummary(source: SummarySource) {}
    func showResultView(success: Bool) {}
    func popToRoot() {}
}
