//
//  HighwayApiClient.swift
//  telenor_app
//
//  Created by Bagics Bence
//

import Foundation

final class HighwayApiClient: HighwayApiClientInterface {

    func fetchVehicleInfo() async throws -> VehicleInfo {
        let url = Constants.baseURL.appendingPathComponent(Constants.vehiclePath)
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(VehicleInfo.self, from: data)
    }

    func fetchHighwayInfo() async throws -> HighwayInfoPayload {
        let url = Constants.baseURL.appendingPathComponent(Constants.infoPath)
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(HighwayInfoResponse.self, from: data)
        return response.payload
    }

    func placeOrder(request: HighwayOrderRequest) async throws {
        let url = Constants.baseURL.appendingPathComponent(Constants.orderPath)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = Constants.postMethod
        urlRequest.setValue(Constants.contentTypeJson, forHTTPHeaderField: Constants.headerContentType)
        urlRequest.httpBody = try JSONEncoder().encode(request)

        let (_, response) = try await URLSession.shared.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == Constants.successStatusCode else {
            throw APIError.invalidResponse
        }
    }
}

enum APIError: Error {
    case invalidResponse
}

private enum Constants {
    static let baseURL = URL(string: "http://127.0.0.1:8080")!

    static let vehiclePath = "v1/highway/vehicle"
    static let infoPath = "v1/highway/info"
    static let orderPath = "v1/highway/order"

    static let postMethod = "POST"
    static let contentTypeJson = "application/json"
    static let headerContentType = "Content-Type"

    static let successStatusCode = 200
}
