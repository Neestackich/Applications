//
//  AddMoneyValueController.swift
//  TravelApp
//
//  Created by Neestackich on 17.08.2020.
//  Copyright © 2020 Neestackich. All rights reserved.
//

import UIKit

class AddMoneyValueController: UIViewController {

    
    // MARK: Properties
    
    @IBOutlet weak var currencyType: UIStackView!
    
    
    // MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
    func setup() {
        currencyType.layer.borderColor = UIColor(red: 126, green: 140, blue: 229, alpha: 1) as! CGColor
    }
}
