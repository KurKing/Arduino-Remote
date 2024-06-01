//
//  SchemesListItem.swift
//  Arduino Remote
//
//  Created by Oleksii on 01.06.2024.
//

import Foundation

class SchemesListItem {
    
    let id: String
    let title: String
    
    var buttons = [ButtonModel]()
    
    init(id: String, title: String) {
        self.id = id
        self.title = title
    }
}
