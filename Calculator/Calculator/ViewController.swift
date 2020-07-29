//
//  ViewController.swift
//  Calculator
//
//  Created by Neestackich on 26.07.2020.
//  Copyright © 2020 Neestackich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var trailing: NSLayoutConstraint!
    @IBOutlet weak var leading: NSLayoutConstraint!
    
    var menuOut: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
<<<<<<< HEAD:Calculator/Calculator/Controllers/Default.swift
=======
        // Do any additional setup after loading the view.
>>>>>>> 1ee505973522313a04023333e60bf1b72227b6e2:Calculator/Calculator/ViewController.swift
    }

    @IBAction func hamburgerClick(_ sender: Any) {
        if !menuOut {
            trailing.constant = -150
            leading.constant = 150
            menuOut = true
        } else {
            trailing.constant = 0
            leading.constant = 0
            menuOut = false
        }
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: { self.view.layoutIfNeeded() }) {
            (animationComolete) in
<<<<<<< HEAD:Calculator/Calculator/ViewController.swift
            print("Animation completed")
=======
>>>>>>> development:Calculator/Calculator/Controllers/Default.swift
        }
    }
    
<<<<<<< HEAD:Calculator/Calculator/Controllers/Default.swift
    @IBAction func sevenClick(_ sender: Any) {
        expression.text! += "7"
    }

    @IBAction func eightClick(_ sender: Any) {
        expression.text! += "8"
    }
    
    @IBAction func nineClick(_ sender: Any) {
        expression.text! += "9"
    }
    
    @IBAction func fourClick(_ sender: Any) {
        expression.text! += "4"
    }
    
    @IBAction func fiveClick(_ sender: Any) {
        expression.text! += "5"
    }
    
    @IBAction func sixClick(_ sender: Any) {
        expression.text! += "6"
    }
    
    @IBAction func oneClick(_ sender: Any) {
        expression.text! += "1"
    }
    
    @IBAction func twoClick(_ sender: Any) {
        expression.text! += "2"
    }
    
    @IBAction func threeClick(_ sender: Any) {
        expression.text! += "3"
    }
    
    @IBAction func clearClick(_ sender: Any) {
        expression.text! = ""
    }
    @IBAction func multiplyClick(_ sender: Any) {
        expression.text! += "x"
    }
    
    @IBAction func bracketsClick(_ sender: Any) {
        if !bracket {
            expression.text! += "("
        } else {
            expression.text! += ")"
        }
    }

    @IBAction func divisionClick(_ sender: Any) {
        expression.text! += "/"

        bracket = true
    }
=======
>>>>>>> 1ee505973522313a04023333e60bf1b72227b6e2:Calculator/Calculator/ViewController.swift
}

