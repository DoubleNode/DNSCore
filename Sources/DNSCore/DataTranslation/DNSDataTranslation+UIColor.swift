//
//  DNSDataTranslation.swift
//  DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

public extension DNSDataTranslation {
    // MARK: - color...
    // swiftlint:disable:next cyclomatic_complexity
    func color(from any: Any?) -> UIColor? {
        guard colorEntryCount == 0 else {
            assertionFailure("DNSDataTranslation.color(from any) reentered!")
            return nil
        }
        colorEntryCount += 1
        defer { colorEntryCount -= 1 }
        guard any != nil else { return nil }

        if any as? Date != nil {
            return self.color(from: any as? Date)
        } else if any as? UIColor != nil {
            return self.color(from: any as? UIColor)
        } else if any as? URL != nil {
            return self.color(from: any as? URL)
        } else if any as? NSNumber != nil {
            return self.color(from: any as? NSNumber)
        } else if any as? Decimal != nil {
            return self.color(from: any as? Decimal)
        } else if any as? Double != nil {
            return self.color(from: any as? Double)
        } else if any as? UInt != nil {
            return self.color(from: any as? UInt)
        } else if any as? Int != nil {
            return self.color(from: any as? Int)
        } else if any as? Bool != nil {
            return self.color(from: any as? Bool)
        }

        return self.color(from: any as? String)
    }
    func color(from color: UIColor?) -> UIColor? {
        guard color != nil else { return nil }

        return color
    }
    func color(from string: String?) -> UIColor? {
        guard !(string?.isEmpty ?? true) else { return nil }

        return UIColor.init(with: string!)
    }
}
