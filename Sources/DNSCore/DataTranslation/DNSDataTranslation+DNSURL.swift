//
//  DNSDataTranslation+DNSURL.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
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
        if any is [String: URL] {
            return self.dnsurl(from: any as? [String: URL])
        }
        return self.dnsurl(from: any as? URL)
    }
    func dnsurl(from dictionary: [String: URL]?) -> DNSURL? {
        guard let dictionary = dictionary else { return nil }
        return DNSURL(with: dictionary)
    }
    func dnsurl(from url: URL?) -> DNSURL? {
        guard let url = url else { return nil }
        return DNSURL(with: url)
    }
}
