//
//  SceneDelegate.swift
//  Arduino Remote
//
//  Created by Oleksii on 22.04.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, 
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = scene as? UIWindowScene else { return }
        
        let window = UIWindow(windowScene: scene)
        self.window = window
        
        let viewController = ViewController()
        
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}
