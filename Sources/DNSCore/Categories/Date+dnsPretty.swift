//
//  Date+dnsPretty.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public extension Date {
    struct Format {
        public enum Size {
            case short, normal, long, full
        }
        public enum Style {
            case simple, smart, pretty, military
        }

        public static let shortSimple: Format = Format(size: .short, style: .simple)
        public static let shortSmart: Format = Format(size: .short, style: .smart)
        public static let shortPretty: Format = Format(size: .short, style: .pretty)
        public static let shortMilitary: Format = Format(size: .short, style: .military)

        public static let normalSimple: Format = Format(size: .normal, style: .simple)
        public static let normalSmart: Format = Format(size: .normal, style: .smart)
        public static let normalPretty: Format = Format(size: .normal, style: .pretty)

        public static let longSimple: Format = Format(size: .long, style: .simple)
        public static let longSmart: Format = Format(size: .long, style: .smart)
        public static let longPretty: Format = Format(size: .long, style: .pretty)

        public static let fullSimple: Format = Format(size: .full, style: .simple)
        public static let fullSmart: Format = Format(size: .full, style: .smart)
        public static let fullPretty: Format = Format(size: .full, style: .pretty)

        let size: Size
        let style: Style

        public init(size: Size = .normal, style: Style = .smart) {
            self.size = size
            self.style = style
        }
    }

    enum Seconds {
        public static let deltaOneMinute = Double(60)
        public static let deltaTwoMinutes = Seconds.deltaOneMinute * 2
        public static let deltaThreeMinutes = Seconds.deltaOneMinute * 3
        public static let deltaSixMinutes = Seconds.deltaOneMinute * 6
        public static let deltaTenMinutes = Seconds.deltaOneMinute * 10
        public static let deltaFifteenMinutes = Seconds.deltaOneMinute * 15
        public static let deltaThirtyMinutes = Seconds.deltaOneMinute * 30
        public static let deltaFourtyFiveMinutes = Seconds.deltaOneMinute * 45
        public static let deltaOneHour = Seconds.deltaOneMinute * 60
        public static let deltaTwoHours = Seconds.deltaOneHour * 2
        public static let deltaThreeHours = Seconds.deltaOneHour * 3
        public static let deltaSixHours = Seconds.deltaOneHour * 6
        public static let deltaOneDay = Seconds.deltaOneHour * 24
        public static let deltaTwoDays = Seconds.deltaOneDay * 2
        public static let deltaThreeDays = Seconds.deltaOneDay * 3
        public static let deltaOneWeek = Seconds.deltaOneDay * 7
        public static let deltaTwoWeeks = Seconds.deltaOneWeek * 2
        public static let deltaThreeWeeks = Seconds.deltaOneWeek * 3
        public static let deltaThirtyDays = Seconds.deltaOneDay * 30
        public static let deltaSixWeeks = Seconds.deltaOneWeek * 6
        public static let delta365Days = Seconds.deltaOneDay * 365
    }

    func dnsDateTime(as format: Format = Format(),
                     in timeZone: TimeZone = TimeZone.current) -> String {
        let startDelta = self.timeIntervalSinceNow
        
        switch format.size {
        case .short:
            return utilityTimeShort(startDelta: startDelta, style: format.style, in: timeZone)
        case .normal:
            return utilityTimeNormal(startDelta: startDelta, style: format.style, in: timeZone)
        case .long:
            return utilityTimeLong(startDelta: startDelta, style: format.style, in: timeZone)
        case .full:
            return utilityTimeFull(startDelta: startDelta, style: format.style, in: timeZone)
        }
    }
    func dnsDate(as format: Format = Format(),
                 in timeZone: TimeZone = TimeZone.current) -> String {
        let delta = self.timeIntervalSinceNow

        switch format.size {
        case .short:
            return utilityDateShort(delta: delta, style: format.style, in: timeZone)
        case .normal:
            return utilityDateNormal(delta: delta, style: format.style, in: timeZone)
        case .long:
            return utilityDateLong(delta: delta, style: format.style, in: timeZone)
        case .full:
            return utilityDateFull(delta: delta, style: format.style, in: timeZone)
        }
    }
    func dnsTime(as format: Format = Format(),
                 in timeZone: TimeZone = TimeZone.current) -> String {
        let delta = self.timeIntervalSinceNow

        switch format.size {
        case .short:
            return utilityTimeShort(delta: delta, style: format.style, in: timeZone)
        case .normal:
            return utilityTimeNormal(delta: delta, style: format.style, in: timeZone)
        case .long:
            return utilityTimeLong(delta: delta, style: format.style, in: timeZone)
        case .full:
            return utilityTimeFull(delta: delta, style: format.style, in: timeZone)
        }
    }

    func dnsDate(to end: Date, as format: Format = Format(),
                 in timeZone: TimeZone = TimeZone.current) -> String {
        let startDelta = self.timeIntervalSinceNow
        let endDelta = end.timeIntervalSinceNow

        switch format.size {
        case .short:
            return utilityDateShort(startDelta: startDelta, to: end, endDelta: endDelta, style: format.style, in: timeZone)
        case .normal:
            return utilityDateNormal(startDelta: startDelta, to: end, endDelta: endDelta, style: format.style, in: timeZone)
        case .long:
            return utilityDateLong(startDelta: startDelta, to: end, endDelta: endDelta, style: format.style, in: timeZone)
        case .full:
            return utilityDateFull(startDelta: startDelta, to: end, endDelta: endDelta, style: format.style, in: timeZone)
        }
    }
    func dnsTime(to end: Date, as format: Format = Format(),
                 in timeZone: TimeZone = TimeZone.current) -> String {
        let startDelta = self.timeIntervalSinceNow
        let endDelta = end.timeIntervalSinceNow

        switch format.size {
        case .short:
            return utilityTimeShort(startDelta: startDelta, to: end, endDelta: endDelta, style: format.style, in: timeZone)
        case .normal:
            return utilityTimeNormal(startDelta: startDelta, to: end, endDelta: endDelta, style: format.style, in: timeZone)
        case .long:
            return utilityTimeLong(startDelta: startDelta, to: end, endDelta: endDelta, style: format.style, in: timeZone)
        case .full:
            return utilityTimeFull(startDelta: startDelta, to: end, endDelta: endDelta, style: format.style, in: timeZone)
        }
    }

    func dnsComponent(component: Calendar.Component) -> Int {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        return calendar.component(component, from: self)
    }
    func dnsEra() -> Int        {   return dnsComponent(component: .era)        }
    func dnsYear() -> Int       {   return dnsComponent(component: .year)       }
    func dnsMonth() -> Int      {   return dnsComponent(component: .month)      }
    func dnsDay() -> Int        {   return dnsComponent(component: .day)        }
    func dnsHour() -> Int       {   return dnsComponent(component: .hour)       }
    func dnsMinute() -> Int     {   return dnsComponent(component: .minute)     }
    func dnsSecond() -> Int     {   return dnsComponent(component: .second)     }
    func dnsWeekday() -> Int    {   return dnsComponent(component: .weekday)    }
    func dnsQuarter() -> Int    {   return dnsComponent(component: .quarter)    }

    func dnsAge(to toDate: Date = Date()) -> (year: Int, month: Int, day: Int) {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let fromDate = calendar.dateComponents([.year, .month, .day], from: self)
        let toDate = calendar.dateComponents([.year, .month, .day], from: toDate)
        let ageComponents = calendar.dateComponents([.year, .month, .day],
                                                    from: fromDate, to: toDate)
        return (ageComponents.year ?? -1, ageComponents.month ?? -1, ageComponents.day ?? -1)
    }

    func isSameDay(as date: Date = Date()) -> Bool {
        return self.dnsDay() == date.dnsDay()
    }
    func isSameWeekday(as date: Date = Date()) -> Bool {
        return self.dnsWeekday() == date.dnsWeekday()
    }
    func isSameMonth(as date: Date = Date()) -> Bool {
        return self.dnsMonth() == date.dnsMonth()
    }
    func isSameYear(as date: Date = Date()) -> Bool {
        return self.dnsYear() == date.dnsYear()
    }
    func isSameDate(as date: Date = Date()) -> Bool {
        return self.isSameDay(as: date) &&
            self.isSameMonth(as: date) &&
            self.isSameYear(as: date)
    }
    var isToday: Bool {
        return isSameDate()
    }
    var isYesterday: Bool {
        let yesterday = Date(timeIntervalSinceNow: -Seconds.deltaOneDay)
        return isSameDate(as: yesterday)
    }
    var isLast7Days: Bool {
        return self.timeIntervalSinceNow > -Seconds.deltaOneWeek
    }
    var isLast30Days: Bool {
        return self.timeIntervalSinceNow > -Seconds.deltaThirtyDays
    }
    var isLast365Days: Bool {
        return self.timeIntervalSinceNow > -Seconds.delta365Days
    }

    static var today: Date {
        Date().replaceTime() ?? Date()
    }
    static var yesterday: Date {
        Date(timeIntervalSinceNow: -Seconds.deltaOneDay).replaceTime()
        ?? Date(timeIntervalSinceNow: -Seconds.deltaOneDay)
    }
    static var lastWeek: Date {
        Date(timeIntervalSinceNow: -Seconds.deltaOneWeek).replaceTime()
        ?? Date(timeIntervalSinceNow: -Seconds.deltaOneWeek)
    }

    var previousDay: Date {
        let newTime = self.timeIntervalSinceNow - Seconds.deltaOneDay
        return Date(timeIntervalSinceNow: newTime).replaceTime()
        ?? Date(timeIntervalSinceNow: newTime)
    }
    var previousWeek: Date {
        let newTime = self.timeIntervalSinceNow - Seconds.deltaOneWeek
        return Date(timeIntervalSinceNow: newTime).replaceTime()
        ?? Date(timeIntervalSinceNow: newTime)
    }

    func replaceDate(with year: Int = 0,
                     and month: Int = 0,
                     and day: Int = 0) -> Date? {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = self.dnsHour()
        components.minute = self.dnsMinute()
        components.second = self.dnsSecond()

        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        return calendar.date(from: components)
    }
    func replaceTime(with seconds: TimeInterval) -> Date? {
        var remainingSeconds = seconds
        let hour = Int(remainingSeconds / Seconds.deltaOneHour)
        remainingSeconds -= Double(hour) * Seconds.deltaOneHour
        let minute = Int(remainingSeconds / Seconds.deltaOneMinute)
        remainingSeconds -= Double(minute) * Seconds.deltaOneMinute
        let second = Int(remainingSeconds)
        return self.replaceTime(with: hour,
                                and: minute,
                                and: second)
    }
    func replaceTime(with hour: Int = 0,
                     and minute: Int = 0,
                     and second: Int = 0) -> Date? {
        var components = DateComponents()
        components.year = self.dnsYear()
        components.month = self.dnsMonth()
        components.day = self.dnsDay()
        components.hour = hour
        components.minute = minute
        components.second = second

        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        return calendar.date(from: components)
    }
    func timeOfDay() -> DNSTimeOfDay {
        return DNSTimeOfDay(hour: self.dnsHour(),
                            minute: self.dnsMinute())
    }

    // MARK: - Utility methods

    static func utilityMinimizeAmPm(of string: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        let amSymbol = dateFormatter.amSymbol.replacingOccurrences(of: "a. m.", with: "a.m.").lowercased()
        let pmSymbol = dateFormatter.pmSymbol.replacingOccurrences(of: "p. m.", with: "p.m.").lowercased()
        
        var retval = string
        retval = retval.replacingOccurrences(of: " \(dateFormatter.amSymbol ?? "")", with: amSymbol)
        retval = retval.replacingOccurrences(of: " \(dateFormatter.pmSymbol ?? "")", with: pmSymbol)
        retval = retval.replacingOccurrences(of: "\(dateFormatter.amSymbol ?? "")", with: amSymbol)
        retval = retval.replacingOccurrences(of: "\(dateFormatter.pmSymbol ?? "")", with: pmSymbol)
        return retval
    }
}
