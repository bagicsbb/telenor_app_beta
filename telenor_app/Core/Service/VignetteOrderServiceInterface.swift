//
//  VignetteOrderServiceInterface.swift
//  telenor_app
//
//  Created by Bagics Bence
//

import Foundation

protocol VignetteOrderServiceInterface {
    func placeOrder(items: [HighwayOrderItem]) async throws
}
