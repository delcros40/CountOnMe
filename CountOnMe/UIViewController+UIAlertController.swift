//
//  UIViewController+UIAlertController.swift
//  CountOnMe
//
//  Created by DELCROS Jean-baptiste on 12/11/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation
import UIKit

/// Extend the ViewController with a UIAlertController display
extension ViewController {

    func presentUIAlert(with message: String) {
        let alertVC = UIAlertController(title: "Erreur !", message: message, preferredStyle: .alert)

        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

        self.present(alertVC, animated: true, completion: nil)
    }
}
