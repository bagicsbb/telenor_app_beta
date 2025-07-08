//
//  VignetteOrder.swift
//  telenor_app
//
//  Created by Bagics Bence
//

import Foundation

@MainActor
final class VignetteOrder: ObservableObject, VignetteOrderInterface {
    @Published var nationalVignette: HighwayVignette?
    @Published var countyVignettes: [CountyVignette] = []

    var nationalVignettePublisher: Published<HighwayVignette?>.Publisher { $nationalVignette }
    var countyVignettesPublisher: Published<[CountyVignette]>.Publisher { $countyVignettes }

    var countyPrice: Float {
        countyVignettes.reduce(0) { partialResult, countyVignette in
            partialResult + countyVignette.vignette.price
        }
    }

    func clear() {
        nationalVignette = nil
        countyVignettes = []
    }

    func toggleCounty(_ item: CountyVignette) {
        if let index = countyVignettes.firstIndex(where: { countyVignette in
            countyVignette.county.id == item.county.id
        }) {
            countyVignettes.remove(at: index)
        } else {
            countyVignettes.append(item)
        }
    }

    func isCountySelected(_ county: County) -> Bool {
        countyVignettes.contains(where: { countyVignette in
            countyVignette.county == county
        })
    }
}
