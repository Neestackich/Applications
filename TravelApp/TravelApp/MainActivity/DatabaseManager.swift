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
                DatabaseManager.shared.addFirestoreTravelsToRealm()
                
                ////////////////////////!!!!!!!
                
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
            "travelId": UUID().uuidString
        ])
    }
    
//    func createFirebaseStop(geolocation: String, raiting: Int, spentMoneyValue: String, stopCityName: String, stopDescription: String, transport: Int) {
//        let firesoreDatabase = Firestore.firestore()
//        firesoreDatabase.collection("users").document(uid).collection("travels").addDocument(data: [
//            "country": country,
//            "raiting": raiting,
//            "travelDescription": travelDescription,
//            "userId": userId
//        ])
//    }
    
    func addFirestoreUserToRealm() {
        let firestoreDatabase = Firestore.firestore()
        let realmDatabase = try! Realm(configuration: config)
        
        firestoreDatabase.collection("users").document(uid).getDocument { document, error in
            if let document = document, document.exists {
                let dataDescription = document.data()
                
                try! realmDatabase.write {
                    realmDatabase.add(User(firstName: dataDescription?["firstName"] as! String, lastName: dataDescription?["lastName"] as! String, email: dataDescription?["email"] as! String, nickName: dataDescription?["nickName"] as! String, password: dataDescription?["password"] as! String, uid: dataDescription?["uid"] as! String))
                }
            }
        }
        
        print(realmDatabase.configuration.fileURL)
    }
    
    func addFirestoreTravelsToRealm() {
        let firestoreDatabase = Firestore.firestore()
        let realmDatabase = try! Realm(configuration: config)
        
        firestoreDatabase.collection("users").document(uid).collection("travels").getDocuments { documentsList, error in
            if let documentsList = documentsList {
                for document in documentsList.documents {
                    let dataDescription = document.data()
                    
                    try! realmDatabase.write {
                        realmDatabase.add(Travel(raiting: dataDescription["raiting"] as! Int, country: dataDescription[""] as! String, travelDescription: dataDescription["travelDescription"] as! String, stops: List<Stop>()))
                    }
                }
            }
        }
    }
    
    func addFirebaseStopsToRealm(travelId: String) {
        let firebaseDatabase = Firestore.firestore()
        let realmDatabase = try! Realm(configuration: config)

        //firebaseDatabase.collection("users").document(uid).collection("travels").document(travelId).collection("stops").ad
    }
    
    func getFirebaseStops() {
        let firestoreDatabase = Firestore.firestore()
        
        firestoreDatabase.collection("travels").document("6AVfK1bQdlPJn6s1GgsN").collection("stops").document("YnVReziT4y8Aof7Wh4R7").getDocument { document, error in
            if let document = document, document.exists {
                let dataDescription = document.data()
                
                // закинуть в реалм
                
            }
        }
    }
    
//    func getFirebaseUser() -> User? {
//        let firestoreDatabase = Firestore.firestore()
//        var user: User?
//
//        firestoreDatabase.collection("users").document(uid).getDocument { document, error in
//            if let document = document, document.exists {
//                let dataDescription = document.data()
//                let fireUser = User(firstName: dataDescription?["firstName"] as! String, lastName: dataDescription?["lastName"] as! String, email: dataDescription?["email"] as! String, nickName: dataDescription?["nickName"] as! String, password: dataDescription?["password"] as! String, uid: dataDescription?["uid"] as! String)
//                user = fireUser
//            }
//        }
//
//        return user
//    }
    
    func getRealmUser() -> User? {
        let realmDatabase = try! Realm(configuration: config)
       
        if let uid = uid {
            if let user = realmDatabase.objects(User.self).filter("uid = '\(uid)'").first {
                return user
            }
        }
        
        return nil
    }

//    func getRealmTravels() -> [Travel]? {
//        let database = try! Realm(configuration: config)
//
//        if let travels  = database.objects(Travel.self).filter("uid = '\(uid)'").first {
//            return travels
//        }
//
//        return
//    }
    
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
