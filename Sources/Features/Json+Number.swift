//
//  Json+Number.swift
//
//  Copyright (c) 2017 Anton Lagutin
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

/// `NSNumber` based methods.
public extension Json {

    /// Returns the `NSNumber` value.
    ///
    /// - Throws: `JsonError`.
    /// - Returns: `NSNumber`.
    public func asNumber() throws -> NSNumber {
        guard let number = root as? NSNumber else {
            throw JsonError.componentTypeMismatch(absolutePath, NSNumber.self)
        }

        return number
    }

    /// Returns the `Int` value.
    ///
    /// - Throws: `JsonError`.
    /// - Returns: `Int`.
    public func asInt() throws -> Int {
        guard let number = root as? NSNumber else {
            throw JsonError.componentTypeMismatch(absolutePath, Int.self)
        }

        return number.intValue
    }

    /// Returns the `Float` value.
    ///
    /// - Throws: `JsonError`.
    /// - Returns: `Float`.
    public func asFloat() throws -> Float {
        guard let number = root as? NSNumber else {
            throw JsonError.componentTypeMismatch(absolutePath, Float.self)
        }

        return number.floatValue
    }

    /// Returns the `Double` value.
    ///
    /// - Throws: `JsonError`.
    /// - Returns: `Double`.
    public func asDouble() throws -> Double {
        guard let number = root as? NSNumber else {
            throw JsonError.componentTypeMismatch(absolutePath, Double.self)
        }

        return number.doubleValue
    }

    /// Returns the `Bool` value.
    ///
    /// - Throws: `JsonError`.
    /// - Returns: `Bool`.
    public func asBool() throws -> Bool {
        guard let number = root as? NSNumber else {
            throw JsonError.componentTypeMismatch(absolutePath, Bool.self)
        }

        return number.boolValue
    }

    /// Returns the `NSNumber` value identified by a given path.
    ///
    /// - Parameter path: Path.
    /// - Throws: `JsonError`.
    /// - Returns: The `NSNumber` value identified by `path`.
    public func number(at path: JsonPath) throws -> NSNumber {
        guard let number = try self.value(at: path) as? NSNumber else {
            throw JsonError.componentTypeMismatch(absolutePath.appending(path), NSNumber.self)
        }

        return number
    }

    /// Returns the `Int` value identified by a given path.
    ///
    /// - Parameter path: Path.
    /// - Throws: `JsonError`.
    /// - Returns: The `Int` value identified by `path`.
    public func int(at path: JsonPath) throws -> Int {
        guard let number = try self.value(at: path) as? NSNumber else {
            throw JsonError.componentTypeMismatch(absolutePath.appending(path), Int.self)
        }

        return number.intValue
    }

    /// Returns the `Float` value identified by a given path.
    ///
    /// - Parameter path: Path.
    /// - Throws: `JsonError`.
    /// - Returns: The `Float` value identified by `path`.
    public func float(at path: JsonPath) throws -> Float {
        guard let number = try self.value(at: path) as? NSNumber else {
            throw JsonError.componentTypeMismatch(absolutePath.appending(path), Float.self)
        }

        return number.floatValue
    }

    /// Returns the `Double` value identified by a given path.
    ///
    /// - Parameter path: Path.
    /// - Throws: `JsonError`.
    /// - Returns: The `Double` value identified by `path`.
    public func double(at path: JsonPath) throws -> Double {
        guard let number = try self.value(at: path) as? NSNumber else {
            throw JsonError.componentTypeMismatch(absolutePath.appending(path), Double.self)
        }

        return number.doubleValue
    }

    /// Returns the `Bool` value identified by a given path.
    ///
    /// - Parameter path: Path.
    /// - Throws: `JsonError`.
    /// - Returns: The `Bool` value identified by `path`.
    public func bool(at path: JsonPath) throws -> Bool {
        guard let number = try self.value(at: path) as? NSNumber else {
            throw JsonError.componentTypeMismatch(absolutePath.appending(path), Bool.self)
        }

        return number.boolValue
    }
}
