//
//  IPFetchService.swift
//  Arduino Remote
//
//  Created by Oleksii on 08.05.2024.
//

import UIKit
import RxSwift

protocol IPFetchServiceProtocol {
    func fetchIP(context: UIViewController, with block: (()->())?)
}

class IPFetchService: IPFetchServiceProtocol {
    
    private let router: RouterProtocol
    private let disposeBag = DisposeBag()
    
    private var apiManager: ApiManager { resolve(ApiManager.self) }
    private var localStorageManager: RealmStorageManager { resolve(RealmStorageManager.self) }
    
    init(router: RouterProtocol = IPInputRouter()) {
        self.router = router
    }
    
    func fetchIP(context: UIViewController, with block: (()->())?) {
        
        router.route(to: .fakeLaunchScreen, context)
        
        getStoredIPAddress()
            .flatMapFirst({ [weak self] ipAddress -> Observable<String> in
                
                guard let self = self else {
                    return Observable.error(ApiManagerError.noBaseURL)
                }
                
                return self.check(address: ipAddress)
            })
            .subscribe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] ipAddress in
                
                self?.router.route(to: .back, context)
                block?()
            }, onError: { [weak self] _ in
                
                self?.save(ipAddress: nil)
                self?.presentInputScreen(context: context, with: block)
            }).disposed(by: disposeBag)
    }
}

// MARK: Helpers
private extension IPFetchService {
    
    func check(address: String) -> Observable<String> {
        
        apiManager.configure(with: address)

        return apiManager.healthCheck().map({ _ in address })
    }
}

// MARK: Local storage
private extension IPFetchService {
    
    func getStoredIPAddress() -> Observable<String> {
        
        Observable.create { observer in
            
            self.localStorageManager.read { realm in
                
                guard let ipAddress = realm.objects(StoredIpAddressConfig.self)
                    .first?
                    .ipAddress
                    .emptyToNil else {
                    
                    observer.onError(LocalStorageError.objectNotFound)
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

// MARK: From user
private extension IPFetchService {
    
    func presentInputScreen(context: UIViewController, with block: (()->())?) {
        
        let onComplete = { [weak self] ipAddress in
            
            guard let self = self else { return }
            
            self.router.route(to: .back, context)
            
            self.check(address: ipAddress)
                .subscribe(on: MainScheduler.asyncInstance)
                .subscribe(onNext: { [weak self] validIpAddress in
                    
                    self?.save(ipAddress: validIpAddress)
                    self?.router.route(to: .back, context)
                    block?()
                }, onError: { [weak self] _ in
                    
                    self?.presentInputScreen(context: context, with: block)
                }).disposed(by: self.disposeBag)
        }
        
        DispatchQueue.main.async {
            self.router.route(to: .ipInput, context, onComplete)
        }
    }
}
