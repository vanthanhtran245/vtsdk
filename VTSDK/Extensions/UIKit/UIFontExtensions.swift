//
//  UIFontExtensions.swift
//  SunflowerExtension 
//
//  Created by Benjamin Meyer on 9/18/17.
//  Copyright © 2017 SunflowerExtension
//

#if canImport(UIKit)
import UIKit

// MARK: - Properties
public extension UIFont {

    /// SunflowerExtension: Font as bold font
    public var bold: UIFont {
        return UIFont(descriptor: fontDescriptor.withSymbolicTraits(.traitBold)!, size: 0)
    }

    /// SunflowerExtension: Font as italic font
    public var italic: UIFont {
        return UIFont(descriptor: fontDescriptor.withSymbolicTraits(.traitItalic)!, size: 0)
    }

	/// SunflowerExtension: Font as monospaced font
	///
	///     UIFont.preferredFont(forTextStyle: .body).monospaced
	///
	public var monospaced: UIFont {
		let settings = [[UIFontDescriptor.FeatureKey.featureIdentifier: kNumberSpacingType, UIFontDescriptor.FeatureKey.typeIdentifier: kMonospacedNumbersSelector]]

		let attributes = [UIFontDescriptor.AttributeName.featureSettings: settings]
		let newDescriptor = fontDescriptor.addingAttributes(attributes)
		return UIFont(descriptor: newDescriptor, size: 0)
	}

}
#endif
