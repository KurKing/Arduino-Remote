//
//  SchemeItemRealm.swift
//  Arduino Remote
//
//  Created by Oleksii on 01.06.2024.
//

import Foundation
import RealmSwift

class ButtonRealmModel: Object {
    
    @Persisted var pin: Int = 0
    @Persisted var modeIndex: Int = 0
    @Persisted var x: Double = 0
    @Persisted var y: Double = 0
}

class ItemRealmModel: Object {
    
    @Persisted(primaryKey: true) var id = ""
    @Persisted var title = ""
    
    @Persisted var buttons: List<ButtonRealmModel>
}
