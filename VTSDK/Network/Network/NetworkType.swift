//
//  NetworkType.swift
//  TVTFramework
//
//  Created by Thanh Tran Van on 1/7/19.
//  Copyright © 2019 Thanh Tran Van. All rights reserved.
//

import Foundation
import RxSwift

public protocol NetworkType {
    func load<A>(resource: Resource<A>) -> Observable<A>
    func load<A>(resource: ArrayResource<A>) -> Observable<[A]>
}
