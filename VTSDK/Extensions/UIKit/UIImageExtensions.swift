//
//  UIImageExtensions.swift
//  SunflowerExtension
//
//  Created by Thanh Tran Van on 8/6/18.
//  Copyright © 2018 SunflowerExtension
//

#if canImport(UIKit)
import UIKit
import ImageIO

// MARK: - Properties
public extension UIImage {

	/// SunflowerExtension: Size in bytes of UIImage
	public var bytesSize: Int {
		return jpegData(compressionQuality: 1)?.count ?? 0
	}

	/// SunflowerExtension: Size in kilo bytes of UIImage
	public var kilobytesSize: Int {
		return bytesSize / 1024
	}

	/// SunflowerExtension: UIImage with .alwaysOriginal rendering mode.
	public var original: UIImage {
		return withRenderingMode(.alwaysOriginal)
	}

	/// SunflowerExtension: UIImage with .alwaysTemplate rendering mode.
	public var template: UIImage {
		return withRenderingMode(.alwaysTemplate)
	}

}

// MARK: - Methods
public extension UIImage {

	/// SunflowerExtension: Compressed UIImage from original UIImage.
	///
	/// - Parameter quality: The quality of the resulting JPEG image, expressed as a value from 0.0 to 1.0. The value 0.0 represents the maximum compression (or lowest quality) while the value 1.0 represents the least compression (or best quality), (default is 0.5).
	/// - Returns: optional UIImage (if applicable).
	public func compressed(quality: CGFloat = 0.5) -> UIImage? {
		guard let data = compressedData(quality: quality) else { return nil }
		return UIImage(data: data)
	}

	/// SunflowerExtension: Compressed UIImage data from original UIImage.
	///
	/// - Parameter quality: The quality of the resulting JPEG image, expressed as a value from 0.0 to 1.0. The value 0.0 represents the maximum compression (or lowest quality) while the value 1.0 represents the least compression (or best quality), (default is 0.5).
	/// - Returns: optional Data (if applicable).
	public func compressedData(quality: CGFloat = 0.5) -> Data? {
		return jpegData(compressionQuality:quality)
	}

	/// SunflowerExtension: UIImage Cropped to CGRect.
	///
	/// - Parameter rect: CGRect to crop UIImage to.
	/// - Returns: cropped UIImage
	public func cropped(to rect: CGRect) -> UIImage {
		guard rect.size.height < size.height && rect.size.height < size.height else { return self }
		guard let image: CGImage = cgImage?.cropping(to: rect) else { return self }
		return UIImage(cgImage: image)
	}

	/// SunflowerExtension: UIImage scaled to height with respect to aspect ratio.
	///
	/// - Parameters:
	///   - toHeight: new height.
    ///   - opaque: flag indicating whether the bitmap is opaque.
	///   - orientation: optional UIImage orientation (default is nil).
	/// - Returns: optional scaled UIImage (if applicable).
    public func scaled(toHeight: CGFloat, opaque: Bool = false, with orientation: Orientation? = nil) -> UIImage? {
		let scale = toHeight / size.height
		let newWidth = size.width * scale
        UIGraphicsBeginImageContextWithOptions(CGSize(width: newWidth, height: toHeight), opaque, scale)
		draw(in: CGRect(x: 0, y: 0, width: newWidth, height: toHeight))
		let newImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return newImage
	}

	/// SunflowerExtension: UIImage scaled to width with respect to aspect ratio.
	///
	/// - Parameters:
	///   - toWidth: new width.
    ///   - opaque: flag indicating whether the bitmap is opaque.
	///   - orientation: optional UIImage orientation (default is nil).
	/// - Returns: optional scaled UIImage (if applicable).
    public func scaled(toWidth: CGFloat, opaque: Bool = false, with orientation: Orientation? = nil) -> UIImage? {
		let scale = toWidth / size.width
		let newHeight = size.height * scale
        UIGraphicsBeginImageContextWithOptions(CGSize(width: toWidth, height: newHeight), opaque, scale)
		draw(in: CGRect(x: 0, y: 0, width: toWidth, height: newHeight))
		let newImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return newImage
	}

	/// SunflowerExtension: UIImage filled with color
	///
	/// - Parameter color: color to fill image with.
	/// - Returns: UIImage filled with given color.
	public func filled(withColor color: UIColor) -> UIImage {
		UIGraphicsBeginImageContextWithOptions(size, false, scale)
		color.setFill()
		guard let context = UIGraphicsGetCurrentContext() else { return self }

		context.translateBy(x: 0, y: size.height)
		context.scaleBy(x: 1.0, y: -1.0)
		context.setBlendMode(CGBlendMode.normal)

		let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
		guard let mask = self.cgImage else { return self }
		context.clip(to: rect, mask: mask)
		context.fill(rect)

		let newImage = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		return newImage
	}

	/// SunflowerExtension: UIImage tinted with color
	///
	/// - Parameters:
	///   - color: color to tint image with.
	///   - blendMode: how to blend the tint
	/// - Returns: UIImage tinted with given color.
	public func tint(_ color: UIColor, blendMode: CGBlendMode) -> UIImage {
		let drawRect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
		UIGraphicsBeginImageContextWithOptions(size, false, scale)
		let context = UIGraphicsGetCurrentContext()
		context!.clip(to: drawRect, mask: cgImage!)
		color.setFill()
		UIRectFill(drawRect)
		draw(in: drawRect, blendMode: blendMode, alpha: 1.0)
		let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return tintedImage!
	}

