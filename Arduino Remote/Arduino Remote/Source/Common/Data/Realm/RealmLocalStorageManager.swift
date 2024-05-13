//
//  RealmLocalStorageManager.swift
//  Arduino Remote
//
//  Created by Oleksii on 13.05.2024.
//

import Foundation
import RealmSwift

enum LocalStorageError: Error {
    
    case objectNotFound
}

protocol RealmStorageManager {
    
    func read(with block: ((Realm) -> ())?)
    func write(with block: ((Realm) -> ())?)
}

class EncryptedRealmStorageManager: RealmStorageManager {
    
    private lazy var realm: Realm = try! Realm(configuration: config)
    private lazy var backgroundRealm: Realm = try! Realm(configuration: config)
    
    private let config: Realm.Configuration
    
    init() {
        
        let keychainStorage = KeychainStorage(service: "realm.storage.manager")
        let key = keychainStorage
            .symmetricKey(for: "realm.configuration",
                          keySize: .init(bitCount: 512))
            .withUnsafeBytes { Data(Array($0)) }
        
        config = Realm.Configuration(encryptionKey: key)
    }
    
    private var realmInstance: Realm {
        
        if Thread.isMainThread {
            return realm
        }
        
        return backgroundRealm
    }
    
    func read(with block: ((Realm) -> ())?) {
                
        let realm = realmInstance
        block?(realm)
    }
    
    func write(with block: ((Realm) -> ())?) {
        
        let realm = realmInstance

        realm.writeAsync({
            block?(realm)
        })
    }
}
