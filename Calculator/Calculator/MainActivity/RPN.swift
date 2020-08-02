
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
        
        mutating func popLastNumber() -> Symbol {
            if !isEmpty {
                let dummy: Symbol = head.next!
                head.next = dummy.next
                
                return dummy
            } else {
                return Symbol()
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
        for character in string {
            switch character {
            case " ":
                if parsedExpression.last != " " {
                    parsedExpression += " "
                }
            case ")":
                stack.pop(by: .frontBracket, &parsedExpression)
            case "(":
                stack.push(String(character))
            case "+", "-":
                if stack.isEmpty {
                    stack.push(String(character))
                } else {
                    stack.pop(by: .plusMinus, &parsedExpression)
                    stack.push(String(character))
                }
            case "x", "/":
                if stack.isEmpty {
                    stack.push(String(character))
                } else {
                    stack.pop(by: .multiplyDivision, &parsedExpression)
                    stack.push(String(character))
                }
            default:
                parsedExpression += String(character)
            }
        }
    }

    func count() -> Double {
        var number: String = ""
        
        for character in parsedExpression {
            switch character {
            case "+":
                let summ = Double(stack.popLastNumber().value!)! + Double(stack.popLastNumber().value!)!
                stack.push(String(summ))
            case "-":
                let firstNum = Double(stack.popLastNumber().value!)!
                let summ = Double(stack.popLastNumber().value!)! - firstNum
                stack.push(String(summ))
            case "x":
                let summ = Double(stack.popLastNumber().value!)! * Double(stack.popLastNumber().value!)!
                stack.push(String(summ))
            case "/":
                let firstNum = Double(stack.popLastNumber().value!)!
                let summ = Double(stack.popLastNumber().value!)! / firstNum
                stack.push(String(summ))
            case " ":
                if number.isEmpty {
                    continue
                } else {
                    stack.push(number)
                    number = ""
                }
            default:
                number += String(character)
            }
        }
        
        return Double(stack.popLastNumber().value!)!
    }
}
