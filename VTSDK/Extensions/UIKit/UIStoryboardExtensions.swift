//
//  UIStoryboardExtensions.swift
//  SunflowerExtension
//
//  Created by Steven on 2/6/17.
//  Copyright © 2017 SunflowerExtension
//

import UIKit

public extension UIStoryboard {

    /// SunflowerExtension: Get main storyboard for application
    public static var main: UIStoryboard? {
        let bundle = Bundle.main
        guard let name = bundle.object(forInfoDictionaryKey: "UIMainStoryboardFile") as? String else { return nil }
        return UIStoryboard(name: name, bundle: bundle)
    }

	/// SunflowerExtension: Instantiate a UIViewController using its class name
	///
	/// - Parameter name: UIViewController type
	/// - Returns: The view controller corresponding to specified class name
	public func instantiateViewController<T: UIViewController>(withClass name: T.Type) -> T? {
		return instantiateViewController(withIdentifier: String(describing: name)) as? T
	}

}
