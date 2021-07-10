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
    // MARK: - firebaseKeyFrom...
    // swiftlint:disable:next cyclomatic_complexity
    func firebaseKey(from any: Any?) -> String? {
        guard any != nil else { return nil }
        if any as? Date != nil {
            return self.firebaseKey(from: any as? Date)
        } else if any as? UIColor != nil {
            return self.firebaseKey(from: any as? UIColor)
        } else if any as? URL != nil {
            return self.firebaseKey(from: any as? URL)
        } else if any as? NSNumber != nil {
            return self.firebaseKey(from: any as? NSNumber)
        } else if any as? Decimal != nil {
            return self.firebaseKey(from: any as? Decimal)
        } else if any as? Double != nil {
            return self.firebaseKey(from: any as? Double)
        } else if any as? Float != nil {
            return self.firebaseKey(from: any as? Float)
        } else if any as? UInt != nil {
            return self.firebaseKey(from: any as? UInt)
        } else if any as? Int != nil {
            return self.firebaseKey(from: any as? Int)
        } else if any as? Bool != nil {
            return self.firebaseKey(from: any as? Bool)
        }

        return self.firebaseKey(from: any as? String)
    }
    func firebaseKey(from string: String?) -> String? {
        guard !(string?.isEmpty ?? true) else { return nil }

        return string!.components(separatedBy: firebaseKeyInvalidCharacterSet).joined(separator: "_")
    }
}
