//
//  DNSDataTranslation.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

public extension DNSDataTranslation {
    // MARK: - int...
    // swiftlint:disable:next cyclomatic_complexity
    func int(from any: Any?) -> Int? {
        guard intEntryCount == 0 else {
            assertionFailure("DNSDataTranslation.int(from any) reentered!")
            return nil
        }
        intEntryCount += 1
        defer { intEntryCount -= 1 }
        guard any != nil else { return nil }

        if any as? Date != nil {
            return self.int(from: any as? Date)
        } else if any as? UIColor != nil {
            return self.int(from: any as? UIColor)
        } else if any as? URL != nil {
            return self.int(from: any as? URL)
        } else if any as? NSNumber != nil {
            return self.int(from: any as? NSNumber)
        } else if any as? Decimal != nil {
            return self.int(from: any as? Decimal)
        } else if any as? Double != nil {
            return self.int(from: any as? Double)
        } else if any as? UInt != nil {
            return self.int(from: any as? UInt)
        } else if any as? Int != nil {
            return self.int(from: any as? Int)
        } else if any as? Bool != nil {
            return self.int(from: any as? Bool)
        }

        return self.int(from: any as? String, nil)
    }
    func int(from int: Int?) -> Int? {
        guard int != nil else { return 0 }

        return int
    }
    func int(from number: NSNumber?) -> Int? {
        guard number != nil else { return 0 }

        return number?.intValue
    }
    func int(from string: String?, _ numberFormatter: NumberFormatter?) -> Int? {
        guard !(string?.isEmpty ?? true) else { return nil }

        return self.number(from: string, numberFormatter)?.intValue
    }
}
