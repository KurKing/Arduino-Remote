//
//  KeychainStorage.swift
//  Arduino Remote
//
//  Created by Oleksii on 13.05.2024.
//

import Foundation
import KeychainAccess
import CryptoKit

class KeychainStorage {
    
    private let keychain: Keychain
    
    init(service: String) {
        keychain = Keychain(service: service)
    }
    
    func save(_ data: Data?, for key: String) {
        keychain[data: key] = data
    }
    
    func loadData(for key: String) -> Data? {
        keychain[data: key]
    }
    
    func symmetricKey(for key: String,
                      keySize: SymmetricKeySize = .bits256) -> SymmetricKey {
        
        if let symmetricKey = loadData(for: key).map({ SymmetricKey(data: $0) }) {
            return symmetricKey
        }
        
        let symmetricKey = SymmetricKey(size: keySize)
        
        let keyData = symmetricKey.withUnsafeBytes { Data(Array($0)) }
        save(keyData, for: key)
        
        return symmetricKey
    }
}
