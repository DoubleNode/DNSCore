//
//  DNSDataTranslation+UIFont.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

#if !os(macOS)
import DNSCoreThreading
import UIKit

public extension DNSDataTranslation {
    // MARK: - dnsuifont...
    // swiftlint:disable:next cyclomatic_complexity
    func dnsfont(from any: Any?) -> DNSUIFont? {
        guard any != nil else { return nil }
        if any is DNSUIFont {
            return self.dnsfont(from: any as? DNSUIFont)
        }
        return self.dnsfont(from: any as? DNSDataDictionary)
    }
    func dnsfont(from dnsfont: DNSUIFont?) -> DNSUIFont? {
        guard let dnsfont else { return nil }
        return dnsfont
    }
    func dnsfont(from dictionary: DNSDataDictionary?) -> DNSUIFont? {
        guard let dictionary else { return nil }
        return DNSUIFont.init(from: dictionary)
    }
}
#endif
