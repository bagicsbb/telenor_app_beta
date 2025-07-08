//
//  HighwayApiClientInterface.swift
//  telenor_app
//
//  Created by Bagics Bence
//

protocol HighwayApiClientInterface {
    func fetchHighwayInfo() async throws -> HighwayInfoPayload
    func fetchVehicleInfo() async throws -> VehicleInfo
    func placeOrder(request: HighwayOrderRequest) async throws
}
