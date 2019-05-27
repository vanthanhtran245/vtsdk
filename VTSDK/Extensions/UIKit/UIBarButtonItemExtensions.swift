//
//  UIBarButtonItemExtensions.swift
//  SunflowerExtension
//
//  Created by Thanh Tran Van on 08/12/2016.
//  Copyright © 2018 SunflowerExtension
//


import UIKit

public extension UIBarButtonItem {

	/// SunflowerExtension: Add Target to UIBarButtonItem
	///
	/// - Parameters:
	///   - target: target.
	///   - action: selector to run when button is tapped.
	public func addTargetForAction(_ target: AnyObject, action: Selector) {
		self.target = target
		self.action = action
	}

}
