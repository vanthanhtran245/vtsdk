//
//  Other.swift
//  TVTFramework
//
//  Created by Thanh Tran Van on 1/7/19.
//  Copyright © 2019 Thanh Tran Van. All rights reserved.
//

import Foundation
import RxSwift

public func ignoreNil<A>(x: A?) -> Observable<A> {
    return x.map { Observable.just($0) } ?? Observable.empty()
}
