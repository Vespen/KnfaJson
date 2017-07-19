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
final class JsonPathTestCase: XCTestCase {

    /// Tests `init()`.
    func testInit() {
        XCTAssert(JsonPath().components.isEmpty)
    }

    /// Tests `init(string:)`.
    func testInitString() {
        let string = "response.items.42.name"

        XCTAssertEqual(JsonPath(string: string).components, string.components(separatedBy: JsonPath.separator))
        XCTAssertTrue(JsonPath(string: "").components.isEmpty)
    }

    /// Tests `init(index:)`.
    func testInitIndex() {
        let index = 42
        let jsonPath = JsonPath(index: index)

        XCTAssertEqual(jsonPath.components.count, 1)

        if let first = jsonPath.components.first {
            XCTAssertEqual(first, String(index))
        }
    }

    /// Tests `init(components:)`.
    func testInitComponents() {
        let components = [
                "response",
                "items",
                "42",
                "name"
        ]

        XCTAssertEqual(JsonPath(components: components).components, components)
    }

    /// Tests `appending(_:)`.
    func testAppending() {
        let lhs = JsonPath(string: "response.items.0")
        let rhs = JsonPath(string: "name")

        XCTAssertEqual(lhs.appending(rhs).components, lhs.components + rhs.components)
    }

    /// Tests `subpath(to:)`.
    func testSubpath() {
        let components = [
                "response",
                "items",
                "42",
                "name"
        ]

        XCTAssertEqual(JsonPath(components: components).subpath(to: 2).components, Array(components.prefix(2)))
    }

    /// Tests `==(lhs:rhs:)`.
    func testEquals() {
        let components = [
                "response",
                "items",
                "42",
                "name"
        ]

        let string = components.joined(separator: JsonPath.separator)

        XCTAssert(JsonPath(components: components) == JsonPath(string: string))
    }

    /// Tests `description`.
    func testDescription() {
        XCTAssertEqual(JsonPath().description, "")

        let components = [
                "response",
                "items",
                "42",
                "name"
        ]

        XCTAssertEqual(JsonPath(components: components).description, components.joined(separator: JsonPath.separator))

        let string = "response.items.42.name"

        XCTAssertEqual(JsonPath(string: string).description, string)

        let index = 42

        XCTAssertEqual(JsonPath(index: index).description, String(index))
    }

    /// Tests `init(stringLiteral:)`.
    func testInitStringLiteral() {
        XCTAssertEqual("response.items.42.name", JsonPath(string: "response.items.42.name"))
    }

    /// Tests `init(extendedGraphemeClusterLiteral:)`.
    func testInitExtendedGraphemeClusterLiteral() {
        let string = "response.items.42.name"

        XCTAssertEqual(JsonPath(extendedGraphemeClusterLiteral: string), JsonPath(string: string))
    }

    /// Tests `init(unicodeScalarLiteral:)`.
    func testInitUnicodeScalarLiteral() {
        let string = "response.items.42.name"

        XCTAssertEqual(JsonPath(unicodeScalarLiteral: string), JsonPath(string: string))
    }

    /// Tests `init(integerLiteral:)`.
    func testInitIntegerLiteral() {
        XCTAssertEqual(42, JsonPath(index: 42))
    }

    /// Tests `init(arrayLiteral:)`.
    func testInitArrayLiteral() {
        XCTAssertEqual(["response", "items", "42", "name"], JsonPath(components: ["response", "items", "42", "name"]))
    }
}
