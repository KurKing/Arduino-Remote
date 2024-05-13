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
    private let viewModel: IPInputViewModelProtocol
    
    private let disposeBag = DisposeBag()
    
    private var apiManager: ApiManager { resolve(ApiManager.self) }
    private var localStorageManager: RealmStorageManager { resolve(RealmStorageManager.self) }
    
    init(router: RouterProtocol = IPInputRouter(),
         viewModel: IPInputViewModelProtocol = IPInputViewModel()) {
        
        self.router = router
        self.viewModel = viewModel
    }
    
    func fetchIP(context: UIViewController, with block: (()->())?) {
        
        router.route(to: .fakeLaunchScreen, context)
        
        let model = viewModel.model
        viewModel.onComplete = { [weak self] _ in
            self?.router.route(to: .back, context)
            block?()
        }
        
        model.getStoredIpAddress()
            .flatMap({ [weak model] ipAddress -> Observable<String> in
                
                guard let model = model else {
                    return Observable.error(ApiManagerError.unknown)
                }
                return model.check(ipAddress: ipAddress)
            })
            .subscribe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] ipAddress in
                
                self?.router.route(to: .back, context)
                block?()
            }, onError: { [weak self] _ in
                                
                guard let self = self else { return }
                self.router.route(to: .ipInput, context, self.viewModel)
            }).disposed(by: disposeBag)
    }
}
