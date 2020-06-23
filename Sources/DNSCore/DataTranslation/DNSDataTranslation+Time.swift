//
//  DNSDataTranslation.swift
//  DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

public extension DNSDataTranslation {
    // MARK: - time...
    // swiftlint:disable:next cyclomatic_complexity
    func time(from any: Any?) -> Date? {
        guard timeEntryCount == 0 else {
            assertionFailure("DNSDataTranslation.time(from any) reentered!")
            return nil
        }
        timeEntryCount += 1
        defer { timeEntryCount -= 1 }

        guard any != nil else { return nil }

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

        for formatter in [ DNSDataTranslation.firebaseTimeFormatterMilliseconds,
                           DNSDataTranslation.firebaseTimeFormatter,
                           DNSDataTranslation.defaultDateFormatter1,
                           DNSDataTranslation.defaultDateFormatter2,
                           DNSDataTranslation.localTimeFormatterWithoutTimezone,
                           ] {
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
