//
//  ActionModeTouchesDelegateStrategy.swift
//  Arduino Remote
//
//  Created by Oleksii on 14.05.2024.
//

import Foundation
import SpriteKit

class ActionModeTouchesDelegateStrategy: TouchesDelegateStrategy {
    
    weak var scene: SKScene?
    private let model: ActionModeModelProtocol
    
    init(model: ActionModeModelProtocol = ActionModeModel()) {
        self.model = model
    }

    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            
        guard let scene = scene,
              let location = touches.first?.location(in: scene),
              let button = scene.nodes(at: location)
                            .compactMap({ $0 as? ButtonNode })
                            .first else {
            return
        }
        
        if button.mode == .oneClick {
            button.isOn = true
            model.sendLedRequest(pin: button.pinNumber, isOn: true)
        }
    }
    
    func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) { /*...*/ }
    
    func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let scene = scene,
              let location = touches.first?.location(in: scene),
              let button = scene.nodes(at: location)
                            .compactMap({ $0 as? ButtonNode })
                            .first else {
            return
        }
        
        if button.mode == .oneClick {
            
            button.isOn = false
            model.sendLedRequest(pin: button.pinNumber, isOn: false)
        } else {
            
            button.blynkAnimation()
            button.isOn.toggle()
            
            model.sendLedRequest(pin: button.pinNumber, isOn: button.isOn)
        }
    }
}
