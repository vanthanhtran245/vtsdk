//
//  UIButtonExtensions.swift
//  SunflowerExtension
//
//  Created by Thanh Tran Van on 8/22/18.
//  Copyright © 2018 SunflowerExtension
//

#if canImport(UIKit)
import UIKit

#if !os(watchOS)
// MARK: - Properties
public extension UIButton {

	/// SunflowerExtension: Image of disabled state for button; also inspectable from Storyboard.
	@IBInspectable public var imageForDisabled: UIImage? {
		get {
			return image(for: .disabled)
		}
		set {
			setImage(newValue, for: .disabled)
		}
	}

	/// SunflowerExtension: Image of highlighted state for button; also inspectable from Storyboard.
	@IBInspectable public var imageForHighlighted: UIImage? {
		get {
			return image(for: .highlighted)
		}
		set {
			setImage(newValue, for: .highlighted)
		}
	}

	/// SunflowerExtension: Image of normal state for button; also inspectable from Storyboard.
	@IBInspectable public var imageForNormal: UIImage? {
		get {
			return image(for: .normal)
		}
		set {
			setImage(newValue, for: .normal)
		}
	}

	/// SunflowerExtension: Image of selected state for button; also inspectable from Storyboard.
	@IBInspectable public var imageForSelected: UIImage? {
		get {
			return image(for: .selected)
		}
		set {
			setImage(newValue, for: .selected)
		}
	}

	/// SunflowerExtension: Title color of disabled state for button; also inspectable from Storyboard.
	@IBInspectable public var titleColorForDisabled: UIColor? {
		get {
			return titleColor(for: .disabled)
		}
		set {
			setTitleColor(newValue, for: .disabled)
		}
	}

	/// SunflowerExtension: Title color of highlighted state for button; also inspectable from Storyboard.
	@IBInspectable public var titleColorForHighlighted: UIColor? {
		get {
			return titleColor(for: .highlighted)
		}
		set {
			setTitleColor(newValue, for: .highlighted)
		}
	}

	/// SunflowerExtension: Title color of normal state for button; also inspectable from Storyboard.
	@IBInspectable public var titleColorForNormal: UIColor? {
		get {
			return titleColor(for: .normal)
		}
		set {
			setTitleColor(newValue, for: .normal)
		}
	}

	/// SunflowerExtension: Title color of selected state for button; also inspectable from Storyboard.
	@IBInspectable public var titleColorForSelected: UIColor? {
		get {
			return titleColor(for: .selected)
		}
		set {
			setTitleColor(newValue, for: .selected)
		}
	}

	/// SunflowerExtension: Title of disabled state for button; also inspectable from Storyboard.
	@IBInspectable public var titleForDisabled: String? {
		get {
			return title(for: .disabled)
		}
		set {
			setTitle(newValue, for: .disabled)
		}
	}

	/// SunflowerExtension: Title of highlighted state for button; also inspectable from Storyboard.
	@IBInspectable public var titleForHighlighted: String? {
		get {
			return title(for: .highlighted)
		}
		set {
			setTitle(newValue, for: .highlighted)
		}
	}

	/// SunflowerExtension: Title of normal state for button; also inspectable from Storyboard.
	@IBInspectable public var titleForNormal: String? {
		get {
			return title(for: .normal)
		}
		set {
			setTitle(newValue, for: .normal)
		}
	}

	/// SunflowerExtension: Title of selected state for button; also inspectable from Storyboard.
	@IBInspectable public var titleForSelected: String? {
		get {
			return title(for: .selected)
		}
		set {
			setTitle(newValue, for: .selected)
		}
	}

}

// MARK: - Methods
public extension UIButton {

	private var states: [State] {
		return [.normal, .selected, .highlighted, .disabled]
	}

	/// SunflowerExtension: Set image for all states.
	///
	/// - Parameter image: UIImage.
	public func setImageForAllStates(_ image: UIImage) {
		states.forEach { self.setImage(image, for: $0) }
	}

	/// SunflowerExtension: Set title color for all states.
	///
	/// - Parameter color: UIColor.
	public func setTitleColorForAllStates(_ color: UIColor) {
		states.forEach { self.setTitleColor(color, for: $0) }
	}

	/// SunflowerExtension: Set title for all states.
	///
	/// - Parameter title: title string.
	public func setTitleForAllStates(_ title: String) {
		states.forEach { self.setTitle(title, for: $0) }
	}

    /// SunflowerExtension: Center align title text and image on UIButton
    ///
    /// - Parameter spacing: spacing between UIButton title text and UIButton Image.
    public func centerTextAndImage(spacing: CGFloat) {
        let insetAmount = spacing / 2
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
    }

}
#endif

#endif
