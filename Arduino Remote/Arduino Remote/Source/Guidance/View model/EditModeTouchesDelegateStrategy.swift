//
//  EditModeTouchesDelegateStrategy.swift
//  Arduino Remote
//
//  Created by Oleksii on 14.05.2024.
//

import UIKit
import SpriteKit

protocol EditModeMenuPresenter: UIViewController {
    
    func present(menu: UIViewController, position: CGPoint)
}

class EditModeTouchesDelegateStrategy: NSObject, TouchesDelegateStrategy {
    
    weak var scene: SKScene?
    private weak var menuPresenter: UIViewController?
    
    private var selectedNode: ButtonNode?
    private var selectedNodeWasEverMoved = false
    
    init(presenter: UIViewController) {
        self.menuPresenter = presenter
    }
    
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let scene = scene,
              let location = touches.first?.location(in: scene) else { return }
        
        if let nodeToSelect = scene.nodes(at: location)
                                .compactMap({ $0 as? ButtonNode })
                                .first {
            selectedNode = nodeToSelect
            return
        }
        
        let newNode = ButtonNode.instantiate(location: transform(location: location))
        scene.addChild(newNode)
    }
    
    func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let scene = scene,
              let location = touches.first?.location(in: scene) else { return }
        
        if let selectedNode = selectedNode {
            if selectedNode.move(to: transform(location: location)) {
                selectedNodeWasEverMoved = true
            }
        }
    }
    
    func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let selectedNode = selectedNode,
           !selectedNodeWasEverMoved {
            
            guard let scene = scene,
                  let menuPresenter = menuPresenter as? EditModeMenuPresenter else { return }
            
            let buttonPosition = scene.convertPoint(toView: selectedNode.position)
                        
            let menu = ButtonEditViewController.instantiate()
            menuPresenter.present(menu: menu, position: buttonPosition)
        }
        
        selectedNode = nil
        selectedNodeWasEverMoved = false
    }
    
    private func transform(location: CGPoint) -> CGPoint {
        
        guard let scene = scene else { return location }
        
        var X = min(max(location.x, 0), scene.size.width)
        var Y = min(max(location.y, 0), scene.size.height)
        
        let divider: CGFloat = ButtonNode.buttonSize / 2
        X = round(X / divider) * divider
        Y = round(Y / divider) * divider

        return .init(x: X, y: Y)
    }
}
