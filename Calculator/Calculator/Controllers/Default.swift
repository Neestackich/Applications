//
//  Default.swift
//  Calculator
//
//  Created by Neestackich on 26.07.2020.
//  Copyright © 2020 Neestackich. All rights reserved.
//

import UIKit

class Default: UIViewController {

    
    // MARK: properties
    
    @IBOutlet weak var expression: UILabel!
    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var trailing: NSLayoutConstraint!
    
    var menuOut: Bool = false
    var commaExists: Bool = false
    var bracketExists: Bool = false
    
    var result: Double = 0
    
    var operation: String!
    
    var bracketsQuantity: Int = 0
    
    
    // MARK: viewDialog and buttons' handlers
    
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
    
    @IBAction func backSpaceClick(_ sender: Any) {
        if expression.text?.count != 0 {
            if expression.text?.last == ")" {
                expression.text?.removeLast()
                bracketsQuantity += 1
                doesBracketsExist()
            } else if expression.text?.last == "(" {
                expression.text?.removeLast()
                bracketsQuantity -= 1
            } else if expression.text?.last == " " {
                for _ in 1...3 {
                    expression.text?.removeLast()
                }
                
                doesBracketsExist()
            } else if expression.text?.last == "." {
                expression.text?.removeLast()
                commaExists = false
            } else {
                expression.text?.removeLast()
            }
        }
    }
    
    @IBAction func clearClick(_ sender: Any) {
        expression.text! = ""
        bracketExists = false
        bracketsQuantity = 0
        commaExists = false
    }
    
    @IBAction func bracketsClick(_ sender: Any) {
        if !bracketExists {
            if expression.text?.last != "(" && bracketsQuantity == 0 && expression.text?.count != 0 && expression.text?.last != " " {
                
                expression.text! += " x ("
                bracketsQuantity += 1
            } else {
                expression.text! += "("
                bracketsQuantity += 1
            }
        } else {
            if bracketsQuantity != 0 && expression.text?.last != " " {
                
                expression.text! += ")"
                bracketsQuantity -= 1
            } else {
                expression.text! += " x ("
                bracketsQuantity += 1
                bracketExists = false
            }
        }
    }
    
    @IBAction func remainderClick(_ sender: Any) {
        if expressionCheck() {
            expression.text! += " % "
        }
        
        doesBracketsExist()
    }
    
    @IBAction func divisionClick(_ sender: Any) {
        if expressionCheck() {
            expression.text! += " / "
        }
        
        doesBracketsExist()
    }
    
    @IBAction func multiplyClick(_ sender: Any) {
        if expressionCheck() {
            expression.text! += " x "
        }
        
        doesBracketsExist()
    }
    
    @IBAction func minusClick(_ sender: Any) {
        if expressionCheck() {
            expression.text! += " - "
        }
        
        doesBracketsExist()
    }
    
    @IBAction func plusClick(_ sender: Any) {
        if expressionCheck() {
            expression.text! += " + "
        }
        
        doesBracketsExist()
    }
    
    @IBAction func sevenClick(_ sender: Any) {
        isZeroFirstChar()
        expression.text! += "7"
        bracketExists = bracketsQuantity != 0 ? true : false
    }

    @IBAction func eightClick(_ sender: Any) {
        isZeroFirstChar()
        expression.text! += "8"
        bracketExists = bracketsQuantity != 0 ? true : false
    }
    
    @IBAction func nineClick(_ sender: Any) {
        isZeroFirstChar()
        expression.text! += "9"
        bracketExists = bracketsQuantity != 0 ? true : false
    }
    
    @IBAction func fourClick(_ sender: Any) {
        isZeroFirstChar()
        expression.text! += "4"
        bracketExists = bracketsQuantity != 0 ? true : false
    }
    
    @IBAction func fiveClick(_ sender: Any) {
        isZeroFirstChar()
        expression.text! += "5"
        bracketExists = bracketsQuantity != 0 ? true : false    }
    
    @IBAction func sixClick(_ sender: Any) {
        isZeroFirstChar()
        expression.text! += "6"
        bracketExists = bracketsQuantity != 0 ? true : false
    }
    
    @IBAction func oneClick(_ sender: Any) {
        isZeroFirstChar()
        expression.text! += "1"
        bracketExists = bracketsQuantity != 0 ? true : false
    }
    
    @IBAction func twoClick(_ sender: Any) {
        isZeroFirstChar()
        expression.text! += "2"
        bracketExists = bracketsQuantity != 0 ? true : false
    }
    
    @IBAction func threeClick(_ sender: Any) {
        isZeroFirstChar()
        expression.text! += "3"
        bracketExists = bracketsQuantity != 0 ? true : false
    }
    
    @IBAction func signClick(_ sender: Any) {
        if expression.text?.count != 0 {
            if 
        } else {
            expression.text! += "-"
        }
    }
    
    @IBAction func zeroClick(_ sender: Any) {
        isZeroFirstChar()
        expression.text! += "0"
        bracketExists = bracketsQuantity != 0 ? true : false
    }
    
    @IBAction func commaClick(_ sender: Any) {
        if expression.text?.count != 0 &&
            expression.text?.last != "." &&
            !commaExists {
            expression.text! += "."
            commaExists = true
        }
    }
    
    
    // MARK:  subsidiary back-end functions
    
    func expressionCheck() -> Bool {
        if expression.text?.last != " " &&
        expression.text?.last != "(" &&
            expression.text?.count != 0 {
            return true
        } else {
            return false
        }
    }
    
    func isZeroFirstChar() {
        if expression.text?.count == 1 && expression.text?.last == "0" {
            expression.text?.removeLast()
        }
    }
    
    func doesBracketsExist() {
        if bracketsQuantity != 0 {
            if bracketExists {
                bracketExists = false
            } else {
                bracketExists = true
            }
        }
    }
}
