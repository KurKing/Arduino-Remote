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
}
