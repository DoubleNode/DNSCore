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

    private var _urls: [String: URL]

    public var asDictionary: [String: URL] {
        return _urls
    }
    public var asURL: URL {
        self.asURL(for: DNSCore.languageCode)
    }
    public func asURL(for language: DNSString.Language) -> URL {
        self.asURL(for: language.rawValue)
    }
    public func asURL(for languageStr: String) -> URL {
        _urls[languageStr] ?? (_urls[fallbackLanguage.rawValue] ?? URL(string: "https://")!)
    }
    public init() {
        _urls = [:]
    }
    public init(with urls: [DNSURL.Language: URL]) {
        var newURLs: [String: URL] = [:]
        urls.keys.forEach { newURLs[$0.rawValue] = urls[$0] }
        _urls = newURLs
    }
    public init(with urls: [String: URL]) {
        _urls = urls
    }
    public init(with url: URL) {
        var newURLs: [String: URL] = [:]
        newURLs[fallbackLanguage.rawValue] = url
        _urls = newURLs
    }
    @discardableResult
    public func replace(for languageStr: String,
                        with url: URL) -> DNSURL {
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
        _urls[Language.en.rawValue] = try container.decode(URL.self, forKey: .en)
        _urls[Language.es419.rawValue] = try container.decode(URL.self, forKey: .es419)
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(_urls[Language.en.rawValue] ?? URL(string: "https://")!, forKey: .en)
        try container.encode(_urls[Language.es419.rawValue] ?? URL(string: "https://")!, forKey: .es419)
    }

    @inlinable public var isEmpty: Bool {
        return asURL.absoluteString.isEmpty
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
        let copy = DNSURL(with: _urls)
        return copy
    }
    
    // Comparable protocol methods
    public static func < (lhs: DNSURL, rhs: DNSURL) -> Bool {
        return lhs.asURL.absoluteString < rhs.asURL.absoluteString
    }
}
