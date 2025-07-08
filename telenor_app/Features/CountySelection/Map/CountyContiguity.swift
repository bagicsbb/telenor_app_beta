//
//  CountyContiguity.swift
//  telenor_app
//
//  Created by Bagics Bence
//

import Foundation

enum CountyContiguity {
    static func isConnected(_ selected: Set<String>) -> Bool {
        guard let start = selected.first else { return true }

        var reached: Set<String> = [start]
        var toCheck: [String] = [start]

        while let current = toCheck.popLast() {
            for neighbor in CountyAdjacency.neighbors[current] ?? [] {
                if selected.contains(neighbor), !reached.contains(neighbor) {
                    reached.insert(neighbor)
                    toCheck.append(neighbor)
                }
            }
        }

        return reached == selected
    }
}
