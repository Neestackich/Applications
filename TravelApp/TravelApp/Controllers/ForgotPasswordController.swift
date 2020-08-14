//
//  ForgotPasswordController.swift
//  TravelApp
//
//  Created by Neestackich on 09.08.2020.
//  Copyright © 2020 Neestackich. All rights reserved.
//

import UIKit

class ForgotPasswordController: UIViewController {
    
    
    // MARK: Properties
    
    @IBOutlet weak var resetPasswordButton: UIButton!
    
    
    // MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetPasswordButton.layer.cornerRadius = 5
    }
}
