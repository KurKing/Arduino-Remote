//
//  UIView + Extension.swift
//  Arduino Remote
//
//  Created by Oleksii on 08.05.2024.
//

import UIKit

extension UIView {
    
    func shake() {
        
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.5
        animation.values = [0.0, -5.0, 5.0, -5.0, 5.0, -5.0, 5.0, -5.0, 5.0, 0.0]
        
        layer.add(animation, forKey: "shake")
    }
    
    func pin(to view: UIView) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topAnchor.constraint(equalTo: view.topAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
