//
//  StoredIpAddressConfig.swift
//  Arduino Remote
//
//  Created by Oleksii on 13.05.2024.
//

import Foundation
import RealmSwift

class StoredIpAddressConfig: Object {
    
    @Persisted var ipAddress = ""
}
