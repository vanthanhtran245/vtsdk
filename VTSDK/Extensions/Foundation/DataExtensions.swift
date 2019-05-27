//
//  DataExtensions.swift
//  SunflowerExtension
//
//  Created by Thanh Tran Van on 07/12/2016.
//  Copyright © 2018 SunflowerExtension
//

#if canImport(Foundation)
import Foundation

// MARK: - Properties
public extension Data {

	/// SunflowerExtension: Return data as an array of bytes.
	public var bytes: [UInt8] {
		// http://stackoverflow.com/questions/38097710/swift-3-changes-for-getbytes-method
		return [UInt8](self)
	}

}

// MARK: - Methods
public extension Data {

	/// SunflowerExtension: String by encoding Data using the given encoding (if applicable).
	///
	/// - Parameter encoding: encoding.
	/// - Returns: String by encoding Data using the given encoding (if applicable).
	public func string(encoding: String.Encoding) -> String? {
		return String(data: self, encoding: encoding)
	}

}
#endif
