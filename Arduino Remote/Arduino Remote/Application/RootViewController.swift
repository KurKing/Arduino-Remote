//
//  RootViewController.swift
//  Arduino Remote
//
//  Created by Oleksii on 08.05.2024.
//

import UIKit

class RootRouter: RouterProtocol {
    
    func route(to route: Route, _ context: UIViewController, _ parameter: Any?) {
        
        guard route == .schemeList else { fatalError("Unknown root") }
        
        let listViewController = SchemesListViewController.instantiate()
        context.navigationController?.pushViewController(listViewController,
                                                         animated: true)
    }
}

class RootViewController: UIViewController {
    
    private lazy var ipFetcher: IPFetchServiceProtocol? = IPFetchService()
    private let router: RouterProtocol = RootRouter()
    
    override func viewDidLoad() {
         
        super.viewDidLoad()
        
        ipFetcher?.fetchIP(context: self) { [weak self] in
            
            guard let self = self else { return }
            
            self.router.route(to: .schemeList, self)
            self.ipFetcher = nil
        }
    }
}
