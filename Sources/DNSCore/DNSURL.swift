//
//  DNSURL.swift
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

public class DNSURL: Hashable, Codable, NSCopying, Comparable {
    public enum Language: String, CaseIterable {
        case en
        case es419 = "es-419"
    }
    private let fallbackLanguage = Language.en

    private var _urls: [String: URL?]

    public var asDictionary: [String: URL?] {
        return _urls
    }
    public var asURL: URL? {
        self.asURL(for: DNSCore.languageCode)
    }
    public func asURL(for language: DNSString.Language) -> URL? {
        self.asURL(for: language.rawValue)
    }
    public func asURL(for languageStr: String) -> URL? {
        _urls[languageStr] ?? _urls[fallbackLanguage.rawValue] ?? nil
    }
    public func rawValue(for languageStr: String) -> URL? {
        _urls[languageStr] ?? nil
    }
    public init() {
        _urls = [:]
    }
    public init(with urls: [DNSURL.Language: URL?]) {
        _urls = [:]
        urls.keys.forEach { _urls[$0.rawValue] = urls[$0] }
    }
    public init(with urls: [String: URL?]) {
        _urls = urls
    }
    public init(with strings: [DNSURL.Language: String]) {
        _urls = [:]
        strings.keys.forEach { _urls[$0.rawValue] = URL(string: strings[$0] ?? "") }
    }
    public init(with strings: [String: String]) {
        _urls = [:]
        strings.keys.forEach { _urls[$0] = URL(string: strings[$0] ?? "") }
    }
    public init(with url: URL?) {
        var newURLs: [String: URL?] = [:]
        newURLs[fallbackLanguage.rawValue] = url
        _urls = newURLs
    }
    @discardableResult
    public func replace(for language: DNSString.Language,
                        with url: URL?) -> DNSURL {
        _urls[language.rawValue] = url
        return self
    }
    @discardableResult
    public func replace(for languageStr: String,
                        with url: URL?) -> DNSURL {
        _urls[languageStr] = url
        return self
    }

    // Codable protocol methods
    public enum CodingKeys: String, CodingKey {
        case en
        case es419 = "es-419"
    }
    required public init(from decoder: Decoder) throws {
        _urls = [:]
        let container = try decoder.container(keyedBy: CodingKeys.self)
        _urls[Language.en.rawValue] = URL(string: try container.decode(String.self, forKey: .en))
        _urls[Language.es419.rawValue] = URL(string: try container.decode(String.self, forKey: .es419))
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let stringEn = _urls[Language.en.rawValue]??.absoluteString
        try container.encode(stringEn ?? "", forKey: .en)
        let stringEs419 = _urls[Language.es419.rawValue]??.absoluteString
        try container.encode(stringEs419 ?? "", forKey: .es419)
    }

    @inlinable public var isEmpty: Bool {
        return asURL?.absoluteString.isEmpty ?? true
    }

    // Equatable protocol methods
    static public func == (lhs: DNSURL, rhs: DNSURL) -> Bool {
        return lhs._urls == rhs._urls
    }

    // Hashable protocol methods
    public func hash(into hasher: inout Hasher) {
        hasher.combine(_urls)
    }

    // NSCopying protocol methods
    public func copy(with zone: NSZone? = nil) -> Any {
        let newUrls = _urls
        let copy = DNSURL(with: newUrls)
        return copy
    }
    
    // Comparable protocol methods
    public static func < (lhs: DNSURL, rhs: DNSURL) -> Bool {
        return (lhs.asURL?.absoluteString ?? "") < (rhs.asURL?.absoluteString ?? "")
    }
}
