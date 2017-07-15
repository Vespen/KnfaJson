//
//  Json.swift
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

/// `Json` class is the helper class aimed to reduce amount of boilerplate code
/// generated during JSON deserialization process. The key method of this class
/// is `value(at:)` method. This method helps you to obtain value of underlying
/// instance by means of `JsonPath` class.
public final class Json {

    /// Returns underlying instance.
    public let root: Any

    /// Returns parent instance.
    public let parent: Json?

    /// Returns relative path.
    public let relativePath: JsonPath

    /// Returns absolute path.
    ///
    /// Absolute path is recursively computed by traversing through all parent
    /// instances.
    ///
    /// - Complexity: O(*n*) where *n* is a number of parent instances.
    public var absolutePath: JsonPath {
        if let parent = parent {
            return parent.absolutePath.appending(relativePath)
        } else {
            return relativePath
        }
    }

    /// Creates a `Json` instance.
    ///
    /// - Parameters:
    ///     - root: Underlying instance.
    ///     - parent: Parent instance.
    ///     - relativePath: Relative path.
    public init(root: Any, parent: Json? = nil, relativePath: JsonPath = []) {
        self.root = root
        self.parent = parent
        self.relativePath = relativePath
    }

    /// Returns the value identified by a given path.
    ///
    /// - Parameter path: Path.
    /// - Throws: `JsonError`.
    /// - Returns: The value identified by `path`.
    public func value(at path: JsonPath) throws -> Any {
        var result = root
        var current = 0

        for component in path.components {
            current += 1

            switch result {
            case let array as [Any]:
                guard let index = Int(component) else {
                    throw JsonError.componentIsNotAnIndex(absolutePath.appending(path.subpath(to: current)))
                }

                guard index >= 0, index < array.count else {
                    throw JsonError.componentIsOutOfBounds(absolutePath.appending(path.subpath(to: current)))
                }

                result = array[index]
            case let dictionary as [String: Any]:
                guard let value = dictionary[component] else {
                    throw JsonError.componentNotFound(absolutePath.appending(path.subpath(to: current)))
                }

                result = value
            default:
                throw JsonError.componentNotFound(absolutePath.appending(path.subpath(to: current)))
            }
        }

        return result
    }

    /// Returns the nested `Json` instance identified by a given path.
    ///
    /// - Parameter path: Path.
    /// - Throws: `JsonError`.
    /// - Returns: The nested `Json` instance identified by `path`.
    public func json(at path: JsonPath) throws -> Json {
        return Json(root: try value(at: path), parent: self, relativePath: path)
    }

    /// Returns the nested array of `Json` instances identified by a given path.
    ///
    /// - Parameter path: Path.
    /// - Throws: `JsonError`.
    /// - Returns: The nested array of `Json` instances identified by `path`.
    public func array(at path: JsonPath) throws -> [Json] {
        let value = try self.value(at: path)

        guard let array = value as? [Any] else {
            throw JsonError.componentTypeMismatch(path, [Any].self)
        }

        var result: [Json] = []

        for (index, item) in array.enumerated() {
            result.append(Json(root: item, parent: parent, relativePath: path.appending(index: index)))
        }

        return result
    }
}
