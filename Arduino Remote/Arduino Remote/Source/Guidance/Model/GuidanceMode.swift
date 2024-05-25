//
//  GuidanceMode.swift
//  Arduino Remote
//
//  Created by Oleksii on 14.05.2024.
//

import Foundation
import UIKit

enum GuidanceMode {
    
    case edit
    case action
    
    var inverted: GuidanceMode {
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
