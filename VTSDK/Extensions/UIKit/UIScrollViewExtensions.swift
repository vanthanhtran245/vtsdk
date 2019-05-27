//
//  UIScrollViewExtensions.swift
//  SunflowerExtension
//
//  Created by camila oliveira on 22/04/18.
//  Copyright © 2018 SunflowerExtension
//

import UIKit


// MARK: - Methods
public extension UIScrollView {
    //Original Source: https://gist.github.com/thestoics/1204051
    /// SunflowerExtension: Takes a snapshot of an entire ScrollView
    ///
    ///    AnySubclassOfUIScroolView().snapshot
    ///    UITableView().snapshot
    ///
    /// - Returns: Snapshot as UIimage for rendered ScrollView
    public var snapshot: UIImage? {
        UIGraphicsBeginImageContextWithOptions(contentSize, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        let previousFrame = frame
        frame = CGRect(origin: frame.origin, size: contentSize)
        layer.render(in: context)
        frame = previousFrame
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
