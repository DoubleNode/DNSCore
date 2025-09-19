//
//  DNSDataTranslation+UIFont.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

#if canImport(UIKit)
import DNSCoreThreading
#if canImport(UIKit)
import UIKit
#endif

public extension DNSDataTranslation {
    // MARK: - font...
    func font(from any: Any?) -> UIFont? {
        guard let any else { return nil }
        if any is UIFont {
            return self.font(from: any as? UIColor)
        } else if any is DNSDataDictionary {
            return self.font(from: any as? DNSDataDictionary)
        }
        return self.font(from: any as? String)
    }
    func font(from font: UIFont?) -> UIFont? {
        guard let font else { return nil }
        return font
    }
    func font(from dictionary: DNSDataDictionary?) -> UIFont? {
        guard let dictionary else { return nil }
        return UIFont(from: dictionary)
    }
    func font(from string: String?) -> UIFont? {
        guard let string else { return nil }
        return UIFont(with: string)
    }
}
#endif
