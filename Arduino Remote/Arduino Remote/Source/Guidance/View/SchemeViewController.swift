//
//  SchemeViewController.swift
//  Arduino Remote
//
//  Created by Oleksii on 13.05.2024.
//

import UIKit
import SpriteKit
import RxSwift
import RxCocoa

extension SchemeViewController {
    
    class func instantiate() -> SchemeViewController {
        
        let storyboard = UIStoryboard(name: "Scheme", bundle: nil)
        let identifier = "SchemeViewController"
        
        let viewController = storyboard
            .instantiateViewController(withIdentifier: identifier) as! SchemeViewController
        
        viewController.scene = ContollerScene()
        
        return viewController
    }
}

class SchemeViewController: UIViewController {
    
    @IBOutlet weak var spriteKitView: SKView!
    @IBOutlet weak var playButton: UIBarButtonItem!
    private var scene: ContollerScene!
    
    private var mode = SchemeMode.edit
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "Scheme"
        
        spriteKitView.presentScene(scene)
        
        spriteKitView.rx.observe(CGRect.self, "bounds")
            .compactMap({ $0 })
            .subscribe(onNext: { [weak self] rect in
                self?.scene?.size = rect.size
            }).disposed(by: disposeBag)
        scene.size = spriteKitView.bounds.size
        
        setupMode()
    }
    
    
    @IBAction func playButtonTapped(_ sender: Any) {
        
        mode = mode.inverted
        
        setupMode()
    }
    
    private func setupMode() {
        
        playButton.image = mode.buttonImage
        scene.touchesDelegateStrategy = mode.touchesStrategy(presenter: self)
    }
}

private extension SchemeMode {
    
    var buttonImage: UIImage {
        switch self {
        case .edit:
            return UIImage(systemName: "play.fill")!
        case .action:
            return UIImage(systemName: "pause.fill")!
        }
    }
}

// MARK: Menu presenter
extension SchemeViewController: EditModeMenuPresenter {
    
    func present(menu: UIViewController, position: CGPoint) {
        
        menu.modalPresentationStyle = .popover
        menu.preferredContentSize = .init(width: 320, height: 160)
        menu.popoverPresentationController?.sourceView = spriteKitView
        menu.popoverPresentationController?.sourceRect = CGRect(origin: position,
                                                                size: .zero)
        menu.popoverPresentationController?.permittedArrowDirections = [.up, .down]
        menu.popoverPresentationController?.delegate = self

        present(menu, animated: true)
    }
}

extension SchemeViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController, 
                                   traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        .none
    }
}
