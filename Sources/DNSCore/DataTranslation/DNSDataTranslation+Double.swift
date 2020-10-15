//
//  DNSDataTranslation.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

public extension DNSDataTranslation {
    // MARK: - double...
    // swiftlint:disable:next cyclomatic_complexity
    func double(from any: Any?) -> Double? {
        guard doubleEntryCount == 0 else {
            assertionFailure("DNSDataTranslation.double(from any) reentered!")
            return nil
        }
        doubleEntryCount += 1
        defer { doubleEntryCount -= 1 }
        guard any != nil else { return nil }

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
