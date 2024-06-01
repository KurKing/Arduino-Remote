//
//  UINavigationBar.swift
//  Arduino Remote
//
//  Created by Oleksii on 18.05.2024.
//

import UIKit

extension UINavigationBar {
    
    class func setupDefaultAppearance() {
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        
        let font = UIFont(name: "HelveticaNeue-Bold", size: 18.0)!
        navigationBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: UIColor.mediumSkyBlue
        ]
        navigationBarAppearance.backgroundColor = .darkMidnightBlue
        
        UINavigationBar.appearance().tintColor = .mediumSkyBlue
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
    }
}
