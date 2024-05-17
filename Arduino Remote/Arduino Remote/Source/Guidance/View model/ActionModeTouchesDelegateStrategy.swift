//
//  ActionModeTouchesDelegateStrategy.swift
//  Arduino Remote
//
//  Created by Oleksii on 14.05.2024.
//

import Foundation
import SpriteKit
import RxSwift

class ActionModeTouchesDelegateStrategy: TouchesDelegateStrategy {
    
    weak var scene: SKScene?
    
    private var ledIsOn = false
    private let disposeBag = DisposeBag()

    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { /*...*/ }
    
    func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) { /*...*/ }
    
    func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let scene = scene,
              let location = touches.first?.location(in: scene),
              let button = scene.nodes(at: location)
                            .compactMap({ $0 as? ButtonNode })
                            .first else {
            return
        }

        button.blynkAnimation()
        ledIsOn.toggle()
        
        resolve(ApiManager.self)
            .ledRequest(pin: button.pinNumber, isOn: ledIsOn)
            .subscribe(onNext: { _ in
                
                print("[ACTION MODE] Led toggled")
            }, onError: { error in
                
                print("[ACTION MODE] \(error.localizedDescription)")
            }).disposed(by: disposeBag)
    }
}
