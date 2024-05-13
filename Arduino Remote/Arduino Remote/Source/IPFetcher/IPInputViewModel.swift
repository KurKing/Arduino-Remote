//
//  IPInputViewModel.swift
//  Arduino Remote
//
//  Created by Oleksii on 28.04.2024.
//

import Foundation
import RxSwift
import RxRelay

protocol IPInputViewModelProtocol: AnyObject {
    
    var model: IPInputModelProtocol { get }
    var onComplete: ((String) -> ())? { get set }
    
    var isCompleteButtonEnabled: BehaviorRelay<Bool> { get }
    var ipAddress: BehaviorRelay<String> { get }
    var isLoading: BehaviorRelay<Bool> { get }
    var reloadEvent: PublishSubject<Void> { get }
    
    func complete()
}

class IPInputViewModel: IPInputViewModelProtocol {
    
    let isCompleteButtonEnabled = BehaviorRelay<Bool>(value: false)
    let ipAddress = BehaviorRelay<String>(value: "192.168.")
    let isLoading = BehaviorRelay<Bool>(value: false)
    let reloadEvent = PublishSubject<Void>()
    
    var onComplete: ((String) -> ())?
    
    let model: IPInputModelProtocol
    private let disposeBag = DisposeBag()
    
    init(model: IPInputModelProtocol = IPInputModel()) {
        
        self.model = model
        
        ipAddress.map({ $0.isIpAddress })
            .subscribe(onNext: { [weak self] isValid in
                self?.isCompleteButtonEnabled.accept(isValid)
            }).disposed(by: disposeBag)
    }
    
    func complete() {
        
        isLoading.accept(true)
        
        model.check(ipAddress: ipAddress.value)
            .subscribe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] validIpAddress in
                
                self?.model.save(ipAddress: validIpAddress)
                self?.isLoading.accept(false)
                
                self?.onComplete?(validIpAddress)
            }, onError: { [weak self] _ in
                
                self?.isLoading.accept(false)
                self?.reloadEvent.onNext(())
            }).disposed(by: self.disposeBag)
    }
}
