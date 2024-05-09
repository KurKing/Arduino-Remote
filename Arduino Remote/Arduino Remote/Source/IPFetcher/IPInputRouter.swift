//
//  IPInputRouter.swift
//  Arduino Remote
//
//  Created by Oleksii on 28.04.2024.
//

import UIKit

class IPInputRouter: RouterProtocol {
    
    private var fakeLaunch: UIViewController?
    
    func route(to route: Route, _ context: UIViewController, _ parameter: Any?) {
        
        switch route {
        case .fakeLaunchScreen:
            
            placeFakeLaunch(context: context)
            
        case .ipInput:
            
            let vc = IPInputViewController.createInstance()
            context.navigationController?.pushViewController(vc, animated: true)

        case .back:
            
            removeFakeLaunch()
            context.presentedViewController?.dismiss(animated: true)
        default:
            fatalError("Unsupported route")
        }
    }
}

// MARK: Fake launch
private extension IPInputRouter {
    
    private var screenTag: Int { 123321 }
    
    func placeFakeLaunch(context: UIViewController) {
        
        let storyboard = UIStoryboard(name: "LaunchScreen", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController()!
        
        context.addChild(viewController)
        context.view.addSubview(viewController.view)
        
        viewController.view.tag = screenTag
        viewController.view.pin(to: context.view)
        viewController.didMove(toParent: context)
        
        fakeLaunch = viewController
    }
    
    func removeFakeLaunch() {
        
        fakeLaunch?.removeFromParent()
        fakeLaunch?.view.removeFromSuperview()
        fakeLaunch = nil
    }
}
