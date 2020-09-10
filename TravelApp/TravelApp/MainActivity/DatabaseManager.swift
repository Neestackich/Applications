//
//  File.swift
//  TravelApp
//
//  Created by Neestackich on 31.08.2020.
//  Copyright © 2020 Neestackich. All rights reserved.
//


import Firebase
import Foundation
import RealmSwift
import FirebaseAuth
import FirebaseFirestore

class DatabaseManager {
    
    
    // MARK: -Properties
    
    private var uid: String!
    private var stopid: String!
    private var travelid: String!
    static let shared = DatabaseManager()
    private var config = Realm.Configuration()
    private let databasePath: String = "travelAppUsers"
    
    
    // MARK: -Methods
    
    private init() {}
    
    func setupRealmDatabase(travelid: String) {
        self.travelid = travelid
    }
    
    func setupRealmDatabase(stopid: String) {
        self.stopid = stopid
    }
    
    func setupRealmDatabase(dbPath: String, uid: String) {
        config.fileURL = config.fileURL?.deletingLastPathComponent().appendingPathComponent("\(dbPath).realm")
        self.uid = uid
    }
    
    func signInFirebaseUser(email: String, password: String) -> AuthErrorCode? {
        var errorCode: AuthErrorCode?
        
        Auth.auth().signIn(withEmail: email, password: password ) { signInResult, error in
            if error != nil {
                errorCode = AuthErrorCode(rawValue: error!._code)
            } else {
                DatabaseManager.shared.setupRealmDatabase(dbPath: self.databasePath, uid: signInResult!.user.uid)
                DatabaseManager.shared.addFirestoreUserToRealm()
                DatabaseManager.shared.addFirestoreTravelsToRealm()
                
                print("Successful sign in")
            }
        }
        
        return errorCode
    }
    
    func createFirebaseUser(email: String, password: String, firstName: String, lastName: String, nickName: String) -> AuthErrorCode? {
        var errorCode: AuthErrorCode?
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error != nil {
                errorCode = AuthErrorCode(rawValue: error!._code)
            } else {
                DatabaseManager.shared.setupRealmDatabase(dbPath: self.databasePath, uid: authResult!.user.uid)
                DatabaseManager.shared.addFirestoreUserToRealm()
                
                let firesoreDatabase = Firestore.firestore()
                firesoreDatabase.collection("users").document(authResult!.user.uid).setData([
                    "email": email,
                    "firstName": firstName,
                    "lastName": lastName,
                    "nickName": nickName,
                    "password": password,
                    "uid": authResult!.user.uid
                    ]) { error in
                    if error != nil {
                         // обработать ошибку
                    }
                    }
                }
            }
        
