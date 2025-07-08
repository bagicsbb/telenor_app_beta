//
//  StickerSelectorCoordinatorInterface.swift
//  telenor_app
//
//  Created by Bagics Bence
//

import Foundation

@MainActor
protocol StickerSelectionCoordinatorInterface {
    func showCountySelection()
    func showSummary(source: SummarySource)
    func showResultView(success: Bool)
    func popToRoot() 
}
