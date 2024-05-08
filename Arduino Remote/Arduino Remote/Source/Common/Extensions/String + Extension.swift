//
//  String + Extension.swift
//  Arduino Remote
//
//  Created by Oleksii on 08.05.2024.
//

import Foundation

extension String {
    
    var trimmed: String { trimmingCharacters(in: .whitespacesAndNewlines) }
}

// MARK: - Regex
extension NSRegularExpression {
    
    func matches(_ string: String) -> Bool {
        
        let range = NSRange(location: 0, length: string.utf16.count)
        return firstMatch(in: string, options: [], range: range) != nil
    }
}

extension String {
    
    static func ~= (lhs: String, rhs: String) -> Bool {
        
        guard let regex = try? NSRegularExpression(pattern: rhs) else { return false }
        return regex.matches(lhs)
    }
}

extension String {
    
    var containsOnlyNumbersAndDots: Bool { self ~= "^[0-9.]+$" }
}
