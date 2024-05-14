//
//  CreationModeTouchesDelegateStrategy.swift
//  Arduino Remote
//
//  Created by Oleksii on 14.05.2024.
//

import Foundation
import SpriteKit

class CreationModeTouchesDelegateStrategy: TouchesDelegateStrategy {
    
    weak var scene: SKScene?
    
    private var buttonSize: CGFloat { 60 }
    
    private var rectNode: SKShapeNode {
        
        let node = SKShapeNode(rectOf: .init(width: buttonSize, height: buttonSize),
                               cornerRadius: 4)
        node.lineWidth = 2.5
        return node
    }
    
    private var selectedNode: SKNode?
    private var selectedNodeWasEverMoved = false
    
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let scene = scene,
              let location = touches.first?.location(in: scene) else { return }
        
        if let nodeToSelect = scene.nodes(at: location).first {
            
            selectedNode = nodeToSelect
            return
        }
        
        let newNode = rectNode
        newNode.position = transform(location: location)
        newNode.strokeColor = UIColor.mediumSkyBlue
        scene.addChild(newNode)
    }
    
    func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let scene = scene,
              let location = touches.first?.location(in: scene) else { return }
        
        if let selectedNode = selectedNode {

            selectedNode.move(to: transform(location: location))
            
            selectedNodeWasEverMoved = true
        }
    }
    
    func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let selectedNode = selectedNode as? SKShapeNode,
           !selectedNodeWasEverMoved {
            
            let randomRed = CGFloat.random(in: 0...1)
            let randomGreen = CGFloat.random(in: 0...1)
            let randomBlue = CGFloat.random(in: 0...1)
            
            selectedNode.strokeColor = UIColor(red: randomRed,
                                               green: randomGreen,
                                               blue: randomBlue, alpha: 1.0)
        }
        
        selectedNode = nil
        selectedNodeWasEverMoved = false
    }
    
    private func transform(location: CGPoint) -> CGPoint {
        
        guard let scene = scene else { return location }
        
        var X = min(max(location.x, 0), scene.size.width)
        var Y = min(max(location.y, 0), scene.size.height)
        
        let divider: CGFloat = 20
        X = round(X / divider) * divider
        Y = round(Y / divider) * divider

        return .init(x: X, y: Y)
    }
}

private extension SKNode {
    
    func move(to location: CGPoint) {
        
        let time = moveTime(from: position, to: location)
        
        run(SKAction.move(to: location, duration: time))
    }
    
    private func moveTime(from start: CGPoint, to finish: CGPoint) -> TimeInterval {
        
        // Pythagorean theorem
        let S: CGFloat = sqrt(pow(start.x-finish.x, 2) + pow(start.y-finish.y, 2))
        let V: CGFloat = 4000.0
        
        // T = S / V
        return TimeInterval(S / V)
    }
}
