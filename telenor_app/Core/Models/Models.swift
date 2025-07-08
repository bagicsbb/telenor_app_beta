//
//  Models.swift
//  telenor_app
//
//  Created by Bagics Bence
//

import Foundation

struct HighwayInfoResponse: Decodable {
    let statusCode: String
    let payload: HighwayInfoPayload
}

struct HighwayInfoPayload: Decodable {
    let highwayVignettes: [HighwayVignetteApiModel]
    let vehicleCategories: [VehicleCategory]
    let counties: [County]
}

struct HighwayVignetteApiModel: Decodable {
    let vignetteType: [String]
    let vehicleCategory: String
    let cost: Float
    let trxFee: Float
    let sum: Float
}

struct HighwayVignette: Identifiable, Equatable, Hashable {
    let id: String
    let type: VignetteType
    let vehicleCategory: String
    let price: Float

    init?(from apiModel: HighwayVignetteApiModel) {
        guard let rawType = apiModel.vignetteType.first,
              let type = VignetteType(rawValue: rawType) else {
            return nil
        }
        self.type = type
        self.vehicleCategory = apiModel.vehicleCategory
        self.price = apiModel.sum
        self.id = "\(rawType)-\(apiModel.vehicleCategory)"
    }

    var title: String {
        type.localizedDescription
    }
}

struct VehicleCategory: Decodable {
    let category: String
    let vignetteCategory: String
    let name: [String: String]
}

struct County: Decodable, Identifiable, Equatable, Hashable {
    let id: String
    let name: String
}

struct VehicleInfo: Decodable {
    let plate: String
    let type: String
    let vignetteType: String
    let name: String
    let internationalRegistrationCode: String
    let country: LocalizedCountry
}

struct LocalizedCountry: Decodable {
    let hu: String
    let en: String
}

struct HighwayOrderRequest: Codable {
    let highwayOrders: [HighwayOrderItem]
}

struct HighwayOrderItem: Codable {
    let type: String
    let category: String
    let cost: Float
}

struct HighwayOrderResponse: Codable {
    let statusCode: String
    let receivedOrders: [HighwayOrderItem]
}

enum VignetteType: String {
    case day = "DAY"
    case week = "WEEK"
    case month = "MONTH"
    case year = "YEAR"

    var localizedDescription: String {
        switch self {
        case .day: return "napi (1 napos)"
        case .week: return "heti (10 napos)"
        case .month: return "havi"
        case .year: return "éves"
        }
    }
}
