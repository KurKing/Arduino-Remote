//
//  Collection+Extension.swift
//  Arduino Remote
//
//  Created by Oleksii on 01.06.2024.
//

import Foundation

extension Collection {
    
    subscript (safe index: Index) -> Element? {
        
        return indices.contains(index) ? self[index] : nil
    }
}
