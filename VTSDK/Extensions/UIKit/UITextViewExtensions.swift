//
//  UITextViewExtensions.swift
//  SunflowerExtension
//
//  Created by Thanh Tran Van on 9/28/18.
//  Copyright © 2018 SunflowerExtension
//


import UIKit

public extension UITextView {

	/// SunflowerExtension: Clear text.
	public func clear() {
		text = ""
		attributedText = NSAttributedString(string: "")
	}

	/// SunflowerExtension: Scroll to the bottom of text view
	public func scrollToBottom() {
        // swiftlint:disable next legacy_constructor
		let range = NSMakeRange((text as NSString).length - 1, 1)
        scrollRangeToVisible(range)
	}

	/// SunflowerExtension: Scroll to the top of text view
	public func scrollToTop() {
        // swiftlint:disable next legacy_constructor
		let range = NSMakeRange(0, 1)
		scrollRangeToVisible(range)
	}

    /// SunflowerExtension: Wrap to the content (Text / Attributed Text).
    public func wrapToContent() {
        contentInset = UIEdgeInsets.zero
        scrollIndicatorInsets = UIEdgeInsets.zero
        contentOffset = CGPoint.zero
        textContainerInset = UIEdgeInsets.zero
        textContainer.lineFragmentPadding = 0
        sizeToFit()
    }

}
