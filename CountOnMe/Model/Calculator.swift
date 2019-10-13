

import Foundation
import UIKit

/// allows to manage the calculation
class Calculator {
    
    var elements: [String] = []
    
    var expressionIsCorrect: Bool {
        for operand in OperandEnum.allValues where self.elements.last == operand {
            return false
        }
        return true
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var canAddOperator: Bool {
        if self.elements.count >= 1 {
            return self.expressionIsCorrect
        }
        return false
    }
    
    func calcul() -> String {
        var operationsToReduce = elements
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            if self.expressionHaveMultiplyOrDivide(elements: operationsToReduce) {
                for element in operationsToReduce where element == OperandEnum.multiply.rawValue || element == OperandEnum.divide.rawValue {
                    let index = operationsToReduce.firstIndex(of: element)!
                    let left = Int(operationsToReduce[index-1])!
                    let operand = element
                    let right = Int(operationsToReduce[index+1])!
                    let result: Int
                    switch operand {
                    case OperandEnum.multiply.rawValue:
                        result = self.multiply(firstNumber: left, secondNumber: right)
                    case OperandEnum.divide.rawValue:
                        result = self.divide(firstNumber: left, secondNumber: right)
                    default: fatalError("Unknown operator !")
                    }
                    operationsToReduce.remove(at: index+1)
                    operationsToReduce.remove(at: index)
                    operationsToReduce.remove(at: index-1)
                    operationsToReduce.insert("\(result)", at: index-1)
                }
            } else {
                let left = Int(operationsToReduce[0])!
                let operand = operationsToReduce[1]
                let right = Int(operationsToReduce[2])!
                let result: Int
                switch operand {
                case OperandEnum.more.rawValue: result = self.more(firstNumber: left, secondNumber: right)
                case OperandEnum.less.rawValue: result = self.less(firstNumber: left, secondNumber: right)
                default: fatalError("Unknown operator !")
                }
                operationsToReduce = Array(operationsToReduce.dropFirst(3))
                operationsToReduce.insert("\(result)", at: 0)
            }
        }
        
      return operationsToReduce.first!
    }
    
    private func expressionHaveMultiplyOrDivide(elements: [String]) -> Bool {
        for element in elements where element == OperandEnum.multiply.rawValue || element == OperandEnum.divide.rawValue {
            return true
        }
        return false
    }
    
    private func more(firstNumber: Int, secondNumber: Int) -> Int {
        return firstNumber + secondNumber
    }
    
    private func less(firstNumber: Int, secondNumber: Int) -> Int {
        return firstNumber - secondNumber
    }
    
    private func multiply(firstNumber: Int, secondNumber: Int) -> Int {
        return firstNumber * secondNumber
    }
    
    private func divide(firstNumber: Int, secondNumber: Int) -> Int {
        return Int(firstNumber / secondNumber)
    }
    
}
