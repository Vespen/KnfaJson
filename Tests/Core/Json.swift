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

import XCTest
import SimpleJson

/// `Json` test case class.
final class JsonTestCase: BaseTestCase {

    /// Tests `init(root:)`.
    func testInitRoot() {
        let json = Json(root: [])

        XCTAssertNil(json.parent)
        XCTAssert(json.relativePath.components.isEmpty)
    }

    /// Tests `init(root:parent:)`.
    func testInitRootParent() {
        let json = Json(root: [], parent: Json(root: []))

        XCTAssertNotNil(json.parent)
        XCTAssert(json.relativePath.components.isEmpty)
    }

    /// Tests `init(root:relativePath:)`.
    func testInitRootRelativePath() {
        let path = JsonPath(string: "response.items.42.name")
        let json = Json(root: [], relativePath: path)

        XCTAssertEqual(json.relativePath, path)
    }

    /// Tests `init(root:parent:relativePath:)`.
    func testInitRootParentRelativePath() {
        let path = JsonPath(string: "response.items.42.name")
        let json = Json(root: [], parent: Json(root: []), relativePath: path)

        XCTAssertNotNil(json.parent)
        XCTAssertEqual(json.relativePath, path)
    }

    /// Tests `absolutePath`.
    func testAbsolutePath() {
        let path0 = JsonPath(string: "response")
        let path1 = JsonPath(string: "items")
        let path2 = JsonPath(index: 42)

        let level0 = Json(root: [], parent: nil, relativePath: path0)
        let level1 = Json(root: [], parent: level0, relativePath: path1)
        let level2 = Json(root: [], parent: level1, relativePath: path2)

        XCTAssertEqual(level2.absolutePath, path0.appending(path1).appending(path2))
    }

    /// Tests `value(at:)`.
    func testValueAt() throws {
        // Array case check.
        XCTAssertNoThrow(try json.value(at: 0))

        if let object = try? json.value(at: 0) {
            XCTAssert(object is [String: Any])
        }

        XCTAssertThrowsError(try json.value(at: -1))
        XCTAssertThrowsError(try json.value(at: 99))
        XCTAssertThrowsError(try json.value(at: "notAnIndex"))

        // Dictionary case check.
        XCTAssertNoThrow(try json.value(at: "0.location"))

        if let array = try? json.value(at: "0.location") {
            XCTAssert(array is [Any])
        }

        XCTAssertThrowsError(try json.value(at: "0.undefined"))

        // Default case check.
        XCTAssertThrowsError(try json.value(at: "0.location.0.key"))
    }

    /// Tests `json(at:)`.
    func testJsonAt() throws {
        let jsonPath: JsonPath = "0.location.0"

        XCTAssertNoThrow(try json.json(at: jsonPath))

        if let json = try? json.json(at: jsonPath) {
            XCTAssert(json.root is NSNumber)
        }
    }

    /// Tests `array(at:)`.
    func testArrayAt() throws {
        let jsonPath: JsonPath = "0.location"

        XCTAssertNoThrow(try json.array(at: jsonPath))

        if let jsonArray = try? json.array(at: jsonPath) {
            XCTAssertEqual(jsonArray.count, 2)

            if let first = jsonArray.first, let last = jsonArray.last {
                XCTAssert(first.root is NSNumber)

                if let number = first.root as? NSNumber {
                    XCTAssertEqualWithAccuracy(number.doubleValue, 40.730610, accuracy: 1e-6)
                }

                XCTAssert(last.root is NSNumber)

                if let number = last.root as? NSNumber {
                    XCTAssertEqualWithAccuracy(number.doubleValue, -73.935242, accuracy: 1e-6)
                }
            }
        }

        XCTAssertThrowsError(try json.array(at: "0.name"))
    }
}
