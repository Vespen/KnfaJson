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

import XCTest
import KnfaJson

/// `JsonStringTestCase` class.
final class JsonStringTestCase: BaseTestCase {

    /// Tests `asString()`.
    func testAsString() throws {
        XCTAssertEqual(try json.json(at: "0.name").asString(), "New York City")

        XCTAssertThrowsError(try json.json(at: 0).asString())
    }

    /// Tests `asUuid()`.
    func testAsUuid() throws {
        XCTAssertEqual(try json.json(at: "0.id").asUuid(),
                UUID(uuidString: "69107332-7152-45e1-8e50-6a7417c26f76")!)

        XCTAssertThrowsError(try json.json(at: 0).asUuid())
    }

    /// Tests `asUrl()`.
    func testAsUrl() throws {
        XCTAssertEqual(try json.json(at: "0.url").asUrl(),
                URL(string: "http://www.latlong.net/place/new-york-city-ny-usa-1848.html")!)

        XCTAssertThrowsError(try json.json(at: 0).asUrl())
    }

    /// Tests `string(at:)`.
    func testStringAt() throws {
        XCTAssertEqual(try json.string(at: "0.name"), "New York City")

        XCTAssertThrowsError(try json.string(at: 0))
    }

    /// Tests `uuid(at:)`.
    func testUuidAt() throws {
        XCTAssertEqual(try json.uuid(at: "0.id"),
                UUID(uuidString: "69107332-7152-45e1-8e50-6a7417c26f76")!)

        XCTAssertThrowsError(try json.uuid(at: 0))
    }

    /// Tests `url(at:)`.
    func testUrlAt() throws {
        XCTAssertEqual(try json.url(at: "0.url"),
                URL(string: "http://www.latlong.net/place/new-york-city-ny-usa-1848.html")!)

        XCTAssertThrowsError(try json.url(at: 0))
    }
}
