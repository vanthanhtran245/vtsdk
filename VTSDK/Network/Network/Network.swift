//
//  Network.swift
//  TVTFramework
//
//  Created by Thanh Tran Van on 1/7/19.
//  Copyright © 2019 Thanh Tran Van. All rights reserved.
//

import Foundation
import RxAlamofire
import RxSwift

public enum Result<T> {
    case success(T)
    case failure(Error)
}

public struct Network: NetworkType {
    public static var baseURL: String?
    
    public func load<A>(resource: ArrayResource<A>) -> Observable<[A]> where A: Codable {
        return RxAlamofire
            .request(resource.asURLRequest())
            .responseJSON()
            .map { $0.data }
            .filter { $0 != nil }
            .map { $0! }
            .flatMap(resource.pasrseArray)
    }
    
    public func load<A>(resource: Resource<A>) -> Observable<A> where A : Codable {
       return RxAlamofire
            .request(resource.asURLRequest())
            .responseJSON()
            .map { $0.data }
            .filter { $0 != nil }
            .map { $0! }
            .flatMap(resource.parse)
    }
}

public extension Network {
    public static func setup(baseURL: String) {
       Network.baseURL = baseURL
    }
}
