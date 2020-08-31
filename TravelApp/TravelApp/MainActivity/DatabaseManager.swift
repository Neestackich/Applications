//
//  File.swift
//  TravelApp
//
//  Created by Neestackich on 31.08.2020.
//  Copyright © 2020 Neestackich. All rights reserved.
//

import Foundation
class DatabaseManager {
    static let shared = DatabaseManager()
    
    func setupDatabase() {
        
    }
    
    func getUser() -> User {
        return realm....
    }
    
    func getTravels() -> [Travel] {
        let user = getUser()
        return realm.object....
    }
    
    
    
}
