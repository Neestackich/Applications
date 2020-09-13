//
//  User.swift
//  TravelApp
//
//  Created by Neestackich on 12.08.2020.
//  Copyright © 2020 Neestackich. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var uid: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var nickName: String = ""
    @objc dynamic var password: String = ""
    @objc dynamic var firstName: String = ""
    
    override required init() {}
    
    init(firstName: String, lastName: String, email: String, nickName: String, password: String, uid: String) {
        self.uid = uid
        self.email = email
        self.lastName = lastName
        self.nickName = nickName
        self.password = password
        self.firstName = firstName
    }
}
