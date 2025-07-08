//
//  HungaryMapView.swift
//  telenor_app
//
//  Created by Bagics Bence
//

import SwiftUI

struct HungaryMapView: View {
    let selectedIds: Set<String>
    let onTap: (String) -> Void

    var body: some View {
        GeometryReader { proxy in
            let scale = min(
                proxy.size.width / CountyMap.canvasSize.width,
                proxy.size.height / CountyMap.canvasSize.height
            )

            ZStack(alignment: .topLeading) {
                ForEach(CountyMap.shapes) { county in
                    county.path
                        .fill(fillColor(for: county))
                        .overlay(county.path.stroke(Color.white, lineWidth: 0.5))
                        .contentShape(county.path)
                        .onTapGesture {
                            guard county.isSelectable else { return }
                            onTap(county.id)
                        }
                }
            }
            .frame(
                width: CountyMap.canvasSize.width,
                height: CountyMap.canvasSize.height,
                alignment: .topLeading
            )
            .scaleEffect(scale, anchor: .topLeading)
        }
    }

    private func fillColor(for county: CountyShape) -> Color {
        guard county.isSelectable else {
            return Color(.systemGray4)
        }
        return selectedIds.contains(county.id) ? Constants.selectedFill : Constants.unselectedFill
    }
}

private extension HungaryMapView {
    enum Constants {
        static let selectedFill = Color(red: 0.71, green: 1.0, blue: 0.0)
        static let unselectedFill = Color(red: 0.77, green: 0.87, blue: 0.91)
    }
}
