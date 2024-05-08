//
//  IPInputViewModel.swift
//  Arduino Remote
//
//  Created by Oleksii on 28.04.2024.
//

import Foundation
import RxSwift
import RxRelay

protocol IPInputViewModelProtocol {
    
    var isCompleteButtonEnabled: BehaviorRelay<Bool> { get }
    var ipAddress: BehaviorRelay<String> { get }
    
    func complete()
}

class IPInputViewModel: IPInputViewModelProtocol {
    
    let isCompleteButtonEnabled = BehaviorRelay<Bool>(value: false)
    let ipAddress = BehaviorRelay<String>(value: "192.168.")
    
    private let disposeBag = DisposeBag()
    
    init() {
        
        ipAddress.map({ $0.isIpAddress })
            .subscribe(onNext: { [weak self] isValid in
                self?.isCompleteButtonEnabled.accept(isValid)
            })
            .disposed(by: disposeBag)
    }
    
    func complete() {
        
        
    }
}
