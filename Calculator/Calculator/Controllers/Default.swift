//
//  Default.swift
//  Calculator
//
//  Created by Neestackich on 26.07.2020.
//  Copyright © 2020 Neestackich. All rights reserved.
//

import UIKit

class Default: UIViewController {
    
    
    // MARK: Properties
        
    var operation: String!
    
    var result: Double = 0
    
    var alert: UIAlertController!
    
    var bracketsQuantity: Int = 0
    
    var menuOut: Bool = false
    var commaExists: Bool = false
    var bracketExists: Bool = false
    
    @IBOutlet weak var expression: UILabel!
    @IBOutlet weak var sixButton: UIButton!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var signButton: UIButton!
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var nineButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var sevenButton: UIButton!
    @IBOutlet weak var eightButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var commaButton: UIButton!
    @IBOutlet weak var countButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var divisionButton: UIButton!
    @IBOutlet weak var multiplyButton: UIButton!
    @IBOutlet weak var bracketsButton: UIButton!
    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var trailing: NSLayoutConstraint!
     @IBOutlet weak var expressionOutputArea: UIView!
    @IBOutlet weak var leftAfterDivisionButton: UIButton!
    
    
    // MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sixButton.layer.cornerRadius = 20
        oneButton.layer.cornerRadius = 20
        twoButton.layer.cornerRadius = 20
        plusButton.layer.cornerRadius = 20
        signButton.layer.cornerRadius = 20
        zeroButton.layer.cornerRadius = 20
        fourButton.layer.cornerRadius = 20
        fiveButton.layer.cornerRadius = 20
        nineButton.layer.cornerRadius = 20
        clearButton.layer.cornerRadius = 20
        sevenButton.layer.cornerRadius = 20
        eightButton.layer.cornerRadius = 20
        commaButton.layer.cornerRadius = 20
        countButton.layer.cornerRadius = 20
        threeButton.layer.cornerRadius = 20
        minusButton.layer.cornerRadius = 20
        divisionButton.layer.cornerRadius = 20
        multiplyButton.layer.cornerRadius = 20
        bracketsButton.layer.cornerRadius = 20
        expressionOutputArea.layer.cornerRadius = 20
        leftAfterDivisionButton.layer.cornerRadius = 20
        
        sixButton.layer.borderWidth = 1
        oneButton.layer.borderWidth = 1
        twoButton.layer.borderWidth = 1
        plusButton.layer.borderWidth = 1
        signButton.layer.borderWidth = 1
        zeroButton.layer.borderWidth = 1
        fourButton.layer.borderWidth = 1
        fiveButton.layer.borderWidth = 1
        nineButton.layer.borderWidth = 1
        clearButton.layer.borderWidth = 1
        sevenButton.layer.borderWidth = 1
        eightButton.layer.borderWidth = 1
        commaButton.layer.borderWidth = 1
        countButton.layer.borderWidth = 1
        threeButton.layer.borderWidth = 1
        minusButton.layer.borderWidth = 1
        divisionButton.layer.borderWidth = 1
        multiplyButton.layer.borderWidth = 1
        bracketsButton.layer.borderWidth = 1
        expressionOutputArea.layer.borderWidth = 1
        leftAfterDivisionButton.layer.borderWidth = 1
        
