//
//  DNSDataTranslation.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

public extension DNSDataTranslation {
    // MARK: - date...
    // swiftlint:disable:next cyclomatic_complexity
    func date(from any: Any?) -> Date? {
        guard dateEntryCount == 0 else {
            assertionFailure("DNSDataTranslation.date(from any) reentered!")
            return nil
        }
        dateEntryCount += 1
        defer { dateEntryCount -= 1 }
        guard any != nil else { return nil }

        if any as? Date != nil {
            return self.date(from: any as? Date)
        } else if any as? UIColor != nil {
            return self.date(from: any as? UIColor)
        } else if any as? URL != nil {
            return self.date(from: any as? URL)
        } else if any as? NSNumber != nil {
            return self.date(from: any as? NSNumber)
        } else if any as? Decimal != nil {
            return self.date(from: any as? Decimal)
        } else if any as? Double != nil {
            return self.date(from: any as? Double)
        } else if any as? UInt != nil {
            return self.date(from: any as? UInt)
        } else if any as? Int != nil {
            return self.date(from: any as? Int)
        } else if any as? Bool != nil {
            return self.date(from: any as? Bool)
        }

        return self.date(from: any as? String, nil)
    }
    func date(from date: Date?) -> Date? {
        guard date != nil else { return nil }

        return date
    }
    func date(from dictionary: [String: String]?) -> Date? {
        guard dictionary != nil else { return nil }

        let string = dictionary![firebaseDateDictionaryISOKey] ?? ""
        return self.date(from: string, DNSDataTranslation.firebaseDateFormatter)
    }
    func date(from number: NSNumber?) -> Date? {
        guard number != nil else { return nil }

        return Date.init(timeIntervalSinceReferenceDate: number!.doubleValue)
    }
    func date(fromTimeIntervalSince1970 number: NSNumber?) -> Date? {
        guard number != nil else { return nil }

        return Date.init(timeIntervalSince1970: number!.doubleValue)
    }
    func date(from string: String?, _ dateFormatter: DateFormatter?) -> Date? {
        guard !(string?.isEmpty ?? true) else { return nil }
        guard dateFormatter != nil else {
            return DNSDataTranslation.defaultDateFormatter1.date(from: string!)
                ?? (DNSDataTranslation.defaultDateFormatter2.date(from: string!)
                ?? DNSDataTranslation.defaultDateFormatter3.date(from: string!))
        }

        return dateFormatter!.date(from: string!)
    }
}
