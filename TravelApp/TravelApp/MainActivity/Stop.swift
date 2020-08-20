//
//  Stop.swift
//  TravelApp
//
//  Created by Neestackich on 12.08.2020.
//  Copyright © 2020 Neestackich. All rights reserved.
//

import Foundation
import RealmSwift

class Stop: Object {
    @objc dynamic var raiting: Int = 0
    @objc dynamic var transport: Int = 0
    @objc dynamic var geolocation: String = ""
    @objc dynamic var stopCityName: String = ""
    @objc dynamic var stopDescription: String = ""
    @objc dynamic var spentMoneyValue: String = ""
    
    override required init() {}
    
    init(raiting: Int, stopCityName: String, stopDescription: String, spentMoneyValue: String) {
        self.raiting = raiting
        self.stopCityName = stopCityName
        self.stopDescription = stopDescription
        self.spentMoneyValue = spentMoneyValue
    }
}
