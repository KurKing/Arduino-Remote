//
//  SchemesListViewController.swift
//  Arduino Remote
//
//  Created by Oleksii on 01.06.2024.
//

import UIKit

extension SchemesListViewController {
    
    class func instantiate() -> SchemesListViewController {
        
        let storyboard = UIStoryboard(name: "SchemesList", bundle: nil)
        let identifier = "SchemesListViewController"
        
        let viewController = storyboard
            .instantiateViewController(withIdentifier: identifier) as! SchemesListViewController
                
        return viewController
    }
}

class SchemesListViewController: UIViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
    }
    
// MARK: - Actions
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        navigationController?.pushViewController(SchemeViewController.instantiate(),
                                                 animated: true)
    }
}
