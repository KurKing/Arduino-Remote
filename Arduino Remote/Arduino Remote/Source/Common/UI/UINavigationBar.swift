//
//  UINavigationBar.swift
//  Arduino Remote
//
//  Created by Oleksii on 18.05.2024.
//

import UIKit

extension UINavigationBar {
    
    class func setupDefaultAppearance() {
        
        UINavigationBar.appearance().tintColor = .mediumSkyBlue
        
        let font = UIFont(name: "HelveticaNeue-Bold", size: 18.0)!
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: UIColor.mediumSkyBlue
        ]
    }
}
