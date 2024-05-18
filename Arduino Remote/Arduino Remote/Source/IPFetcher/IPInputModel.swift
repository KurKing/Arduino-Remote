//
//  IPInputModel.swift
//  Arduino Remote
//
//  Created by Oleksii on 13.05.2024.
//

import Foundation
import RxSwift

protocol IPInputModelProtocol: AnyObject {
    
    func check(ipAddress: String) -> Observable<String>
    func getStoredIpAddress() -> Observable<String>
    
    func save(ipAddress: String?)
}

enum IPInputModelError: Error {
    
    case validationError
}

class IPInputModel: IPInputModelProtocol {
        
    private var apiManager: ApiManager { resolve(ApiManager.self) }
    private var localStorageManager: RealmStorageManager {
        resolve(RealmStorageManager.self)
    }
    
    func check(ipAddress: String) -> Observable<String> {
        
        guard let ipAddress = ipAddress.emptyToNil,
              ipAddress.isIpAddress else {
            
            return Observable.error(IPInputModelError.validationError)
        }
        
        apiManager.configure(with: ipAddress)

        return apiManager.healthCheck().map({ _ in ipAddress })
    }
    
    func getStoredIpAddress() -> Observable<String> {
        
        Observable.create { observer in
            
            self.localStorageManager.read { realm in
                
                guard let ipAddress = realm.objects(StoredIpAddressConfig.self)
                    .first?
                    .ipAddress
                    .emptyToNil else {
                    
                    observer.onError(LocalStorageError.objectNotFound)
                    return
                }
                
                guard ipAddress.isIpAddress else {
                    observer.onError(IPInputModelError.validationError)
                    return
                }
                
                observer.onNext(ipAddress)
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
    
    func save(ipAddress: String?) {
        
        localStorageManager.read { realm in
            
            if let existedObject = realm.objects(StoredIpAddressConfig.self).first {
                
                try? realm.write({
                    existedObject.ipAddress = ipAddress ?? ""
                })
                return
            }
            
            let config = StoredIpAddressConfig()
            config.ipAddress = ipAddress ?? ""
            
            try? realm.write({
                realm.add(config)
            })
        }
    }
}
