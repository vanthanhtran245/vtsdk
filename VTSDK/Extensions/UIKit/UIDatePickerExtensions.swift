//
//  UIDatePickerExtensions.swift
//  SunflowerExtension
//
//  Created by Thanh Tran Van on 12/9/17.
//  Copyright © 2017 SunflowerExtension
//

#if canImport(UIKit)
import UIKit

#if os(iOS)
// MARK: - Properties
public extension UIDatePicker {

	/// SunflowerExtension: Text color of UIDatePicker.
	public var textColor: UIColor? {
		set {
			setValue(newValue, forKeyPath: "textColor")
		}
		get {
			return value(forKeyPath: "textColor") as? UIColor
		}
	}

}
#endif

#endif
