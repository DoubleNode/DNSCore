//
//  DNSString.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation
import LocalAuthentication
#if !os(macOS)
import UIKit
#endif

public class DNSString: Hashable, Codable, NSCopying, Comparable {
    public enum Language: String, CaseIterable {
        case en
        case es419 = "es-419"
    }
    private let fallbackLanguage = Language.en

    private var _strings: [String: String]

    public var asDictionary: [String: String] {
        return _strings
    }
    public var asString: String {
        self.asString(for: DNSCore.languageCode)
    }
    public func asString(for language: DNSString.Language) -> String {
        self.asString(for: language.rawValue)
    }
    public func asString(for languageStr: String) -> String {
        _strings[languageStr] ?? (_strings[fallbackLanguage.rawValue] ?? "")
    }
    public func rawValue(for language: DNSString.Language) -> String {
        self.rawValue(for: language.rawValue)
    }
    public func rawValue(for languageStr: String) -> String {
        _strings[languageStr] ?? ""
    }
    public init() {
        _strings = [:]
    }
    public init(with strings: [DNSString.Language: String]) {
        var newStrings: [String: String] = [:]
        strings.keys.forEach {
            newStrings[$0.rawValue] = DNSString.utilityCleanupString(strings[$0])
        }
        _strings = newStrings
    }
    public init(with strings: [String: String]) {
        var newStrings: [String: String] = [:]
        strings.keys.forEach {
            newStrings[$0] = DNSString.utilityCleanupString(strings[$0])
        }
        _strings = newStrings
    }
    public init(with string: String) {
        var newStrings: [String: String] = [:]
        newStrings[fallbackLanguage.rawValue] = DNSString.utilityCleanupString(string)
        _strings = newStrings
    }
    @discardableResult
    public func replace(for languageStr: String,
                        with string: String) -> DNSString {
        _strings[languageStr] = DNSString.utilityCleanupString(string)
        return self
    }
    @discardableResult
    public func replace(for language: DNSString.Language,
                        with string: String) -> DNSString {
        _strings[language.rawValue] = DNSString.utilityCleanupString(string)
        return self
    }

    // Codable protocol methods
    public enum CodingKeys: String, CodingKey {
        case en
        case es419 = "es-419"
    }
    required public init(from decoder: Decoder) throws {
        _strings = [:]
        let container = try decoder.container(keyedBy: CodingKeys.self)
        _strings[Language.en.rawValue] = try container.decode(String.self, forKey: .en)
        _strings[Language.es419.rawValue] = try container.decode(String.self, forKey: .es419)
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(_strings[Language.en.rawValue] ?? "", forKey: .en)
        try container.encode(_strings[Language.es419.rawValue] ?? "", forKey: .es419)
    }

    @inlinable public var isEmpty: Bool {
        return asString.isEmpty
    }

    // Equatable protocol methods
    static public func == (lhs: DNSString, rhs: DNSString) -> Bool {
        return lhs._strings == rhs._strings
    }

    // Hashable protocol methods
    public func hash(into hasher: inout Hasher) {
        hasher.combine(_strings)
    }

    // NSCopying protocol methods
    public func copy(with zone: NSZone? = nil) -> Any {
        let newStrings = _strings
        let copy = DNSString(with: newStrings)
        return copy
    }
    
    // Comparable protocol methods
    public static func < (lhs: DNSString, rhs: DNSString) -> Bool {
        return lhs.asString < rhs.asString
    }
    
    // Utility Methods
    static func utilityCleanupString(_ string: String?) -> String? {
        guard let string = string else { return nil }
        return string.replacingOccurrences(of: "\\r", with: "\r")
            .replacingOccurrences(of: "\\n", with: "\n")
    }
}
