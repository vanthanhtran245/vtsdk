//
//  OptionalExtensions.swift
//  SunflowerExtension
//
//  Created by Thanh Tran Van on 3/3/17.
//  Copyright © 2017 SunflowerExtension
//

// MARK: - Methods
public extension Optional {

    /// SunflowerExtension: Get self of default value (if self is nil).
    ///
    ///		let foo: String? = nil
    ///		print(foo.unwrapped(or: "bar")) -> "bar"
    ///
    ///		let bar: String? = "bar"
    ///		print(bar.unwrapped(or: "foo")) -> "bar"
    ///
    /// - Parameter defaultValue: default value to return if self is nil.
    /// - Returns: self if not nil or default value if nil.
    public func unwrapped(or defaultValue: Wrapped) -> Wrapped {
        // http://www.russbishop.net/improving-optionals
        return self ?? defaultValue
    }

    /// SunflowerExtension: Gets the wrapped value of an optional. If the optional is `nil`, throw a custom error.
    ///
    ///        let foo: String? = nil
    ///        try print(foo.unwrapped(or: MyError.notFound)) -> error: MyError.notFound
    ///
    ///        let bar: String? = "bar"
    ///        try print(bar.unwrapped(or: MyError.notFound)) -> "bar"
    ///
    /// - Parameter error: The error to throw if the optional is `nil`.
    /// - Returns: The value wrapped by the optional.
    /// - Throws: The error passed in.
    public func unwrapped(or error: Error) throws -> Wrapped {
        guard let wrapped = self else { throw error }
        return wrapped
    }

    /// SunflowerExtension: Runs a block to Wrapped if not nil
    ///
    ///		let foo: String? = nil
    ///		foo.run { unwrappedFoo in
    ///			// block will never run sice foo is nill
    ///			print(unwrappedFoo)
    ///		}
    ///
    ///		let bar: String? = "bar"
    ///		bar.run { unwrappedBar in
    ///			// block will run sice bar is not nill
    ///			print(unwrappedBar) -> "bar"
    ///		}
    ///
    /// - Parameter block: a block to run if self is not nil.
    public func run(_ block: (Wrapped) -> Void) {
        // http://www.russbishop.net/improving-optionals
        _ = self.map(block)
    }

    /// SunflowerExtension: Assign an optional value to a variable only if the value is not nil.
    ///
    ///     let someParameter: String? = nil
    ///     let parameters = [String:Any]() //Some parameters to be attached to a GET request
    ///     parameters[someKey] ??= someParameter //It won't be added to the parameters dict
    ///
    /// - Parameters:
    ///   - lhs: Any?
    ///   - rhs: Any?
    public static func ??= (lhs: inout Optional, rhs: Optional) {
        guard let rhs = rhs else { return }
        lhs = rhs
    }

}

// MARK: - Methods (Collection)
public extension Optional where Wrapped: Collection {

    /// Check if optional is nil or empty collection.
    public var isNilOrEmpty: Bool {
        guard let collection = self else { return true }
        return collection.isEmpty
    }

}

// MARK: - Operators
infix operator ??= : AssignmentPrecedence
