//
//  CacheNetwork.swift
//  TVTFramework
//
//  Created by Thanh Tran Van on 1/7/19.
//  Copyright © 2019 Thanh Tran Van. All rights reserved.
//

import Foundation
import RxSwift

public struct CacheNetwork: NetworkType {
    private let networkService: NetworkType
    private let cache = Cache()
    private let disposeBag = DisposeBag()

    init(_ service: NetworkType) {
        networkService = service
    }
    
    public func load<A>(resource: Resource<A>) -> Observable<A> where A : Encodable {
        return Observable.create { observer in
            if let cached = self.cache.loadData(for: resource) {
                observer.onNext(cached)
            }
            self.networkService
                .load(resource: resource)
                .subscribe(observer)
                .disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
    public func load<A>(resource: ArrayResource<A>) -> Observable<[A]> where A : Codable {
        return Observable.create { observer in
            if let cached = self.cache.loadArrayData(for: resource) {
                observer.onNext(cached)
            }
            self.networkService
                .load(resource: resource)
                .subscribe(observer)
                .disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
}
