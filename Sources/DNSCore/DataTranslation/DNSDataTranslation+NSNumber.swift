//
//  DNSDataTranslation.swift
//  DNSCore
//
//  Created by Darren Ehlers on 8/14/19.
//  Copyright © 2019 DoubleNode.com. All rights reserved.
//

import UIKit

public extension DNSDataTranslation {
    // MARK: - number...
    // swiftlint:disable:next cyclomatic_complexity
    func number(from any: Any?) -> NSNumber? {
        guard numberEntryCount == 0 else {
            assertionFailure("DNSDataTranslation.number(from any) reentered!")
            return nil
        }
        numberEntryCount += 1
        defer { numberEntryCount -= 1 }
        guard any != nil else { return nil }

        if any as? Date != nil {
            return self.number(from: any as? Date)
        } else if any as? UIColor != nil {
            return self.number(from: any as? UIColor)
        } else if any as? URL != nil {
            return self.number(from: any as? URL)
        } else if any as? NSNumber != nil {
            return self.number(from: any as? NSNumber)
        } else if any as? Decimal != nil {
            return self.number(from: any as? Decimal)
        } else if any as? Double != nil {
            return self.number(from: any as? Double)
        } else if any as? UInt != nil {
            return self.number(from: any as? UInt)
        } else if any as? Int != nil {
            return self.number(from: any as? Int)
        } else if any as? Bool != nil {
            return self.number(from: any as? Bool)
        }

        return self.number(from: any as? String)
    }
    func number(from number: NSNumber?) -> NSNumber? {
        guard number != nil else { return nil }

        return number
    }
    func number(from string: String?, _ numberFormatter: NumberFormatter? = nil) -> NSNumber? {
        guard !(string?.isEmpty ?? true) else { return nil }

        let formatter = numberFormatter ?? DNSDataTranslation.defaultNumberFormatter
        return formatter.number(from: string!)
    }
}