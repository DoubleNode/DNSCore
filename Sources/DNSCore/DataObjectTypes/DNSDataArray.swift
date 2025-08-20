//
//  DNSDataArray.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public typealias DNSDataArray = [DNSDataDictionary]

public extension DNSDataArray {
    /// Returns an empty DNSDataArray instance
    /// This computed property ensures thread safety by creating a new instance each time
    static var empty: DNSDataArray {
        return []
    }

    /// Creates a new empty DNSDataArray
    /// Alternative method for clarity in code
    static func createEmpty() -> DNSDataArray {
        return []
    }
}

// MARK: - Sendable-compatible alternative for future use

/// A Sendable-compatible array of data dictionaries for Swift 6+ projects
public struct DNSSendableDataArray: Sendable, ExpressibleByArrayLiteral {
    private let data: [DNSSendableDataDictionary]

    public init() {
        self.data = []
    }

    public init(_ array: [DNSSendableDataDictionary]) {
        self.data = array
    }

    public init(arrayLiteral elements: DNSSendableDataDictionary...) {
        self.data = elements
    }

    /// Empty array singleton - safe because DNSSendableDataArray is immutable
    public static let empty = DNSSendableDataArray()

    public var count: Int {
        return data.count
    }

    public var isEmpty: Bool {
        return data.isEmpty
    }

    public subscript(index: Int) -> DNSSendableDataDictionary {
        return data[index]
    }

    public func appending(_ element: DNSSendableDataDictionary) -> DNSSendableDataArray {
        return DNSSendableDataArray(data + [element])
    }

    public func appending(contentsOf array: [DNSSendableDataDictionary]) -> DNSSendableDataArray {
        return DNSSendableDataArray(data + array)
    }

    public func map<T>(_ transform: (DNSSendableDataDictionary) throws -> T) rethrows -> [T] {
        return try data.map(transform)
    }

    public func filter(_ isIncluded: (DNSSendableDataDictionary) throws -> Bool) rethrows -> DNSSendableDataArray {
        return DNSSendableDataArray(try data.filter(isIncluded))
    }

    public func forEach(_ body: (DNSSendableDataDictionary) throws -> Void) rethrows {
        try data.forEach(body)
    }

    public func first(where predicate: (DNSSendableDataDictionary) throws -> Bool) rethrows -> DNSSendableDataDictionary? {
        return try data.first(where: predicate)
    }

    public func contains(where predicate: (DNSSendableDataDictionary) throws -> Bool) rethrows -> Bool {
        return try data.contains(where: predicate)
    }

    /// Convert to legacy DNSDataArray format (use with caution in concurrent contexts)
    public func toLegacyArray() -> DNSDataArray {
        return data.map { sendableDict in
            var dict: DNSDataDictionary = [:]
            for key in sendableDict.keys {
                dict[key] = sendableDict[key]
            }
            return dict
        }
    }
}

// MARK: - Sequence and Collection conformance
extension DNSSendableDataArray: Sequence, Collection {
    public typealias Element = DNSSendableDataDictionary
    public typealias Index = Array<DNSSendableDataDictionary>.Index

    public var startIndex: Index {
        return data.startIndex
    }

    public var endIndex: Index {
        return data.endIndex
    }

    public func index(after i: Index) -> Index {
        return data.index(after: i)
    }

    public func makeIterator() -> Array<DNSSendableDataDictionary>.Iterator {
        return data.makeIterator()
    }
}
