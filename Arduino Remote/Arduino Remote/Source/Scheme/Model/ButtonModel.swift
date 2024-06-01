//
//  ButtonModel.swift
//  Arduino Remote
//
//  Created by Oleksii on 01.06.2024.
//

import Foundation

class ButtonModel {
    
    let pin: Int
    let position: CGPoint
    let mode: ButtonNodeMode
    
    init(node: ButtonNode) {
        
        pin = node.pinNumber
        position = node.position
        mode = node.mode
    }
}
