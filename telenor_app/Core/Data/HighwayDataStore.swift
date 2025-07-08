//
//  HighwayDataStore.swift
//  telenor_app
//
//  Created by Bagics Bence
//

import Foundation

@MainActor
final class HighwayDataStore: ObservableObject, HighwayDataStoreInterface {
    @Published private(set) var counties: [County] = []
    @Published private(set) var highwayVignettes: [HighwayVignette] = []
    @Published private(set) var vehicleCategories: [VehicleCategory] = []
    @Published private(set) var vehicleInfo: VehicleInfo?

    private let apiClient: HighwayApiClientInterface

    init(apiClient: HighwayApiClientInterface) {
        self.apiClient = apiClient
    }

    func loadHighwayInfo() {
        Task { [weak self] in
            guard let self else { return }
            do {
                let payload = try await self.apiClient.fetchHighwayInfo()
                self.counties = payload.counties
                self.vehicleCategories = payload.vehicleCategories
                self.highwayVignettes = payload.highwayVignettes.compactMap {
                    HighwayVignette(from: $0)
                }
            } catch {
                print("Highway info fetch failed: \(error)")
            }
        }
    }

    func loadVehicleInfo() {
        Task { [weak self] in
            guard let self else { return }
            do {
                self.vehicleInfo = try await self.apiClient.fetchVehicleInfo()
            } catch {
                print("Vehicle info fetch failed: \(error)")
            }
        }
    }

    func loadAll() {
        loadHighwayInfo()
        loadVehicleInfo()
    }
}
