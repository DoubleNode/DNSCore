//
//  DNSDataTranslation+DNSUIEnabled.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

#if !os(macOS)
import DNSCoreThreading
import UIKit

public extension DNSDataTranslation {
    // MARK: - color...
    // swiftlint:disable:next cyclomatic_complexity
    func dnsenabled(from any: Any?) -> DNSUIEnabled? {
        guard let any else { return nil }
        if any is DNSUIEnabled {
            return self.dnsenabled(from: any as? DNSUIEnabled)
        }
        return self.dnsenabled(from: any as? DNSDataDictionary)
    }
    func dnsenabled(from dnsenabled: DNSUIEnabled?) -> DNSUIEnabled? {
        guard let dnsenabled else { return nil }
        return dnsenabled
    }
    func dnsenabled(from dictionary: DNSDataDictionary?) -> DNSUIEnabled? {
        guard let dictionary else { return nil }
        return DNSUIEnabled.init(from: dictionary)
    }
    func dnsenabled(from string: String?) -> DNSUIEnabled? {
        guard let string else { return nil }
        return DNSUIEnabled.init(with: string)
    }
}
#endif
