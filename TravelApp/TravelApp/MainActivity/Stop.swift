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
    @objc dynamic var stopCityName: String = ""
    @objc dynamic var stopDescription: String = ""
    @objc dynamic var spentMoneyValue: String = ""
}
