//
//  Date+dnsPretty.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public extension Date {
    static var zeroTime: DNSTimeOfDay = DNSTimeOfDay(hour: 0, minute: 0)

    struct Format {
        public enum Size {
            case short, normal, long, longer, full
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

        public static let longerSimple: Format = Format(size: .longer, style: .simple)
        public static let longerSmart: Format = Format(size: .longer, style: .smart)
        public static let longerPretty: Format = Format(size: .longer, style: .pretty)

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
    enum Weekday: Int, CaseIterable, Codable {
        case unknown = 0
        case sunday = 1
        case monday
        case tuesday
        case wednesday
        case thursday
        case friday
        case saturday
    }

    enum Seconds {
        public static var deltaZeroTime: Double {
            (Double(zeroTime.hour) * deltaOneHour) + (Double(zeroTime.minute) * deltaOneMinute)
        }
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
        public static let deltaFourWeeks = Seconds.deltaOneWeek * 4
        public static let deltaThirtyDays = Seconds.deltaOneDay * 30
        public static let deltaSixWeeks = Seconds.deltaOneWeek * 6
        public static let deltaOneYear = Seconds.deltaOneDay * 365.25
    }

    func dnsDateTime(as dateFormat: Format = Format(),
                     and timeFormat: Format? = nil,
                     in timeZone: TimeZone = TimeZone.current) -> String {
        let timeFormat: Format = timeFormat ?? dateFormat
        let dateString = dnsDate(as: dateFormat, in: timeZone)
        let timeString = dnsTime(as: timeFormat, in: timeZone)
        guard dateString != timeString else {
            return dateString
        }

        switch dateFormat.size {
        case .short:
            return dateString + self.utilityAtShort(style: timeFormat.style) + timeString
        case .normal:
            return dateString + self.utilityAtNormal(style: timeFormat.style) + timeString
        case .long:
            return dateString + self.utilityAtLong(style: timeFormat.style) + timeString
        case .longer:
            return dateString + self.utilityAtLonger(style: timeFormat.style) + timeString
        case .full:
            return dateString + self.utilityAtFull(style: timeFormat.style) + timeString
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
        case .longer:
            return utilityDateLonger(delta: delta, style: format.style, in: timeZone)
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
        case .longer:
            return utilityTimeLonger(delta: delta, style: format.style, in: timeZone)
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
        case .longer:
            return utilityDateLonger(startDelta: startDelta, to: end, endDelta: endDelta, style: format.style, in: timeZone)
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
        case .longer:
            return utilityTimeLonger(startDelta: startDelta, to: end, endDelta: endDelta, style: format.style, in: timeZone)
        case .full:
            return utilityTimeFull(startDelta: startDelta, to: end, endDelta: endDelta, style: format.style, in: timeZone)
        }
    }

    func dnsComponent(component: Calendar.Component,
                      in timeZone: TimeZone = TimeZone.current) -> Int {
        var calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        calendar.timeZone = timeZone
        return calendar.component(component, from: self)
    }
    
    var dnsEra: Int { dnsEra() }
    var dnsYear: Int { dnsYear() }
    var dnsMonth: Int { dnsMonth() }
    var dnsDay: Int { dnsDay() }
    var dnsHour: Int { dnsHour() }
    var dnsMinute: Int { dnsMinute() }
    var dnsSecond: Int { dnsSecond() }
    var dnsWeekday: Int { dnsWeekday() }
    var dnsQuarter: Int { dnsQuarter() }
    var dnsDayOfWeek: Weekday { dnsDayOfWeek() }

    var dnsMonthName: String { dnsMonthName() }
    func dnsMonthName(as format: Format = Format(),
                      in timeZone: TimeZone = TimeZone.current) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        switch format.size {
        case .short:
            dateFormatter.dateFormat = "MMM"
        default:
            dateFormatter.dateFormat = "MMMM"
        }
        return dateFormatter.string(from: self)
    }

    func dnsEra(in timeZone: TimeZone = TimeZone.current) -> Int {
        return dnsComponent(component: .era, in: timeZone)
    }
    func dnsYear(in timeZone: TimeZone = TimeZone.current) -> Int {
        return dnsComponent(component: .year, in: timeZone)
    }
    func dnsMonth(in timeZone: TimeZone = TimeZone.current) -> Int {
        return dnsComponent(component: .month, in: timeZone)
    }
    func dnsDay(in timeZone: TimeZone = TimeZone.current) -> Int {
        return dnsComponent(component: .day, in: timeZone)
    }
    func dnsHour(in timeZone: TimeZone = TimeZone.current) -> Int {
        return dnsComponent(component: .hour, in: timeZone)
    }
    func dnsMinute(in timeZone: TimeZone = TimeZone.current) -> Int {
        return dnsComponent(component: .minute, in: timeZone)
    }
    func dnsSecond(in timeZone: TimeZone = TimeZone.current) -> Int {
        return dnsComponent(component: .second, in: timeZone)
    }
    func dnsWeekday(in timeZone: TimeZone = TimeZone.current) -> Int {
        return dnsComponent(component: .weekday, in: timeZone)
    }
    func dnsQuarter(in timeZone: TimeZone = TimeZone.current) -> Int {
        return dnsComponent(component: .quarter, in: timeZone)
    }
    func dnsDayOfWeek(in timeZone: TimeZone = TimeZone.current) -> Weekday {
        return Weekday(rawValue: dnsComponent(component: .weekday, in: timeZone)) ?? .unknown
    }
    
    var dnsDatePart: Date? { dnsDatePart() }
    var dnsTimePart: DNSTimeOfDay { dnsTimePart() }
    func dnsDatePart(in timeZone: TimeZone = TimeZone.current) -> Date? {
        self.replaceTime(with: 0, in: timeZone)
    }
    func dnsTimePart(in timeZone: TimeZone = TimeZone.current) -> DNSTimeOfDay {
        DNSTimeOfDay(hour: self.dnsHour(in: timeZone),
                     minute: self.dnsMinute(in: timeZone))
    }
    func timeOfDay(in timeZone: TimeZone = TimeZone.current) -> DNSTimeOfDay { dnsTimePart(in: timeZone) }
    
    func dnsAge(to toDate: Date = Date(),
                in timeZone: TimeZone = TimeZone.current) -> (year: Int, month: Int, day: Int) {
        var calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        calendar.timeZone = timeZone
        let fromDate = calendar.dateComponents([.year, .month, .day], from: self)
        let toDate = calendar.dateComponents([.year, .month, .day], from: toDate)
        let ageComponents = calendar.dateComponents([.year, .month, .day],
                                                    from: fromDate, to: toDate)
        return (ageComponents.year ?? -1, ageComponents.month ?? -1, ageComponents.day ?? -1)
    }
    func dnsSeconds(to toDate: Date = Date()) -> Int {
        let fromSeconds = self.timeIntervalSinceReferenceDate
        let toSeconds = toDate.timeIntervalSinceReferenceDate
        return Int(toSeconds - fromSeconds)
    }
    func dnsMinutes(to toDate: Date = Date()) -> Int {
        return Int(Double(dnsSeconds(to: toDate)) / Date.Seconds.deltaOneMinute)
    }
    func dnsHours(to toDate: Date = Date()) -> Int {
        return Int(Double(dnsSeconds(to: toDate)) / Date.Seconds.deltaOneHour)
    }
    func dnsDays(to toDate: Date = Date()) -> Int {
        return Int(Double(dnsSeconds(to: toDate)) / Date.Seconds.deltaOneDay)
    }
    func dnsWeeks(to toDate: Date = Date()) -> Int {
        return Int(Double(dnsSeconds(to: toDate)) / Date.Seconds.deltaOneWeek)
    }
    func dnsYears(to toDate: Date = Date()) -> Int {
        return Int(Double(dnsSeconds(to: toDate)) / Date.Seconds.deltaOneYear)
    }

    var zeroDate: Date {
        guard self.isZeroTime else { return self }
        return self - (Seconds.deltaZeroTime + 1)
    }
    var zeroTime: Date { self.replaceTime(with: Self.zeroTime) ?? Date() }

    func zeroDate(in timeZone: TimeZone = TimeZone.current) -> Date {
        guard self.isZeroTime(in: timeZone) else { return self }
        return self - (Seconds.deltaZeroTime + 1)
    }
    func zeroTime(in timeZone: TimeZone = TimeZone.current) -> Date {
        self.replaceTime(with: Self.zeroTime,
                         in: timeZone) ?? Date()
    }

    func isSameDay(as date: Date = Date(),
                   in timeZone: TimeZone = TimeZone.current) -> Bool {
        return self.dnsDay(in: timeZone) == date.dnsDay(in: timeZone)
    }
    func isSameWeekday(as date: Date = Date(),
                       in timeZone: TimeZone = TimeZone.current) -> Bool {
        return self.dnsWeekday(in: timeZone) == date.dnsWeekday(in: timeZone)
    }
    func isSameMonth(as date: Date = Date(),
                     in timeZone: TimeZone = TimeZone.current) -> Bool {
        return self.dnsMonth(in: timeZone) == date.dnsMonth(in: timeZone)
    }
    func isSameYear(as date: Date = Date(),
                    in timeZone: TimeZone = TimeZone.current) -> Bool {
        return self.dnsYear(in: timeZone) == date.dnsYear(in: timeZone)
    }
    func isSameDate(as date: Date = Date(),
                    in timeZone: TimeZone = TimeZone.current) -> Bool {
        return self.isSameDay(as: date, in: timeZone) &&
            self.isSameMonth(as: date, in: timeZone) &&
            self.isSameYear(as: date, in: timeZone)
    }
    var isMidnight: Bool { self.isMidnight() }
    var isZeroTime: Bool { self.isZeroTime() }
    var isToday: Bool { self.isToday() }
    var isTomorrow: Bool { self.isTomorrow() }
    var isYesterday: Bool { self.isYesterday() }
    var isLast7Days: Bool { self.isLast7Days() }
    var isLast30Days: Bool { self.isLast30Days() }
    var isLastYear: Bool { self.isLastYear() }
    
    func isMidnight(in timeZone: TimeZone = TimeZone.current) -> Bool {
        self == self.dnsDatePart(in: timeZone)
    }
    func isZeroTime(in timeZone: TimeZone = TimeZone.current) -> Bool {
        self.dnsTimePart(in: timeZone) == Self.zeroTime
    }
    func isToday(in timeZone: TimeZone = TimeZone.current) -> Bool {
        return isSameDate(in: timeZone)
    }
    func isTomorrow(in timeZone: TimeZone = TimeZone.current) -> Bool {
        let tomorrow = Date(timeIntervalSinceNow: Seconds.deltaOneDay)
        return isSameDate(as: tomorrow, in: timeZone)
    }
    func isYesterday(in timeZone: TimeZone = TimeZone.current) -> Bool {
        let yesterday = Date(timeIntervalSinceNow: -Seconds.deltaOneDay)
        return isSameDate(as: yesterday, in: timeZone)
    }
    func isLast7Days(in timeZone: TimeZone = TimeZone.current) -> Bool {
        return self.timeIntervalSinceNow > -Seconds.deltaOneWeek
    }
    func isLast30Days(in timeZone: TimeZone = TimeZone.current) -> Bool {
        return self.timeIntervalSinceNow > -Seconds.deltaThirtyDays
    }
    func isLastYear(in timeZone: TimeZone = TimeZone.current) -> Bool {
        return self.timeIntervalSinceNow > -Seconds.deltaOneYear
    }

    static var today: Date {
        Date().replaceTime() ?? Date()
    }
    static var tomorrow: Date {
        Date(timeIntervalSinceNow: Seconds.deltaOneDay).replaceTime()
        ?? Date(timeIntervalSinceNow: Seconds.deltaOneDay)
    }
    static var yesterday: Date {
        Date(timeIntervalSinceNow: -Seconds.deltaOneDay).replaceTime()
        ?? Date(timeIntervalSinceNow: -Seconds.deltaOneDay)
    }
    static var lastWeek: Date {
        Date(timeIntervalSinceNow: -Seconds.deltaOneWeek).replaceTime()
        ?? Date(timeIntervalSinceNow: -Seconds.deltaOneWeek)
    }

    var nextDay: Date { self + Seconds.deltaOneDay }
    var nextWeek: Date { self + Seconds.deltaOneWeek }
    var nextMonth: Date {
        var components = DateComponents()
        components.month = 1
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        return calendar.date(byAdding: components, to: self) ?? self
    }
    var nextYear: Date {
        var components = DateComponents()
        components.year = 1
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        return calendar.date(byAdding: components, to: self) ?? self
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
    var previousMonth: Date {
        var components = DateComponents()
        components.month = -1
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        return calendar.date(byAdding: components, to: self) ?? self
    }
    var previousYear: Date {
        var components = DateComponents()
        components.year = 1
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        return calendar.date(byAdding: components, to: self) ?? self
    }

    func replaceDate(with year: Int = 0,
                     and month: Int = 0,
                     and day: Int = 0,
                     in timeZone: TimeZone = TimeZone.current) -> Date? {
        var components = DateComponents()
        components.timeZone = timeZone
        components.year = year
        components.month = month
        components.day = day
        components.hour = self.dnsHour(in: timeZone)
        components.minute = self.dnsMinute(in: timeZone)
        components.second = self.dnsSecond(in: timeZone)

        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        return calendar.date(from: components)
    }
    func replaceTime(with seconds: TimeInterval,
                     in timeZone: TimeZone = TimeZone.current) -> Date? {
        var remainingSeconds = seconds
        let hour = Int(remainingSeconds / Seconds.deltaOneHour)
        remainingSeconds -= Double(hour) * Seconds.deltaOneHour
        let minute = Int(remainingSeconds / Seconds.deltaOneMinute)
        remainingSeconds -= Double(minute) * Seconds.deltaOneMinute
        let second = Int(remainingSeconds)
        return self.replaceTime(with: hour,
                                and: minute,
                                and: second,
                                in: timeZone)
    }
    func replaceTime(with timeOfDay: DNSTimeOfDay,
                     in timeZone: TimeZone = TimeZone.current) -> Date? {
        replaceTime(with: timeOfDay.hour,
                    and: timeOfDay.minute,
                    in: timeZone)
    }
    func replaceTime(with hour: Int = 0,
                     and minute: Int = 0,
                     and second: Int = 0,
                     in timeZone: TimeZone = TimeZone.current) -> Date? {
        var components = DateComponents()
        components.timeZone = timeZone
        components.year = self.dnsYear(in: timeZone)
        components.month = self.dnsMonth(in: timeZone)
        components.day = self.dnsDay(in: timeZone)
        components.hour = hour
        components.minute = minute
        components.second = second

        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        return calendar.date(from: components)
    }

    // MARK: - Custom Operator methods
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
    static func -= (lhs: Date, rhs: Date) -> TimeInterval { lhs - rhs }

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
