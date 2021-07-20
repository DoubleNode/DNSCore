//
//  DNSDataTranslation.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import DNSCoreThreading
import UIKit

public extension DNSDataTranslation {
    // MARK: - color...
    // swiftlint:disable:next cyclomatic_complexity
    func color(from any: Any?) -> UIColor? {
        guard any != nil else { return nil }
        if any is Date {
            return self.color(from: any as? Date)
        } else if any is UIColor {
            return self.color(from: any as? UIColor)
        } else if any is URL {
            return self.color(from: any as? URL)
        } else if any is NSNumber {
            return self.color(from: any as? NSNumber)
        } else if any is Decimal {
            return self.color(from: any as? Decimal)
        } else if any is Double {
            return self.color(from: any as? Double)
        } else if any is Float {
            return self.color(from: any as? Float)
        } else if any is UInt {
            return self.color(from: any as? UInt)
        } else if any is Int {
            return self.color(from: any as? Int)
        } else if any is Bool {
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
