//
//  LaunchScreenController.swift
//  TravelApp
//
//  Created by Neestackich on 06.08.2020.
//  Copyright © 2020 Neestackich. All rights reserved.
//

import UIKit

class LaunchScreenController: UIViewController {
    
    
    // MARK: Properties
    
    @IBOutlet weak var welcomeLabel: UILabel!
    

    
    // MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeLabel.text! = "Welcome.\nThis is travel app."
    }
}
