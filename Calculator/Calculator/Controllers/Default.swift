//
//  Default.swift
//  Calculator
//
//  Created by Neestackich on 26.07.2020.
//  Copyright © 2020 Neestackich. All rights reserved.
//

import UIKit

class Default: UIViewController {

    @IBOutlet weak var trailing: NSLayoutConstraint!
    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var expression: UILabel!
    
    var operation: String!
    
    var menuOut: Bool = false
    var bracketExists: Bool = false
    
    var result: Double = 0
    var bracketsQuantity: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        }
    }
    
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
        if !bracketExists {
            expression.text! += "("
            bracketsQuantity += 1
        } else {
            if bracketsQuantity != 0 {
                expression.text! += ")"
                bracketsQuantity -= 1
            } else {
                expression.text! += "("
                bracketExists = false
            }
        }
    }
    
    @IBAction func divisionClick(_ sender: Any) {
        expression.text! += "/"

        bracketExists = true
    }
}
