//
//  ApiManager.swift
//  Arduino Remote
//
//  Created by Oleksii on 28.04.2024.
//

import Foundation
import Alamofire
import RxSwift

enum ApiManagerError: Error {
    
    case noBaseURL
    case unknown
}

protocol ApiManager {
    
    func configure(with ip: String)
    
    func healthCheck() -> Observable<Void>
    func ledRequest(pin: Int, isOn: Bool) -> Observable<Void>
}

final class AlamofireApiManager: ApiManager {
        
    private var baseURL: String?
    
    func configure(with ip: String) {
        
        baseURL = "http://\(ip)"
    }
    
    func healthCheck() -> Observable<Void> {
        
        request(path: "/", timeoutInterval: 3).map({ (_: EmptyResponse) in () })
    }
    
    func ledRequest(pin: Int, isOn: Bool) -> Observable<Void> {
        
        request(path: "/led",
                method: .post,
                parameters: ["is_on": (isOn ? "true" : "false"),
                             "pin": pin])
        .map({ (_: EmptyResponse) in () })
    }
    
    private func request<T: Decodable>(path: String,
                                       method: HTTPMethod = .get,
                                       parameters: [String: Any]? = nil,
                                       timeoutInterval: Double = 5.0) -> Observable<T> {
        
        guard let baseURL = baseURL else {
            return Observable.error(ApiManagerError.noBaseURL)
        }
        
        return Observable.create({ observer -> Disposable in
            
            AF.request("\(baseURL)\(path)",
                       method: method,
                       parameters: parameters, requestModifier: {
                
                $0.timeoutInterval = timeoutInterval
            })
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseDecodable(of: T.self, completionHandler: { response in
                
                switch response.result {
                case let .success(data):
                    
                    observer.onNext(data)
                    observer.onCompleted()
                case let .failure(error):
                    
                    observer.onError(error)
                }
            })
            
            return Disposables.create()
        })
    }
    
    private struct EmptyResponse: Decodable {}
}
