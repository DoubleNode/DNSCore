//
//  Date+dnsPretty.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public extension Date {
    func utilityDateShort(delta: TimeInterval, style: Format.Style) -> String {
        switch style {
        case .simple:
            return utilityDateShortSimple(delta: delta)
        case .smart:
            return utilityDateShortSmart(delta: delta)
        case .pretty:
            return utilityDateShortPretty(delta: delta)
        case .military:
            return utilityDateShortMilitary(delta: delta)
        }
    }
    func utilityTimeShort(delta: TimeInterval, style: Format.Style) -> String {
        switch style {
        case .simple:
            return utilityTimeShortSimple(delta: delta)
        case .smart:
            return utilityTimeShortSmart(delta: delta)
        case .pretty:
            return utilityTimeShortPretty(delta: delta)
        case .military:
            return utilityTimeShortMilitary(delta: delta)
        }
    }
    func utilityDateShort(startDelta: TimeInterval, to end: Date? = nil,
                          endDelta: TimeInterval? = nil, style: Format.Style) -> String {
        switch style {
        case .simple:
            return utilityDateShortSimple(startDelta: startDelta, to: end, endDelta: endDelta)
        case .smart:
            return utilityDateShortSmart(startDelta: startDelta, to: end, endDelta: endDelta)
        case .pretty:
            return utilityDateShortPretty(startDelta: startDelta, to: end, endDelta: endDelta)
        case .military:
            return utilityDateShortMilitary(startDelta: startDelta, to: end, endDelta: endDelta)
        }
    }
    func utilityTimeShort(startDelta: TimeInterval, to end: Date? = nil,
                          endDelta: TimeInterval? = nil, style: Format.Style) -> String {
        switch style {
        case .simple:
            return utilityTimeShortSimple(startDelta: startDelta, to: end, endDelta: endDelta)
        case .smart:
            return utilityTimeShortSmart(startDelta: startDelta, to: end, endDelta: endDelta)
        case .pretty:
            return utilityTimeShortPretty(startDelta: startDelta, to: end, endDelta: endDelta)
        case .military:
            return utilityTimeShortMilitary(startDelta: startDelta, to: end, endDelta: endDelta)
        }
    }

    private func utilityDateShortSimple(delta: TimeInterval) -> String {
        return self.utilityDateShortSimple(startDelta: delta)
    }
    private func utilityDateShortSimple(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
        var retval = DateFormatter.localizedString(from: self,
                                                   dateStyle: DateFormatter.Style.short,
                                                   timeStyle: DateFormatter.Style.none)
        guard end != nil && end != self else { return retval }

        let endString = end!.utilityDateShortSimple(startDelta: endDelta!, to: end, endDelta: endDelta)
        guard retval != endString else { return retval }
        retval += " - " + endString
        return retval
    }
    private func utilityDateShortSmart(delta: TimeInterval) -> String {
        return self.utilityDateShortSmart(startDelta: delta)
    }
    private func utilityDateShortSmart(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
        let dateFormatter = DateFormatter()
        let yearFormatSubString = self.isSameYear(as: end) ? "" : "/yy"
        let dateFormatString = "M/d\(yearFormatSubString)"
        dateFormatter.dateFormat = dateFormatString
        var retval = dateFormatter.string(from: self)
        guard end != nil && end != self else { return retval }

        let endString = end!.utilityDateShortSmart(startDelta: endDelta!, to: end, endDelta: endDelta)
        guard retval != endString else { return retval }
        retval += " - " + endString
        return retval
    }
    private func utilityDateShortPretty(delta: TimeInterval) -> String {
        return self.utilityDateShortPretty(startDelta: delta)
    }
    private func utilityDateShortPretty(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
        var retval = ""

        if startDelta < 0 {
            retval = utilityDateShortPrettyPast(delta: startDelta)
        } else {
            retval = utilityDateShortPrettyFuture(delta: startDelta)
        }
        guard end != nil && end != self else { return retval }

        let endString = end!.utilityDateShortPretty(startDelta: endDelta!, to: end, endDelta: endDelta)
        guard retval != endString else { return retval }
        retval += " - " + endString
        return retval
    }
    private func utilityDateShortPrettyFuture(delta: TimeInterval) -> String {
        var retval = ""

        switch delta {
        case 0..<Seconds.deltaOneDay:
            retval = C.Localizations.DatePretty.todayShort
        case 0..<Seconds.deltaTwoDays:
            retval = C.Localizations.DatePretty.tomorrowShort
        case 0..<Seconds.deltaThreeDays:
            retval = String(format: C.Localizations.DatePretty.daysShort, "2")
        case 0..<Seconds.deltaOneWeek:
            retval = String(format: C.Localizations.DatePretty.daysShort, "3+")
        case 0..<Seconds.deltaTwoWeeks:
            retval = String(format: C.Localizations.DatePretty.weekShort, "1")
        case 0..<Seconds.deltaThreeWeeks:
            retval = String(format: C.Localizations.DatePretty.weeksShort, "2")
        case 0..<Seconds.deltaSixWeeks:
            retval = String(format: C.Localizations.DatePretty.weeksShort, "3+")
        default:
            retval = Formatters.dateShort.string(from: self)
        }

        return retval
    }
    private func utilityDateShortPrettyPast(delta: TimeInterval) -> String {
        let deltaPast = 0 - delta
        var retval = ""

        switch deltaPast {
        case 0..<Seconds.deltaOneDay:
            retval = C.Localizations.DatePretty.todayShort
        case 0..<Seconds.deltaTwoDays:
            retval = C.Localizations.DatePretty.yesterdayShort
        case 0..<Seconds.deltaThreeDays:
            retval = String(format: C.Localizations.DatePretty.daysAgoShort, "2")
        case 0..<Seconds.deltaOneWeek:
            retval = String(format: C.Localizations.DatePretty.daysAgoShort, "3+")
        case 0..<Seconds.deltaTwoWeeks:
            retval = String(format: C.Localizations.DatePretty.weekAgoShort, "1")
        case 0..<Seconds.deltaThreeWeeks:
            retval = String(format: C.Localizations.DatePretty.weeksAgoShort, "2")
        case 0..<Seconds.deltaSixWeeks:
            retval = String(format: C.Localizations.DatePretty.weeksAgoShort, "3+")
        default:
            retval = NSLocalizedString("\(Formatters.dateShort.string(from: self))", comment: "")
        }

        return retval
    }
    private func utilityDateShortMilitary(delta: TimeInterval) -> String {
        return self.utilityDateShortMilitary(startDelta: delta)
    }
    private func utilityDateShortMilitary(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        var retval = dateFormatter.string(from: self)
        guard end != nil && end != self else { return retval }

        let endString = end!.utilityDateShortMilitary(startDelta: endDelta!, to: end, endDelta: endDelta)
        guard retval != endString else { return retval }
        retval += " - " + endString
        return retval
    }

    private func utilityTimeShortSimple(delta: TimeInterval) -> String {
        let retval = DateFormatter.localizedString(from: self,
                                                   dateStyle: DateFormatter.Style.none,
                                                   timeStyle: DateFormatter.Style.short)
        return Date.utilityMinimizeAmPm(of: retval)
    }
    private func utilityTimeShortSimple(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
        let dateStyle = self.isSameDate(as: end) ? DateFormatter.Style.none : DateFormatter.Style.short
        var retval = DateFormatter.localizedString(from: self,
                                                   dateStyle: dateStyle,
                                                   timeStyle: DateFormatter.Style.short)
        retval = Date.utilityMinimizeAmPm(of: retval)
        guard end != nil && end != self else { return retval }

        let endString = end!.utilityTimeShortSimple(startDelta: endDelta!, to: end, endDelta: endDelta)
        guard retval != endString else { return retval }
        retval += " - " + endString
        return retval
    }

    private func utilityTimeShortSmart(delta: TimeInterval) -> String {
        let timeFormatString = "h\(self.dnsMinute() > 0 ? ":mm" : "")a"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = timeFormatString
        let retval = dateFormatter.string(from: self)
        return Date.utilityMinimizeAmPm(of: retval)
    }
    private func utilityTimeShortSmart(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
        let yearFormatSubString = self.isSameYear(as: end) ? "" : "/yy"
        let dayFormatString = self.isSameDate(as: end) ? "" : "M/d\(yearFormatSubString) '@' "
        let timeFormatString = "\(dayFormatString)h\(self.dnsMinute() > 0 ? ":mm" : "")a"

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = timeFormatString
        var retval = dateFormatter.string(from: self)
        retval = Date.utilityMinimizeAmPm(of: retval)
        guard end != nil && end != self else { return retval }

        let endString = end!.utilityTimeShortSmart(startDelta: endDelta!, to: end, endDelta: endDelta)
        guard retval != endString else { return retval }
        retval += " - " + endString
        return retval
    }

    private func utilityTimeShortPretty(delta: TimeInterval) -> String {
        if delta < 0 {
            return utilityTimeShortPrettyPast(delta: delta)
        } else {
            return utilityTimeShortPrettyFuture(delta: delta)
        }
    }
    private func utilityTimeShortPretty(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
        var retval = ""

        if startDelta < 0 {
            retval = utilityTimeShortPrettyPast(delta: startDelta)
        } else {
            retval = utilityTimeShortPrettyFuture(delta: startDelta)
        }
        guard end != nil && end != self else { return retval }

        let endString = end!.utilityTimeShortPretty(startDelta: endDelta!, to: end, endDelta: endDelta)
        guard retval != endString else { return retval }
        retval += " - " + endString
        return retval
    }
    // swiftlint:disable:next cyclomatic_complexity
    private func utilityTimeShortPrettyFuture(delta: TimeInterval) -> String {
        var retval = ""

        switch delta {
        case 0..<Seconds.deltaOneMinute:
            retval = C.Localizations.DatePretty.now
        case 0..<Seconds.deltaTwoMinutes:
            retval = String(format: C.Localizations.DatePretty.minuteShort, "1")
        case 0..<Seconds.deltaThreeMinutes:
            retval = String(format: C.Localizations.DatePretty.minutesShort, "2")
        case 0..<Seconds.deltaSixMinutes:
            retval = String(format: C.Localizations.DatePretty.minutesShort, "3+")
        case 0..<Seconds.deltaOneHour:
            let minutes = Int(floor(delta / Seconds.deltaOneMinute))
            retval = String(format: C.Localizations.DatePretty.minutesAbbrev, "\(minutes)")
        case 0..<Seconds.deltaTwoHours:
            retval = String(format: C.Localizations.DatePretty.hourShort, "1")
        case 0..<Seconds.deltaThreeHours:
            retval = String(format: C.Localizations.DatePretty.hoursShort, "2")
        case 0..<Seconds.deltaSixHours:
            retval = String(format: C.Localizations.DatePretty.hoursShort, "3+")
        case 0..<Seconds.deltaOneDay:
            retval = C.Localizations.DatePretty.todayShort
        case 0..<Seconds.deltaTwoDays:
            retval = C.Localizations.DatePretty.tomorrowShort
        case 0..<Seconds.deltaThreeDays:
            retval = String(format: C.Localizations.DatePretty.daysShort, "2")
        case 0..<Seconds.deltaOneWeek:
            retval = String(format: C.Localizations.DatePretty.daysShort, "3+")
        case 0..<Seconds.deltaTwoWeeks:
            retval = String(format: C.Localizations.DatePretty.weekShort, "1")
        case 0..<Seconds.deltaThreeWeeks:
            retval = String(format: C.Localizations.DatePretty.weeksShort, "2")
        case 0..<Seconds.deltaSixWeeks:
            retval = String(format: C.Localizations.DatePretty.weeksShort, "3+")
        default:
            retval = Formatters.dateShort.string(from: self)
        }

        return retval
    }
    // swiftlint:disable:next cyclomatic_complexity
    private func utilityTimeShortPrettyPast(delta: TimeInterval) -> String {
        let deltaPast = 0 - delta
        var retval = ""

        switch deltaPast {
        case 0..<Seconds.deltaOneMinute:
            retval = C.Localizations.DatePretty.now
        case 0..<Seconds.deltaTwoMinutes:
            retval = String(format: C.Localizations.DatePretty.minuteAgoShort, "1")
        case 0..<Seconds.deltaThreeMinutes:
            retval = String(format: C.Localizations.DatePretty.minutesAgoShort, "2")
        case 0..<Seconds.deltaSixMinutes:
            retval = String(format: C.Localizations.DatePretty.minutesAgoShort, "3+")
        case 0..<Seconds.deltaOneHour:
            let minutes = Int(floor(delta / Seconds.deltaOneMinute))
            retval = String(format: C.Localizations.DatePretty.minutesAgoAbbrev, "\(minutes)")
        case 0..<Seconds.deltaTwoHours:
            retval = String(format: C.Localizations.DatePretty.hourAgoShort, "1")
        case 0..<Seconds.deltaThreeHours:
            retval = String(format: C.Localizations.DatePretty.hoursAgoShort, "2")
        case 0..<Seconds.deltaSixHours:
            retval = String(format: C.Localizations.DatePretty.hoursAgoShort, "3+")
        case 0..<Seconds.deltaOneDay:
            retval = C.Localizations.DatePretty.todayShort
        case 0..<Seconds.deltaTwoDays:
            retval = C.Localizations.DatePretty.yesterdayShort
        case 0..<Seconds.deltaThreeDays:
            retval = String(format: C.Localizations.DatePretty.daysAgoShort, "2")
        case 0..<Seconds.deltaOneWeek:
            retval = String(format: C.Localizations.DatePretty.daysAgoShort, "3+")
        case 0..<Seconds.deltaTwoWeeks:
            retval = String(format: C.Localizations.DatePretty.weekAgoShort, "1")
        case 0..<Seconds.deltaThreeWeeks:
            retval = String(format: C.Localizations.DatePretty.weeksAgoShort, "2")
        case 0..<Seconds.deltaSixWeeks:
            retval = String(format: C.Localizations.DatePretty.weeksAgoShort, "3+")
        default:
            retval = Formatters.dateShort.string(from: self)
        }

        return retval
    }
    private func utilityTimeShortMilitary(delta: TimeInterval) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HHmm"
        return dateFormatter.string(from: self)
    }
    private func utilityTimeShortMilitary(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HHmm"
        var retval = dateFormatter.string(from: self)
        guard end != nil && end != self else { return retval }

        let endString = end!.utilityTimeShortMilitary(startDelta: endDelta!, to: end, endDelta: endDelta)
        guard retval != endString else { return retval }
        retval += " - " + endString
        return retval
    }
}
