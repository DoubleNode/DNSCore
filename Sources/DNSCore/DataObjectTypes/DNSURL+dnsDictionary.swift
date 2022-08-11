//
//  DNSURL+dnsDictionary.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation
import LocalAuthentication
#if !os(macOS)
import UIKit
#endif

public extension DNSURL {
    convenience init(from data: [DNSURL.Language: URL?]) {
        self.init()
        data.keys.forEach { _urls[$0.rawValue] = data[$0] }
    }
    convenience init(from data: DNSDataDictionary) {
        self.init()
        data.keys.forEach { _urls[$0] = Self.xlt.url(from: data[$0] as Any?) }
    }
    convenience init(from data: [DNSURL.Language: String]) {
        self.init()
        data.keys.forEach { _urls[$0.rawValue] = URL(string: data[$0] ?? "") }
    }
    var asDictionary: [String: URL?] {
        return _urls
    }
    var asJsonDictionary: [String: Any?] {
        var jsonDictionary: DNSDataDictionary = [:]
        _urls.forEach { (language, url) in
            jsonDictionary[language] = url?.absoluteString ?? ""
        }
        return jsonDictionary
    }
}
