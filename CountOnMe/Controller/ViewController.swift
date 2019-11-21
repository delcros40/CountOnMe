//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    var calculator = Calculator()
    
    var expressionHaveResult: Bool {
        return textView.text.firstIndex(of: "=") != nil
    }
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        if expressionHaveResult {
            calculator.elements = []
            textView.text = ""
        }
        if calculator.expressionIsCorrect {
            let number = "\(calculator.elements.last ?? "")\(numberText)"
            if calculator.elements.last != nil {
                calculator.elements.removeLast()
                textView.text.removeAll()
            }
            calculator.elements.append(number)
            self.updateTextViewCalcul()
        } else {
            calculator.elements.append(numberText)
            textView.text.append(numberText)
        }
        
    }
    
    @IBAction func tappedOperandButton(_ sender: UIButton) {
        if expressionHaveResult {
            textView.text.removeLast(5)
        }
        if calculator.canAddOperator {
            switch sender.titleLabel!.text {
            case OperandEnum.more.rawValue:
                calculator.elements.append(OperandEnum.more.rawValue)
            case OperandEnum.less.rawValue:
                calculator.elements.append(OperandEnum.less.rawValue)
            case OperandEnum.multiply.rawValue:
                calculator.elements.append(OperandEnum.multiply.rawValue)
            case OperandEnum.divide.rawValue:
                calculator.elements.append(OperandEnum.divide.rawValue)
            default: break
            }
            self.updateTextViewCalcul()
        } else {
            self.presentUIAlert(with: "Un operateur est déja mis !")
        }
    }
    
    @IBAction func tappedACButton(_ sender: UIButton) {
        self.resetOperation()
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard calculator.expressionIsCorrect else {
            return self.presentUIAlert(with: "Entrez une expression correcte !")
        }
        
        guard calculator.expressionHaveEnoughElement else {
            return self.presentUIAlert(with: "Démarrez un nouveau calcul !")
        }
        
        do {
            let result = try calculator.calcul()
            textView.text.append(String(format: " = %0.2f", Double(result)!.rounded()))
        } catch OperandError.unknownOperator {
            self.resetOperation()
            self.presentUIAlert(with: OperandError.unknownOperator.rawValue)
        } catch OperandError.divideByZero {
            self.resetOperation()
            self.presentUIAlert(with: OperandError.divideByZero.rawValue)
        } catch {
            print("error")
        }
        
    }
    private func resetOperation() {
        calculator.elements = []
        self.updateTextViewCalcul()
    }

    private func updateTextViewCalcul() {
        var text = ""
        for stringNumber in self.calculator.elements {
            text += "\(stringNumber) "
        }
        self.textView.text = text
    }
    
}
