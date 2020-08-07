//
//  LoginWithEmailController.swift
//  TravelApp
//
//  Created by Neestackich on 07.08.2020.
//  Copyright © 2020 Neestackich. All rights reserved.
//

import UIKit

class LoginWithEmailController: UIViewController {
    
    
    // MARK: properties
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailUnderline: UIView!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordUnderline: UIView!
    @IBOutlet weak var loginButton: UIButton!
    
    
    
    // MARK: methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = 5
    }
}
