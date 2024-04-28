//
//  RouterProtocol.swift
//  Arduino Remote
//
//  Created by Oleksii on 28.04.2024.
//

import UIKit

enum UIRoute {
    
    case back
    case ipInput
}

protocol UIRouterProtocol {
    func route(to route: UIRoute, _ context: UIViewController, _ parameter: Any?)
}

extension UIRouterProtocol {
    func route(to route: UIRoute, _ context: UIViewController) {
        self.route(to: route, context, nil)
    }
}
