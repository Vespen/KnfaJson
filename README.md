# KnfaJson

[![Build Status](https://travis-ci.org/Vespen/KnfaJson.svg?branch=master)](https://travis-ci.org/Vespen/KnfaJson)
[![Coverage](https://codecov.io/github/Vespen/KnfaJson/coverage.svg?branch=master)](https://codecov.io/github/Vespen/KnfaJson)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

Simple JSON handling in Swift

`KnfaJson` is the helper framework aimed to reduce amount of boilerplate code generated during JSON deserialization process. 

The key class of this framework is `Json` class.

```swift
// Json instance can be initialized with `JSONSerialization.jsonObject(with:)` result.
let json = Json(root: try JSONSerialization.jsonObject(with: ...))
```

## Example

```json
{
  "name": "New York City",
  "location": [
    40.730610, -73.935242
  ]
}
```

```swift
// All values can be retrieved using their JSON keys.
let name = try json.string(at: "name")

let (latitude, longitude) = (
        // Multiple path components can be joined to a single string using
        // dot character.
        try json.double(at: "location.0"),
        // Array index can be used as path component.
        try json.double(at: "location.1")
)
```

## Capabilities

`Json` class helps you to get values of the following types: `String`, `UUID`, `URL`, `NSNumber`, `Int`, `Float`, `Double`, `Bool`, `Date` from string, `Date` from timestamp and `Date` from timestamp in milliseconds.

```swift
// Array of `Json` instances can be retrieved using `array(at:)` method.
for item in try json.array(at: "location") {
    print(item.absolutePath, try item.asDouble())
}
// Output:
// location.0 40.73061
// location.1 -73.935242
```

```swift
// Array literal can be used as path.
let _ = json.double(at: ["location", "0"])
```

```swift
// Nested `Json` instances can be retrieved using `json(at:)` method.
let array = json.json(at: "location")
```

```swift
// Integer literal can be used as path.
let _ = array.double(at: 0)
```
