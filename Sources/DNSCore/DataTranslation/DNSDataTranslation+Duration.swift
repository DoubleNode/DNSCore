//
//  DNSDataTranslation+TimeOfDay.swift
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
    // MARK: - timeOfDay...
    func duration<K>(from container: KeyedDecodingContainer<K>,
                     forKey key: KeyedDecodingContainer<K>.Key) -> DNSDuration? where K: CodingKey {
        do { return duration(from: try container.decodeIfPresent(DNSDuration.self, forKey: key)) } catch { }
        do { return duration(from: try container.decodeIfPresent(Date.self, forKey: key)) } catch { }
        do { return duration(from: try container.decodeIfPresent(Decimal.self, forKey: key)) } catch { }
        do { return duration(from: try container.decodeIfPresent(Double.self, forKey: key)) } catch { }
        do { return duration(from: try container.decodeIfPresent(Float.self, forKey: key)) } catch { }
        do { return duration(from: try container.decodeIfPresent(UInt.self, forKey: key)) } catch { }
        do { return duration(from: try container.decodeIfPresent(Int.self, forKey: key)) } catch { }
        do { return duration(from: try container.decodeIfPresent(Bool.self, forKey: key)) } catch { }
        do { return duration(from: try container.decodeIfPresent(String.self, forKey: key)) } catch { }
        return nil
    }
    // swiftlint:disable:next cyclomatic_complexity
    func duration(from any: Any?) -> DNSDuration? {
        guard let any else { return nil }
#if !os(macOS)
        if any is UIColor {
            return self.duration(from: any as? UIColor)
        }
#endif
        if any is Date {
            return self.duration(from: any as? Date)
        } else if any is DNSDuration {
            return self.duration(from: any as? DNSDuration)
        } else if any is NSNumber {
            return self.duration(from: any as? NSNumber)
        } else if any is Decimal {
            return self.duration(from: any as? Decimal)
        } else if any is Double {
            return self.duration(from: any as? Double)
        } else if any is Float {
            return self.duration(from: any as? Float)
        } else if any is UInt {
            return self.duration(from: any as? UInt)
        } else if any is Int {
            return self.duration(from: any as? Int)
        } else if any is Bool {
            return self.duration(from: any as? Bool)
        }
        return self.duration(from: any as? String)
    }
    func duration(from date: Date?) -> DNSDuration? {
        guard let date else { return DNSDuration() }
        return DNSDuration(hour: date.dnsHour, minute: date.dnsMinute)
    }
    func duration(from duration: DNSDuration?) -> DNSDuration? {
        guard let duration else { return DNSDuration() }
        return duration
    }
    func duration(from number: NSNumber?) -> DNSDuration? {
        guard let number else { return DNSDuration() }
        return DNSDuration(timeValue: number.floatValue)
    }
    func duration(from string: String?) -> DNSDuration? {
        guard let string else { return nil }
        guard !string.isEmpty else { return nil }
        let strings = string.components(separatedBy: [":", " "])
        var hourValue = 0
        var minuteValue = 0
        hourValue = self.number(from: strings[0],
                                DNSDataTranslation.defaultNumberFormatter)?.intValue ?? 0
        if strings.count > 1 {
            minuteValue = self.number(from: strings[1],
                                      DNSDataTranslation.defaultNumberFormatter)?.intValue ?? 0
        }
        if strings.count > 2 {
            if strings[2].uppercased() == "PM" {
                hourValue += 12
            }
        }
        return DNSDuration(hour: hourValue, minute: minuteValue)
    }
}
