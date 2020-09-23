//
//  AddStopController.swift
//  TravelApp
//
//  Created by Neestackich on 09.08.2020.
//  Copyright © 2020 Neestackich. All rights reserved.
//

import UIKit
import RealmSwift

class AddStopViewController: UIViewController {
    
    
    // MARK: properties
    
    @IBOutlet weak var raiting: UILabel!
    @IBOutlet weak var moneySpent: UILabel!
    @IBOutlet weak var stopName: UITextField!
    @IBOutlet weak var raitingStepper: UIStepper!
    @IBOutlet weak var stopDescription: UITextView!
    @IBOutlet weak var transport: UISegmentedControl!
    
    var user: User!
    var travel: Travel!
    var travelIndex: Int!
    let addMoneyVCID: String = "AddMoney"
    let stopsListVCID: String = "StopsList"
    
    
    // MARK: methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        transport.layer.borderWidth = 1
        transport.layer.borderColor = CGColor.init(srgbRed: 0, green: 122/255, blue: 255/255, alpha: 1)
    }
    
    @IBAction func cancelClick(_ sender: Any) {
        let stopsListVC = storyboard?.instantiateViewController(identifier: stopsListVCID) as! StopsListViewController
        stopsListVC.modalPresentationStyle = .fullScreen
        stopsListVC.travelIndex = travelIndex
        
        present(stopsListVC, animated: true)
    }
    
    @IBAction func saveClick(_ sender: Any) {
        if let name = stopName.text, !name.isEmpty {
            var config = Realm.Configuration()
            config.fileURL = config.fileURL?.deletingLastPathComponent().appendingPathComponent("\(user.email).realm")
            
            let travelsDB = try! Realm(configuration: config)
            
            let travels = travelsDB.objects(Travel.self)
            
            try! travelsDB.write {
                let stop: Stop = Stop()
                stop.raiting = Int(raitingStepper.value)
                stop.stopCityName = name
                //stop.transport = transport.
                stop.stopDescription = stopDescription.text
                
                if let money = moneySpent.text, !money.isEmpty {
                    stop.spentMoneyValue = money
                }
                
                if transport.selectedSegmentIndex == 1 {
                    stop.transport = 1
                } else if transport.selectedSegmentIndex == 2 {
                    stop.transport = 2
                }
            }
            
            let stopsListVC = storyboard?.instantiateViewController(identifier: stopsListVCID) as! StopsListViewController
            stopsListVC.modalPresentationStyle = .fullScreen
            stopsListVC.travelIndex = travelIndex
            
            present(stopsListVC, animated: true)
        }
    }
    
    @IBAction func stepperClick(_ sender: Any) {
        raiting.text = String(raitingStepper.value)
    }
    
    @IBAction func chooseCurrency(_ sender: Any) {
        let addMoneyVC = storyboard?.instantiateViewController(withIdentifier: addMoneyVCID) as! AddMoneyValueController
        addMoneyVC.modalPresentationStyle = .fullScreen
        
        present(addMoneyVC, animated: true)
    }
}
