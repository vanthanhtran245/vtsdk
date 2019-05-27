//
//  UINavigationItemExtensions.swift
//  SunflowerExtension
//
//  Created by Thanh Tran Van on 9/28/18.
//  Copyright © 2018 SunflowerExtension
//

import UIKit

public extension UINavigationItem {

	/// SunflowerExtension: Replace title label with an image in navigation item.
	///
	/// - Parameter image: UIImage to replace title with.
	public func replaceTitle(with image: UIImage) {
		let logoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
		logoImageView.contentMode = .scaleAspectFit
		logoImageView.image = image
		titleView = logoImageView
	}

}
