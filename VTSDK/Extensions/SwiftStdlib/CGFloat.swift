//
// Created by Thanh Tran Van on 7/13/18.
// Copyright (c) 2018 Sunflower. All rights reserved.
//

import Foundation

extension CGFloat {
    /// EZSE: Returns a random floating point number between 0.0 and 1.0, inclusive.
    public static func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }

    /// EZSE: Returns a random floating point number in the range min...max, inclusive.
    public static func random(within: Range<CGFloat>) -> CGFloat {
        return CGFloat.random() * (within.upperBound - within.lowerBound) + within.lowerBound
    }

    /// EZSE: Returns a random floating point number in the range min...max, inclusive.
    public static func random(within: ClosedRange<CGFloat>) -> CGFloat {
        return CGFloat.random() * (within.upperBound - within.lowerBound) + within.lowerBound
    }
}