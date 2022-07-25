//
//  DNSDataTranslation+DNSURL.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import DNSCoreThreading
import Foundation
#if !os(macOS)
import UIKit
#endif

public extension DNSDataTranslation {
    // MARK: - dnsstring...
    // swiftlint:disable:next cyclomatic_complexity
    func dnsurl(from any: Any?) -> DNSURL? {
        guard let any = any else { return nil }
        if any is [DNSURL.Language: URL?] {
            return self.dnsurl(from: any as? [DNSURL.Language: URL?])
        } else if any is [String: URL?] {
            return self.dnsurl(from: any as? [String: URL?])
        } else if any is [DNSURL.Language: String] {
            return self.dnsurl(from: any as? [DNSURL.Language: String])
        } else if any is [String: String] {
            return self.dnsurl(from: any as? [String: String])
        } else if any is String {
            return self.dnsurl(from: any as? String)
        }
        return self.dnsurl(from: any as? URL)
    }
    func dnsurl(from dictionary: [DNSURL.Language: URL?]?) -> DNSURL? {
        guard let dictionary = dictionary else { return nil }
        return DNSURL(with: dictionary)
    }
    func dnsurl(from dictionary: [String: URL?]?) -> DNSURL? {
        guard let dictionary = dictionary else { return nil }
        return DNSURL(with: dictionary)
    }
    func dnsurl(from dictionary: [DNSURL.Language: String]?) -> DNSURL? {
        guard let dictionary = dictionary else { return nil }
        return DNSURL(with: dictionary)
    }
    func dnsurl(from dictionary: [String: String]?) -> DNSURL? {
        guard let dictionary = dictionary else { return nil }
        return DNSURL(with: dictionary)
    }
    func dnsurl(from url: URL?) -> DNSURL? {
        guard let url = url else { return nil }
        return DNSURL(with: url)
    }
    func dnsurl(from string: String?) -> DNSURL? {
        guard let string = string else { return nil }
        return dnsurl(from: URL(string: string))
    }
}
