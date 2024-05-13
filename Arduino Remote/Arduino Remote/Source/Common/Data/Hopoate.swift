//
//  Hopoate.swift
//  Arduino Remote
//
//  Created by Oleksii on 12.05.2024.
//

import Foundation
import Hopoate

public func resolve<T>(_ serviceType: T.Type) -> T {
    DependencyContainer.shared.resolve(serviceType)
}

public func register<T>(_ instance: T, for service: T.Type) {
    DependencyContainer.shared.register(instance, for: service)
}
