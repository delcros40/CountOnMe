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
                calculator.elements.append("+")
            case OperandEnum.less.rawValue:
                calculator.elements.append("-")
            case OperandEnum.multiply.rawValue:
                calculator.elements.append("×")
            case OperandEnum.divide.rawValue:
                calculator.elements.append("÷")
            default: break
            }
            self.updateTextViewCalcul()
        } else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func tappedACButton(_ sender: UIButton) {
        calculator.elements = []
        self.updateTextViewCalcul()
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard calculator.expressionIsCorrect else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        guard calculator.expressionHaveEnoughElement else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        do {
            let result = try calculator.calcul()
            textView.text.append(" = \(result)")
        } catch {
            let alertVC = UIAlertController(title: "error", message: "Unknown operator", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
    }
    
    private func updateTextViewCalcul() {
        var text = ""
        for stringNumber in self.calculator.elements {
            text += "\(stringNumber) "
        }
        self.textView.text = text
    }
    
}
