//
//  Date+dnsPretty.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public extension Date {
    func utilityDateNormal(delta: TimeInterval,
                           to end: Date? = nil,
                           endDelta: TimeInterval? = nil,
                           style: Format.Style) -> String {
        switch style {
        case .simple:
            return utilityDateNormalSimple(delta: delta, to: end, endDelta: endDelta)
        case .smart:
            return utilityDateNormalSmart(delta: delta, to: end, endDelta: endDelta)
        case .pretty:
            return utilityDateNormalPretty(delta: delta, to: end, endDelta: endDelta)
        }
    }
    func utilityTimeNormal(delta: TimeInterval,
                           to end: Date? = nil,
                           endDelta: TimeInterval? = nil,
                           style: Format.Style) -> String {
        switch style {
        case .simple:
            return utilityTimeNormalSimple(delta: delta, to: end, endDelta: endDelta)
        case .smart:
            return utilityTimeNormalSmart(delta: delta, to: end, endDelta: endDelta)
        case .pretty:
            return utilityTimeNormalPretty(delta: delta, to: end, endDelta: endDelta)
        }
    }

    private func utilityDateNormalSimple(delta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
        var retval = DateFormatter.localizedString(from: self,
                                                   dateStyle: DateFormatter.Style.medium,
                                                   timeStyle: DateFormatter.Style.none)
        guard end != nil else { return retval }

        retval += " - " + end!.utilityDateNormalSimple(delta: endDelta!)
        return retval
    }
    private func utilityDateNormalSmart(delta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
        let dateFormatter = DateFormatter()
        let yearFormatSubString = self.isSameYear(as: end) ? "" : ", yyyy"
        let dateFormatString = "MMM d\(yearFormatSubString)"
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: dateFormatString,
                                                            options: 0,
                                                            locale: Locale.current)
        var retval = dateFormatter.string(from: self)
        guard end != nil else { return retval }

        retval += " - " + end!.utilityDateNormalSmart(delta: endDelta!)
        return retval
    }
    private func utilityDateNormalPretty(delta: TimeInterval,
                                         to end: Date? = nil,
                                         endDelta: TimeInterval? = nil) -> String {
        var retval = ""

        if delta < 0 {
            retval = utilityDateShortPrettyPast(delta: delta)
        } else {
            retval = utilityDateShortPrettyFuture(delta: delta)
        }
        guard end != nil else { return retval }

        let endString = end!.utilityDateNormalPretty(delta: endDelta!)
        guard retval != endString else { return retval }

        retval += " - " + endString
        return retval
    }
    private func utilityDateShortPrettyFuture(delta: TimeInterval) -> String {
        var retval = ""

        switch delta {
        case 0..<Seconds.deltaOneDay:
            retval = C.Localizations.DatePretty.today
        case 0..<Seconds.deltaTwoDays:
            retval = C.Localizations.DatePretty.tomorrow
        case 0..<Seconds.deltaThreeDays:
            retval = String(format: C.Localizations.DatePretty.days, "2")
        case 0..<Seconds.deltaOneWeek:
            retval = String(format: C.Localizations.DatePretty.days, "3+")
        case 0..<Seconds.deltaTwoWeeks:
            retval = String(format: C.Localizations.DatePretty.week, "1")
        case 0..<Seconds.deltaThreeWeeks:
            retval = String(format: C.Localizations.DatePretty.weeks, "2")
        case 0..<Seconds.deltaSixWeeks:
            retval = String(format: C.Localizations.DatePretty.weeks, "3+")
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
            retval = C.Localizations.DatePretty.today
        case 0..<Seconds.deltaTwoDays:
            retval = C.Localizations.DatePretty.yesterday
        case 0..<Seconds.deltaThreeDays:
            retval = String(format: C.Localizations.DatePretty.daysAgo, "2")
        case 0..<Seconds.deltaOneWeek:
            retval = String(format: C.Localizations.DatePretty.daysAgo, "3+")
        case 0..<Seconds.deltaTwoWeeks:
            retval = String(format: C.Localizations.DatePretty.weekAgo, "1")
        case 0..<Seconds.deltaThreeWeeks:
            retval = String(format: C.Localizations.DatePretty.weeksAgo, "2")
        case 0..<Seconds.deltaSixWeeks:
            retval = String(format: C.Localizations.DatePretty.weeksAgo, "3+")
        default:
            retval = Formatters.dateShort.string(from: self)
        }

        return retval
    }

    private func utilityTimeNormalSimple(delta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
        let dateStyle = self.isSameDate(as: end) ? DateFormatter.Style.none : DateFormatter.Style.medium
        var retval = DateFormatter.localizedString(from: self,
                                                   dateStyle: dateStyle,
                                                   timeStyle: DateFormatter.Style.medium)
        retval = Date.utilityMinimizeAmPm(of: retval)
        guard end != nil else { return retval }

        retval += " - " + end!.utilityTimeNormalSimple(delta: endDelta!)
        return retval
    }
    private func utilityTimeNormalSmart(delta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
        let yearFormatSubString = self.isSameYear(as: end) ? "" : ", yyyy"
        let dayFormatString = self.isSameDate(as: end) ? "" : "MMM d\(yearFormatSubString) @ "
        let timeFormatString = "\(dayFormatString)h\(self.dnsMinute() > 0 ? ":mm" : "")a"

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: timeFormatString,
                                                            options: 0,
                                                            locale: Locale.current)
        var retval = dateFormatter.string(from: self)
        retval = Date.utilityMinimizeAmPm(of: retval)
        guard end != nil else { return retval }

        retval += " - " + end!.utilityTimeNormalSmart(delta: endDelta!)
        return retval
    }

    private func utilityTimeNormalPretty(delta: TimeInterval,
                                         to end: Date? = nil,
                                         endDelta: TimeInterval? = nil) -> String {
        var retval = ""

        if delta < 0 {
            retval = utilityTimeNormalPrettyPast(delta: delta)
        } else {
            retval = utilityTimeNormalPrettyFuture(delta: delta)
        }
        guard end != nil else { return retval }

        let endString = end!.utilityTimeNormalPretty(delta: endDelta!)
        guard retval != endString else { return retval }

        retval += " - " + endString
        return retval
    }
    // swiftlint:disable:next cyclomatic_complexity
    private func utilityTimeNormalPrettyFuture(delta: TimeInterval) -> String {
        var retval = ""

        switch delta {
        case 0..<Seconds.deltaOneMinute:
            retval = C.Localizations.DatePretty.justNow
        case 0..<Seconds.deltaTwoMinutes:
            retval = String(format: C.Localizations.DatePretty.minute, "1")
        case 0..<Seconds.deltaThreeMinutes:
            retval = String(format: C.Localizations.DatePretty.minutes, "2")
        case 0..<Seconds.deltaSixMinutes:
            retval = String(format: C.Localizations.DatePretty.minutes, "3+")
        case 0..<Seconds.deltaOneHour:
            let minutes = Int(floor(delta / Seconds.deltaOneMinute))
            retval = String(format: C.Localizations.DatePretty.minutes, "\(minutes)")
        case 0..<Seconds.deltaTwoHours:
            retval = String(format: C.Localizations.DatePretty.hour, "1")
        case 0..<Seconds.deltaThreeHours:
            retval = String(format: C.Localizations.DatePretty.hours, "2")
        case 0..<Seconds.deltaSixHours:
            retval = String(format: C.Localizations.DatePretty.hours, "3+")
        case 0..<Seconds.deltaOneDay:
            retval = C.Localizations.DatePretty.today
        case 0..<Seconds.deltaTwoDays:
            retval = C.Localizations.DatePretty.tomorrow
        case 0..<Seconds.deltaThreeDays:
            retval = String(format: C.Localizations.DatePretty.days, "2")
        case 0..<Seconds.deltaOneWeek:
            retval = String(format: C.Localizations.DatePretty.days, "3+")
        case 0..<Seconds.deltaTwoWeeks:
            retval = String(format: C.Localizations.DatePretty.week, "1")
        case 0..<Seconds.deltaThreeWeeks:
            retval = String(format: C.Localizations.DatePretty.weeks, "2")
        case 0..<Seconds.deltaSixWeeks:
            retval = String(format: C.Localizations.DatePretty.weeks, "3+")
        default:
            retval = Formatters.dateShort.string(from: self)
        }

        return retval
    }
    // swiftlint:disable:next cyclomatic_complexity
    private func utilityTimeNormalPrettyPast(delta: TimeInterval) -> String {
        let deltaPast = 0 - delta
        var retval = ""

        switch deltaPast {
        case 0..<Seconds.deltaOneMinute:
            retval = C.Localizations.DatePretty.justNow
        case 0..<Seconds.deltaTwoMinutes:
            retval = String(format: C.Localizations.DatePretty.minuteAgo, "1")
        case 0..<Seconds.deltaThreeMinutes:
            retval = String(format: C.Localizations.DatePretty.minutesAgo, "2")
        case 0..<Seconds.deltaSixMinutes:
            retval = String(format: C.Localizations.DatePretty.minutesAgo, "3+")
        case 0..<Seconds.deltaOneHour:
            let minutesAgo = Int(floor(deltaPast / Seconds.deltaOneMinute))
            retval = String(format: C.Localizations.DatePretty.minutesAgo, "\(minutesAgo)")
        case 0..<Seconds.deltaTwoHours:
            retval = String(format: C.Localizations.DatePretty.hourAgo, "1")
        case 0..<Seconds.deltaThreeHours:
            retval = String(format: C.Localizations.DatePretty.hoursAgo, "2")
        case 0..<Seconds.deltaSixHours:
            retval = String(format: C.Localizations.DatePretty.hoursAgo, "3+")
        case 0..<Seconds.deltaOneDay:
            retval = C.Localizations.DatePretty.today
        case 0..<Seconds.deltaTwoDays:
            retval = C.Localizations.DatePretty.yesterday
        case 0..<Seconds.deltaThreeDays:
            retval = String(format: C.Localizations.DatePretty.daysAgo, "2")
        case 0..<Seconds.deltaOneWeek:
            retval = String(format: C.Localizations.DatePretty.daysAgo, "3+")
        case 0..<Seconds.deltaTwoWeeks:
            retval = String(format: C.Localizations.DatePretty.weekAgo, "1")
        case 0..<Seconds.deltaThreeWeeks:
            retval = String(format: C.Localizations.DatePretty.weeksAgo, "2")
        case 0..<Seconds.deltaSixWeeks:
            retval = String(format: C.Localizations.DatePretty.weeksAgo, "3+")
        default:
            retval = NSLocalizedString("\(Formatters.dateShort.string(from: self))", comment: "")
        }

        return retval
    }
}
