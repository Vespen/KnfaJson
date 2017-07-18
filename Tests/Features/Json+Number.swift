//
//  Json+Number.swift
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

/// `JsonNumberTestCase` class.
final class JsonNumberTestCase: BaseTestCase {

    /// Tests `asNumber()`.
    func testAsNumber() throws {
        let jsonPath: JsonPath = "0.location.0"

        XCTAssertNoThrow(try json.json(at: jsonPath).asNumber())

        if let number = try? json.json(at: jsonPath).asNumber() {
            XCTAssertEqualWithAccuracy(number.doubleValue, 40.730610, accuracy: 1e-6)
        }

        XCTAssertThrowsError(try json.json(at: 0).asNumber())
    }

    /// Tests `asInt()`.
    func testAsInt() throws {
        let jsonPath: JsonPath = "0.population"

        XCTAssertNoThrow(try json.json(at: jsonPath).asInt())

        if let population = try? json.json(at: jsonPath).asInt() {
            XCTAssertEqual(population, 8537673)
        }

        XCTAssertThrowsError(try json.json(at: 0).asInt())
    }

    /// Tests `asFloat()`.
    func testAsFloat() throws {
        let jsonPath: JsonPath = "0.location.0"

        XCTAssertNoThrow(try json.json(at: jsonPath).asFloat())

        if let float = try? json.json(at: jsonPath).asFloat() {
            XCTAssertEqualWithAccuracy(float, 40.730610, accuracy: 1e-6)
        }

        XCTAssertThrowsError(try json.json(at: 0).asFloat())
    }

    /// Tests `asDouble()`.
    func testAsDouble() throws {
        let jsonPath: JsonPath = "0.location.0"

        XCTAssertNoThrow(try json.json(at: jsonPath).asDouble())

        if let double = try? json.json(at: jsonPath).asDouble() {
            XCTAssertEqualWithAccuracy(double, 40.730610, accuracy: 1e-6)
        }

        XCTAssertThrowsError(try json.json(at: 0).asDouble())
    }

    /// Tests `asBool()`.
    func testAsBool() throws {
        let jsonPath: JsonPath = "0.favorite"

        XCTAssertNoThrow(try json.json(at: jsonPath).asBool())

        if let bool = try? json.json(at: jsonPath).asBool() {
            XCTAssertEqual(bool, true)
        }

        XCTAssertThrowsError(try json.json(at: 0).asBool())
    }

    /// Tests `number(at:)`.
    func testNumberAt() throws {
        let jsonPath: JsonPath = "0.location.0"

        XCTAssertNoThrow(try json.number(at: jsonPath))

        if let number = try? json.number(at: jsonPath) {
            XCTAssertEqualWithAccuracy(number.doubleValue, 40.730610, accuracy: 1e-6)
        }

        XCTAssertThrowsError(try json.number(at: 0))
    }

    /// Tests `int(at:)`.
    func testIntAt() throws {
        let jsonPath: JsonPath = "0.population"

        XCTAssertNoThrow(try json.int(at: jsonPath))

        if let population = try? json.int(at: jsonPath) {
            XCTAssertEqual(population, 8537673)
        }

        XCTAssertThrowsError(try json.int(at: 0))
    }

    /// Tests `float(at:)`.
    func testFloatAt() throws {
        let jsonPath: JsonPath = "0.location.0"

        XCTAssertNoThrow(try json.float(at: jsonPath))

        if let float = try? json.float(at: jsonPath) {
            XCTAssertEqualWithAccuracy(float, 40.730610, accuracy: 1e-6)
        }

        XCTAssertThrowsError(try json.float(at: 0))
    }

    /// Tests `double(at:)`.
    func testDoubleAt() throws {
        let jsonPath: JsonPath = "0.location.0"

        XCTAssertNoThrow(try json.double(at: jsonPath))

        if let double = try? json.double(at: jsonPath) {
            XCTAssertEqualWithAccuracy(double, 40.730610, accuracy: 1e-6)
        }

        XCTAssertThrowsError(try json.double(at: 0))
    }

    /// Tests `bool(at:)`.
    func testBoolAt() throws {
        let jsonPath: JsonPath = "0.favorite"

        XCTAssertNoThrow(try json.bool(at: jsonPath))

        if let bool = try? json.bool(at: jsonPath) {
            XCTAssertEqual(bool, true)
        }

        XCTAssertThrowsError(try json.bool(at: 0))
    }
}
