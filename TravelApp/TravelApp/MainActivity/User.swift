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
    @objc dynamic var name: String = ""
    @objc dynamic var surname: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var nickName: String = ""
    @objc dynamic var password: String = ""
}
