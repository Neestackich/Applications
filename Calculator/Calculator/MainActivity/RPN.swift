
import UIKit

class RPN {
    
    
    // MARK: properties
    
    var stack: Stack = Stack()
    var parsedExpression: String = ""

    
    // MARK: inserted types
    
    enum Priority: Int {
        case backBracket
        case frontBracket
        case plusMinus
        case multiplyDivision
    }

    class Symbol {
        var value: String!
        var priority: Priority!
        var next: Symbol? = nil
    }

    struct Stack {
        var isEmpty: Bool = true
        var head: Symbol = Symbol()

        mutating func push(_ symbol: String) {
            isEmpty = false
            head.value = symbol
            priorityDefind(symbol)
            let dummy: Symbol = Symbol()
            dummy.next = head
            head = dummy
        }
        
        func priorityDefind(_ symbol: String) {
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
        }
        
        mutating func popLastNumber() -> Symbol? {
            if !isEmpty {
                let dummy: Symbol = head.next!
                head.next = dummy.next
                isEmpty = head.next == nil ? true : false
                
                return dummy
            } else {
                return nil
            }
        }
        
        mutating func pop(by: Priority, _ result: inout String) {
            if !isEmpty {
                var dummy: Symbol = head
                
                while dummy.next != nil && dummy.next!.priority.rawValue >= by.rawValue {
                    dummy = dummy.next!
                    if dummy.priority != Priority.frontBracket {
                        if result.last != " " {
                            result += " "
                        }
                        
                        result += String(dummy.value)
                    }
                }
                
                head.next = dummy.next
                isEmpty = head.next == nil ? true : false
            }
        }
    }
    
    
    // MARK: init, parse and count methods
    
    init(_ expression: String) {
        parse(expression)
    }

    func parse(_ string: String) {
        var sign: String = ""
        
        for character in string {
            switch character {
            case " ":
                if sign.count != 0 {
                    if stack.isEmpty {
                        stack.push(sign)
                    } else {
                        stack.pop(by: .plusMinus, &parsedExpression)
                        stack.push(sign)
                    }
                    
                    sign.removeAll()
                }
                
                if parsedExpression.last != " " {
                    parsedExpression += " "
                }
            case ")":
                stack.pop(by: .frontBracket, &parsedExpression)
            case "(":
                stack.push(String(character))
            case "+":
                if stack.isEmpty {
                    stack.push(String(character))
                } else {
                    stack.pop(by: .plusMinus, &parsedExpression)
                    stack.push(String(character))
                }
            case "-":
                sign = "-"
            case "x", "/":
                if stack.isEmpty {
                    stack.push(String(character))
                } else {
                    stack.pop(by: .multiplyDivision, &parsedExpression)
                    stack.push(String(character))
                }
            default:
                parsedExpression += sign
                sign.removeAll()
                parsedExpression += String(character)
            }
        }
        
        if parsedExpression.last != " " {
            parsedExpression += " "
        }
        
        stack.pop(by: .plusMinus, &parsedExpression)
        
        if let value = stack.popLastNumber()?.value {
            parsedExpression += value
        }
    }

    func count() throws -> Double? {
        var number: String = ""
        var sign: String = ""
        
        func minus() throws -> Void {
            if let firstNum = stack.popLastNumber()?.value, let secondNum = stack.popLastNumber()?.value {
                    let summ = Double(secondNum)! - Double(firstNum)!
                    stack.push(String(summ))
                } else {
                    throw CalculatorError.unexpectedExpression
                }

            sign.removeAll()
        }
        
        for character in parsedExpression {
            switch character {
            case "+":
                if let firstNum = stack.popLastNumber()?.value, let secondNum = stack.popLastNumber()?.value {
                    let summ = Double(secondNum)! + Double(firstNum)!
                    stack.push(String(summ))
                } else {
                    throw CalculatorError.unexpectedExpression
                }
            case "-":
                if parsedExpression.last != character {
                    sign = String(character)
                } else {
                    try minus()
                }
            case "x":
                if let firstNum = stack.popLastNumber()?.value, let secondNum = stack.popLastNumber()?.value {
                    let summ = Double(secondNum)! * Double(firstNum)!
                    stack.push(String(summ))
                } else {
                    throw CalculatorError.unexpectedExpression
                }
            case "/":
                if let firstNum = stack.popLastNumber()?.value, let secondNum = stack.popLastNumber()?.value {
                    if firstNum != "0" {
                        print(secondNum, firstNum)
                        let summ = Double(secondNum)! / Double(firstNum)!
                        stack.push(String(summ))
                    } else {
                        throw CalculatorError.zeroDivision
                    }
                } else {
                    throw CalculatorError.unexpectedExpression
                }
            case " ":
                if number.isEmpty {
                    if sign.count != 0 {
                       try minus()
                    } else {
                        continue
                    }
                } else {
                    stack.push(number)
                    number.removeAll()
                }
            default:
                number += sign
                sign.removeAll()
                number += String(character)
            }
        }
        
        if let value = stack.popLastNumber()?.value {
            return Double(value)
        } else {
            return nil
        }
    }
}
