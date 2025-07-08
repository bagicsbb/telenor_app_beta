//
//  Strings.swift
//  telenor_app
//
//  Created by Bagics Bence
//

import Foundation

enum Strings {

    enum Common {
        static let purchase = String(localized: "Vásárlás")
        static let confirm = String(localized: "Rendben")
        static let cancel = String(localized: "Mégsem")
        static let currency = String(localized: "Ft")
        static let totalLabel = String(localized: "Fizetendő összeg")
        static let countyYearlyTitle = String(localized: "Éves vármegyei matricák")

        enum Period {
            static let daily = String(localized: "napi (1 napos)")
            static let weekly = String(localized: "heti (10 napos)")
            static let monthly = String(localized: "havi")
            static let yearly = String(localized: "éves")
        }
    }

    enum StickerSelection {
        static let title = String(localized: "Matrica választás")
        static let national = String(localized: "Országos matricák")
        static let countySelect = String(localized: "Vármegyék kiválasztása")
    }

    enum CountySelection {
        static let alertTitle = String(localized: "Figyelmeztetés")
        static let warning = String(localized: "A kiválasztott vármegyék nem összefüggőek.")
        static let continueButton = String(localized: "Tovább")
    }

    enum Summary {
        static let navTitle = String(localized: "E-matrica")
        static let header = String(localized: "Vásárlás megerősítése")
        static let plate = String(localized: "Rendszám")
        static let stickerType = String(localized: "Matrica típusa")
        static let processing = String(localized: "Feldolgozás…")
        static let national = String(localized: "Országos matrica")
        static let county = String(localized: "Éves vármegyei")
    }

    enum Result {
        static let success = String(localized: "A matrica\nvásárlás\nsikeres!")
        static let failure = String(localized: "A vásárlás\nsikertelen volt")
    }
}