        sixButton.layer.borderColor = CGColor(srgbRed: 48, green: 48, blue: 48, alpha: 0.3)
        oneButton.layer.borderColor = CGColor(srgbRed: 48, green: 48, blue: 48, alpha: 0.3)
        twoButton.layer.borderColor = CGColor(srgbRed: 48, green: 48, blue: 48, alpha: 0.3)
        plusButton.layer.borderColor = CGColor(srgbRed: 48, green: 48, blue: 48, alpha: 0.3)
        signButton.layer.borderColor = CGColor(srgbRed: 48, green: 48, blue: 48, alpha: 0.3)
        zeroButton.layer.borderColor = CGColor(srgbRed: 48, green: 48, blue: 48, alpha: 0.3)
        fourButton.layer.borderColor = CGColor(srgbRed: 48, green: 48, blue: 48, alpha: 0.3)
        fiveButton.layer.borderColor = CGColor(srgbRed: 48, green: 48, blue: 48, alpha: 0.3)
        nineButton.layer.borderColor = CGColor(srgbRed: 48, green: 48, blue: 48, alpha: 0.3)
        clearButton.layer.borderColor = CGColor(srgbRed: 48, green: 48, blue: 48, alpha: 0.3)
        sevenButton.layer.borderColor = CGColor(srgbRed: 48, green: 48, blue: 48, alpha: 0.3)
        eightButton.layer.borderColor = CGColor(srgbRed: 48, green: 48, blue: 48, alpha: 0.3)
        commaButton.layer.borderColor = CGColor(srgbRed: 48, green: 48, blue: 48, alpha: 0.3)
        countButton.layer.borderColor = CGColor(srgbRed: 48, green: 48, blue: 48, alpha: 0.3)
        threeButton.layer.borderColor = CGColor(srgbRed: 48, green: 48, blue: 48, alpha: 0.3)
        minusButton.layer.borderColor = CGColor(srgbRed: 48, green: 48, blue: 48, alpha: 0.3)
        divisionButton.layer.borderColor = CGColor(srgbRed: 48, green: 48, blue: 48, alpha: 0.3)
        multiplyButton.layer.borderColor = CGColor(srgbRed: 48, green: 48, blue: 48, alpha: 0.3)
        bracketsButton.layer.borderColor = CGColor(srgbRed: 48, green: 48, blue: 48, alpha: 0.3)
        expressionOutputArea.layer.borderColor = CGColor(srgbRed: 48, green: 48, blue: 48, alpha: 0.3)
        leftAfterDivisionButton.layer.borderColor = CGColor(srgbRed: 48, green: 48, blue: 48, alpha: 0.3)
    }
    
    
    // MARK: -buttons' handlers
    
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
                bracketsQuantity += 1
                expression.text?.removeLast()
                bracketExists = bracketsQuantity != 0 ? true : false
            } else if expression.text?.last == "(" {
                bracketsQuantity -= 1
                expression.text?.removeLast()
                bracketExists = bracketsQuantity != 0 ? true : false
            } else if expression.text?.last == " " {
                
                for _ in 1...3 {
                    expression.text?.removeLast()
                }
                
                bracketExists = bracketsQuantity != 0 ? true : false
            } else if expression.text?.last == "." {
                commaExists = false
                expression.text?.removeLast()
            } else if expression.text?.last == "-" {
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
        
        buttonPressAnimatio(objects: clearButton, duration: 0.1, resizeDuration: 0.1, x: 0.9, y: 0.9, resizeX: 1, resizeY: 1)
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
        
        buttonPressAnimatio(objects: bracketsButton, duration: 0.1, resizeDuration: 0.1, x: 0.9, y: 0.9, resizeX: 1, resizeY: 1)
    }
    
    @IBAction func numberButtonClick(_ sender: UIButton) {
        if let buttonText = sender.titleLabel?.text {
            isZeroFirstChar()
            isBracketLastChar()
            expression.text! += buttonText
            bracketExists = bracketsQuantity != 0 ? true : false
        }
        
        buttonPressAnimatio(objects: sender, duration: 0.1, resizeDuration: 0.1, x: 0.9, y: 0.9, resizeX: 1, resizeY: 1)
    }
    
    @IBAction func operationButtonClick(_ sender: UIButton) {
        if expressionCheck() {
            if let buttonText = sender.titleLabel?.text {
                doesBracketsExist()
                expression.text! += buttonText
                commaExists = commaExists ? false : true
            }
        }
        
        buttonPressAnimatio(objects: sender, duration: 0.1, resizeDuration: 0.1, x: 0.9, y: 0.9, resizeX: 1, resizeY: 1)
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
            case "-", "+", "x", "/":
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
                }
            case "(":
                if expression.text?.last != "(" {
                    minusInsert(stringSize)
                } else {
                    bracketsQuantity += 1
                    expression.text! += "(--"
                    bracketExists = bracketsQuantity != 0 ? false : true
                }
            case ")":
                break
            default:
                minusInsert(stringSize - 1)
            }
            
            if expression.text?.last == "-" {
                expression.text?.removeLast()
            }
        } else {
            expression.text! += "-"
        }
        
        buttonPressAnimatio(objects: signButton, duration: 0.1, resizeDuration: 0.1, x: 0.9, y: 0.9, resizeX: 1, resizeY: 1)
    }
    
    @IBAction func zeroClick(_ sender: Any) {
        isZeroFirstChar()
        expression.text! += "0"
        bracketExists = bracketsQuantity != 0 ? true : false
        
        buttonPressAnimatio(objects: zeroButton, duration: 0.1, resizeDuration: 0.1, x: 0.9, y: 0.9, resizeX: 1, resizeY: 1)
    }
    
    @IBAction func commaClick(_ sender: Any) {
        if expression.text?.count != 0 && expression.text?.last != "." &&
            !commaExists {
            commaExists = true
            expression.text! += "."
        }
        
        buttonPressAnimatio(objects: commaButton, duration: 0.1, resizeDuration: 0.1, x: 0.9, y: 0.9, resizeX: 1, resizeY: 1)
    }
    
    @IBAction func countClick(_ sender: Any) {
        if expression.text!.count != 0 {
            do {
                expression.text! = String(try RPN(expression.text!).count()!)
            } catch CalculatorError.zeroDivision {
                alert = UIAlertController(title: "Error", message: "Division by zero", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch CalculatorError.unexpectedExpression {
                alert = UIAlertController(title: "Error", message: "Unexpected expression", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch {
                alert = UIAlertController(title: "Error", message: "Unexpected error", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        buttonPressAnimatio(objects: countButton, duration: 0.1, resizeDuration: 0.1, x: 0.9, y: 0.9, resizeX: 1, resizeY: 1)
    }
    
    
    // MARK:  -subsidiary back-end functions
    
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
    
    func isBracketLastChar() {
        if expression.text?.last == ")" {
            expression.text! += " x "
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
    
    func buttonPressAnimatio<T: UIButton>(objects: T..., duration: TimeInterval, resizeDuration: TimeInterval, x: CGFloat, y: CGFloat, resizeX: CGFloat, resizeY: CGFloat) {
        UIView.animate(withDuration: duration, animations: {
            for object in objects {
                object.transform = CGAffineTransform(scaleX: x, y: y)
            }
        }, completion: { _ in
            UIView.animate(withDuration: resizeDuration, animations: {
                for object in objects {
                    object.transform = CGAffineTransform(scaleX: resizeX, y: resizeY)
                }
            })
        })
    }
}
