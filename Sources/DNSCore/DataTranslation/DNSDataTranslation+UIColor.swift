//
//  DNSDataTranslation+UIColor.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

#if !os(macOS)
import DNSCoreThreading
import UIKit

public extension DNSDataTranslation {
    // MARK: - color...
    // swiftlint:disable:next cyclomatic_complexity
    func color(from any: Any?) -> UIColor? {
        guard let any else { return nil }
        if any is UIColor {
            return self.color(from: any as? UIColor)
        } else if any is DNSDataDictionary {
            return self.color(from: any as? DNSDataDictionary)
        }
        return self.color(from: any as? String)
    }
    func color(from color: UIColor?) -> UIColor? {
        guard let color else { return nil }
        return color
    }
    func color(from dictionary: DNSDataDictionary?) -> UIColor? {
        guard let dictionary else { return nil }
        return UIColor(from: dictionary)
    }
    func color(from string: String?) -> UIColor? {
        guard let string else { return nil }
        return UIColor(with: string)
    }
}
#endif
