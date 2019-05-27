//
//  Method.swift
//  TVTFramework
//
//  Created by Thanh Tran Van on 1/7/19.
//  Copyright © 2019 Thanh Tran Van. All rights reserved.
//

import Foundation

public enum HttpMethod<Body> {
    case get
    case post(Body)
    case postDict([String: Any])
}

extension HttpMethod {
    var method: String {
        switch self {
        case .get: return "GET"
        case .post, .postDict: return "POST"
        }
    }
    
    func map<B>(f: (Body) -> B) -> HttpMethod<B> {
        switch self {
        case .get: return .get
        case let .post(body):
            return .post(f(body))
        case let .postDict(dict): return .postDict(dict)
        }
    }
}
