//
//  FloatingPointExtensions.swift
//  SunflowerExtension
//
//  Created by Thanh Tran Van on 7/23/17.
//  Copyright © 2017 SunflowerExtension
//

// MARK: - Properties
public extension FloatingPoint {

	/// SunflowerExtension: Absolute value of integer number.
	public var abs: Self {
		return Swift.abs(self)
	}

	/// SunflowerExtension: Check if integer is positive.
	public var isPositive: Bool {
		return self > 0
	}

	/// SunflowerExtension: Check if integer is negative.
	public var isNegative: Bool {
		return self < 0
	}

	/// SunflowerExtension: Ceil of number.
	public var ceil: Self {
		return Foundation.ceil(self)
	}

	/// SunflowerExtension: Radian value of degree input.
	public var degreesToRadians: Self {
		return Self.pi * self / Self(180)
	}

	/// SunflowerExtension: Floor of number.
	public var floor: Self {
		return Foundation.floor(self)
	}

	/// SunflowerExtension: Degree value of radian input.
	public var radiansToDegrees: Self {
		return self * Self(180) / Self.pi
	}

}

// MARK: - Methods
public extension FloatingPoint {

	/// SunflowerExtension: Random number between two number.
	///
	/// - Parameters:
	///   - min: minimum number to start random from.
	///   - max: maximum number random number end before.
	/// - Returns: random number between two numbers.
	public static func random(between min: Self, and max: Self) -> Self {
		let aMin = Self.minimum(min, max)
		let aMax = Self.maximum(min, max)
		let delta = aMax - aMin
		return Self(arc4random()) / Self(UInt64(UINT32_MAX)) * delta + aMin
	}

	/// SunflowerExtension: Random number in a closed interval range.
	///
	/// - Parameter range: closed interval range.
	/// - Returns: random number in the given closed range.
	public static func random(inRange range: ClosedRange<Self>) -> Self {
		let delta = range.upperBound - range.lowerBound
		return Self(arc4random()) / Self(UInt64(UINT32_MAX)) * delta + range.lowerBound
	}

}

// MARK: - Initializers
public extension FloatingPoint {

	/// SunflowerExtension: Created a random number between two numbers.
	///
	/// - Parameters:
	///   - min: minimum number to start random from.
	///   - max: maximum number random number end before.
	public init(randomBetween min: Self, and max: Self) {
		let aMin = Self.minimum(min, max)
		let aMax = Self.maximum(min, max)
		let delta = aMax - aMin
		self = Self(arc4random()) / Self(UInt64(UINT32_MAX)) * delta + aMin
	}

	/// SunflowerExtension: Create a random number in a closed interval range.
	///
	/// - Parameter range: closed interval range.
	public init(randomInRange range: ClosedRange<Self>) {
		let delta = range.upperBound - range.lowerBound
		self = Self(arc4random()) / Self(UInt64(UINT32_MAX)) * delta + range.lowerBound
	}

}

// MARK: - Operators

// swiftlint:disable next identifier_name
infix operator ±
/// SunflowerExtension: Tuple of plus-minus operation.
///
/// - Parameters:
///   - lhs: number
///   - rhs: number
/// - Returns: tuple of plus-minus operation ( 2.5 ± 1.5 -> (4, 1)).
public func ±<T: FloatingPoint> (lhs: T, rhs: T) -> (T, T) {
	// http://nshipster.com/swift-operators/
	return (lhs + rhs, lhs - rhs)
}

// swiftlint:disable next identifier_name
prefix operator ±
/// SunflowerExtension: Tuple of plus-minus operation.
///
/// - Parameter int: number
/// - Returns: tuple of plus-minus operation (± 2.5 -> (2.5, -2.5)).
public prefix func ±<T: FloatingPoint> (number: T) -> (T, T) {
	// http://nshipster.com/swift-operators/
	return 0 ± number
}