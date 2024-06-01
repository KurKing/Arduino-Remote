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
    
    init(realmObject: ButtonRealmModel) {
        
        pin = realmObject.pin
        mode = .init(rawValue: realmObject.modeIndex) ?? .oneClick
        position = .init(x: realmObject.x,
                         y: realmObject.y)
    }
}
