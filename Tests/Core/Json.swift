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

    /// Tests `root`.
    func testRootString() {
        let string = "string"

        let json = Json(root: string)

        XCTAssert(json.root is String,
                "Json root type must be equal to the source root type."
        )

        XCTAssert(json.root as! String == string,
                "Json root instance must be equal to the source root instance."
        )
    }

    /// Tests `root`.
    func testRootNumber() {
        let number = NSNumber(value: 42)

        let json = Json(root: number)

        XCTAssert(json.root is NSNumber,
                "Json root type must be equal to the source root type."
        )

        XCTAssert(json.root as! NSNumber === number,
                "Json root instance must be reference equal to the source root instance."
        )
    }

    /// Tests `root`.
    func testRootObject() {
        let object: [String: Any] = [:]

        let json = Json(root: object)

        XCTAssert(json.root is [String: Any],
                "Json root type must be equal to the source root type."
        )

        XCTAssert(json.root as AnyObject === object as AnyObject,
                "Json root instance must be reference equal to the source root instance."
        )
    }

    /// Tests `root`.
    func testRootArray() {
        let array: [Any] = []

        let json = Json(root: array)

        XCTAssert(json.root is [Any],
                "Json root type must be equal to the source root type."
        )

        XCTAssert(json.root as AnyObject === array as AnyObject,
                "Json root instance must be reference equal to the source root instance."
        )
    }

    /// Tests `parent`.
    func testParent() {
        let parent = Json(root: [])

        let json = Json(root: [], parent: parent)

        XCTAssert(json.parent === parent,
                "Json parent must be reference equal to the source parent."
        )
    }

    /// Tests `relativePath`.
    func testRelativePath() {
        let relativePath = JsonPath(string: "items")

        let json = Json(root: [], relativePath: relativePath)

        XCTAssert(json.relativePath === relativePath,
                "Json relative path must be reference equal to the source relative path."
        )
    }

    /// Tests `absolutePath`.
    func testAbsolutePath() {
        let path0 = JsonPath(string: "response")
        let path1 = JsonPath(string: "items")
        let path2 = JsonPath(index: 0)

        let level0 = Json(root: [], parent: nil, relativePath: path0)
        let level1 = Json(root: [], parent: level0, relativePath: path1)
        let level2 = Json(root: [], parent: level1, relativePath: path2)

        XCTAssertEqual(level2.absolutePath, path0.appending(path1).appending(path2),
                "Absolute path must be equal to concatenation of the subsequent paths."
        )
    }
}
