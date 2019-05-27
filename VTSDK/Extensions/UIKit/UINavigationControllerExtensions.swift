//
//  UINavigationControllerExtensions.swift
//  SunflowerExtension
//
//  Created by Thanh Tran Van on 8/6/18.
//  Copyright © 2018 SunflowerExtension
//

#if canImport(UIKit)
import UIKit

#if !os(watchOS)
// MARK: - Methods
public extension UINavigationController {

	/// SunflowerExtension: Pop ViewController with completion handler.
	///
	/// - Parameters:
	///   - animated: Set this value to true to animate the transition (default is true).
	///   - completion: optional completion handler (default is nil).
	public func popViewController(animated: Bool = true, _ completion: (() -> Void)? = nil) {
		// https://github.com/cotkjaer/UserInterface/blob/master/UserInterface/UIViewController.swift
		CATransaction.begin()
		CATransaction.setCompletionBlock(completion)
		popViewController(animated: animated)
		CATransaction.commit()
	}

	/// SunflowerExtension: Push ViewController with completion handler.
	///
	/// - Parameters:
	///   - viewController: viewController to push.
	///   - completion: optional completion handler (default is nil).
	public func pushViewController(_ viewController: UIViewController, completion: (() -> Void)? = nil) {
		// https://github.com/cotkjaer/UserInterface/blob/master/UserInterface/UIViewController.swift
		CATransaction.begin()
		CATransaction.setCompletionBlock(completion)
		pushViewController(viewController, animated: true)
		CATransaction.commit()
	}

	/// SunflowerExtension: Make navigation controller's navigation bar transparent.
	///
	/// - Parameter tint: tint color (default is .white).
	public func makeTransparent(withTint tint: UIColor = .white) {
		navigationBar.setBackgroundImage(UIImage(), for: .default)
		navigationBar.shadowImage = UIImage()
		navigationBar.isTranslucent = true
		navigationBar.tintColor = tint
		navigationBar.titleTextAttributes = [.foregroundColor: tint]
	}

}
#endif

#endif
