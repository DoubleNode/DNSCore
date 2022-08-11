//
//  DNSDataTranslation+UIColor.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

#if !os(macOS)
import DNSCoreThreading
import UIKit

public extension DNSDataTranslation {
    // MARK: - dnsuicolor...
    // swiftlint:disable:next cyclomatic_complexity
    func dnscolor(from any: Any?) -> DNSUIColor? {
        guard any != nil else { return nil }
        if any is DNSUIColor {
            return self.dnscolor(from: any as? DNSUIColor)
        }
        return self.dnscolor(from: any as? DNSDataDictionary)
    }
    func dnscolor(from dnscolor: DNSUIColor?) -> DNSUIColor? {
        guard let dnscolor else { return nil }
        return dnscolor
    }
    func dnscolor(from dictionary: DNSDataDictionary?) -> DNSUIColor? {
        guard let dictionary else { return nil }
        return DNSUIColor.init(from: dictionary)
    }
}
#endif
