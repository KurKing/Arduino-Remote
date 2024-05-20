//
//  ActionModeModel.swift
//  Arduino Remote
//
//  Created by Oleksii on 20.05.2024.
//

import Foundation
import RxSwift

protocol ActionModeModelProtocol {
    
    func sendLedRequest(pin: Int, isOn: Bool)
}

class ActionModeModel: ActionModeModelProtocol {
    
    private var apiManager: ApiManager { resolve(ApiManager.self) }
    private let disposeBag = DisposeBag()
    
    func sendLedRequest(pin: Int, isOn: Bool) {
        
        apiManager.ledRequest(pin: pin, isOn: isOn)
            .subscribe(onNext: { _ in
                
                print("[ACTION MODE] Led toggled")
            }, onError: { error in
                
                print("[ACTION MODE] \(error.localizedDescription)")
            }).disposed(by: disposeBag)
    }
}
