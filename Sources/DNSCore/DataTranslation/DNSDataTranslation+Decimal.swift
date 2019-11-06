//
//  DNSDataTranslation.swift
//  DNSCore
//
//  Created by Darren Ehlers on 8/14/19.
//  Copyright © 2019 DoubleNode.com. All rights reserved.
//

import UIKit

public extension DNSDataTranslation {
    // MARK: - decimal...
    // swiftlint:disable:next cyclomatic_complexity
    func decimal(from any: Any?) -> Decimal? {
        guard decimalEntryCount == 0 else {
            assertionFailure("DNSDataTranslation.decimal(from any) reentered!")
            return nil
        }
        decimalEntryCount += 1
        defer { decimalEntryCount -= 1 }
        guard any != nil else { return nil }

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