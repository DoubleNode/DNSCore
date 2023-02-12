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
    func timeOfDay<K>(from container: KeyedDecodingContainer<K>,
                      forKey key: KeyedDecodingContainer<K>.Key) -> DNSTimeOfDay? where K: CodingKey {
        do { return timeOfDay(from: try container.decodeIfPresent(DNSTimeOfDay.self, forKey: key)) } catch { }
        do { return timeOfDay(from: try container.decodeIfPresent(Date.self, forKey: key)) } catch { }
        do { return timeOfDay(from: try container.decodeIfPresent(Decimal.self, forKey: key)) } catch { }
        do { return timeOfDay(from: try container.decodeIfPresent(Double.self, forKey: key)) } catch { }
        do { return timeOfDay(from: try container.decodeIfPresent(Float.self, forKey: key)) } catch { }
        do { return timeOfDay(from: try container.decodeIfPresent(UInt.self, forKey: key)) } catch { }
        do { return timeOfDay(from: try container.decodeIfPresent(Int.self, forKey: key)) } catch { }
        do { return timeOfDay(from: try container.decodeIfPresent(Bool.self, forKey: key)) } catch { }
        do { return timeOfDay(from: try container.decodeIfPresent(String.self, forKey: key)) } catch { }
        return nil
    }
    // swiftlint:disable:next cyclomatic_complexity
    func timeOfDay(from any: Any?) -> DNSTimeOfDay? {
        guard let any else { return nil }
#if !os(macOS)
        if any is UIColor {
            return self.timeOfDay(from: any as? UIColor)
        }
#endif
        if any is Date {
            return self.timeOfDay(from: any as? Date)
        } else if any is DNSTimeOfDay {
            return self.timeOfDay(from: any as? DNSTimeOfDay)
        } else if any is NSNumber {
            return self.timeOfDay(from: any as? NSNumber)
        } else if any is Decimal {
            return self.timeOfDay(from: any as? Decimal)
        } else if any is Double {
            return self.timeOfDay(from: any as? Double)
        } else if any is Float {
            return self.timeOfDay(from: any as? Float)
        } else if any is UInt {
            return self.timeOfDay(from: any as? UInt)
        } else if any is Int {
            return self.timeOfDay(from: any as? Int)
        } else if any is Bool {
            return self.timeOfDay(from: any as? Bool)
        }
        return self.timeOfDay(from: any as? String)
    }
    func timeOfDay(from date: Date?) -> DNSTimeOfDay? {
        guard let date else { return DNSTimeOfDay() }
        return DNSTimeOfDay(hour: date.dnsHour, minute: date.dnsMinute)
    }
    func timeOfDay(from timeOfDay: DNSTimeOfDay?) -> DNSTimeOfDay? {
        guard let timeOfDay else { return DNSTimeOfDay() }
        return timeOfDay
    }
    func timeOfDay(from number: NSNumber?) -> DNSTimeOfDay? {
        guard let number else { return DNSTimeOfDay() }
        return DNSTimeOfDay(timeValue: number.floatValue)
    }
    func timeOfDay(from string: String?) -> DNSTimeOfDay? {
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
        return DNSTimeOfDay(hour: hourValue, minute: minuteValue)
    }
}
