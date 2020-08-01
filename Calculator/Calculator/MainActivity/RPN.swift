//
//  RPN.swift
//  Calculator
//
//  Created by Neestackich on 31.07.2020.
//  Copyright © 2020 Neestackich. All rights reserved.
//

import UIKit

class RPN {
    
    
    // MARK: operands' types
    
    var finalExpression: String = ""

    
    // MARK: operators' types
    
    enum Priority {
        case backBracket
        case frontBracket
        case plusMinus
        case multiplyDivision
    }
    
    class Symbol {
        var value: Character!
        var priority: Priority!
        var next: Symbol? = nil
    }
    
    struct Stack {
        var head: Symbol
        
        func push(_ symbol: Character) {
            if head.value == nil {
                head.value = symbol
                head.next = Symbol()
                
                switch symbol {
                case ")":
                    head.priority = Priority.backBracket
                case "(":
                    head.priority = Priority.frontBracket
                case "+", "-":
                    head.priority = Priority.plusMinus
                case "x", "/":
                    head.priority = Priority.multiplyDivision
                default:
                    break
                }
            } else {
                var dummy: Symbol = head
                
                while dummy.next != nil {
                    dummy = dummy.next!
                }
                
                dummy.value = symbol
                dummy.next = Symbol()
            }
        }
        
        func pop() {
            
        }
        
        //сделать функцию pop для почленного вытягивания из стека
        //и функцию для вытягивания всех элементов
        //или сделать одну функцию с передачей нужных параметров для этого
    }
    
    // MARK: parsing and counting functions
    
    func parse(_ expression: String) {
        
    }
    
    func count() -> Double {
        var result: Double = 0
        
        
        
        return result
    }
}
