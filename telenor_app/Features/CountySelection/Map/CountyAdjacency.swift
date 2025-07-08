//
//  CountyAdjacency.swift
//  telenor_app
//
//  Created by Bagics Bence
//

import Foundation

enum CountyAdjacency {
    static let neighbors: [String: Set<String>] = [
        "YEAR_11": ["YEAR_23", "YEAR_20", "YEAR_15", "YEAR_26"],                             // Bács-Kiskun
        "YEAR_12": ["YEAR_24", "YEAR_26"],                                                   // Baranya
        "YEAR_13": ["YEAR_15", "YEAR_20", "YEAR_18"],                                        // Békés
        "YEAR_14": ["YEAR_19", "YEAR_22", "YEAR_18", "YEAR_25", "YEAR_20"],                  // Borsod-Abaúj-Zemplén
        "YEAR_15": ["YEAR_11", "YEAR_20", "YEAR_13"],                                        // Csongrád-Csanád
        "YEAR_16": ["YEAR_21", "YEAR_23", "YEAR_26", "YEAR_24", "YEAR_28"],                  // Fejér
        "YEAR_17": ["YEAR_21", "YEAR_27", "YEAR_28"],                                        // Győr-Moson-Sopron
        "YEAR_18": ["YEAR_14", "YEAR_25", "YEAR_13", "YEAR_20"],                             // Hajdú-Bihar
        "YEAR_19": ["YEAR_22", "YEAR_14", "YEAR_20", "YEAR_23"],                             // Heves
        "YEAR_20": ["YEAR_23", "YEAR_19", "YEAR_14", "YEAR_18", "YEAR_13", "YEAR_15", "YEAR_11"], // Jász-Nagykun-Szolnok
        "YEAR_21": ["YEAR_17", "YEAR_28", "YEAR_16", "YEAR_23"],                             // Komárom-Esztergom
        "YEAR_22": ["YEAR_23", "YEAR_19", "YEAR_14"],                                        // Nógrád
        "YEAR_23": ["YEAR_21", "YEAR_22", "YEAR_19", "YEAR_20", "YEAR_11", "YEAR_16"],       // Pest
        "YEAR_24": ["YEAR_29", "YEAR_28", "YEAR_16", "YEAR_26", "YEAR_12"],                  // Somogy
        "YEAR_25": ["YEAR_14", "YEAR_18"],                                                   // Szabolcs-Szatmár-Bereg
        "YEAR_26": ["YEAR_24", "YEAR_16", "YEAR_11", "YEAR_12"],                             // Tolna
        "YEAR_27": ["YEAR_17", "YEAR_28", "YEAR_29"],                                        // Vas
        "YEAR_28": ["YEAR_17", "YEAR_21", "YEAR_16", "YEAR_24", "YEAR_29", "YEAR_27"],       // Veszprém
        "YEAR_29": ["YEAR_27", "YEAR_28", "YEAR_24"]                                         // Zala
    ]
}
