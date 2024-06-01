//
//  SchemeMode.swift
//  Arduino Remote
//
//  Created by Oleksii on 14.05.2024.
//

import Foundation
import UIKit

enum SchemeMode {
    
    case edit
    case action
    
    var inverted: SchemeMode {
        switch self {
        case .action:
            return .edit
        case .edit:
            return .action
        }
    }
    
    func touchesStrategy(presenter: UIViewController) -> TouchesDelegateStrategy {
        switch self {
        case .action:
            return ActionModeTouchesDelegateStrategy()
        case .edit:
            return EditModeTouchesDelegateStrategy(presenter: presenter)
        }
    }
}
