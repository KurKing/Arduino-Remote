//
//  IPInputRouter.swift
//  Arduino Remote
//
//  Created by Oleksii on 28.04.2024.
//

import UIKit

class IPInputRouter: UIRouterProtocol {
    
    func initializeStack(in presenter: UIViewController) {
        
        let vc = IPInputViewController.createInstance()
        
        presenter.present(vc, animated: false)
    }
    
    func route(to route: UIRoute, _ context: UIViewController, _ parameter: Any?) {
        
    }
}
