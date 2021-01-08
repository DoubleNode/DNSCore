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
    // MARK: - time...
    // swiftlint:disable:next cyclomatic_complexity
    func time(from any: Any?) -> Date? {
        guard any != nil else { return nil }
        let currentThread = Thread.current
        guard !(timeEntryCounts[Thread.current] ?? false) else {
            let dnsError = DNSDataTranslationError.reentered(domain: "com.doublenode.\(type(of: self))",
                                                             file: DNSCore.shortenErrorPath("\(#file)"),
                                                             line: "\(#line)",
                                                             method: "\(#function)")
            DNSCore.reportError(dnsError.nsError)
            assertionFailure(dnsError.errorDescription!)
            return nil
        }
        timeEntryCounts[Thread.current] = true
#if DEBUG
        dnsLog.debug("timeEntryCounts.start = \(currentThread)")
#endif
        defer {
#if DEBUG
            dnsLog.debug("timeEntryCounts.end = \(currentThread)")
#endif
            timeEntryCounts.removeValue(forKey: currentThread)
        }

        if any as? Date != nil {
            return self.time(from: any as? Date)
        } else if any as? UIColor != nil {
            return self.time(from: any as? UIColor)
        } else if any as? URL != nil {
            return self.time(from: any as? URL)
        } else if any as? NSNumber != nil {
            return self.time(from: any as? NSNumber)
        } else if any as? Decimal != nil {
            return self.time(from: any as? Decimal)
        } else if any as? Double != nil {
            return self.time(from: any as? Double)
        } else if any as? Float != nil {
            return self.time(from: any as? Float)
        } else if any as? UInt != nil {
            return self.time(from: any as? UInt)
        } else if any as? Int != nil {
            return self.time(from: any as? Int)
        } else if any as? Bool != nil {
            return self.time(from: any as? Bool)
        }

        return self.time(from: any as? String)
    }
    func time(from dictionary: [String: String]?) -> Date? {
        guard dictionary != nil else { return nil }

        let string = dictionary![firebaseDateDictionaryISOKey] ?? ""
        return self.time(from: string, DNSDataTranslation.firebaseTimeFormatterMilliseconds)
    }
    func time(from string: String?, _ timeFormatter: DateFormatter? = nil) -> Date? {
        guard string != nil else { return nil }

        if let number = self.number(from: string) {
            return self.date(fromTimeIntervalSince1970: number)
        }

        for formatter in DNSDataTranslation.defaultTimeFormatters {
            let retval = self.date(from: string, formatter)
            guard retval == nil else {  return retval   }
        }
        return nil
    }
    func time(from time: Date?) -> Date? {
        guard time != nil else { return nil }

        return time
    }
}
