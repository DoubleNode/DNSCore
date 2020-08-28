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

    func isSameDay(as date: Date? = nil) -> Bool {
        return self.dnsDay() == (date != nil ? date! : Date()).dnsDay()
    }
    func isSameWeekday(as date: Date? = nil) -> Bool {
        return self.dnsWeekday() == (date != nil ? date! : Date()).dnsWeekday()
    }
    func isSameMonth(as date: Date? = nil) -> Bool {
        return self.dnsMonth() == (date != nil ? date! : Date()).dnsMonth()
    }
    func isSameYear(as date: Date? = nil) -> Bool {
        return self.dnsYear() == (date != nil ? date! : Date()).dnsYear()
    }
    func isSameDate(as date: Date? = nil) -> Bool {
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
    
    // MARK: - Utility methods
    
    func utilityMinimizeAmPm(of string: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        let amSymbol = dateFormatter.amSymbol.replacingOccurrences(of: "a. m.", with: "a.m.")
        let pmSymbol = dateFormatter.pmSymbol.replacingOccurrences(of: "p. m.", with: "p.m.")
        
        var retval = string
        retval = retval.replacingOccurrences(of: " \(amSymbol)", with: amSymbol)
        retval = retval.replacingOccurrences(of: " \(pmSymbol)", with: pmSymbol)
        return retval
    }
}
