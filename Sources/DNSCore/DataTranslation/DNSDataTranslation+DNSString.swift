//
//  DNSDataTranslation+DNSString.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import DNSCoreThreading
import UIKit

public extension DNSDataTranslation {
    // MARK: - dnsstring...
    // swiftlint:disable:next cyclomatic_complexity
    func dnsstring(from any: Any?) -> DNSString? {
        guard any != nil else { return nil }
        if any is [String: String] {
            return self.dnsstring(from: any as? [String: String])
        }
        return self.dnsstring(from: any as? String)
    }
    func dnsstring(from dictionary: [String: String]?) -> DNSString? {
        guard let dictionary = dictionary else { return nil }
        return DNSString(with: dictionary)
    }
    func dnsstring(from string: String?) -> DNSString? {
        guard let string = string else { return nil }
        return DNSString(with: string)
    }
}
