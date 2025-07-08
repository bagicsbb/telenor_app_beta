//
//  StickerSelectionCoordinator.swift
//  telenor_app
//
//  Created by Bagics Bence
//

import Foundation

@MainActor
final class StickerSelectionCoordinator: ObservableObject, StickerSelectionCoordinatorInterface {
    @Published var path: [Route] = []

    enum Route: Hashable {
        case summary(source: SummarySource)
        case countySelection
        case resultView(success: Bool)
    }

    func showSummary(source: SummarySource) {
        path.append(.summary(source: source))
    }

    func showCountySelection() {
        path.append(.countySelection)
    }
    
    func showResultView(success: Bool) {
        path.append(.resultView(success: success))
    }

    func popToRoot() {
        path.removeAll()
    }
}
