//
//  UISearchBarExtensions.swift
//  SunflowerExtension
//
//  Created by Thanh Tran Van on 8/23/18.
//  Copyright © 2018 SunflowerExtension
//

import UIKit

public extension UISearchBar {

	/// SunflowerExtension: Text field inside search bar (if applicable).
	public var textField: UITextField? {
		let subViews = subviews.flatMap { $0.subviews }
		guard let textField = (subViews.filter { $0 is UITextField }).first as? UITextField else {
			return nil
		}
		return textField
	}

	/// SunflowerExtension: Text with no spaces or new lines in beginning and end (if applicable).
	public var trimmedText: String? {
		return text?.trimmingCharacters(in: .whitespacesAndNewlines)
	}

}

// MARK: - Methods
public extension UISearchBar {

	/// SunflowerExtension: Clear text.
	public func clear() {
		text = ""
	}

}
