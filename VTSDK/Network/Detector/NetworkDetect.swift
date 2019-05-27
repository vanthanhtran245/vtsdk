//
//  NetworkDetect.swift
//  TVTFramework
//
//  Created by Thanh Tran Van on 1/7/19.
//  Copyright © 2019 Thanh Tran Van. All rights reserved.
//

import Foundation

public class NetworkDetect {
    private (set) var reachability: Reachability?
    public static let shared = NetworkDetect()
    public var connectionStatus: ((Connection) -> ())?
    private init() {}
    private func setupReachability() {
        reachability = Reachability()
        detectConnection(reachability: reachability)
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(_:)), name: .reachabilityChanged, object: reachability)
    }
    
    private func detectConnection(reachability: Reachability?) {
        guard let reachability = reachability else { return }
        connectionStatus?(reachability.connection)
    }
    
    private func startNotifier() {
        do {
            try reachability?.startNotifier()
        } catch {
            return
        }
    }
    
    private func stopNotifier() {
        reachability?.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: nil)
        reachability = nil
    }
    
    @objc func reachabilityChanged(_ note: Notification) {
        let reachability = note.object as! Reachability
        detectConnection(reachability: reachability)
    }
    
    public func startListening(networkCallBack: ((Connection) -> ())? = nil) {
        connectionStatus = networkCallBack
        stopNotifier()
        setupReachability()
        startNotifier()
    }
}
