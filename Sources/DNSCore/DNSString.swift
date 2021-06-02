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
    private var _strings: [String: String] = [:]

    public var asString: String {
        _strings[DNSCore.languageCode] ?? ""
    }
    public func asString(for languageCode: String) -> String {
        _strings[DNSCore.languageCode] ?? ""
    }
    public init(with strings: [String: String]) {
        _strings = strings
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
        let container = try decoder.container(keyedBy: CodingKeys.self)
        _strings["en"] = try container.decode(String.self, forKey: .en)
        _strings["es-419"] = try container.decode(String.self, forKey: .es419)
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(_strings["en"], forKey: .en)
        try container.encode(_strings["es-419"], forKey: .es419)
    }
}
