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
    // MARK: - decimal...
    // swiftlint:disable:next cyclomatic_complexity
    func decimal(from any: Any?) -> Decimal? {
        guard any != nil else { return nil }
        let currentThread = Thread.current
        guard !(decimalEntryCounts[Thread.current] ?? false) else {
            let dnsError = DNSDataTranslationError.reentered(domain: "com.doublenode.\(type(of: self))",
                                                             file: DNSCore.shortenErrorPath("\(#file)"),
                                                             line: "\(#line)",
                                                             method: "\(#function)")
            DNSCore.reportError(dnsError.nsError)
            assertionFailure(dnsError.errorDescription!)
            return nil
        }
#if DEBUG
        dnsLog.debug("decimalEntryCounts.start = \(currentThread)")
#endif
        decimalEntryCounts[Thread.current] = true
        defer {
            decimalEntryCounts.removeValue(forKey: currentThread)
#if DEBUG
            dnsLog.debug("decimalEntryCounts.end = \(currentThread)")
#endif
        }

        if any as? Date != nil {
            return self.decimal(from: any as? Date)
        } else if any as? UIColor != nil {
            return self.decimal(from: any as? UIColor)
        } else if any as? URL != nil {
            return self.decimal(from: any as? URL)
        } else if any as? NSNumber != nil {
            return self.decimal(from: any as? NSNumber)
        } else if any as? Decimal != nil {
            return self.decimal(from: any as? Decimal)
        } else if any as? Double != nil {
            return self.decimal(from: any as? Double)
        } else if any as? Float != nil {
            return self.decimal(from: any as? Float)
        } else if any as? UInt != nil {
            return self.decimal(from: any as? UInt)
        } else if any as? Int != nil {
            return self.decimal(from: any as? Int)
        } else if any as? Bool != nil {
            return self.decimal(from: any as? Bool)
        }

        return self.decimal(from: any as? String, nil)
    }
    func decimal(from decimal: Decimal?) -> Decimal? {
        guard decimal != nil else { return Decimal(0) }

        return decimal
    }
    func decimal(from number: NSNumber?) -> Decimal? {
        guard number != nil else { return Decimal(0) }

        return number?.decimalValue
    }
    func decimal(from string: String?, _ decimalFormatter: NumberFormatter?) -> Decimal? {
        guard !(string?.isEmpty ?? true) else { return Decimal(0) }

        let formatter = decimalFormatter ?? DNSDataTranslation.defaultNumberFormatter
        return decimal(from: formatter.number(from: string!))
    }
}
