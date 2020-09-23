//
//  AddMoneyValueController.swift
//  TravelApp
//
//  Created by Neestackich on 17.08.2020.
//  Copyright © 2020 Neestackich. All rights reserved.
//

import UIKit

class AddMoneyValueViewController: UIViewController {

    
    // MARK: Properties
    
    @IBOutlet weak var currencyType: UISegmentedControl!
    
    
    // MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    func setup() {
        currencyType.layer.borderWidth = 1
        currencyType.layer.borderColor = CGColor(srgbRed: 126/255, green: 140/255, blue: 229/255, alpha: 1)
    }
}
