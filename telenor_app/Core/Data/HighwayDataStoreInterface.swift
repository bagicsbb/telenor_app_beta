//
//  HighwayDataStoreInterface.swift
//  telenor_app
//
//  Created by Bagics Bence
//

import Foundation
import Combine

@MainActor
protocol HighwayDataStoreInterface: AnyObject {
    var counties: [County] { get }
    var highwayVignettes: [HighwayVignette] { get }
    var vehicleCategories: [VehicleCategory] { get }
    var vehicleInfo: VehicleInfo? { get }

    func loadHighwayInfo()
    func loadVehicleInfo()
    func loadAll()
}
