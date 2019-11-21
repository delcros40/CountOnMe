import Foundation
/// Model : logic of application
/// allows to manage the calculation.
class Calculator {
    /// tab containing numbers and operand
    var elements: [String] = []
    /// expression does not end with an operation
    var expressionIsCorrect: Bool {
        for operand in OperandEnum.allValues where self.elements.last == operand {
            return false
        }
        return true
    }
    
    /// expression has an operation between 2 numbers
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    /// possibility of carrying out an operation
    var canAddOperator: Bool {
        if self.elements.count >= 1 {
            return self.expressionIsCorrect
        }
        return false
    }
    /// allows to calculate the element calculation line
    func calcul() throws -> String {
        var operationsToReduce = elements
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            // multiply or divide
            if self.expressionHaveMultiplyOrDivide(elements: operationsToReduce) {
                for element in operationsToReduce where element == OperandEnum.multiply.rawValue || element == OperandEnum.divide.rawValue {
                    let index = operationsToReduce.firstIndex(of: element)!
                    let left = Double(operationsToReduce[index-1])!
                    let operand = element
                    let right = Double(operationsToReduce[index+1])!
                    let result: Double
                    result = try calculOperation(firstNumber: left, secondNumber: right, operand: operand)
                    operationsToReduce.remove(at: index+1)
                    operationsToReduce.remove(at: index)
                    operationsToReduce.remove(at: index-1)
                    operationsToReduce.insert("\(result)", at: index-1)
                }
            } else {
                // more or less
                let left = Double(operationsToReduce[0])!
                let operand = operationsToReduce[1]
                let right = Double(operationsToReduce[2])!
                let result: Double
                result = try calculOperation(firstNumber: left, secondNumber: right, operand: operand)
                operationsToReduce = Array(operationsToReduce.dropFirst(3))
                operationsToReduce.insert("\(result)", at: 0)
            }
        }
        
        return operationsToReduce.first!
    }
    /// returns true if the operation is a division or a multiplication
    private func expressionHaveMultiplyOrDivide(elements: [String]) -> Bool {
        for element in elements where element == OperandEnum.multiply.rawValue || element == OperandEnum.divide.rawValue {
            return true
        }
        return false
    }
    /// perform an operation between two numbers
    /// - Parameters:
    ///   - firstNumber: The first value.
    ///   - secondNumber: The second value.
    ///   - operand: The operand.
    private func calculOperation(firstNumber: Double, secondNumber: Double, operand: String) throws -> Double {
        switch operand {
        case OperandEnum.more.rawValue: return self.more(firstNumber: firstNumber, secondNumber: secondNumber)
        case OperandEnum.less.rawValue: return self.less(firstNumber: firstNumber, secondNumber: secondNumber)
        case OperandEnum.multiply.rawValue: return self.multiply(firstNumber: firstNumber, secondNumber: secondNumber)
        case OperandEnum.divide.rawValue:
            if secondNumber.isZero {
                throw OperandError.divideByZero
            }
            return self.divide(firstNumber: firstNumber, secondNumber: secondNumber)
        default: throw OperandError.unknownOperator
        }
    }
    
    /// Adds two values
    /// - Parameters:
    ///   - firstNumber: The first value to add.
    ///   - secondNumber: The second value to add.
    private func more(firstNumber: Double, secondNumber: Double) -> Double {
        return firstNumber + secondNumber
    }
    /// Subtracts one value from another and produces their difference
    /// - Parameters:
    ///   - firstNumber: A numeric value.
    ///   - secondNumber: The value to subtract from `lhs`.
    private func less(firstNumber: Double, secondNumber: Double) -> Double {
        return firstNumber - secondNumber
    }
    /// Multiplies two values and produces their product,
    /// - Parameters:
    ///   - firstNumber: The first value to multiply.
    ///   - secondNumber: The second value to multiply.
    private func multiply(firstNumber: Double, secondNumber: Double) -> Double {
        return firstNumber * secondNumber
    }
    /// Returns the quotient of dividing the first value by the second
    /// to a representable value.
    /// - Parameters:
    ///   - firstNumber: The value to divide.
    ///   - secondNumber: The value to divide `lhs` by.
    private func divide(firstNumber: Double, secondNumber: Double) -> Double {
        return firstNumber / secondNumber
    }
    
}
/// Error: unrecognized operand
enum OperandError: String, Error {
    case unknownOperator = "Unknown operator"
    case divideByZero = "Forbidden to divide by zero"
}
