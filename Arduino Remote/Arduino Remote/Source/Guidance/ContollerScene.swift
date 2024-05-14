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

class ContollerScene: SKScene {

    private var rectNode: SKShapeNode {
        
        let node = SKShapeNode(rectOf: .init(width: 60, height: 60),
                                     cornerRadius: 4)
        node.lineWidth = 2.5
        
        return node
    }
    
    private var selectedNode: SKNode?
    
    override init() {
        
        super.init(size: .zero)
        
        scaleMode = .aspectFill
        backgroundColor = UIColor.darkMidnightBlue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func touchDown(atPoint pos : CGPoint) {

        let n = rectNode
        n.position = pos
        n.strokeColor = UIColor.mediumSkyBlue
        n.fillColor = UIColor.mediumSkyBlue
        self.addChild(n)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let location = touches.first?.location(in: self) else { return }

        if let nodeToSelect = nodes(at: location).first {
            
            selectedNode = nodeToSelect
            return
        }
        
        let newNode = rectNode
        newNode.position = location
        newNode.strokeColor = UIColor.mediumSkyBlue
        self.addChild(newNode)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let location = touches.first?.location(in: self) else { return }
        
        if let selectedNode = selectedNode {
            
            let clampedX = min(max(location.x, 0), size.width)
            let clampedY = min(max(location.y, 0), size.height)
            let newPosition = CGPoint(x: clampedX, y: clampedY)
            
            selectedNode.run(
                SKAction.move(to: newPosition,
                              duration: moveTime(from: selectedNode.position,
                                                 to: newPosition))
            )
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        selectedNode = nil
    }
    
    private func moveTime(from start: CGPoint, to finish: CGPoint) -> TimeInterval {
        
        // Pythagorean theorem
        let S: CGFloat = sqrt(pow(start.x-finish.x, 2) + pow(start.y-finish.y, 2))
        let V: CGFloat = 2000.0
        
        // T = S / V
        return TimeInterval(S / V)
    }
}
