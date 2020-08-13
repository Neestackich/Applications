//
//  Travel.swift
//  TravelApp
//
//  Created by Neestackich on 12.08.2020.
//  Copyright © 2020 Neestackich. All rights reserved.
//

import UIKit

class Travel: NSObject {
    @objc dynamic var country: String = ""
    @objc dynamic var stops: [Stop] = []
    
    init(country: String, stops: [Stop]) {
        self.country = country
        self.stops = stops
    }
}