        return errorCode
    }
    
    func createFirebaseTravel(userId: String, raiting: Int, country: String, travelDescription: String) {
        let firesoreDatabase = Firestore.firestore()
        firesoreDatabase.collection("users").document(uid).collection("travels").addDocument(data: [
            "country": country,
            "raiting": raiting,
            "travelDescription": travelDescription,
            "travelid": UUID().uuidString
        ])
    }
    
    func createFirebaseStop(geolocation: String, raiting: Int, spentMoneyValue: String, stopCityName: String, stopDescription: String, transport: Int) {
        let firesoreDatabase = Firestore.firestore()
        firesoreDatabase.collection("users").document(uid).collection("travels").addDocument(data: [
            "geolocation": geolocation,
            "raiting": raiting,
            "stopCityName": stopCityName,
            "spentMoneyValue": spentMoneyValue,
            "stopDescription": stopDescription,
            "transport": transport,
            "stopid": UUID().uuidString
        ])
    }
    
    func addFirestoreUserToRealm() {
        let firestoreDatabase = Firestore.firestore()
        let realmDatabase = try! Realm(configuration: config)
        
        if let uid = uid {
            firestoreDatabase.collection("users").document(uid).getDocument { document, error in
                if let document = document, document.exists {
                    let dataDescription = document.data()
                    
                    try! realmDatabase.write {
                        realmDatabase.add(User(firstName: dataDescription?["firstName"] as! String, lastName: dataDescription?["lastName"] as! String, email: dataDescription?["email"] as! String, nickName: dataDescription?["nickName"] as! String, password: dataDescription?["password"] as! String, uid: dataDescription?["uid"] as! String))
                    }
                }
            }
        }
        print(realmDatabase.configuration.fileURL)
    }
    
    func addFirestoreTravelsToRealm() {
        let firestoreDatabase = Firestore.firestore()
        let realmDatabase = try! Realm(configuration: config)
        
        if let uid = uid {
            firestoreDatabase.collection("users").document(uid).collection("travels").getDocuments { documentsList, error in
                if let documentsList = documentsList {
                    for document in documentsList.documents {
                        let dataDescription = document.data()
                        
                        try! realmDatabase.write {
                            realmDatabase.add(Travel(travelid: dataDescription["travelId"] as! String, raiting: dataDescription["raiting"] as! Int, country: dataDescription["country"] as! String, travelDescription: dataDescription["travelDescription"] as! String, stops: List<Stop>()))
                        }
                    }
                }
            }
        }
    }
    
    func addFirebaseStopsToRealm() {
        let firebaseDatabase = Firestore.firestore()
        let realmDatabase = try! Realm(configuration: config)
        
        if let unwrappedUid = uid, let unwrappedTravelid = travelid {
            firebaseDatabase.collection("users").document(unwrappedUid).collection("travels").document(unwrappedTravelid).collection("stops").getDocuments { documentsList, error in
                if let documentsList = documentsList {
                    for document in documentsList.documents {
                        let dataDescription = document.data()
                        
                        try! realmDatabase.write {
                            realmDatabase.add(Stop(geolocation: dataDescription["geolocation"] as! String, raiting: dataDescription["raiting"] as! Int, spentMoneyValue: dataDescription["spentMoneyValue"] as! String, stopCityName: dataDescription["stopCityName"] as! String, stopDescription: dataDescription["stopDescription"] as! String, transport: dataDescription["transport"] as! Int, stopid: dataDescription["stopid"] as! String))
                        }
                    }
                }
            }
        }
    }
    
    func updateFirebaseTravel(raiting: Int, country: String, travelDescription: String) {
        let firebaseDatabase = Firestore.firestore()
        
        if let unwrappedUid = uid, let unwrappedTravelid = travelid {
            firebaseDatabase.collection("users").document(unwrappedUid).collection("travels").document(unwrappedTravelid).updateData([
                "raiting": raiting,
                "country": country,
                "travelDescription": travelDescription
            ]) { error in
                
            }
        }
    }
    
    func updateFirebaseStop() {
        
    }
    
    func updateRealmStop() {
        
    }
    
    func getRealmUser() -> User? {
        let realmDatabase = try! Realm(configuration: config)
       
        if let uid = uid {
            if let user = realmDatabase.objects(User.self).filter("uid = '\(uid)'").first {
                return user
            }
        }
        
        return nil
    }

    func getRealmTravels() -> Results<Travel>? {
        let realmDatabase = try! Realm(configuration: config)

        return realmDatabase.objects(Travel.self)
    }
    
    func getRealmStops() -> Results<Stop>? {
        let realmDatabase = try! Realm(configuration: config)
        
        return realmDatabase.objects(Stop.self)
    }
    
    //
    
    func deleteExactRealmUser() {
        let realmUsersDatabase = try! Realm(configuration: config)
        
        if uid != nil {
            try! realmUsersDatabase.write {
                
            }
        }
    }
    
    func clearObjects() {
        let realmUsersDatabase = try! Realm(configuration: config)
        
        if uid != nil {
            try! realmUsersDatabase.write {
                realmUsersDatabase.deleteAll()
            }
        }
    }
}
