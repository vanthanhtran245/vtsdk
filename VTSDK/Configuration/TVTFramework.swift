//
//  TVTFramework.swift
//  TVTFramework
//
//  Created by Thanh Tran Van on 1/7/19.
//  Copyright © 2019 Thanh Tran Van. All rights reserved.
//

import Foundation
import SnapKit

public typealias snp = SnapKit.ConstraintViewDSL

public class VTSDK: NSObject {
    public static func setup(for baseURL: String) {
        Network.setup(baseURL: baseURL)
    }
    
    public static let network = Network()
}
