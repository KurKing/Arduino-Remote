//
//  AppDelegate.swift
//  Arduino Remote
//
//  Created by Oleksii on 22.04.2024.
//

import UIKit
import Hopoate

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, 
                     didFinishLaunchingWithOptions
                     launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        register(AlamofireApiManager(), for: ApiManager.self)
        register(MockApiManager(), for: ApiManager.self)
        register(EncryptedRealmStorageManager(), for: RealmStorageManager.self)
        register(SVProgressHUDLoadingIndicator(), for: LoadingIndicator.self)
        
        UINavigationBar.appearance().tintColor = .mediumSkyBlue

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
