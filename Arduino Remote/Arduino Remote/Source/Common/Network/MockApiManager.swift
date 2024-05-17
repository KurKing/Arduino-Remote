//
//  MockApiManager.swift
//  Arduino Remote
//
//  Created by Oleksii on 17.05.2024.
//

import Foundation
import RxSwift

/// For testing only! Should be removed in final version
final class MockApiManager: ApiManager {
    
    func configure(with ip: String) { }
    
    func healthCheck() -> Observable<Void> {
        Observable.just(())
    }
    
    func ledRequest(pin: Int, isOn: Bool) -> Observable<Void> {
        Observable.just(())
    }
}
