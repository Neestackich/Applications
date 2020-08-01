//
//  RPN.swift
//  Calculator
//
//  Created by Neestackich on 31.07.2020.
//  Copyright © 2020 Neestackich. All rights reserved.
//

import UIKit

class RPN {
    
    
    // MARK: operators' types
    
    class Symbol {
        var value: Character!
        var next: Symbol? = nil
    }
    
    struct Stack {
        var head: Symbol
        
        func push(_ symbol: Character) {
            if head.value == nil {
                head.value = symbol
                head.next = Symbol()
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
    }
    
    
    // MARK: operands' types
    
    
}
