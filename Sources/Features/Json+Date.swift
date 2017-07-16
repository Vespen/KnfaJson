//
//  Json+Date.swift
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

/// `DateFormat` enum.
public enum DateFormat {
    /// String.
    case string(DateFormatter)
    /// Timestamp.
    case timestamp
    /// Timestamp in milliseconds.
    case timestampInMs
}

/// `Date` based methods.
public extension Json {

    /// Returns the `Date` value.
    ///
    /// - Parameter format: Date format.
    /// - Throws: `JsonError`.
    /// - Returns: `Date`.
    public func asDate(_ format: DateFormat) throws -> Date {
        switch format {
        case .string(let formatter):
            guard let string = root as? String, let date = formatter.date(from: string) else {
                throw JsonError.componentTypeMismatch(absolutePath, Date.self)
            }

            return date
        case .timestamp:
            guard let number = root as? NSNumber else {
                throw JsonError.componentTypeMismatch(absolutePath, Date.self)
            }

            return Date(timeIntervalSince1970: number.doubleValue)
        case .timestampInMs:
            guard let number = root as? NSNumber else {
                throw JsonError.componentTypeMismatch(absolutePath, Date.self)
            }

            return Date(timeIntervalSince1970: number.doubleValue * 0.001)
        }
    }

    /// Returns the `Date` value identified by a given path.
    ///
    /// - Parameters:
    ///     - path: Path.
    ///     - format: Date format.
    /// - Throws: `JsonError`.
    /// - Returns: The `Date` value identified by `path`.
    public func date(at path: JsonPath, format: DateFormat) throws -> Date {
        let value = try self.value(at: path)

        switch format {
        case .string(let formatter):
            guard let string = value as? String, let date = formatter.date(from: string) else {
                throw JsonError.componentTypeMismatch(absolutePath.appending(path), Date.self)
            }

            return date
        case .timestamp:
            guard let number = value as? NSNumber else {
                throw JsonError.componentTypeMismatch(absolutePath.appending(path), Date.self)
            }

            return Date(timeIntervalSince1970: number.doubleValue)
        case .timestampInMs:
            guard let number = value as? NSNumber else {
                throw JsonError.componentTypeMismatch(absolutePath.appending(path), Date.self)
            }

            return Date(timeIntervalSince1970: number.doubleValue * 0.001)
        }
    }
}