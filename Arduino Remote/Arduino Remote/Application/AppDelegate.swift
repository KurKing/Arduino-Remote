//
//  AppDelegate.swift
//  Arduino Remote
//
//  Created by Oleksii on 22.04.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, 
                     didFinishLaunchingWithOptions
                     launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        _ = ApiManager.shared
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, 
                     configurationForConnecting connectingSceneSession: UISceneSession, 
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {

        return UISceneConfiguration(name: "Default Configuration", 
                                    sessionRole: connectingSceneSession.role)
    }
}