    /// SunflowerExtension: UIImage with rounded corners
    ///
    /// - Parameters:
    ///   - radius: corner radius (optional), resulting image will be round if unspecified
    /// - Returns: UIImage with all corners rounded
    public func withRoundedCorners(radius: CGFloat? = nil) -> UIImage? {
        let maxRadius = min(size.width, size.height) / 2
        let cornerRadius: CGFloat
        if let radius = radius, radius > 0 && radius <= maxRadius {
            cornerRadius = radius
        } else {
            cornerRadius = maxRadius
        }

        UIGraphicsBeginImageContextWithOptions(size, false, scale)

        let rect = CGRect(origin: .zero, size: size)
        UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
        draw(in: rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

}

// MARK: - Initializers
public extension UIImage {

	/// SunflowerExtension: Create UIImage from color and size.
	///
	/// - Parameters:
	///   - color: image fill color.
	///   - size: image size.
	public convenience init(color: UIColor, size: CGSize) {
		UIGraphicsBeginImageContextWithOptions(size, false, 1)

		defer {
			UIGraphicsEndImageContext()
		}

		color.setFill()
		UIRectFill(CGRect(origin: .zero, size: size))

		guard let aCgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
			self.init()
			return
		}

		self.init(cgImage: aCgImage)
	}

}
#endif

import ImageIO

extension UIImageView {
    
    public func loadGif(name: String) {
        DispatchQueue.global().async {
            let image = UIImage.gif(name: name)
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
    
    @available(iOS 9.0, *)
    public func loadGif(asset: String) {
        DispatchQueue.global().async {
            let image = UIImage.gif(asset: asset)
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
    
}

extension UIImage {
    
    public class func gif(data: Data) -> UIImage? {
        // Create source from data
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            print("Sunflower: Source for the image does not exist")
            return nil
        }
        
        return UIImage.animatedImageWithSource(source)
    }
    
    public class func gif(url: String) -> UIImage? {
        // Validate URL
        guard let bundleURL = URL(string: url) else {
            print("Sunflower: This image named \"\(url)\" does not exist")
            return nil
        }
        
        // Validate data
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("Sunflower: Cannot turn image named \"\(url)\" into NSData")
            return nil
        }
        
        return gif(data: imageData)
    }
    
    public class func gif(name: String) -> UIImage? {
        // Check for existance of gif
        guard let bundleURL = Bundle.main
            .url(forResource: name, withExtension: "gif") else {
                print("Sunflower: This image named \"\(name)\" does not exist")
                return nil
        }
        
        // Validate data
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("Sunflower: Cannot turn image named \"\(name)\" into NSData")
            return nil
        }
        
        return gif(data: imageData)
    }
    
    @available(iOS 9.0, *)
    public class func gif(asset: String) -> UIImage? {
        // Create source from assets catalog
        guard let dataAsset = NSDataAsset(name: asset) else {
            print("Sunflower: Cannot turn image named \"\(asset)\" into NSDataAsset")
            return nil
        }
        
        return gif(data: dataAsset.data)
    }
    
    internal class func delayForImageAtIndex(_ index: Int, source: CGImageSource!) -> Double {
        var delay = 0.1
        
        // Get dictionaries
        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let gifPropertiesPointer = UnsafeMutablePointer<UnsafeRawPointer?>.allocate(capacity: 0)
        if CFDictionaryGetValueIfPresent(cfProperties, Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque(), gifPropertiesPointer) == false {
            return delay
        }
        
        let gifProperties:CFDictionary = unsafeBitCast(gifPropertiesPointer.pointee, to: CFDictionary.self)
        
        // Get delay time
        var delayObject: AnyObject = unsafeBitCast(
            CFDictionaryGetValue(gifProperties,
                                 Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()),
            to: AnyObject.self)
        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties,
                                                             Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
        }
        
        delay = delayObject as? Double ?? 0
        
        if delay < 0.1 {
            delay = 0.1 // Make sure they're not too fast
        }
        
        return delay
    }
    
    internal class func gcdForPair(_ a: Int?, _ b: Int?) -> Int {
        var a = a
        var b = b
        // Check if one of them is nil
        if b == nil || a == nil {
            if b != nil {
                return b!
            } else if a != nil {
                return a!
            } else {
                return 0
            }
        }
        
        // Swap for modulo
        if a! < b! {
            let c = a
            a = b
            b = c
        }
        
        // Get greatest common divisor
        var rest: Int
        while true {
            rest = a! % b!
            
            if rest == 0 {
                return b! // Found it
            } else {
                a = b
                b = rest
            }
        }
    }
    
    internal class func gcdForArray(_ array: Array<Int>) -> Int {
        if array.isEmpty {
            return 1
        }
        
        var gcd = array[0]
        
        for val in array {
            gcd = UIImage.gcdForPair(val, gcd)
        }
        
        return gcd
    }
    
    internal class func animatedImageWithSource(_ source: CGImageSource) -> UIImage? {
        let count = CGImageSourceGetCount(source)
        var images = [CGImage]()
        var delays = [Int]()
        
        // Fill arrays
        for i in 0..<count {
            // Add image
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(image)
            }
            
            // At it's delay in cs
            let delaySeconds = UIImage.delayForImageAtIndex(Int(i),
                                                            source: source)
            delays.append(Int(delaySeconds * 1000.0)) // Seconds to ms
        }
        
        // Calculate full duration
        let duration: Int = {
            var sum = 0
            
            for val: Int in delays {
                sum += val
            }
            
            return sum
        }()
        
        // Get frames
        let gcd = gcdForArray(delays)
        var frames = [UIImage]()
        
        var frame: UIImage
        var frameCount: Int
        for i in 0..<count {
            frame = UIImage(cgImage: images[Int(i)])
            frameCount = Int(delays[Int(i)] / gcd)
            
            for _ in 0..<frameCount {
                frames.append(frame)
            }
        }
        
        // Heyhey
        let animation = UIImage.animatedImage(with: frames,
                                              duration: Double(duration) / 1000.0)
        
        return animation
    }
    
}
