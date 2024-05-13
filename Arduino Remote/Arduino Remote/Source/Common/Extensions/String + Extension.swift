//
//  String + Extension.swift
//  Arduino Remote
//
//  Created by Oleksii on 08.05.2024.
//

import Foundation

extension String {
    
    var trimmed: String { trimmingCharacters(in: .whitespacesAndNewlines) }
    var emptyToNil: String? {
        
        let trimmed = self.trimmed
        
        if trimmed.isEmpty {
            return nil
        }
        
        return trimmed
    }
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
    
    var isIpAddress: Bool {
        
        let ipPattern = #"^\b(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b$"#
        return self ~= ipPattern
    }
}
