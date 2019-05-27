//
//  NSAttributedStringExtensions.swift
//  SunflowerExtension
//
//  Created by Thanh Tran Van on 26/11/2016.
//  Copyright © 2018 SunflowerExtension
//

#if canImport(Foundation)
import Foundation

#if canImport(UIKit)
import UIKit
#endif

#if canImport(Cocoa)
import Cocoa
#endif

// MARK: - Properties
public extension NSAttributedString {

	#if os(iOS)
	/// SunflowerExtension: Bolded string.
	public var bolded: NSAttributedString {
		return applying(attributes: [.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)])
	}
	#endif

	/// SunflowerExtension: Underlined string.
	public var underlined: NSAttributedString {
		return applying(attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
	}

	#if os(iOS)
	/// SunflowerExtension: Italicized string.
	public var italicized: NSAttributedString {
		return applying(attributes: [.font: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)])
	}
	#endif

	/// SunflowerExtension: Struckthrough string.
	public var struckthrough: NSAttributedString {
		return applying(attributes: [.strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue as Int)])
	}

	/// SunflowerExtension: Dictionary of the attributes applied across the whole string
    public var attributes: [NSAttributedString.Key: Any] {
		return attributes(at: 0, effectiveRange: nil)
	}

}

// MARK: - Methods
public extension NSAttributedString {

	/// SunflowerExtension: Applies given attributes to the new instance of NSAttributedString initialized with self object
	///
	/// - Parameter attributes: Dictionary of attributes
	/// - Returns: NSAttributedString with applied attributes
    fileprivate func applying(attributes: [NSAttributedString.Key: Any]) -> NSAttributedString {
		let copy = NSMutableAttributedString(attributedString: self)
		let range = (string as NSString).range(of: string)
		copy.addAttributes(attributes, range: range)

		return copy
	}

	#if os(macOS)
	/// SunflowerExtension: Add color to NSAttributedString.
	///
	/// - Parameter color: text color.
	/// - Returns: a NSAttributedString colored with given color.
	public func colored(with color: NSColor) -> NSAttributedString {
	return applying(attributes: [.foregroundColor: color])
	}
	#else
	/// SunflowerExtension: Add color to NSAttributedString.
	///
	/// - Parameter color: text color.
	/// - Returns: a NSAttributedString colored with given color.
	public func colored(with color: UIColor) -> NSAttributedString {
		return applying(attributes: [.foregroundColor: color])
	}
	#endif

	/// SunflowerExtension: Apply attributes to substrings matching a regular expression
	///
	/// - Parameters:
	///   - attributes: Dictionary of attributes
	///   - pattern: a regular expression to target
	/// - Returns: An NSAttributedString with attributes applied to substrings matching the pattern
    public func applying(attributes: [Key: Any], toRangesMatching pattern: String) -> NSAttributedString {
		guard let pattern = try? NSRegularExpression(pattern: pattern, options: []) else { return self }

		let matches = pattern.matches(in: string, options: [], range: NSRange(0..<length))
		let result = NSMutableAttributedString(attributedString: self)

		for match in matches {
			result.addAttributes(attributes, range: match.range)
		}

		return result
	}

	/// SunflowerExtension: Apply attributes to occurrences of a given string
	///
	/// - Parameters:
	///   - attributes: Dictionary of attributes
	///   - target: a subsequence string for the attributes to be applied to
	/// - Returns: An NSAttributedString with attributes applied on the target string
	public func applying<T: StringProtocol>(attributes: [Key: Any], toOccurrencesOf target: T) -> NSAttributedString {
		let pattern = "\\Q\(target)\\E"

		return applying(attributes: attributes, toRangesMatching: pattern)
	}

}

// MARK: - Operators
public extension NSAttributedString {

	/// SunflowerExtension: Add a NSAttributedString to another NSAttributedString.
	///
	/// - Parameters:
	///   - lhs: NSAttributedString to add to.
	///   - rhs: NSAttributedString to add.
	public static func += (lhs: inout NSAttributedString, rhs: NSAttributedString) {
		let string = NSMutableAttributedString(attributedString: lhs)
		string.append(rhs)
		lhs = string
	}

	/// SunflowerExtension: Add a NSAttributedString to another NSAttributedString and return a new NSAttributedString instance.
	///
	/// - Parameters:
	///   - lhs: NSAttributedString to add.
	///   - rhs: NSAttributedString to add.
	/// - Returns: New instance with added NSAttributedString.
	public static func + (lhs: NSAttributedString, rhs: NSAttributedString) -> NSAttributedString {
		let string = NSMutableAttributedString(attributedString: lhs)
		string.append(rhs)
		return NSAttributedString(attributedString: string)
	}

	/// SunflowerExtension: Add a NSAttributedString to another NSAttributedString.
	///
	/// - Parameters:
	///   - lhs: NSAttributedString to add to.
	///   - rhs: String to add.
	public static func += (lhs: inout NSAttributedString, rhs: String) {
		lhs += NSAttributedString(string: rhs)
	}

	/// SunflowerExtension: Add a NSAttributedString to another NSAttributedString and return a new NSAttributedString instance.
	///
	/// - Parameters:
	///   - lhs: NSAttributedString to add.
	///   - rhs: String to add.
	/// - Returns: New instance with added NSAttributedString.
	public static func + (lhs: NSAttributedString, rhs: String) -> NSAttributedString {
		return lhs + NSAttributedString(string: rhs)
	}

}
#endif
