//
//  ButtonNode.swift
//  Arduino Remote
//
//  Created by Oleksii on 17.05.2024.
//

import Foundation
import SpriteKit

enum ButtonNodeMode {
    
    case oneClick
    case buttonSwitch
    
    static func mode(for index: Int) -> ButtonNodeMode {
        
        switch index {
        case 1:
            return .buttonSwitch
        default:
            return .oneClick
        }
    }
    
    var intIndex: Int {
        switch self {
        case .oneClick:
            0
        case .buttonSwitch:
            1
        }
    }
}

extension ButtonNode {
    
    class func instantiate(location: CGPoint) -> ButtonNode {
        
        let button = ButtonNode(rectOf: .init(width: buttonSize, 
                                              height: buttonSize),
                                cornerRadius: buttonSize * 0.2)
        
        button.setup()
        button.position = location
        
        return button
    }
}

class ButtonNode: SKShapeNode {
    
    // !!! buttonSize % 2 = 0
    static var buttonSize: CGFloat { 100 }
    
    private weak var circle: SKShapeNode?
    private weak var label: SKLabelNode?
    
    var pinNumber = 0 {
        didSet {
            label?.text = "P\(pinNumber)"
        }
    }
    
    var isOn = false
    var mode = ButtonNodeMode.oneClick
    
    override var strokeColor: UIColor {
        get { super.strokeColor }
        set {
            super.strokeColor = newValue
            circle?.strokeColor = newValue
            label?.fontColor = newValue
        }
    }
    
    @discardableResult
    func move(to location: CGPoint) -> Bool {
        
        if position == location {
            return false
        }
        
        let time = moveTime(from: position, to: location)
        
        run(SKAction.move(to: location, duration: time))
        
        return true
    }
    
    func blynkAnimation() {
        
        let currentColor = strokeColor
        
        run(.sequence([
            .customAction(withDuration: 0.2, actionBlock: { _, _ in
                self.strokeColor = .white
            }),
            .customAction(withDuration: 0.2, actionBlock: { _, _ in
                self.strokeColor = currentColor
            })
        ]))
    }
    
    private func moveTime(from start: CGPoint, to finish: CGPoint) -> TimeInterval {
        
        // Pythagorean theorem
        let S: CGFloat = sqrt(pow(start.x-finish.x, 2) + pow(start.y-finish.y, 2))
        let V: CGFloat = 4000.0
        
        // T = S / V
        return TimeInterval(S / V)
    }

    private func setup() {
        
        lineWidth = 2.5
        
        let circle = SKShapeNode(circleOfRadius: Self.buttonSize / 2 * 0.75)
        circle.lineWidth = 2.5
        addChild(circle)
        self.circle = circle
        
        let label = SKLabelNode(text: "P0")
        label.fontName = "HelveticaNeue-Bold"
        label.fontSize = 20
        label.verticalAlignmentMode = .center
        label.horizontalAlignmentMode = .center
        label.position = .zero
        addChild(label)
        self.label = label
        
        strokeColor = .mediumSkyBlue
    }
}
