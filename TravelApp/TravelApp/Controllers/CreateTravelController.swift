//
//  CreateTravelController.swift
//  TravelApp
//
//  Created by Neestackich on 16.08.2020.
//  Copyright © 2020 Neestackich. All rights reserved.
//

import UIKit
import RealmSwift

class CreateTravelController: UIViewController {

    
    // MARK: Properties
    
    @IBOutlet weak var raitingLabel: UILabel!
    @IBOutlet weak var nameUnderline: UIView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var raitingUnderline: UIView!
    @IBOutlet weak var descriptionUnderline: UIView!
    @IBOutlet weak var raitingStepper: UIStepper!
    @IBOutlet weak var descriptionField: UITextField!
    
    var travel: Travel!
    
    var userEmail: String!
    
    
    // MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    // MARK: -buttons' handlers
    
    @IBAction func cancelClick(_ sender: Any) {
        let travelListVC = storyboard?.instantiateViewController(identifier: "Travels list") as! TravelListViewController
        travelListVC.modalPresentationStyle = .fullScreen
        
        present(travelListVC, animated: true)
    }
    
    @IBAction func saveClick(_ sender: Any) {
        if let name = nameField.text, !name.isEmpty, let description = descriptionField.text, !description.isEmpty {
            var config = Realm.Configuration()
            
            if let email = userEmail {
                config.fileURL = config.fileURL?.deletingLastPathComponent().appendingPathComponent("\(email).realm")
            }
            
            let travelList = try! Realm(configuration: config)
            
            //print(travelList.configuration.fileURL)
            
            try! travelList.write {
                travelList.add(Travel(raiting: Int(raitingStepper.value), country: name, travelDescription: description, stops: List<Stop>()))
            }
            
            let travelListVC = storyboard?.instantiateViewController(identifier: "Travels list") as! TravelListViewController
            travelListVC.modalPresentationStyle = .fullScreen
            
            present(travelListVC, animated: true)
        } else {
            if (nameField.text?.isEmpty)! {
                slowedColorChange(objects: nameUnderline, color: .red, duration: 1.3)
            }
            
            if (descriptionField.text?.isEmpty)! {
                slowedColorChange(objects: descriptionUnderline, color: .red, duration: 1.3)
            }
        }
    }
    
    @IBAction func stepperClick(_ sender: Any) {
        raitingLabel.text = String(raitingStepper.value)
    }
    
    
    // MARK: -
    
    func slowedColorChange<T: UIView>(objects: T..., color: UIColor, duration: TimeInterval) {
        UIView.animate(withDuration: duration, animations: {
            for object in objects {
                if object is UIButton {
                    object.tintColor = color
                } else {
                    object.backgroundColor = color
                }
            }
        })
    }
}
