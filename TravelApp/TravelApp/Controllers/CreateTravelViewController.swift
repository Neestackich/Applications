//
//  CreateTravelController.swift
//  TravelApp
//
//  Created by Neestackich on 16.08.2020.
//  Copyright © 2020 Neestackich. All rights reserved.
//

import UIKit
import RealmSwift

class CreateTravelViewController: UIViewController {

    
    // MARK: Properties
    
    @IBOutlet weak var raitingLabel: UILabel!
    @IBOutlet weak var nameUnderline: UIView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var raitingUnderline: UIView!
    @IBOutlet weak var descriptionUnderline: UIView!
    @IBOutlet weak var raitingStepper: UIStepper!
    @IBOutlet weak var descriptionField: UITextField!
    
    var user: User!
    var travel: Travel!
    let tarvelsListVCID: String = "Travels list"
    
    
    // MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: -buttons' handlers
    
    @IBAction func cancelClick(_ sender: Any) {
        let travelListVC = storyboard?.instantiateViewController(identifier: tarvelsListVCID) as! TravelListViewController
        travelListVC.modalPresentationStyle = .fullScreen
        //travelListVC.user = user
        
        present(travelListVC, animated: true)
    }
    
    @IBAction func saveClick(_ sender: Any) {
        if let name = nameField.text, !name.isEmpty, let description = descriptionField.text, !description.isEmpty {
            var config = Realm.Configuration()

            config.fileURL = config.fileURL?.deletingLastPathComponent().appendingPathComponent("\(user.email).realm")
            
            let travelList = try! Realm(configuration: config)
            
            //print(travelList.configuration.fileURL)
            
            try! travelList.write {
                travelList.add(Travel(travelid: UUID().uuidString, raiting: Int(raitingStepper.value), country: name, travelDescription: description))
            }
            
            
            // добавить добавление в файербейз
            
            
            let travelListVC = storyboard?.instantiateViewController(identifier: "Travels list") as! TravelListViewController
            travelListVC.modalPresentationStyle = .fullScreen
            //travelListVC.user = user
            
            present(travelListVC, animated: true)
        } else {
            if nameField.text?.isEmpty == true {
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
    
    
    // MARK: -animation functions
    
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
