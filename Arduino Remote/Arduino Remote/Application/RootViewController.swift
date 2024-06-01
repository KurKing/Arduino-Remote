//
//  RootViewController.swift
//  Arduino Remote
//
//  Created by Oleksii on 08.05.2024.
//

import UIKit

class RootViewController: UIViewController {
    
    private lazy var ipFetcher: IPFetchServiceProtocol? = IPFetchService()
    
    override func viewDidLoad() {
         
        super.viewDidLoad()
        
        ipFetcher?.fetchIP(context: self) { [weak self] in
            self?.presentChildViews()
            self?.ipFetcher = nil
        }
    }
    
    private func presentChildViews() {
        
        navigationController?.pushViewController(SchemesListViewController.instantiate(),
                                                 animated: true)
    }
}
