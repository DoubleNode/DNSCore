//
//  Date+dnsPrettyShort.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public extension Date {
    func utilityAtShort(style: Format.Style) -> String {
        switch style {
        case .simple:
            return ", "
        case .smart:
            return ", "
        case .pretty:
            return ", "
        case .military:
            return ""
        }
    }
    func utilityDateShort(delta: TimeInterval, style: Format.Style,
                          in timeZone: TimeZone) -> String {
        switch style {
        case .simple:
            return utilityDateShortSimple(delta: delta, in: timeZone)
        case .smart:
            return utilityDateShortSmart(delta: delta, in: timeZone)
        case .pretty:
            return utilityDateShortPretty(delta: delta, in: timeZone)
        case .military:
            return utilityDateShortMilitary(delta: delta, in: timeZone)
        }
    }
    func utilityTimeShort(delta: TimeInterval, style: Format.Style,
                          in timeZone: TimeZone) -> String {
        switch style {
        case .simple:
            return utilityTimeShortSimple(delta: delta, in: timeZone)
        case .smart:
            return utilityTimeShortSmart(delta: delta, in: timeZone)
        case .pretty:
            return utilityTimeShortPretty(delta: delta, in: timeZone)
        case .military:
            return utilityTimeShortMilitary(delta: delta, in: timeZone)
        }
    }
    func utilityDateShort(startDelta: TimeInterval, to end: Date? = nil,
                          endDelta: TimeInterval? = nil, style: Format.Style,
                          in timeZone: TimeZone) -> String {
        switch style {
        case .simple:
            return utilityDateShortSimple(startDelta: startDelta, to: end, endDelta: endDelta, in: timeZone)
        case .smart:
            return utilityDateShortSmart(startDelta: startDelta, to: end, endDelta: endDelta, in: timeZone)
        case .pretty:
            return utilityDateShortPretty(startDelta: startDelta, to: end, endDelta: endDelta, in: timeZone)
        case .military:
            return utilityDateShortMilitary(startDelta: startDelta, to: end, endDelta: endDelta, in: timeZone)
        }
    }
    func utilityTimeShort(startDelta: TimeInterval, to end: Date? = nil,
                          endDelta: TimeInterval? = nil, style: Format.Style,
                          in timeZone: TimeZone) -> String {
        switch style {
        case .simple:
            return utilityTimeShortSimple(startDelta: startDelta, to: end, endDelta: endDelta, in: timeZone)
        case .smart:
            return utilityTimeShortSmart(startDelta: startDelta, to: end, endDelta: endDelta, in: timeZone)
        case .pretty:
            return utilityTimeShortPretty(startDelta: startDelta, to: end, endDelta: endDelta, in: timeZone)
        case .military:
            return utilityTimeShortMilitary(startDelta: startDelta, to: end, endDelta: endDelta, in: timeZone)
        }
    }

    private func utilityDateShortSimple(delta: TimeInterval,
                                        in timeZone: TimeZone) -> String {
        return self.utilityDateShortSimple(startDelta: delta, in: timeZone)
    }
    private func utilityDateShortSimple(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil,
                                        in timeZone: TimeZone) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.none
        var retval = dateFormatter.string(from: self)
        guard end != nil && end != self else { return retval }

        let endString = end!.utilityDateShortSimple(startDelta: endDelta!, to: end, endDelta: endDelta, in: timeZone)
        guard retval != endString else { return retval }
        retval += " - " + endString
        return retval
    }
    private func utilityDateShortSmart(delta: TimeInterval,
                                       in timeZone: TimeZone) -> String {
        return self.utilityDateShortSmart(startDelta: delta, in: timeZone)
    }
    private func utilityDateShortSmart(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil,
                                       in timeZone: TimeZone) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        let yearFormatSubString = (self.isSameYear(as: /*end ?? */Date(), in: timeZone) && (end != self)) ? "" : "/yy"
        let dateFormatString = "M/d\(yearFormatSubString)"
        dateFormatter.dateFormat = dateFormatString
        var retval = dateFormatter.string(from: self)
        guard end != nil && end != self else { return retval }

        let endString = end!.utilityDateShortSmart(startDelta: endDelta!, to: end, endDelta: endDelta, in: timeZone)
        guard retval != endString else { return retval }
        retval += " - " + endString
        return retval
    }
    private func utilityDateShortPretty(delta: TimeInterval,
                                        in timeZone: TimeZone) -> String {
        return self.utilityDateShortPretty(startDelta: delta, in: timeZone)
    }
    private func utilityDateShortPretty(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil,
                                        in timeZone: TimeZone) -> String {
        var retval = ""

        if startDelta < 0 {
            retval = utilityDateShortPrettyPast(delta: startDelta, in: timeZone)
        } else {
            retval = utilityDateShortPrettyFuture(delta: startDelta, in: timeZone)
        }
        guard end != nil && end != self else { return retval }

        let endString = end!.utilityDateShortPretty(startDelta: endDelta!, to: end, endDelta: endDelta, in: timeZone)
        guard retval != endString else { return retval }
        retval += " - " + endString
        return retval
    }
    private func utilityDateShortPrettyFuture(delta: TimeInterval,
                                              in timeZone: TimeZone) -> String {
        var retval = ""

        switch delta {
        case 0..<Seconds.deltaOneDay:
            retval = self.isToday ? C.Localizations.DatePretty.todayShort :
                C.Localizations.DatePretty.tomorrowShort
        case 0..<Seconds.deltaTwoDays:
            retval = self.isToday ? C.Localizations.DatePretty.tomorrowShort :
                String(format: C.Localizations.DatePretty.inDaysShort, "2")
        case 0..<Seconds.deltaThreeDays:
            retval = String(format: C.Localizations.DatePretty.inDaysShort, "2")
        case 0..<Seconds.deltaOneWeek:
            retval = String(format: C.Localizations.DatePretty.inDaysShort, "3+")
        case 0..<Seconds.deltaTwoWeeks:
            retval = String(format: C.Localizations.DatePretty.inWeekShort, "1")
        case 0..<Seconds.deltaThreeWeeks:
            retval = String(format: C.Localizations.DatePretty.inWeeksShort, "2")
        case 0..<Seconds.deltaSixWeeks:
            retval = String(format: C.Localizations.DatePretty.inWeeksShort, "3+")
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
            retval = self.isToday ? C.Localizations.DatePretty.todayShort :
                C.Localizations.DatePretty.yesterdayShort
        case 0..<Seconds.deltaTwoDays:
            retval = self.isToday ? C.Localizations.DatePretty.yesterdayShort :
                String(format: C.Localizations.DatePretty.daysAgoShort, "2")
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
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = timeZone
            dateFormatter.dateStyle = DateFormatter.Style.short
            retval = NSLocalizedString("\(dateFormatter.string(from: self))", comment: "")
        }

        return retval
    }
    private func utilityDateShortMilitary(delta: TimeInterval,
                                          in timeZone: TimeZone) -> String {
        return self.utilityDateShortMilitary(startDelta: delta, in: timeZone)
    }
    private func utilityDateShortMilitary(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil,
                                          in timeZone: TimeZone) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = "yyyyMMdd"
        var retval = dateFormatter.string(from: self)
        guard end != nil && end != self else { return retval }

        let endString = end!.utilityDateShortMilitary(startDelta: endDelta!, to: end, endDelta: endDelta, in: timeZone)
        guard retval != endString else { return retval }
        retval += " - " + endString
        return retval
    }

    private func utilityTimeShortSimple(delta: TimeInterval,
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
    private func utilityTimeShortSimple(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil,
                                        in timeZone: TimeZone) -> String {
        let dayFormatString = "M/d/yy, "
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

        let endString = end!.utilityTimeShortSimple(startDelta: endDelta!, to: end, endDelta: endDelta, in: timeZone)
        guard retval != endString else { return retval }
        retval += " - " + endString
        return retval
    }

    private func utilityTimeShortSmart(delta: TimeInterval,
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
    private func utilityTimeShortSmart(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil,
                                       in timeZone: TimeZone) -> String {
        let yearFormatSubString = (self.isSameYear(as: /*end ?? */Date(), in: timeZone) && (end != self)) ? "" : "/yy"
        let dayFormatString = (self.isSameDate(as: /*end ?? */Date(), in: timeZone) && (end != self)) ? "" : "M/d\(yearFormatSubString) '@' "
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

        let endDateString = self.isSameDate(as: end ?? Date(), in: timeZone) ? "" :
            end!.utilityDateShortSmart(delta: endDelta!, in: timeZone)
        let endTimeString = end!.utilityTimeShortSmart(startDelta: endDelta!, to: end, endDelta: endDelta, in: timeZone)
        let endString = endDateString + (endDateString.isEmpty ? "" : " @ ") + endTimeString
        guard retval != endString else { return retval }
        retval += " - " + endString
        return retval
    }

    private func utilityTimeShortPretty(delta: TimeInterval,
                                        in timeZone: TimeZone) -> String {
        if delta < 0 {
            return utilityTimeShortPrettyPast(delta: delta, in: timeZone)
        } else {
            return utilityTimeShortPrettyFuture(delta: delta, in: timeZone)
        }
    }
    private func utilityTimeShortPretty(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil,
                                        in timeZone: TimeZone) -> String {
        var retval = ""

        if startDelta < 0 {
            retval = utilityTimeShortPrettyPast(delta: startDelta, in: timeZone)
        } else {
            retval = utilityTimeShortPrettyFuture(delta: startDelta, in: timeZone)
        }
        guard end != nil && end != self else { return retval }

        let endDateString = end!.utilityDateShortPretty(delta: endDelta!, in: timeZone)
        let endTimeString = end!.utilityTimeShortPretty(startDelta: endDelta!, to: end, endDelta: endDelta, in: timeZone)
        let endString = endDateString + " @ " + endTimeString
        guard retval != endString else { return retval }
        retval += " - " + endString
        return retval
    }
    // swiftlint:disable:next cyclomatic_complexity
    private func utilityTimeShortPrettyFuture(delta: TimeInterval,
                                              in timeZone: TimeZone) -> String {
        var retval = ""

        switch delta {
        case 0..<Seconds.deltaOneMinute:
            retval = C.Localizations.DatePretty.now
        case 0..<Seconds.deltaTwoMinutes:
            retval = String(format: C.Localizations.DatePretty.inMinuteShort, "1")
        case 0..<Seconds.deltaThreeMinutes:
            retval = String(format: C.Localizations.DatePretty.inMinutesShort, "2")
        case 0..<Seconds.deltaSixMinutes:
            retval = String(format: C.Localizations.DatePretty.inMinutesShort, "3+")
        case 0..<Seconds.deltaOneHour:
            let minutes = Int(floor(delta / Seconds.deltaOneMinute))
            retval = String(format: C.Localizations.DatePretty.inMinutesShort, "\(minutes)")
        case 0..<Seconds.deltaTwoHours:
            retval = String(format: C.Localizations.DatePretty.inHourShort, "1")
        case 0..<Seconds.deltaThreeHours:
            retval = String(format: C.Localizations.DatePretty.inHoursShort, "2")
        case 0..<Seconds.deltaSixHours:
            retval = String(format: C.Localizations.DatePretty.inHoursShort, "3+")
        case 0..<Seconds.deltaOneDay:
            retval = C.Localizations.DatePretty.todayShort
        case 0..<Seconds.deltaTwoDays:
            retval = C.Localizations.DatePretty.tomorrowShort
        case 0..<Seconds.deltaThreeDays:
            retval = String(format: C.Localizations.DatePretty.inDaysShort, "2")
        case 0..<Seconds.deltaOneWeek:
            retval = String(format: C.Localizations.DatePretty.inDaysShort, "3+")
        case 0..<Seconds.deltaTwoWeeks:
            retval = String(format: C.Localizations.DatePretty.inWeekShort, "1")
        case 0..<Seconds.deltaThreeWeeks:
            retval = String(format: C.Localizations.DatePretty.inWeeksShort, "2")
        case 0..<Seconds.deltaSixWeeks:
            retval = String(format: C.Localizations.DatePretty.inWeeksShort, "3+")
        default:
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = timeZone
            dateFormatter.dateStyle = DateFormatter.Style.short
            retval = dateFormatter.string(from: self)
        }

        return retval
    }
    // swiftlint:disable:next cyclomatic_complexity
    private func utilityTimeShortPrettyPast(delta: TimeInterval,
                                            in timeZone: TimeZone) -> String {
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
            let minutes = Int(floor(deltaPast / Seconds.deltaOneMinute))
            retval = String(format: C.Localizations.DatePretty.minutesAgoShort, "\(minutes)")
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
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = timeZone
            dateFormatter.dateStyle = DateFormatter.Style.short
            retval = dateFormatter.string(from: self)
        }

        return retval
    }
    private func utilityTimeShortMilitary(delta: TimeInterval,
                                          in timeZone: TimeZone) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = "HHmm"
        return dateFormatter.string(from: self)
    }
    private func utilityTimeShortMilitary(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil,
                                          in timeZone: TimeZone) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = "HHmm"
        var retval = dateFormatter.string(from: self)
        guard end != nil && end != self else { return retval }

        let endDateString = end!.utilityDateShortMilitary(delta: endDelta!, in: timeZone)
        let endTimeString = end!.utilityTimeShortMilitary(startDelta: endDelta!, to: end, endDelta: endDelta, in: timeZone)
        let endString = endDateString + " @ " + endTimeString
        guard retval != endString else { return retval }
        retval += " - " + endString
        return retval
    }
}
