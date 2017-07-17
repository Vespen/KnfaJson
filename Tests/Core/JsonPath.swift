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

import XCTest
import SimpleJson

/// `JsonPath` test case class.
class JsonPathTestCase: XCTestCase {

    /// Tests `init()`.
    public func testInit() {
        let emptyPath = JsonPath()

        XCTAssertEqual(emptyPath.description, String(),
                "Empty path description must be equal to empty string."
        )

        XCTAssertEqual(emptyPath.components.count, 0,
                "Empty path components count must be equal to zero."
        )
    }

    /// Tests `init(string:)`.
    public func testInitString() {
        let string = "response.items.42.name"

        let path = JsonPath(string: string)

        XCTAssertEqual(path.description, string,
                "Path description must be equal to the source string."
        )
    }

    /// Tests `init(index:)`.
    public func testInitIndex() {
        let index = 42

        let path = JsonPath(index: 42)

        XCTAssertEqual(path.components.count, 1,
                "Path components count must be equal to one."
        )

        XCTAssertEqual(path.components.first!, String(index),
                "Path component must be equal to string with the index value."
        )

        XCTAssertEqual(path.description, String(index),
                "Path description must be equal to string with the index value."
        )
    }

    /// Tests `init(components:)`.
    public func testInitComponents() {
        let components = [
                "response",
                "items",
                "42",
                "name"
        ]

        let path = JsonPath(components: components)

        XCTAssertEqual(path.components, components,
                "Path components must be equal to the source components."
        )

        XCTAssertEqual(path.description, components.joined(separator: JsonPath.separator),
                "Path description must be equal to the source components joined by `JsonPath.separator`."
        )
    }

    /// Tests `appending(_:)`.
    public func testAppending() {
        let lhs = JsonPath(string: "response.items.0")
        let rhs = JsonPath(string: "name")

        let path = lhs.appending(rhs)

        XCTAssertEqual(path.components, lhs.components + rhs.components,
                "Path components must be equal to concatenated components of the source paths."
        )

        XCTAssertEqual(path.description, [lhs.description, rhs.description].joined(separator: JsonPath.separator),
                "Path description must be equal to the source descriptions joined by `JsonPath.separator`."
        )
    }

    /// Tests `subpath(to:)`.
    public func testSubpath() {
        let components = [
                "response",
                "items",
                "42",
                "name"
        ]

        let path = JsonPath(components: components)

        for index in 0..<components.count + 1 {
            let subpath = path.subpath(to: index)

            XCTAssertEqual(subpath.components, Array(path.components.prefix(index)),
                    "Subpath components must be equal to prefixed path components by the given index."
            )
        }
    }
}
