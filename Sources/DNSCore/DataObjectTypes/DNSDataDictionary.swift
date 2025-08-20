//
//  DNSDataDictionary.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

// For Swift 6 compatibility, we need to be careful with Any types
// For now, we'll maintain backward compatibility but add Sendable support
public typealias DNSDataDictionary = [String: Any?]

public extension DNSDataDictionary {
    /// Returns an empty DNSDataDictionary instance
    /// This computed property ensures thread safety by creating a new instance each time
    static var empty: DNSDataDictionary {
        return [:]
    }

    /// Creates a new empty DNSDataDictionary
    /// Alternative method for clarity in code
    static func createEmpty() -> DNSDataDictionary {
        return [:]
    }
}

// MARK: - Sendable-compatible alternative for future use

/// A Sendable-compatible dictionary for Swift 6+ projects
public struct DNSSendableDataDictionary: Sendable, ExpressibleByDictionaryLiteral {
    private let data: [String: (any Sendable)?]

    public init() {
        self.data = [:]
    }

    public init(_ dictionary: [String: (any Sendable)?]) {
        self.data = dictionary
    }

    public init(dictionaryLiteral elements: (String, (any Sendable)?)...) {
        var dict: [String: (any Sendable)?] = [:]
        for (key, value) in elements {
            dict[key] = value
        }
        self.data = dict
    }

    /// Empty dictionary singleton - safe because DNSSendableDataDictionary is immutable
    public static let empty = DNSSendableDataDictionary()

    public subscript(key: String) -> (any Sendable)? {
        return data[key]
    }

    public var keys: Dictionary<String, (any Sendable)?>.Keys {
        return data.keys
    }

    public var values: Dictionary<String, (any Sendable)?>.Values {
        return data.values
    }

    public var count: Int {
        return data.count
    }

    public var isEmpty: Bool {
        return data.isEmpty
    }

    public func contains(key: String) -> Bool {
        return data.keys.contains(key)
    }

    /// Returns a new dictionary with the specified key-value pair added or updated
    public func setting(key: String, value: (any Sendable)?) -> DNSSendableDataDictionary {
        var newData = data
        newData[key] = value
        return DNSSendableDataDictionary(newData)
    }

    /// Returns a new dictionary with the specified key removed
    public func removing(key: String) -> DNSSendableDataDictionary {
        var newData = data
        newData.removeValue(forKey: key)
        return DNSSendableDataDictionary(newData)
    }

    /// Merges this dictionary with another, returning a new instance
    public func merging(_ other: DNSSendableDataDictionary) -> DNSSendableDataDictionary {
        return DNSSendableDataDictionary(data.merging(other.data) { _, new in new })
    }

    /// Convert to legacy DNSDataDictionary format (use with caution in concurrent contexts)
    public func toLegacyDictionary() -> DNSDataDictionary {
        var legacyDict: DNSDataDictionary = [:]
        for (key, value) in data {
            legacyDict[key] = value
        }
        return legacyDict
    }

    /// Create from legacy DNSDataDictionary (only includes known Sendable types)
    public static func from(legacyDictionary: DNSDataDictionary) -> DNSSendableDataDictionary {
        var sendableDict: [String: (any Sendable)?] = [:]
        for (key, value) in legacyDictionary {
            // Only include known Sendable types to avoid casting issues
            let sendableValue: (any Sendable)? = extractSendableValue(from: value)
            sendableDict[key] = sendableValue
        }
        return DNSSendableDataDictionary(sendableDict)
    }

    /// Helper function to extract Sendable values from Any? values
    private static func extractSendableValue(from value: Any?) -> (any Sendable)? { // swiftlint:disable:this cyclomatic_complexity line_length
        guard let value = value else { return nil }

        // Check for common Sendable types explicitly
        switch value {
        case let stringValue as String:
            return stringValue
        case let intValue as Int:
            return intValue
        case let doubleValue as Double:
            return doubleValue
        case let floatValue as Float:
            return floatValue
        case let boolValue as Bool:
            return boolValue
        case let dataValue as Data:
            return dataValue
        case let dateValue as Date:
            return dateValue
        case let urlValue as URL:
            return urlValue
        case let uuidValue as UUID:
            return uuidValue
        case let decimalValue as Decimal:
            return decimalValue
        case let arrayValue as [Any]:
            // Convert array elements recursively
            let sendableArray = arrayValue.compactMap { extractSendableValue(from: $0) }
            return sendableArray
        case let dictValue as [String: Any]:
            // Convert dictionary recursively
            var sendableDict: [String: any Sendable] = [:]
            for (key, dictValue) in dictValue {
                if let sendableValue = extractSendableValue(from: dictValue) {
                    sendableDict[key] = sendableValue
                }
            }
            return sendableDict
        default:
            // For unknown types, return nil rather than risk unsafe casting
            return nil
        }
    }
}

// MARK: - Sequence conformance
extension DNSSendableDataDictionary: Sequence {
    public typealias Element = (key: String, value: (any Sendable)?)

    public func makeIterator() -> Dictionary<String, (any Sendable)?>.Iterator {
        return data.makeIterator()
    }
}
