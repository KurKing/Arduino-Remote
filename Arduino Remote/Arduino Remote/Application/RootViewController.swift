//
//  RootViewController.swift
//  Arduino Remote
//
//  Created by Oleksii on 08.05.2024.
//

import UIKit

class RootViewController: UIViewController {
    
    private lazy var ipFetcher: IPFetchServiceProtocol = IPFetchService()
    private var isInitiated = false
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if !isInitiated {
            
            ipFetcher.fetchIP(context: self) { [weak self] in
                self?.presentChildViews()
            }
            
            isInitiated = true
        } else {
            
        }
    }
    
    private func presentChildViews() {
        
        
    }
}
