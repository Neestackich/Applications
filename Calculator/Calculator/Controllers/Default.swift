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
        
    var operation: String!
    
    var result: Double = 0
    
    var bracketsQuantity: Int = 0
    
    var menuOut: Bool = false
    var commaExists: Bool = false
    var bracketExists: Bool = false
    
    @IBOutlet weak var expression: UILabel!
    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var trailing: NSLayoutConstraint!
    
    
    // MARK: viewDialog and buttons' handlers
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func hamburgerClick(_ sender: Any) {
        if !menuOut {
            menuOut = true
            leading.constant = 150
            trailing.constant = -150
        } else {
            menuOut = false
            leading.constant = 0
            trailing.constant = 0
        }
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: { self.view.layoutIfNeeded() }) {
            (animationComolete) in
        }
    }
    
    @IBAction func backSpaceClick(_ sender: Any) {
        if expression.text?.count != 0 {
            if expression.text?.last == ")" {
                doesBracketsExist()
                bracketsQuantity += 1
                expression.text?.removeLast()
            } else if expression.text?.last == "(" {
                bracketsQuantity -= 1
                expression.text?.removeLast()
            } else if expression.text?.last == " " {
                
                for _ in 1...3 {
                    expression.text?.removeLast()
                }
                
                doesBracketsExist()
            } else if expression.text?.last == "." {
                commaExists = false
                expression.text?.removeLast()
            } else if expression.text?.last == "-" {
                //doesBracketsExist()
                bracketsQuantity -= 1
                expression.text?.removeLast()
            } else {
                expression.text?.removeLast()
                bracketExists = bracketsQuantity != 0 ? true : false
            }
        }
    }
    
    @IBAction func clearClick(_ sender: Any) {
        commaExists = false
        bracketExists = false
        bracketsQuantity = 0
        expression.text! = ""
    }
    
    @IBAction func bracketsClick(_ sender: Any) {
        if !bracketExists {
            if expression.text?.last != "(" && bracketsQuantity == 0 && expression.text?.count != 0 && expression.text?.last != " " && expression.text?.last != "-" {
                bracketsQuantity += 1
                expression.text! += " x ("
            } else {
                bracketsQuantity += 1
                expression.text! += "("
            }
        } else {
            if bracketsQuantity != 0 && expression.text?.last != " " {
                bracketsQuantity -= 1
                expression.text! += ")"
            } else {
                bracketExists = false
                bracketsQuantity += 1
                
                expression.text! += expression.text?.last != " " ? " x (" : "("
            }
        }
    }
    
    @IBAction func remainderClick(_ sender: Any) {
        if expressionCheck() {
            doesBracketsExist()
            expression.text! += " % "
        }
    }
    
    @IBAction func divisionClick(_ sender: Any) {
        if expressionCheck() {
            doesBracketsExist()
            expression.text! += " / "
        }
    }
    
    @IBAction func multiplyClick(_ sender: Any) {
        if expressionCheck() {
            doesBracketsExist()
            expression.text! += " x "
        }
    }
    
    @IBAction func minusClick(_ sender: Any) {
        if expressionCheck() {
            doesBracketsExist()
            expression.text! += " - "
        }
    }
    
    @IBAction func plusClick(_ sender: Any) {
        if expressionCheck() {
            doesBracketsExist()
            expression.text! += " + "
        }
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
        bracketExists = bracketsQuantity != 0 ? true : false
    }
    
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
        if expression.text?.count != 0  {
            var stringSize = expression.text!.count - 1
            
            while expression.text?[expression.text!.index(expression.text!.startIndex, offsetBy: stringSize)] != " " &&
                expression.text?[expression.text!.index(expression.text!.startIndex, offsetBy: stringSize)] != "(" &&
                expression.text?[expression.text!.index(expression.text!.startIndex, offsetBy: stringSize)] != ")" &&
                expression.text?[expression.text!.index(expression.text!.startIndex, offsetBy: stringSize)] != "-" &&
                stringSize != 0 {
                    stringSize -= 1
            }
            
            switch expression.text?[expression.text!.index(expression.text!.startIndex, offsetBy: stringSize)] {
            case "-":
                if expression.text!.count >= 2 && expression.text?[expression.text!.index(expression.text!.startIndex, offsetBy: stringSize - 1)] == "(" {
                    bracketsQuantity -= 1
                    expression.text?.remove(at: expression.text!.index(expression.text!.startIndex, offsetBy: stringSize - 1))
                    expression.text?.remove(at: expression.text!.index(expression.text!.startIndex, offsetBy: stringSize - 1))
                } else {
                    expression.text?.remove(at: expression.text!.index(expression.text!.startIndex, offsetBy: stringSize))
                }
            case " ":
                if expression.text?.last != " " {
                    minusInsert(stringSize)
                } else {
                    bracketsQuantity += 1
                    expression.text! += "(--"
                    //bracketExists = bracketsQuantity != 0 ? true : false
                }
            case "(":
                if expression.text?.last != "(" {
                    minusInsert(stringSize - 1)
                } else {
                    bracketsQuantity += 1
                    expression.text! += "(--"
                    bracketExists = bracketsQuantity != 0 ? false : true
                }
            case ")":
                expression.text?.insert("-", at: expression.text!.index(expression.text!.startIndex, offsetBy: stringSize))
            default:
                minusInsert(stringSize - 1)
            }
            
            if expression.text?.last == "-" {
                expression.text?.removeLast()
            }
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
        if expression.text?.count != 0 && expression.text?.last != "." &&
            !commaExists {
            commaExists = true
            expression.text! += "."
        }
    }
    
    
    // MARK:  subsidiary back-end functions
    
    func minusInsert(_ stringSize: Int) {
        expression.text?.insert("-", at: expression.text!.index(expression.text!.startIndex, offsetBy: stringSize + 1))
        expression.text?.insert("(", at: expression.text!.index(expression.text!.startIndex, offsetBy: stringSize + 1))
        
        bracketsQuantity += 1
        bracketExists = bracketsQuantity != 0 ? true : false
    }
    
    func expressionCheck() -> Bool {
        if expression.text?.last != " " && expression.text?.last != "(" &&
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
