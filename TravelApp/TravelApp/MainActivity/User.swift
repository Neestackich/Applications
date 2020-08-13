//
//  User.swift
//  TravelApp
//
//  Created by Neestackich on 12.08.2020.
//  Copyright © 2020 Neestackich. All rights reserved.
//

import UIKit
import RealmSwift

class User: Object {
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var nickName: String = ""
    @objc dynamic var password: String = ""
    
    init(firstName: String, lastName: String, email: String, nickName: String, password: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.nickName = nickName
        self.password = password
    }
    
    override required init() {
    }
}
