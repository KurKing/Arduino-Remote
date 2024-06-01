//
//  SchemesListModel.swift
//  Arduino Remote
//
//  Created by Oleksii on 01.06.2024.
//

import Foundation
import RxSwift

protocol SchemesListModelProtocol {
    func loadItems() -> Observable<[SchemesListItem]>
}

class SchemesListModel: SchemesListModelProtocol {
    
    private var localStorageManager: RealmStorageManager {
        resolve(RealmStorageManager.self)
    }
    
    func loadItems() -> Observable<[SchemesListItem]> {
        
        return Observable.create { observer -> Disposable in
            
            self.localStorageManager.read { realm in
                
                let items = realm.objects(ItemRealmModel.self)
                    .map({ realmItem in
                        
                        let item = SchemesListItem(id: realmItem.id, 
                                                   title: realmItem.title)
                        item.buttons = realmItem.buttons.map({
                            ButtonModel(realmObject: $0)
                        })
                        
                        return item
                    })
                
                observer.onNext(Array(items))
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
}
