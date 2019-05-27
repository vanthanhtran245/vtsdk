//
//  Cacheable.swift
//  TVTFramework
//
//  Created by Thanh Tran Van on 1/7/19.
//  Copyright © 2019 Thanh Tran Van. All rights reserved.
//

import Foundation

public protocol Cacheable {
    var cacheKey: String { get }
}
