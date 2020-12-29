//
//  DNSDataTranslation.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

public extension DNSDataTranslation {
    // MARK: - string...
    // swiftlint:disable:next cyclomatic_complexity
    func string(from any: Any?) -> String? {
        guard any != nil else { return nil }
        guard !(stringEntryCounts[Thread.current] ?? false) else {
            assertionFailure("DNSDataTranslation.string(from any) reentered!")
            return nil
        }
        stringEntryCounts[Thread.current] = true
        defer { stringEntryCounts.removeValue(forKey: Thread.current) }

        if any as? Date != nil {
            return self.string(from: any as? Date)
        } else if any as? UIColor != nil {
            return self.string(from: any as? UIColor)
        } else if any as? URL != nil {
            return self.string(from: any as? URL)
        } else if any as? [Any] != nil {
            return self.string(from: any as? [Any])
        } else if any as? [String: Any] != nil {
            return self.string(from: any as? [String: Any])
        } else if any as? NSNumber != nil {
            return self.string(from: any as? NSNumber)
        } else if any as? Decimal != nil {
            return self.string(from: any as? Decimal)
        } else if any as? Double != nil {
            return self.string(from: any as? Double)
        } else if any as? Float != nil {
            return self.string(from: any as? Float)
        } else if any as? UInt != nil {
            return self.string(from: any as? UInt)
        } else if any as? Int != nil {
            return self.string(from: any as? Int)
        } else if any as? Bool != nil {
            return self.string(from: any as? Bool)
        }

        return self.string(from: any as? String)
    }
    func string(from number: NSNumber?) -> String? {
        guard number != nil else { return nil }

        return number!.stringValue
    }
    func string(from array: [Any]?) -> String? {
        guard array != nil else { return nil }

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: array!,
                                                      options: [.withoutEscapingSlashes])
            return String.init(data: jsonData, encoding: String.Encoding.utf8)
        } catch {
            return ""
        }
    }
    func string(from dictionary: [String: Any]?) -> String? {
        guard dictionary != nil else { return nil }

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary!,
                                                      options: [.withoutEscapingSlashes])
            return String.init(data: jsonData, encoding: String.Encoding.utf8)
        } catch {
            return ""
        }
    }
    func string(fromFirebaseDate date: Date?) -> String? {
        guard date != nil else { return nil }

        return DNSDataTranslation.firebaseDateFormatter.string(from: date!)
    }
    func string(fromFirebaseTime time: Date?) -> String? {
        guard time != nil else { return nil }

        return DNSDataTranslation.firebaseTimeFormatterMilliseconds.string(from: time!)
    }
    func string(from localTime: Date?, _ timezone: Bool = false) -> String? {
        guard localTime != nil else { return nil }

        if timezone {
            return DNSDataTranslation.localTimeFormatterMilliseconds.string(from: localTime!)
        } else {
            return DNSDataTranslation.localTimeFormatterWithoutTimezone.string(from: localTime!)
        }
    }
    func string(from string: String?) -> String? {
        guard string != nil else { return nil }

        return string!
    }
}
