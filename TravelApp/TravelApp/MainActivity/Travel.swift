//
//  Travel.swift
//  TravelApp
//
//  Created by Neestackich on 12.08.2020.
//  Copyright © 2020 Neestackich. All rights reserved.
//

import Foundation
import RealmSwift

class Travel: Object {
    @objc dynamic var raiting: Int = 0
    @objc dynamic var country: String = ""
    @objc dynamic var travelDescription: String = ""
    dynamic var stops: List<Stop> = List<Stop>()
    
    override required init() {}
    
    init(raiting: Int, country: String, travelDescription: String, stops: List<Stop>) {
        self.stops = stops
        self.country = country
        self.raiting = raiting
        self.travelDescription = travelDescription
    }
}
