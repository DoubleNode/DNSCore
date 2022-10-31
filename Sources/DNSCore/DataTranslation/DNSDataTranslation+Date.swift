//
//  DNSDataTranslation+Date.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import DNSCoreThreading
import Foundation
#if !os(macOS)
import UIKit
#endif

public extension DNSDataTranslation {
    // MARK: - date...
    func date<K>(from container: KeyedDecodingContainer<K>,
                 forKey key: KeyedDecodingContainer<K>.Key) -> Date? where K: CodingKey {
        do { return date(from: try container.decodeIfPresent(Date.self, forKey: key)) } catch { }
        do { return date(from: try container.decodeIfPresent(String.self, forKey: key)) } catch { }
        do { return date(from: try container.decodeIfPresent(Decimal.self, forKey: key)) } catch { }
        do { return date(from: try container.decodeIfPresent(Double.self, forKey: key)) } catch { }
        do { return date(from: try container.decodeIfPresent(Float.self, forKey: key)) } catch { }
        do { return date(from: try container.decodeIfPresent(UInt.self, forKey: key)) } catch { }
        do { return date(from: try container.decodeIfPresent(Int.self, forKey: key)) } catch { }
        return nil
    }
    // swiftlint:disable:next cyclomatic_complexity
    func date(from any: Any?) -> Date? {
        guard let any else { return nil }
#if !os(macOS)
        if any is UIColor {
            return self.date(from: any as? UIColor)
        }
#endif
        if any is Date {
            return self.date(from: any as? Date)
        } else if any is URL {
            return self.date(from: any as? URL)
        } else if any is NSNumber {
            return self.date(from: any as? NSNumber)
        } else if any is Decimal {
            return self.date(from: any as? Decimal)
        } else if any is Double {
            return self.date(from: any as? Double)
        } else if any is Float {
            return self.date(from: any as? Float)
        } else if any is UInt {
            return self.date(from: any as? UInt)
        } else if any is Int {
            return self.date(from: any as? Int)
        } else if any is Bool {
            return self.date(from: any as? Bool)
        }
        return self.date(from: any as? String, nil)
    }
    func date(from date: Date?) -> Date? {
        guard let date else { return nil }
        return date
    }
    func date(from dictionary: [String: String]?) -> Date? {
        guard let dictionary else { return nil }
        let string = dictionary[firebaseDateDictionaryISOKey] ?? ""
        return self.date(from: string, DNSDataTranslation.firebaseDateFormatter)
    }
    func date(from decimal: Decimal?) -> Date? {
        guard let decimal else { return nil }
        return Date.init(timeIntervalSinceReferenceDate: Double(truncating: decimal as NSNumber))
    }
    func date(from double: Double?) -> Date? {
        guard let double else { return nil }
        return Date.init(timeIntervalSinceReferenceDate: double)
    }
    func date(from float: Float?) -> Date? {
        guard let float else { return nil }
        return Date.init(timeIntervalSinceReferenceDate: Double(float))
    }
    func date(from uint: UInt?) -> Date? {
        guard let uint else { return nil }
        return Date.init(timeIntervalSinceReferenceDate: Double(uint))
    }
    func date(from int: Int?) -> Date? {
        guard let int else { return nil }
        return Date.init(timeIntervalSinceReferenceDate: Double(int))
    }
    func date(from number: NSNumber?) -> Date? {
        guard let number else { return nil }
        return Date.init(timeIntervalSinceReferenceDate: number.doubleValue)
    }
    func date(fromTimeIntervalSince1970 number: NSNumber?) -> Date? {
        guard let number else { return nil }
        return Date.init(timeIntervalSince1970: number.doubleValue)
    }
    func date(from string: String?, _ dateFormatter: DateFormatter?) -> Date? {
        guard let string else { return nil }
        guard !string.isEmpty else { return nil }
        guard let dateFormatter = dateFormatter else {
            for formatter in DNSDataTranslation.defaultDateFormatters {
                let retval = self.date(from: string, formatter)
                guard retval == nil else {  return retval   }
            }
            return nil
        }
        return dateFormatter.date(from: string)
    }
    func date(from url: URL?) -> Date? {
        guard let url else { return nil }
        return self.date(from: url.absoluteString, nil)
    }
}
