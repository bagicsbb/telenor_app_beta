//
//  VignetteOrderService.swift
//  telenor_app
//
//  Created by Bagics Bence
//

import Foundation

final class VignetteOrderService: VignetteOrderServiceInterface {
    private let apiClient: HighwayApiClientInterface

    init(apiClient: HighwayApiClientInterface) {
        self.apiClient = apiClient
    }

    func placeOrder(items: [HighwayOrderItem]) async throws {
        let request = HighwayOrderRequest(highwayOrders: items)
        try await apiClient.placeOrder(request: request)
    }
}
