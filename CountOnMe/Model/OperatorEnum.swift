//
//  OperatorEnum.swift
//  CountOnMe
//
//  Created by DELCROS Jean-baptiste on 09/10/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation
import UIKit

enum OperandEnum: String {
    case more = "+"
    case less = "-"
    case multiply = "*"
    case divide = "/"
    
    static let allValues: [String] = [more.rawValue, less.rawValue, multiply.rawValue, divide.rawValue]
}
