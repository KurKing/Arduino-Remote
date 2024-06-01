//
//  SchemeListRouter.swift
//  Arduino Remote
//
//  Created by Oleksii on 01.06.2024.
//

import UIKit

class SchemeListRouter: RouterProtocol {
    
    func route(to route: Route, _ context: UIViewController, _ parameter: Any?) {
        
        guard route == .scheme else { fatalError("Unknown root") }
        
        guard let item = parameter as? SchemesListItem else { return }
        
        let schemeListViewController = SchemeViewController.instantiate(item: item)
        
        context.navigationController?.pushViewController(schemeListViewController,
                                                         animated: true)
    }
}
