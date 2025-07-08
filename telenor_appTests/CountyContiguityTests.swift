//
//  CountyContiguityTests.swift
//  telenor_app
//
//  Created by Bagics Bence
//

import Testing
@testable import telenor_app

struct CountyContiguityTests {

    @Test func walksThroughChainOfNeighbors() {
        let chain: Set<String> = ["YEAR_27", "YEAR_28", "YEAR_16", "YEAR_23", "YEAR_19"]
        #expect(CountyContiguity.isConnected(chain) == true)
    }

    @Test func detectsSeparateGroups() {
        let twoGroups: Set<String> = ["YEAR_27", "YEAR_17", "YEAR_13", "YEAR_18"]
        #expect(CountyContiguity.isConnected(twoGroups) == false)
    }

    @Test func wholeCountryIsConsistent() {
        let allCounties: Set<String> = [
            "YEAR_11", "YEAR_12", "YEAR_13", "YEAR_14", "YEAR_15",
            "YEAR_16", "YEAR_17", "YEAR_18", "YEAR_19", "YEAR_20",
            "YEAR_21", "YEAR_22", "YEAR_23", "YEAR_24", "YEAR_25",
            "YEAR_26", "YEAR_27", "YEAR_28", "YEAR_29"
        ]
        #expect(CountyContiguity.isConnected(allCounties) == true)
    }
}
