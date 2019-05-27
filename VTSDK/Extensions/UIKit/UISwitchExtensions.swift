//
//  UISwitchExtensions.swift
//  SunflowerExtension
//
//  Created by Thanh Tran Van on 08/12/2016.
//  Copyright © 2018 SunflowerExtension
//

#if canImport(UIKit)
import UIKit

#if os(iOS)
// MARK: - Methods
public extension UISwitch {

	/// SunflowerExtension: Toggle a UISwitch
	///
	/// - Parameter animated: set true to animate the change (default is true)
	public func toggle(animated: Bool = true) {
		setOn(!isOn, animated: animated)
	}

}
#endif

#endif
