//
//  RouterProtocol.swift
//  Arduino Remote
//
//  Created by Oleksii on 28.04.2024.
//

import UIKit

enum Route {
    
    case back
    case ipInput
    case fakeLaunchScreen
}

protocol RouterProtocol {
    func route(to route: Route, _ context: UIViewController, _ parameter: Any?)
}

extension RouterProtocol {
    func route(to route: Route, _ context: UIViewController) {
        self.route(to: route, context, nil)
    }
}
