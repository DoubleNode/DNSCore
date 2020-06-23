//
//  DNSDataTranslation.swift
//  DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

public extension DNSDataTranslation {
    // MARK: - id...
    // swiftlint:disable:next cyclomatic_complexity
    func id(from any: Any?) -> String? {
        guard idEntryCount == 0 else {
            assertionFailure("DNSDataTranslation.id(from any) reentered!")
            return nil
        }
        idEntryCount += 1
        defer { idEntryCount -= 1 }
        guard any != nil else { return nil }

        if any as? Date != nil {
            return self.id(from: any as? Date)
        } else if any as? UIColor != nil {
            return self.id(from: any as? UIColor)
        } else if any as? URL != nil {
            return self.id(from: any as? URL)
        } else if any as? NSNumber != nil {
            return self.id(from: any as? NSNumber)
        } else if any as? Decimal != nil {
            return self.id(from: any as? Decimal)
        } else if any as? Double != nil {
            return self.id(from: any as? Double)
        } else if any as? UInt != nil {
            return self.id(from: any as? UInt)
        } else if any as? Int != nil {
            return self.id(from: any as? Int)
        } else if any as? Bool != nil {
            return self.id(from: any as? Bool)
        }

        return self.id(from: any as? String)
    }
    func id(from string: String?) -> String? {
        guard !(string?.isEmpty ?? true) else { return nil }

        return string
    }
}
