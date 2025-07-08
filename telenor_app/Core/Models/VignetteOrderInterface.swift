//
//  VignetteOrderInterface.swift
//  telenor_app
//
//  Created by Bagics Bence
//

import Foundation
import Combine

@MainActor
protocol VignetteOrderInterface: AnyObject {
    var nationalVignette: HighwayVignette? { get set }
    var countyVignettes: [CountyVignette] { get set }

    var nationalVignettePublisher: Published<HighwayVignette?>.Publisher { get }
    var countyVignettesPublisher: Published<[CountyVignette]>.Publisher { get }

    var countyPrice: Float { get }

    func clear()
    func toggleCounty(_ item: CountyVignette)
    func isCountySelected(_ county: County) -> Bool
}
