//
//  GuidanceViewController.swift
//  Arduino Remote
//
//  Created by Oleksii on 13.05.2024.
//

import UIKit
import SpriteKit
import RxSwift
import RxCocoa

extension GuidanceViewController {
    
    class func instantiate() -> GuidanceViewController {
        
        let storyboard = UIStoryboard(name: "Guidance", bundle: nil)
        let identifier = "GuidanceViewController"
        
        let viewController = storyboard
            .instantiateViewController(withIdentifier: identifier) as! GuidanceViewController
        
        viewController.scene = ContollerScene()
        
        return viewController
    }
}

class GuidanceViewController: UIViewController {
    
    @IBOutlet weak var spriteKitView: SKView!
    private var scene: SKScene!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        spriteKitView.presentScene(scene)
        
        spriteKitView.rx.observe(CGRect.self, "bounds")
            .compactMap({ $0 })
            .subscribe(onNext: { [weak self] rect in
                self?.scene?.size = rect.size
            }).disposed(by: disposeBag)
    }
}
