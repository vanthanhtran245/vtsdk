//
//  UIGestureRecognizerExtensions.swift
//  SunflowerExtension
//
//  Created by Morgan Dock on 4/21/18.
//  Copyright © 2018 SunflowerExtension
//

#if canImport(UIKit)
import UIKit

#if !os(watchOS)
// MARK: - Methods
public extension UIGestureRecognizer {

    /// SunflowerExtension: Remove Gesture Recognizer from its view.
    public func removeFromView() {
        self.view?.removeGestureRecognizer(self)
    }
}
#endif

#endif
