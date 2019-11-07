import Foundation

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
    
    func calcul() throws -> String {
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
                    result = try calculOperation(firstNumber: left, secondNumber: right, operand: operand)
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
                result = try calculOperation(firstNumber: left, secondNumber: right, operand: operand)
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
    
    private func calculOperation(firstNumber: Int, secondNumber: Int, operand: String) throws -> Int {
        switch operand {
        case OperandEnum.more.rawValue: return self.more(firstNumber: firstNumber, secondNumber: secondNumber)
        case OperandEnum.less.rawValue: return self.less(firstNumber: firstNumber, secondNumber: secondNumber)
        case OperandEnum.multiply.rawValue: return self.multiply(firstNumber: firstNumber, secondNumber: secondNumber)
        case OperandEnum.divide.rawValue: return self.divide(firstNumber: firstNumber, secondNumber: secondNumber)
        default: throw OperandError.unknownOperator
        }
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

enum OperandError: Error {
    case unknownOperator
}
