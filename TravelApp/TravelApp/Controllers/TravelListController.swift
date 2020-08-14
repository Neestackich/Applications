//
//  TravelListController.swift
//  TravelApp
//
//  Created by Neestackich on 07.08.2020.
//  Copyright © 2020 Neestackich. All rights reserved.
//

import UIKit

class TravelListViewController: UIViewController {
    
    
    // MARK: Properties
    
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    
    var user: User!
    var nameOpt: String!
    var email: String!
    
    
    // MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailLabel.text = user?.email
    }
    
//    func linking() {
//        nameLabel.text = user?.firstName
//        lastNameLabel.text = user?.lastName
//        emailLabel.text = user?.email
//        nicknameLabel.text = user?.nickName
//    }
    
    static func classInit(user: User) -> TravelListViewController {
        let travelListController = TravelListViewController()
        travelListController.user = user
        
        
        return travelListController
    }
}
