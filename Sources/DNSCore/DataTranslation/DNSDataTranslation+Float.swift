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
    // MARK: - float...
    // swiftlint:disable:next cyclomatic_complexity
    func float(from any: Any?) -> Float? {
        guard any != nil else { return nil }
        let currentThread = Thread.current
        guard !(floatEntryCounts[Thread.current] ?? false) else {
            let dnsError = DNSDataTranslationError.reentered(domain: "com.doublenode.\(type(of: self))",
                                                             file: DNSCore.shortenErrorPath("\(#file)"),
                                                             line: "\(#line)",
                                                             method: "\(#function)")
            DNSCore.reportError(dnsError.nsError)
            assertionFailure(dnsError.errorDescription!)
            return nil
        }
        floatEntryCounts[Thread.current] = true
        dnsLog.debug("floatEntryCounts.start = \(currentThread ?? "")")
        defer {
            dnsLog.debug("floatEntryCounts.end = \(currentThread ?? "")")
            floatEntryCounts.removeValue(forKey: currentThread)
        }

        if any as? Date != nil {
            return self.float(from: any as? Date)
        } else if any as? UIColor != nil {
            return self.float(from: any as? UIColor)
        } else if any as? URL != nil {
            return self.float(from: any as? URL)
        } else if any as? NSNumber != nil {
            return self.float(from: any as? NSNumber)
        } else if any as? Decimal != nil {
            return self.float(from: any as? Decimal)
        } else if any as? Double != nil {
            return self.float(from: any as? Double)
        } else if any as? Float != nil {
            return self.float(from: any as? Float)
        } else if any as? UInt != nil {
            return self.float(from: any as? UInt)
        } else if any as? Int != nil {
            return self.float(from: any as? Int)
        } else if any as? Bool != nil {
            return self.float(from: any as? Bool)
        }

        return self.float(from: any as? String, nil)
    }
    func float(from float: Float?) -> Float? {
        guard float != nil else { return 0 }

        return float
    }
    func float(from number: NSNumber?) -> Float? {
        guard number != nil else { return 0 }

        return number?.floatValue
    }
    func float(from string: String?, _ numberFormatter: NumberFormatter?) -> Float? {
        guard !(string?.isEmpty ?? true) else { return nil }

        return self.number(from: string, numberFormatter)?.floatValue
    }
}
