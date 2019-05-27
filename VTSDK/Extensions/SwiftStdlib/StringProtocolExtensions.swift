//
//  StringProtocolExtensions.swift
//  SunflowerExtension
//
//  Created by Max Härtwig on 11/26/17.
//  Copyright © 2017 SunflowerExtension
//

import Foundation

public extension StringProtocol where Index == String.Index {

    /// SunflowerExtension: The longest common suffix.
    ///
    ///        "Hello world!".commonSuffix(with: "It's cold!") = "ld!"
    ///
    /// - Parameters:
    ///     - Parameter aString: The string with which to compare the receiver.
    ///     - Parameter options: Options for the comparison.
    /// - Returns: The longest common suffix of the receiver and the given String
    public func commonSuffix<T: StringProtocol>(with aString: T, options: String.CompareOptions = []) -> String {
        let reversedSuffix = String(reversed()).commonPrefix(with: String(aString.reversed()), options: options)
        return String(reversedSuffix.reversed())
    }

}
