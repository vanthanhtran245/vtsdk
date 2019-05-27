//
//  Resource.swift
//  TVTFramework
//
//  Created by Thanh Tran Van on 1/7/19.
//  Copyright © 2019 Thanh Tran Van. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift


public protocol BaseResource: Cacheable, URLRequestConvertible {
    var url: String { get }
    var baseURL: String { get }
    var method: HttpMethod<Data> { get }
    var headers: HTTPHeaders? { get }
    var parameters: [String: Any]? { get }
    var alamofireMethod: Alamofire.HTTPMethod { get }
    var parametersOrPost: [String: Any]? { get }
    var encoding: ParameterEncoding { get }
}

extension BaseResource {
    public var alamofireMethod: Alamofire.HTTPMethod {
        switch method {
        case .get: return .get
        case .post, .postDict: return .post
        }
    }
    
    public var parametersOrPost: [String: Any]? {
        guard parameters == nil else { return parameters }
        switch method {
        case let .postDict(dict):
            return dict
        default:
            return nil
        }
    }
    
    public var encoding: ParameterEncoding {
        switch method {
        case .postDict: return JSONEncoding.default
        default: return URLEncoding.default
        }
    }
    
    public var baseURL: String {
        guard let baseURL = Network.baseURL, baseURL.isValidUrl else {
            fatalError("Missing BaseURL: Please ensure you have called Sunflower.setup(baseURL:) passing in your base URL request")
        }
        return baseURL
    }
    
    public var cacheKey: String {
        return "cache".appending(baseURL.appending(url))
    }
    
    public func asURLRequest() -> URLRequest {
        let originalRequest = try! URLRequest(url: baseURL.appending(url), method: alamofireMethod, headers: headers)
        let encodedRequest = try! encoding.encode(originalRequest, with: parametersOrPost)
        return encodedRequest
    }
}

public struct Resource<A: Codable>: BaseResource {
    public var url: String
    
    public var method: HttpMethod<Data>
    
    public var headers: HTTPHeaders?
    
    public var parameters: [String : Any]?
    
    let parse: (Data) -> Observable<A>

}

public extension Resource {
    init(path: String, parameters: [String: Any]? = nil, method: HttpMethod<Any> = .get, headers: HTTPHeaders? = nil) {
        self.url = path
        self.method = method.map { json in
            try! JSONSerialization.data(withJSONObject: json, options: [])
        }
        self.parse = { data in
            return Observable.create { observer in
                guard let result = try? JSONDecoder().decode(A.self, from: data) else {
                    observer.onError(CustomError(value: "Can't map response."))
                    return Disposables.create()
                }
                observer.onNext(result)
                return Disposables.create()
            }
        }
        self.parameters = parameters
        self.headers = headers
    }
}

public struct ArrayResource<A: Codable>: BaseResource {
    public var url: String
    
    public var method: HttpMethod<Data>
    
    public var headers: HTTPHeaders?
    
    public var parameters: [String : Any]?
    
    let pasrseArray: (Data) -> Observable<[A]>
    
    public init(path: String, parameters: [String: Any]? = nil, method: HttpMethod<Any> = .get, headers: HTTPHeaders? = nil) {
        self.url = path
        self.method = method.map { json in
            try! JSONSerialization.data(withJSONObject: json, options: [])
        }
        self.pasrseArray = { data in
            return Observable.create { observer in
                guard let result = try? JSONDecoder().decode([A].self, from: data) else {
                    observer.onError(CustomError(value: "Can't map response."))
                    return Disposables.create()
                }
                observer.onNext(result)
                return Disposables.create()
            }
        }
        self.parameters = parameters
        self.headers = headers
    }
}

struct CustomError: LocalizedError {
    let value: String
    var localizedDescription: String {
        return value
    }
}
