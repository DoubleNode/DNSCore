//
//  DNSDataTranslation+Time.swift
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
    // MARK: - time...
    func time<K>(from container: KeyedDecodingContainer<K>,
                 forKey key: KeyedDecodingContainer<K>.Key) -> Date? where K: CodingKey {
        do { return time(from: try container.decodeIfPresent(Date.self, forKey: key)) } catch { }
        do { return time(from: try container.decodeIfPresent(URL.self, forKey: key)) } catch { }
        do { return time(from: try container.decodeIfPresent(Decimal.self, forKey: key)) } catch { }
        do { return time(from: try container.decodeIfPresent(Double.self, forKey: key)) } catch { }
        do { return time(from: try container.decodeIfPresent(Float.self, forKey: key)) } catch { }
        do { return time(from: try container.decodeIfPresent(UInt.self, forKey: key)) } catch { }
        do { return time(from: try container.decodeIfPresent(Int.self, forKey: key)) } catch { }
        do { return time(from: try container.decodeIfPresent(Bool.self, forKey: key)) } catch { }
        do { return time(from: try container.decodeIfPresent([String: String].self, forKey: key)) } catch { }
        do { return time(from: try container.decodeIfPresent([String: Int].self, forKey: key)) } catch { }
        do { return time(from: try container.decodeIfPresent(String.self, forKey: key)) } catch { }
        return nil
    }
    // swiftlint:disable:next cyclomatic_complexity
    func time(from any: Any?) -> Date? {
        guard let any else { return nil }
#if !os(macOS)
        if any is UIColor {
            return self.time(from: any as? UIColor)
        }
#endif
        if any is Date {
            return self.time(from: any as? Date)
        } else if any is URL {
            return self.time(from: any as? URL)
        } else if any is NSNumber {
            return self.time(from: any as? NSNumber)
        } else if any is Decimal {
            return self.time(from: any as? Decimal)
        } else if any is Double {
            return self.time(from: any as? Double)
        } else if any is Float {
            return self.time(from: any as? Float)
        } else if any is UInt {
            return self.time(from: any as? UInt)
        } else if any is Int {
            return self.time(from: any as? Int)
        } else if any is Bool {
            return self.time(from: any as? Bool)
        } else if any is [String: String] {
            return self.time(from: any as? [String: String])
        } else if any is [String: Int] {
            return self.time(from: any as? [String: Int])
        }
        return self.time(from: any as? String)
    }
    func time(from dictionary: [String: Int]?) -> Date? {
        guard let dictionary else { return nil }
        let number = dictionary[firebaseTimestampDictionarySecondsKey]
        guard let number = self.number(from: number) else { return nil }
        return self.date(fromTimeIntervalSince1970: number)
    }
    func time(from dictionary: [String: String]?) -> Date? {
        guard let dictionary else { return nil }
        let string = dictionary[firebaseDateDictionaryISOKey] ?? ""
        return self.time(from: string, DNSDataTranslation.firebaseTimeFormatterMilliseconds)
    }
    func time(from number: NSNumber?) -> Date? {
        guard let number = self.number(from: number) else { return nil }
        return self.date(fromTimeIntervalSince1970: number)
    }
    func time(from string: String?, _ timeFormatter: DateFormatter? = nil) -> Date? {
        guard let string else { return nil }
        guard !string.isEmpty else { return nil }
        guard let timeFormatter = timeFormatter else {
            for formatter in DNSDataTranslation.defaultTimeFormatters {
                if let retval = self.date(from: string, formatter) {
                    return retval
                }
            }
            if let number = self.number(from: string) {
                return self.date(fromTimeIntervalSince1970: number)
            }
            return nil
        }
        return timeFormatter.date(from: string)
    }
    func time(from time: Date?) -> Date? {
        guard let time else { return nil }
        return time
    }
}
