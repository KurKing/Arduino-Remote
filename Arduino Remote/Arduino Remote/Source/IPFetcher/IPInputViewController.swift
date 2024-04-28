//
//  IPInputViewController.swift
//  Arduino Remote
//
//  Created by Oleksii on 28.04.2024.
//

import UIKit

extension IPInputViewController {
    
    class func createInstance() -> IPInputViewController {
        
        let storyboard = UIStoryboard(name: "IPInputView", bundle: nil)
        let identifier = "IPInputViewController"
        
        let viewController = storyboard
            .instantiateViewController(withIdentifier: identifier) as! IPInputViewController
        
        viewController.modalPresentationStyle = .fullScreen
        
        return viewController
    }
}

class IPInputViewController: UIViewController {
    
    @IBOutlet weak var completeButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        
        completeButton.layer.cornerRadius = 8
    }
}
