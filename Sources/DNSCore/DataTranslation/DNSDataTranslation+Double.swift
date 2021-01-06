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
    // MARK: - double...
    // swiftlint:disable:next cyclomatic_complexity
    func double(from any: Any?) -> Double? {
        guard any != nil else { return nil }
        let currentThread = Thread.current
        guard !(doubleEntryCounts[Thread.current] ?? false) else {
            let dnsError = DNSDataTranslationError.reentered(domain: "com.doublenode.\(type(of: self))",
                                                             file: DNSCore.shortenErrorPath("\(#file)"),
                                                             line: "\(#line)",
                                                             method: "\(#function)")
            DNSCore.reportError(dnsError.nsError)
            assertionFailure(dnsError.errorDescription!)
            return nil
        }
        doubleEntryCounts[Thread.current] = true
        dnsLog.debug("doubleEntryCounts.start = \(currentThread ?? "")")
        defer {
            dnsLog.debug("doubleEntryCounts.end = \(currentThread ?? "")")
            doubleEntryCounts.removeValue(forKey: currentThread)
        }

        if any as? Date != nil {
            return self.double(from: any as? Date)
        } else if any as? UIColor != nil {
            return self.double(from: any as? UIColor)
        } else if any as? URL != nil {
            return self.double(from: any as? URL)
        } else if any as? NSNumber != nil {
            return self.double(from: any as? NSNumber)
        } else if any as? Decimal != nil {
            return self.double(from: any as? Decimal)
        } else if any as? Double != nil {
            return self.double(from: any as? Double)
        } else if any as? Float != nil {
            return self.double(from: any as? Float)
        } else if any as? UInt != nil {
            return self.double(from: any as? UInt)
        } else if any as? Int != nil {
            return self.double(from: any as? Int)
        } else if any as? Bool != nil {
            return self.double(from: any as? Bool)
        }

        return self.double(from: any as? String, nil)
    }
    func double(from double: Double?) -> Double? {
        guard double != nil else { return 0 }

        return double
    }
    func double(from number: NSNumber?) -> Double? {
        guard number != nil else { return 0 }

        return number?.doubleValue
    }
    func double(from string: String?, _ numberFormatter: NumberFormatter?) -> Double? {
        guard !(string?.isEmpty ?? true) else { return nil }

        return self.number(from: string, numberFormatter)?.doubleValue
    }
}
