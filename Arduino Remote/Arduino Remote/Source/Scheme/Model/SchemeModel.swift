//
//  SchemeModel.swift
//  Arduino Remote
//
//  Created by Oleksii on 01.06.2024.
//

import Foundation
import RealmSwift

protocol SchemeModelProtocol {
    func save(item: SchemesListItem)
}

class SchemeModel: SchemeModelProtocol {
    
    private var localStorageManager: RealmStorageManager {
        resolve(RealmStorageManager.self)
    }

    func save(item: SchemesListItem) {
        
        localStorageManager.read { realm in
            
            let newButtons = item.buttons
                .map({
                    let realmButton = ButtonRealmModel()
                    
                    realmButton.pin = $0.pin
                    realmButton.modeIndex = $0.mode.rawValue
                    realmButton.x = $0.position.x
                    realmButton.y = $0.position.y
                    
                    return realmButton
                })
            
            if let existing = realm.object(ofType: ItemRealmModel.self,
                                           forPrimaryKey: item.id) {
                try? realm.write({
                    existing.buttons.removeAll()
                    existing.buttons.append(objectsIn: newButtons)
                })
                return
            }
            
            let object = ItemRealmModel()
            object.id = item.id
            object.title = item.title
            
            try? realm.write({
                realm.add(object)
            })
        }
    }
}
