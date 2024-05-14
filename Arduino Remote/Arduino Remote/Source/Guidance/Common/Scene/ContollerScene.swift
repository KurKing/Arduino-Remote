//
//  ContollerScene.swift
//  Arduino Remote
//
//  Created by Oleksii on 14.05.2024.
//

import Foundation
import SpriteKit
import RxSwift
import RxRelay

protocol TouchesDelegateStrategy {
    
    var scene: SKScene? { get set }
    
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
}

class ContollerScene: SKScene {
    
    var touchesDelegateStrategy: TouchesDelegateStrategy? {
        didSet {
            touchesDelegateStrategy?.scene = self
        }
    }
    
    override init() {
        
        super.init(size: .zero)
        
        scaleMode = .aspectFill
        backgroundColor = UIColor.darkMidnightBlue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesDelegateStrategy?.touchesBegan(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesDelegateStrategy?.touchesMoved(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesDelegateStrategy?.touchesEnded(touches, with: event)
    }
}
