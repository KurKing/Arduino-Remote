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
    
    init(router: RouterProtocol = IPInputRouter()) {
        self.router = router
    }
    
    func fetchIP(context: UIViewController, with block: (()->())?) {
        
        router.route(to: .fakeLaunchScreen, context)
        
        if let storedIPAddress = getStoredIPAddress() {
            
            check(address: storedIPAddress) { [weak self] isValid in
                
                if isValid {
                    
                    self?.router.route(to: .back, context)
                    block?()
                    return
                }
                
                self?.save(ipAddress: nil)
                self?.presentInputScreen(context: context) { [weak self] ipAddress in
                    self?.save(ipAddress: ipAddress)
                }
            }
            return
        }
        
        presentInputScreen(context: context) { [weak self] ipAddress in
            
            self?.save(ipAddress: ipAddress)
            block?()
        }
    }
}

// MARK: Helpers
private extension IPFetchService {
    
    func check(address: String, with block: ((Bool)->())?) {
        
        ApiManager.shared.configure(with: address)

        ApiManager.shared.healthCheck
            .subscribe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { _ in
                block?(true)
            }, onError: { error in
                
                print("[HEALTH CHECK] Error: \(error)")
                block?(false)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: Local storage
private extension IPFetchService {
    
    func getStoredIPAddress() -> String? {
        return nil
    }
    
    func save(ipAddress: String?) {
        
        
    }
}

// MARK: From user
private extension IPFetchService {
    
    func presentInputScreen(context: UIViewController, with block: ((String) -> ())?) {
        
        let onComplete = { [weak self] ipAddress in
            
            self?.router.route(to: .back, context)
            block?(ipAddress)
        }
        
        router.route(to: .ipInput, context, onComplete)
    }
}
