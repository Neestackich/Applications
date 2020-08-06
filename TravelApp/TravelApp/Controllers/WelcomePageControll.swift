//
//  WelcomePageController.swift
//  TravelApp
//
//  Created by Neestackich on 06.08.2020.
//  Copyright © 2020 Neestackich. All rights reserved.
//

import UIKit

class WelcomePageController: UIViewController {
    
    
    // MARK: properties
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var emailLogin: UIButton!
    @IBOutlet weak var createAccount: UIButton!
    
    
    // MARK: Methods
    
    override func loadView() {
        super.loadView()
        
        welcomeLabel.text! = "Welcome.\nThis is travel app."
        createAccount.layer.cornerRadius = 5
        emailLogin.layer.cornerRadius = 5
    }
    
    
}
