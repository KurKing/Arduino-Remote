//
//  RootViewController.swift
//  Arduino Remote
//
//  Created by Oleksii on 08.05.2024.
//

import UIKit

class RootViewController: UIViewController {
    
    private lazy var ipFetcher: IPFetchServiceProtocol = IPFetchService()
    
    override func viewWillAppear(_ animated: Bool) {
        
        ipFetcher.fetchIP(context: self) { [weak self] in
            self?.presentChildViews()
        }
    }
    
    private func presentChildViews() {
        
        
    }
}
