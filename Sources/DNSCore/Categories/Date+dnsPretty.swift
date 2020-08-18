//
//  Date+dnsPretty.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public extension Date {
    struct Format {
        public enum Size {
            case short, normal, long, full
        }
        public enum Style {
            case simple, smart, pretty
        }

        public static let shortSimple: Format = Format(size: .short, style: .simple)
        public static let shortSmart: Format = Format(size: .short, style: .smart)
        public static let shortPretty: Format = Format(size: .short, style: .pretty)

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

    enum Formatters {
        static var dateFull: DateFormatter {
            let retval = DateFormatter()
            retval.dateStyle = DateFormatter.Style.full
            return retval
        }
        static var dateLong: DateFormatter {
            let retval = DateFormatter()
            retval.dateStyle = DateFormatter.Style.long
            return retval
        }
        static var dateMedium: DateFormatter {
            let retval = DateFormatter()
            retval.dateStyle = DateFormatter.Style.medium
            return retval
        }
        static var dateShort: DateFormatter {
            let retval = DateFormatter()
            retval.dateStyle = DateFormatter.Style.short
            return retval
        }
    }

    enum Seconds {
        static let deltaOneMinute = Double(60)
        static let deltaTwoMinutes = Double(120)
        static let deltaThreeMinutes = Double(180)
        static let deltaSixMinutes = Double(320)
        static let deltaOneHour = Double(3600)
        static let deltaTwoHours = Double(7200)
        static let deltaThreeHours = Double(10800)
        static let deltaSixHours = Double(21600)
        static let deltaOneDay = Double(86400)
        static let deltaTwoDays = Double(86400 * 2)
        static let deltaThreeDays = Double(86400 * 3)
        static let deltaOneWeek = Double(86400 * 7)
        static let deltaTwoWeeks = Double(86400 * 14)
        static let deltaThreeWeeks = Double(86400 * 21)
        static let deltaThirtyDays = Double(86400 * 30)
        static let deltaSixWeeks = Double(86400 * 42)
        static let delta365Days = Double(86400 * 365)
    }

    func dnsDate(as format: Format = Format()) -> String {
        let delta = self.timeIntervalSinceNow

        switch format.size {
        case .short:
            return utilityDateShort(delta: delta, style: format.style)
        case .normal:
            return utilityDateNormal(delta: delta, style: format.style)
        case .long:
            return utilityDateLong(delta: delta, style: format.style)
        case .full:
            return utilityDateFull(delta: delta, style: format.style)
        }
    }
    func dnsTime(as format: Format = Format()) -> String {
        let delta = self.timeIntervalSinceNow

        switch format.size {
        case .short:
            return utilityTimeShort(delta: delta, style: format.style)
        case .normal:
            return utilityTimeNormal(delta: delta, style: format.style)
        case .long:
            return utilityTimeLong(delta: delta, style: format.style)
        case .full:
            return utilityTimeFull(delta: delta, style: format.style)
        }
    }

    func dnsDate(to end: Date, as format: Format = Format()) -> String {
        let delta = self.timeIntervalSinceNow
        let endDelta = end.timeIntervalSinceNow

        switch format.size {
        case .short:
            return utilityDateShort(delta: delta, to: end, endDelta: endDelta, style: format.style)
        case .normal:
            return utilityDateNormal(delta: delta, to: end, endDelta: endDelta, style: format.style)
        case .long:
            return utilityDateLong(delta: delta, to: end, endDelta: endDelta, style: format.style)
        case .full:
            return utilityDateFull(delta: delta, to: end, endDelta: endDelta, style: format.style)
        }
    }
    func dnsTime(to end: Date, as format: Format = Format()) -> String {
        let delta = self.timeIntervalSinceNow
        let endDelta = end.timeIntervalSinceNow

        switch format.size {
        case .short:
            return utilityTimeShort(delta: delta, to: end, endDelta: endDelta, style: format.style)
        case .normal:
            return utilityTimeNormal(delta: delta, to: end, endDelta: endDelta, style: format.style)
        case .long:
            return utilityTimeLong(delta: delta, to: end, endDelta: endDelta, style: format.style)
        case .full:
            return utilityTimeFull(delta: delta, to: end, endDelta: endDelta, style: format.style)
        }
    }

    func isSameDay(as date: Date? = nil) -> Bool {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)

        let selfDay = calendar.component(Calendar.Component.day, from: self)
        let dateDay = calendar.component(Calendar.Component.day, from: date ?? Date())

        return selfDay == dateDay
    }
    func isSameWeekday(as date: Date? = nil) -> Bool {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)

        let selfWeekday = calendar.component(Calendar.Component.weekday, from: self)
        let dateWeekday = calendar.component(Calendar.Component.weekday, from: date ?? Date())

        return selfWeekday == dateWeekday
    }
    func isSameMonth(as date: Date? = nil) -> Bool {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)

        let selfMonth = calendar.component(Calendar.Component.month, from: self)
        let dateMonth = calendar.component(Calendar.Component.month, from: date ?? Date())

        return selfMonth == dateMonth
    }
    func isSameYear(as date: Date? = nil) -> Bool {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)

        let selfYear = calendar.component(Calendar.Component.year, from: self)
        let dateYear = calendar.component(Calendar.Component.year, from: date ?? Date())

        return selfYear == dateYear
    }
    func isSameDate(as date: Date? = nil) -> Bool {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)

        let selfDay = calendar.component(Calendar.Component.day, from: self)
        let dateDay = calendar.component(Calendar.Component.day, from: date ?? Date())
        let selfMonth = calendar.component(Calendar.Component.month, from: self)
        let dateMonth = calendar.component(Calendar.Component.month, from: date ?? Date())
        let selfYear = calendar.component(Calendar.Component.year, from: self)
        let dateYear = calendar.component(Calendar.Component.year, from: date ?? Date())

        return (selfDay == dateDay) &&
                (selfMonth == dateMonth) &&
                (selfYear == dateYear)
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
}
