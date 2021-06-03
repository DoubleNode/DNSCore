//
//  DNSString.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation
import LocalAuthentication
import UIKit

public class DNSString: Hashable, Codable {
    public enum Language: String, CaseIterable {
        case en
        case es419 = "es-419"
    }
    private let fallbackLanguage = Language.en

    private var _strings: [String: String]

    public var asString: String {
        self.asString(for: DNSCore.languageCode)
    }
    public func asString(for language: DNSString.Language) -> String {
        self.asString(for: language.rawValue)
    }
    public func asString(for languageStr: String) -> String {
        _strings[languageStr] ?? (_strings[fallbackLanguage.rawValue] ?? "<MISSING_STRING>")
    }
    public init() {
        _strings = [:]
    }
    public init(with strings: [DNSString.Language: String]) {
        var newStrings: [String: String] = [:]
        strings.keys.forEach { newStrings[$0.rawValue] = strings[$0] }
        _strings = newStrings
    }
    public init(with strings: [String: String]) {
        _strings = strings
    }
    public init(with string: String) {
        var newStrings: [String: String] = [:]
        newStrings[fallbackLanguage.rawValue] = string
        _strings = newStrings
    }
    static public func == (lhs: DNSString, rhs: DNSString) -> Bool {
        return lhs.asString == rhs.asString
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(_strings)
    }

    public enum CodingKeys: String, CodingKey {
        case en, es419
    }
    required public init(from decoder: Decoder) throws {
        _strings = [:]
        let container = try decoder.container(keyedBy: CodingKeys.self)
        _strings[Language.en.rawValue] = try container.decode(String.self, forKey: .en)
        _strings[Language.es419.rawValue] = try container.decode(String.self, forKey: .es419)
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(_strings[Language.en.rawValue], forKey: .en)
        try container.encode(_strings[Language.es419.rawValue], forKey: .es419)
    }
}
