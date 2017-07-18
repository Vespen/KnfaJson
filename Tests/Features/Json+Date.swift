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

import XCTest
import SimpleJson

/// `JsonDateTestCase` class.
final class JsonDateTestCase: BaseTestCase {

    /// Tests `asDate(_:)`.
    func testAsDate() throws {
        let formatter = DateFormatter()

        formatter.dateFormat = "dd.MM.YYYY"

        XCTAssertNoThrow(try json.json(at: "0.incorporated").asDate(.string(formatter)))
        XCTAssertNoThrow(try json.json(at: "0.incorporatedTs").asDate(.timestamp))
        XCTAssertNoThrow(try json.json(at: "0.incorporatedTsMs").asDate(.timestampInMs))
        XCTAssertThrowsError(try json.json(at: "0.name").asDate(.string(formatter)))
        XCTAssertThrowsError(try json.json(at: "0.name").asDate(.timestamp))
        XCTAssertThrowsError(try json.json(at: "0.name").asDate(.timestampInMs))
    }

    /// Tests `date(at:format:)`.
    func testDateAtFormat() throws {
        let formatter = DateFormatter()

        formatter.dateFormat = "dd.MM.YYYY"

        XCTAssertNoThrow(try json.date(at: "0.incorporated", format: .string(formatter)))
        XCTAssertNoThrow(try json.date(at: "0.incorporatedTs", format: .timestamp))
        XCTAssertNoThrow(try json.date(at: "0.incorporatedTsMs", format: .timestampInMs))
        XCTAssertThrowsError(try json.date(at: "0.name", format: .string(formatter)))
        XCTAssertThrowsError(try json.date(at: "0.name", format: .timestamp))
        XCTAssertThrowsError(try json.date(at: "0.name", format: .timestampInMs))
    }
}
