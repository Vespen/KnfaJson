//
//  Json+String.swift
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

/// `String` based methods.
public extension Json {

    /// Returns the `String` value.
    ///
    /// - Throws: `JsonError`.
    /// - Returns: `String`.
    public func asString() throws -> String {
        guard let string = root as? String else {
            throw JsonError.componentTypeMismatch(absolutePath, String.self)
        }

        return string
    }

    /// Returns the `UUID` value.
    ///
    /// - Throws: `JsonError`.
    /// - Returns: `UUID`.
    public func asUuid() throws -> UUID {
        guard let string = root as? String, let uuid = UUID(uuidString: string) else {
            throw JsonError.componentTypeMismatch(absolutePath, UUID.self)
        }

        return uuid
    }

    /// Returns the URL value.
    ///
    /// - Throws: `JsonError`.
    /// - Returns: `URL`.
    public func asUrl() throws -> URL {
        guard let string = root as? String, let url = URL(string: string) else {
            throw JsonError.componentTypeMismatch(absolutePath, URL.self)
        }

        return url
    }

    /// Returns the `String` value identified by a given path.
    ///
    /// - Parameter path: Path.
    /// - Throws: `JsonError`.
    /// - Returns: The `String` value identified by `path`.
    public func string(at path: JsonPath) throws -> String {
        guard let string = try value(at: path) as? String else {
            throw JsonError.componentTypeMismatch(absolutePath.appending(path), String.self)
        }

        return string
    }

    /// Returns the `UUID` value identified by a given path.
    ///
    /// - Parameter path: Path.
    /// - Throws: `JsonError`.
    /// - Returns: The `UUID` value identified by `path`.
    public func uuid(at path: JsonPath) throws -> UUID {
        guard let string = try value(at: path) as? String, let uuid = UUID(uuidString: string) else {
            throw JsonError.componentTypeMismatch(absolutePath.appending(path), UUID.self)
        }

        return uuid
    }

    /// Returns the `URL` value identified by a given path.
    ///
    /// - Parameter path: Path.
    /// - Throws: `JsonError`.
    /// - Returns: The `URL` value identified by `path`.
    public func url(at path: JsonPath) throws -> URL {
        guard let string = try value(at: path) as? String, let url = URL(string: string) else {
            throw JsonError.componentTypeMismatch(absolutePath.appending(path), URL.self)
        }

        return url
    }
}
