//
//  UISegmentedControlExtensions.swift
//  SunflowerExtension
//
//  Created by Thanh Tran Van on 9/28/18.
//  Copyright © 2018 SunflowerExtension
//

#if canImport(UIKit)
import UIKit

#if !os(watchOS)
// MARK: - Properties
public extension UISegmentedControl {

	/// SunflowerExtension: Segments titles.
	public var segmentTitles: [String] {
		get {
			let range = 0..<numberOfSegments
			return range.compactMap { titleForSegment(at: $0) }
		}
		set {
			removeAllSegments()
			for (index, title) in newValue.enumerated() {
				insertSegment(withTitle: title, at: index, animated: false)
			}
		}
	}

	/// SunflowerExtension: Segments images.
	public var segmentImages: [UIImage] {
		get {
			let range = 0..<numberOfSegments
			return range.compactMap { imageForSegment(at: $0) }
		}
		set {
			removeAllSegments()
			for (index, image) in newValue.enumerated() {
				insertSegment(with: image, at: index, animated: false)
			}
		}
	}

}
#endif

#endif
