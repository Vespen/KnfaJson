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
public class JsonPath: ExpressibleByStringLiteral, ExpressibleByIntegerLiteral, ExpressibleByArrayLiteral {

    /// Path component separator.
    ///
    /// Path components **must** be separated by that separator.
    public static let separator = "."

    /// Returns path components.
    public let components: [String]

    /// Creates a `JsonPath` instance.
    ///
    /// - Parameter components: Path components.
    public init(components: [String]) {
        self.components = components
    }

    /// Returns a new `JsonPath` made by appending path components of a given
    /// path to the components of `self`.
    ///
    /// - Parameter path: Path.
    /// - Returns: `JsonPath`.
    public func appending(_ path: JsonPath) -> JsonPath {
        return JsonPath(components: components + path.components)
    }

    /// Returns a new `JsonPath` made by appending single path component,
    /// created from a given index, to the components of `self`.
    ///
    /// - Parameter index: Index.
    /// - Returns: `JsonPath`.
    public func appending(index: Int) -> JsonPath {
        return JsonPath(components: components + [String(index)])
    }

    /// Returns a new `JsonPath` containing path components of the `self` up
    /// to, but not including, the one at a given index.
    ///
    /// - Parameter index: Index.
    /// - Returns: `JsonPath`.
    public func subpath(to index: Int) -> JsonPath {
        return JsonPath(components: Array(components.prefix(index)))
    }

    // MARK: - ExpressibleByStringLiteral
    public convenience required init(stringLiteral value: String) {
        self.init(components: value.components(separatedBy: JsonPath.separator))
    }

    public convenience required init(extendedGraphemeClusterLiteral value: String) {
        self.init(stringLiteral: value)
    }

    public convenience required init(unicodeScalarLiteral value: String) {
        self.init(stringLiteral: value)
    }

    // MARK: - ExpressibleByIntegerLiteral
    public convenience required init(integerLiteral value: Int) {
        self.init(components: [String(value)])
    }

    // MARK: - ExpressibleByArrayLiteral
    public convenience required init(arrayLiteral elements: String...) {
        self.init(components: elements)
    }
}

/// `CustomStringConvertible` extension for `JsonPath`.
extension JsonPath: CustomStringConvertible {

    public var description: String {
        return components.joined(separator: JsonPath.separator)
    }
}
