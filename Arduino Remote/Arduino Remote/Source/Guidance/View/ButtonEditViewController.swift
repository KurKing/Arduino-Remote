//
//  ButtonEditViewController.swift
//  Arduino Remote
//
//  Created by Oleksii on 25.05.2024.
//

import UIKit

extension ButtonEditViewController {
    
    class func instantiate() -> UIViewController {
        
        let storyboard = UIStoryboard(name: "Guidance", bundle: nil)
        let identifier = "ButtonEditViewController"
        
        let viewContoller = storyboard.instantiateViewController(withIdentifier: identifier)
                                as! ButtonEditViewController
        return viewContoller
    }
}

class ButtonEditViewController: UIViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
}
