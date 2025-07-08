//
//  CountyShape.swift
//  telenor_app
//
//  Created by Bagics Bence
//

import SwiftUI

struct CountyShape: Identifiable {
    let id: String
    let name: String
    let path: Path
    let isSelectable: Bool
}

extension CountyShape: Hashable {
    static func == (lhs: CountyShape, rhs: CountyShape) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
