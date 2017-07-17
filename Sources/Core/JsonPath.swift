//
//  JsonPath.swift
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

/// `JsonPath` class.
public class JsonPath {

    /// String path component separator.
    ///
    /// String path components **must** be separated by that separator.
    public static let separator = "."

    /// Returns path components.
    public let components: [String]

    /// Creates a `JsonPath` instance.
    ///
    /// Each path component **must** identify underlying object's property.
    ///
    /// - Parameter components: Path components.
    public init(components: [String]) {
        self.components = components
    }

    /// Creates an empty `JsonPath` instance.
    public convenience init() {
        self.init(components: [])
    }

    /// Creates a `JsonPath` instance.
    ///
    /// Path components of a given *string path* **must** be separated by
    /// `JsonPath.separator`.
    ///
    /// - Parameter string: String path.
    public convenience init(string: String) {
        self.init(components: string.components(separatedBy: JsonPath.separator))
    }

    /// Creates a `JsonPath` instance.
    ///
    /// - Parameter index: Index.
    public convenience init(index: Int) {
        self.init(components: [String(index)])
    }

    /// Returns a new `JsonPath` made by appending path components of a given
    /// path to the components of `self`.
    ///
    /// - Parameter path: Path.
    /// - Returns: `JsonPath`.
    public func appending(_ path: JsonPath) -> JsonPath {
        return JsonPath(components: components + path.components)
    }

    /// Returns a new `JsonPath` containing path components of the `self` up
    /// to, but not including, the one at a given index.
    ///
    /// - Parameter index: Index.
    /// - Returns: `JsonPath`.
    public func subpath(to index: Int) -> JsonPath {
        return JsonPath(components: Array(components.prefix(index)))
    }
}

/// `CustomStringConvertible` extension for `JsonPath`.
extension JsonPath: CustomStringConvertible {

    public var description: String {
        return components.joined(separator: JsonPath.separator)
    }
}
