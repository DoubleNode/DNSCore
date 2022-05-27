//
//  Date+dnsPrettyNormal.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public extension Date {
    func utilityAtNormal(style: Format.Style) -> String {
        switch style {
        case .simple:
            return " @ "
        case .smart:
            return " @ "
        case .pretty:
            return ", "
        case .military:
            return " "
        }
    }
    func utilityDateNormal(delta: TimeInterval, style: Format.Style,
                           in timeZone: TimeZone) -> String {
        switch style {
        case .simple:
            return utilityDateNormalSimple(delta: delta, in: timeZone)
        case .smart:
            return utilityDateNormalSmart(delta: delta, in: timeZone)
        case .pretty:
            return utilityDateNormalPretty(delta: delta, in: timeZone)
        case .military:
            return ""
        }
    }
    func utilityTimeNormal(delta: TimeInterval, style: Format.Style,
                           in timeZone: TimeZone) -> String {
        switch style {
        case .simple:
            return utilityTimeNormalSimple(delta: delta, in: timeZone)
        case .smart:
            return utilityTimeNormalSmart(delta: delta, in: timeZone)
        case .pretty:
            return utilityTimeNormalPretty(delta: delta, in: timeZone)
        case .military:
            return ""
        }
    }
    func utilityDateNormal(startDelta: TimeInterval, to end: Date? = nil,
                           endDelta: TimeInterval? = nil, style: Format.Style,
                           in timeZone: TimeZone) -> String {
        switch style {
        case .simple:
            return utilityDateNormalSimple(startDelta: startDelta, to: end, endDelta: endDelta, in: timeZone)
        case .smart:
            return utilityDateNormalSmart(startDelta: startDelta, to: end, endDelta: endDelta, in: timeZone)
        case .pretty:
            return utilityDateNormalPretty(startDelta: startDelta, to: end, endDelta: endDelta, in: timeZone)
        case .military:
            return ""
        }
    }
    func utilityTimeNormal(startDelta: TimeInterval, to end: Date? = nil,
                           endDelta: TimeInterval? = nil, style: Format.Style,
                           in timeZone: TimeZone) -> String {
        switch style {
        case .simple:
            return utilityTimeNormalSimple(startDelta: startDelta, to: end, endDelta: endDelta, in: timeZone)
        case .smart:
            return utilityTimeNormalSmart(startDelta: startDelta, to: end, endDelta: endDelta, in: timeZone)
        case .pretty:
            return utilityTimeNormalPretty(startDelta: startDelta, to: end, endDelta: endDelta, in: timeZone)
        case .military:
            return ""
        }
    }

    private func utilityDateNormalSimple(delta: TimeInterval,
                                         in timeZone: TimeZone) -> String {
        return self.utilityDateNormalSimple(startDelta: delta, in: timeZone)
    }
    private func utilityDateNormalSimple(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil,
                                         in timeZone: TimeZone) -> String {
        let dayFormatString = "MMM d, yyyy"
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = dayFormatString
        var retval = dateFormatter.string(from: self)
        guard end != nil && end != self else { return retval }

        let endString = end!.utilityDateNormalSimple(startDelta: endDelta!, to: end, endDelta: endDelta, in: timeZone)
        guard retval != endString else { return retval }
        retval += " - " + endString
        return retval
    }
    private func utilityDateNormalSmart(delta: TimeInterval,
                                        in timeZone: TimeZone) -> String {
        return self.utilityDateNormalSmart(startDelta: delta, in: timeZone)
    }
    private func utilityDateNormalSmart(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil,
                                        in timeZone: TimeZone) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        let yearFormatSubString = (self.isSameYear(as: end ?? Date(), in: timeZone) && (end != self)) ? "" : ", yyyy"
        let dateFormatString = "MMM d\(yearFormatSubString)"
        dateFormatter.dateFormat = dateFormatString
        var retval = dateFormatter.string(from: self)
        guard end != nil && end != self else { return retval }

        let endString = end!.utilityDateNormalSmart(startDelta: endDelta!, to: end, endDelta: endDelta, in: timeZone)
        guard retval != endString else { return retval }
        retval += " - " + endString
        return retval
    }
    private func utilityDateNormalPretty(delta: TimeInterval,
                                         in timeZone: TimeZone) -> String {
        return self.utilityDateNormalPretty(startDelta: delta, in: timeZone)
    }
    private func utilityDateNormalPretty(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil,
                                         in timeZone: TimeZone) -> String {
        var retval = ""

        if startDelta < 0 {
            retval = utilityDateShortPrettyPast(delta: startDelta, in: timeZone)
        } else {
            retval = utilityDateShortPrettyFuture(delta: startDelta, in: timeZone)
        }
        guard end != nil && end != self else { return retval }

        let endString = end!.utilityDateNormalPretty(startDelta: endDelta!, to: end, endDelta: endDelta, in: timeZone)
        guard retval != endString else { return retval }
        retval += " - " + endString
        return retval
    }
    private func utilityDateShortPrettyFuture(delta: TimeInterval,
                                              in timeZone: TimeZone) -> String {
        var retval = ""

        switch delta {
        case 0..<Seconds.deltaOneDay:
            retval = self.isToday ? C.Localizations.DatePretty.today :
                C.Localizations.DatePretty.tomorrow
        case 0..<Seconds.deltaTwoDays:
            retval = self.isToday ? C.Localizations.DatePretty.tomorrow :
                String(format: C.Localizations.DatePretty.inDays, "2")
        case 0..<Seconds.deltaThreeDays:
            retval = String(format: C.Localizations.DatePretty.inDays, "2")
        case 0..<Seconds.deltaOneWeek:
            retval = String(format: C.Localizations.DatePretty.inDays, "3+")
        case 0..<Seconds.deltaTwoWeeks:
            retval = String(format: C.Localizations.DatePretty.inWeek, "1")
        case 0..<Seconds.deltaThreeWeeks:
            retval = String(format: C.Localizations.DatePretty.inWeeks, "2")
        case 0..<Seconds.deltaSixWeeks:
            retval = String(format: C.Localizations.DatePretty.inWeeks, "3+")
        default:
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = timeZone
            dateFormatter.dateStyle = DateFormatter.Style.short
            retval = dateFormatter.string(from: self)
        }

        return retval
    }
    private func utilityDateShortPrettyPast(delta: TimeInterval,
                                            in timeZone: TimeZone) -> String {
        let deltaPast = 0 - delta
        var retval = ""

        switch deltaPast {
        case 0..<Seconds.deltaOneDay:
            retval = self.isToday ? C.Localizations.DatePretty.today :
                C.Localizations.DatePretty.yesterday
        case 0..<Seconds.deltaTwoDays:
            retval = self.isToday ? C.Localizations.DatePretty.yesterday :
                String(format: C.Localizations.DatePretty.daysAgo, "2")
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
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = timeZone
            dateFormatter.dateStyle = DateFormatter.Style.short
            retval = dateFormatter.string(from: self)
        }

        return retval
    }

    private func utilityTimeNormalSimple(delta: TimeInterval,
                                         in timeZone: TimeZone) -> String {
        var timeFormatString = "h:mma"
        if timeZone != TimeZone.current {
            timeFormatString += " zzz"
        }
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = timeFormatString
        let retval = dateFormatter.string(from: self)
        return Date.utilityMinimizeAmPm(of: retval)
    }
    private func utilityTimeNormalSimple(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil,
                                         in timeZone: TimeZone) -> String {
        let dayFormatString = "MMM d, yyyy @ "
        var timeFormatString = "\(dayFormatString)h:mma"
        if timeZone != TimeZone.current {
            if end == nil || end == self {
                timeFormatString += " zzz"
            }
        }
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = timeFormatString
        var retval = dateFormatter.string(from: self)
        retval = Date.utilityMinimizeAmPm(of: retval)
        guard end != nil && end != self else { return retval }

        let endString = end!.utilityTimeNormalSimple(startDelta: endDelta!, to: end, endDelta: endDelta, in: timeZone)
        guard retval != endString else { return retval }
        retval += " - " + endString
        return retval
    }
    private func utilityTimeNormalSmart(delta: TimeInterval,
                                        in timeZone: TimeZone) -> String {
        var timeFormatString = "h\(self.dnsMinute > 0 ? ":mm" : "")a"
        if timeZone != TimeZone.current {
            timeFormatString += " zzz"
        }

        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = timeFormatString
        let retval = dateFormatter.string(from: self)
        return Date.utilityMinimizeAmPm(of: retval)
    }
    private func utilityTimeNormalSmart(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil,
                                        in timeZone: TimeZone) -> String {
        let yearFormatSubString = (self.isSameYear(as: end ?? Date(), in: timeZone) && (end != self)) ? "" : ", yyyy"
        let dayFormatString = self.isSameDate(as: end ?? Date(), in: timeZone) ? "" : "MMM d\(yearFormatSubString) @ "
        var timeFormatString = "\(dayFormatString)h\(self.dnsMinute > 0 ? ":mm" : "")a"
        if timeZone != TimeZone.current {
            if end == nil || end == self {
                timeFormatString += " zzz"
            }
        }

        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = timeFormatString
        var retval = dateFormatter.string(from: self)
        retval = Date.utilityMinimizeAmPm(of: retval)
        guard end != nil && end != self else { return retval }

        let endDateString = self.isSameDate(as: end!, in: timeZone) ? "" :
            end!.utilityDateNormalSmart(delta: endDelta!, in: timeZone)
        let endTimeString = end!.utilityTimeNormalSmart(startDelta: endDelta!, to: end, endDelta: endDelta, in: timeZone)
        let endString = endDateString + (endDateString.isEmpty ? "" : " @ ") + endTimeString
        guard retval != endString else { return retval }
        retval += " - " + endString
        return retval
    }

    private func utilityTimeNormalPretty(delta: TimeInterval,
                                         in timeZone: TimeZone) -> String {
        if delta < 0 {
            return utilityTimeNormalPrettyPast(delta: delta, in: timeZone)
        } else {
            return utilityTimeNormalPrettyFuture(delta: delta, in: timeZone)
        }
    }
    private func utilityTimeNormalPretty(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil,
                                         in timeZone: TimeZone) -> String {
        var retval = ""

        if startDelta < 0 {
            retval = utilityTimeNormalPrettyPast(delta: startDelta, in: timeZone)
        } else {
            retval = utilityTimeNormalPrettyFuture(delta: startDelta, in: timeZone)
        }
        guard end != nil && end != self else { return retval }

        let endString = end!.utilityTimeNormalPretty(startDelta: endDelta!, to: end, endDelta: endDelta, in: timeZone)
        guard retval != endString else { return retval }
        retval += " - " + endString
        return retval
    }
    // swiftlint:disable:next cyclomatic_complexity
    private func utilityTimeNormalPrettyFuture(delta: TimeInterval,
                                               in timeZone: TimeZone) -> String {
        var retval = ""

        switch delta {
        case 0..<Seconds.deltaOneMinute:
            retval = C.Localizations.DatePretty.justNow
        case 0..<Seconds.deltaTwoMinutes:
            retval = String(format: C.Localizations.DatePretty.inMinute, "1")
        case 0..<Seconds.deltaThreeMinutes:
            retval = String(format: C.Localizations.DatePretty.inMinutesAbbrev, "2")
        case 0..<Seconds.deltaSixMinutes:
            retval = String(format: C.Localizations.DatePretty.inMinutesAbbrev, "3+")
        case 0..<Seconds.deltaOneHour:
            let minutes = Int(floor(delta / Seconds.deltaOneMinute))
            retval = String(format: C.Localizations.DatePretty.inMinutesAbbrev, "\(minutes)")
        case 0..<Seconds.deltaTwoHours:
            retval = String(format: C.Localizations.DatePretty.inHour, "1")
        case 0..<Seconds.deltaThreeHours:
            retval = String(format: C.Localizations.DatePretty.inHours, "2")
        case 0..<Seconds.deltaSixHours:
            retval = String(format: C.Localizations.DatePretty.inHours, "3+")
        case 0..<Seconds.deltaOneDay:
            retval = C.Localizations.DatePretty.today
        case 0..<Seconds.deltaTwoDays:
            retval = C.Localizations.DatePretty.tomorrow
        case 0..<Seconds.deltaThreeDays:
            retval = String(format: C.Localizations.DatePretty.inDays, "2")
        case 0..<Seconds.deltaOneWeek:
            retval = String(format: C.Localizations.DatePretty.inDays, "3+")
        case 0..<Seconds.deltaTwoWeeks:
            retval = String(format: C.Localizations.DatePretty.inWeek, "1")
        case 0..<Seconds.deltaThreeWeeks:
            retval = String(format: C.Localizations.DatePretty.inWeeks, "2")
        case 0..<Seconds.deltaSixWeeks:
            retval = String(format: C.Localizations.DatePretty.inWeeks, "3+")
        default:
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = timeZone
            dateFormatter.dateStyle = DateFormatter.Style.short
            retval = dateFormatter.string(from: self)
        }

        return retval
    }
    // swiftlint:disable:next cyclomatic_complexity
    private func utilityTimeNormalPrettyPast(delta: TimeInterval,
                                             in timeZone: TimeZone) -> String {
        let deltaPast = 0 - delta
        var retval = ""

        switch deltaPast {
        case 0..<Seconds.deltaOneMinute:
            retval = C.Localizations.DatePretty.justNow
        case 0..<Seconds.deltaTwoMinutes:
            retval = String(format: C.Localizations.DatePretty.minuteAgo, "1")
        case 0..<Seconds.deltaThreeMinutes:
            retval = String(format: C.Localizations.DatePretty.minutesAgoAbbrev, "2")
        case 0..<Seconds.deltaSixMinutes:
            retval = String(format: C.Localizations.DatePretty.minutesAgoAbbrev, "3+")
        case 0..<Seconds.deltaOneHour:
            let minutesAgo = Int(floor(deltaPast / Seconds.deltaOneMinute))
            retval = String(format: C.Localizations.DatePretty.minutesAgoAbbrev, "\(minutesAgo)")
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
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = timeZone
            dateFormatter.dateStyle = DateFormatter.Style.short
            retval = NSLocalizedString("\(dateFormatter.string(from: self))", comment: "")
        }

        return retval
    }
}
