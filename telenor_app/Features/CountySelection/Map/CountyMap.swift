//
//  CountyMap.swift
//  telenor_app
//
//  Created by Bagics Bence
//

import SwiftUI
import PocketSVG

enum CountyMap {
    static let canvasSize = CGSize(width: 313, height: 188)

    static let shapes: [CountyShape] = loadShapes()

    private static func loadShapes() -> [CountyShape] {
        guard let url = Bundle.main.url(forResource: "hungary_map", withExtension: "svg") else {
            assertionFailure("hungary_map.svg missing from bundle")
            return []
        }

        return SVGBezierPath.pathsFromSVG(at: url).compactMap { svgPath in
            let id = svgPath.svgAttributes["id"] as? String ?? ""
            guard let mapping = mapping[id] else { return nil }
            return CountyShape(
                id: mapping.id,
                name: mapping.name,
                path: Path(svgPath.cgPath),
                isSelectable: mapping.id != "budapest"
            )
        }
    }

    private static let mapping: [String: (id: String, name: String)] = [
        "Vector_2":          ("YEAR_14", "Borsod-Abaúj-Zemplén"),
        "Vector_3":          ("YEAR_25", "Szabolcs-Szatmár-Bereg"),
        "Vector_6":          ("YEAR_22", "Nógrád"),
        "Vector_5":          ("YEAR_19", "Heves"),
        "gyor-moson-sopron": ("YEAR_17", "Győr-Moson-Sopron"),
        "Vector_10":         ("YEAR_21", "Komárom-Esztergom"),
        "Vector_4":          ("YEAR_18", "Hajdú-Bihar"),
        "Vector_11":         ("YEAR_23", "Pest"),
        "Vector":            ("YEAR_20", "Jász-Nagykun-Szolnok"),
        "Vector_14":         ("YEAR_27", "Vas"),
        "Vector_12":         ("YEAR_28", "Veszprém"),
        "Vector_13":         ("YEAR_16", "Fejér"),
        "Vector_8":          ("YEAR_13", "Békés"),
        "zala":              ("YEAR_29", "Zala"),
        "bacs-kiskun":       ("YEAR_11", "Bács-Kiskun"),
        "tolna":             ("YEAR_26", "Tolna"),
        "Vector_15":         ("YEAR_24", "Somogy"),
        "Vector_9":          ("YEAR_15", "Csongrád-Csanád"),
        "baranya":           ("YEAR_12", "Baranya"),
        "Vector_7":          ("budapest", "Budapest"),
    ]
}
