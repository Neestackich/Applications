//
//  AddStopController.swift
//  TravelApp
//
//  Created by Neestackich on 09.08.2020.
//  Copyright © 2020 Neestackich. All rights reserved.
//

import UIKit
import RealmSwift

class AddStopController: UIViewController {
    
    
    // MARK: properties
    
    @IBOutlet weak var raiting: UILabel!
    @IBOutlet weak var moneySpent: UILabel!
    @IBOutlet weak var stopName: UITextField!
    @IBOutlet weak var raitingStepper: UIStepper!
    @IBOutlet weak var stopDescription: UITextView!
    
    var user: User!
    var travelIndex: Int!
    let stopsListVCID: String = "StopsList"
    
    
    // MARK: methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cancelClick(_ sender: Any) {
        let stopsListVC = storyboard?.instantiateViewController(identifier: stopsListVCID) as! StopsListController
        stopsListVC.modalPresentationStyle = .fullScreen
        stopsListVC.user = user
        
        present(stopsListVC, animated: true)
    }
    
    @IBAction func saveClick(_ sender: Any) {
        if let name = stopName.text, !name.isEmpty {
            var config = Realm.Configuration()
            config.fileURL = config.fileURL?.deletingLastPathComponent().appendingPathComponent("\(user.email).realm")
            
            let travelsDB = try! Realm(configuration: config)
            print(travelsDB.configuration.fileURL)
            
            let travels = travelsDB.objects(Travel.self)
            //print(travels[travelIndex])
            
            try! travelsDB.write {
                let stop: Stop = Stop()
                stop.raiting = Int(raitingStepper.value)
                stop.stopCityName = name
                
                travels[travelIndex].stops.append(stop)

                
//                travels[travelIndex].stops.append(Stop(raiting: Int(raitingStepper.value), stopCityName: name, stopDescription: stopDescription, spentMoneyValue: moneySpent))
            }
            
            let stopsListVC = storyboard?.instantiateViewController(identifier: stopsListVCID) as! StopsListController
            stopsListVC.modalPresentationStyle = .fullScreen
            stopsListVC.user = user
            stopsListVC.travelIndex = travelIndex
            
            present(stopsListVC, animated: true)
        }
    }
}
