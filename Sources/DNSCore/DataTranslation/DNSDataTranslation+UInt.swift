//
//  DNSDataTranslation.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import DNSCoreThreading
import UIKit

public extension DNSDataTranslation {
    // MARK: - uint...
    // swiftlint:disable:next cyclomatic_complexity
    func uint(from any: Any?) -> UInt? {
        guard any != nil else { return nil }
        let currentThread = Thread.current
        guard !(uintEntryCounts[Thread.current] ?? false) else {
            let dnsError = DNSDataTranslationError.reentered(domain: "com.doublenode.\(type(of: self))",
                                                             file: DNSCore.shortenErrorPath("\(#file)"),
                                                             line: "\(#line)",
                                                             method: "\(#function)")
            DNSCore.reportError(dnsError.nsError)
            assertionFailure(dnsError.errorDescription!)
            return nil
        }
        uintEntryCounts[Thread.current] = true
        dnsLog.debug("uintEntryCounts.start = \(currentThread)")
        defer {
            dnsLog.debug("uintEntryCounts.end = \(currentThread)")
            uintEntryCounts.removeValue(forKey: currentThread)
        }

        if any as? Date != nil {
            return self.uint(from: any as? Date)
        } else if any as? UIColor != nil {
            return self.uint(from: any as? UIColor)
        } else if any as? URL != nil {
            return self.uint(from: any as? URL)
        } else if any as? UInt != nil {
            return self.uint(from: any as? UInt)
        } else if any as? Int != nil {
            return self.uint(from: any as? Int)
        } else if any as? NSNumber != nil {
            return self.uint(from: any as? NSNumber)
        } else if any as? Decimal != nil {
            return self.uint(from: any as? Decimal)
        } else if any as? Double != nil {
            return self.uint(from: any as? Double)
        } else if any as? Float != nil {
            return self.uint(from: any as? Float)
        } else if any as? Bool != nil {
            return self.uint(from: any as? Bool)
        }

        return self.uint(from: any as? String, nil)
    }
    func uint(from int: Int?) -> UInt? {
        guard int != nil else { return 0 }

        return UInt(abs(Int32(int!)))
    }
    func uint(from uint: UInt?) -> UInt? {
        guard uint != nil else { return 0 }

        return uint
    }
    func uint(from number: NSNumber?) -> UInt? {
        guard number != nil else { return 0 }

        return number?.uintValue
    }
    func uint(from string: String?, _ numberFormatter: NumberFormatter?) -> UInt? {
        guard !(string?.isEmpty ?? true) else { return 0 }

        return self.number(from: string, numberFormatter)?.uintValue
    }
}
