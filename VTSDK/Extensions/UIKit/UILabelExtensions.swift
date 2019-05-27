//
//  UILabelExtensions.swift
//  SunflowerExtension
//
//  Created by Thanh Tran Van on 9/23/18.
//  Copyright © 2018 SunflowerExtension
//

#if canImport(UIKit)
import UIKit

#if !os(watchOS)
// MARK: - Methods
public extension UILabel {

	/// SunflowerExtension: Initialize a UILabel with text
	public convenience init(text: String?) {
		self.init()
		self.text = text
	}

	/// SunflowerExtension: Required height for a label
	public var requiredHeight: CGFloat {
		let label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: CGFloat.greatestFiniteMagnitude))
		label.numberOfLines = 0
		label.lineBreakMode = NSLineBreakMode.byWordWrapping
		label.font = font
		label.text = text
		label.attributedText = attributedText
		label.sizeToFit()
		return label.frame.height
	}

}
#endif

#endif
