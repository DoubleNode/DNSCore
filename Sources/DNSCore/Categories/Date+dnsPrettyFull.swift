//
//  Date+dnsPrettyFull.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public extension Date {
    func utilityDateFull(delta: TimeInterval, style: Format.Style,
                         in timeZone: TimeZone) -> String {
        switch style {
        case .simple:
            return utilityDateFullSimple(delta: delta, in: timeZone)
        case .smart:
            return utilityDateFullSmart(delta: delta, in: timeZone)
        case .pretty:
            return utilityDateFullPretty(delta: delta, in: timeZone)
        case .military:
            return ""
        }
    }
    func utilityTimeFull(delta: TimeInterval, style: Format.Style,
                         in timeZone: TimeZone) -> String {
        switch style {
        case .simple:
            return utilityTimeFullSimple(delta: delta, in: timeZone)
        case .smart:
            return utilityTimeFullSmart(delta: delta, in: timeZone)
        case .pretty:
            return utilityTimeFullPretty(delta: delta, in: timeZone)
        case .military:
            return ""
        }
    }
    func utilityDateFull(startDelta: TimeInterval, to end: Date? = nil,
                         endDelta: TimeInterval? = nil, style: Format.Style,
                         in timeZone: TimeZone) -> String {
        switch style {
        case .simple:
            return utilityDateFullSimple(startDelta: startDelta, to: end, endDelta: endDelta, in: timeZone)
        case .smart:
            return utilityDateFullSmart(startDelta: startDelta, to: end, endDelta: endDelta, in: timeZone)
        case .pretty:
            return utilityDateFullPretty(startDelta: startDelta, to: end, endDelta: endDelta, in: timeZone)
        case .military:
            return ""
        }
    }
    func utilityTimeFull(startDelta: TimeInterval, to end: Date? = nil,
                         endDelta: TimeInterval? = nil, style: Format.Style,
                         in timeZone: TimeZone) -> String {
        switch style {
        case .simple:
            return utilityTimeFullSimple(startDelta: startDelta, to: end, endDelta: endDelta, in: timeZone)
        case .smart:
            return utilityTimeFullSmart(startDelta: startDelta, to: end, endDelta: endDelta, in: timeZone)
        case .pretty:
            return utilityTimeFullPretty(startDelta: startDelta, to: end, endDelta: endDelta, in: timeZone)
        case .military:
            return ""
        }
    }

    private func utilityDateFullSimple(delta: TimeInterval,
                                       in timeZone: TimeZone) -> String {
        return self.utilityDateFullSimple(startDelta: delta, in: timeZone)
    }
    private func utilityDateFullSimple(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil,
                                       in timeZone: TimeZone) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.dateStyle = DateFormatter.Style.full
        dateFormatter.timeStyle = DateFormatter.Style.none
        var retval = dateFormatter.string(from: self)
        guard end != nil && end != self else { return retval }

        let endString = end!.utilityDateFullSimple(startDelta: endDelta!, to: end, endDelta: endDelta, in: timeZone)
        guard retval != endString else { return retval }
        retval += " - " + endString
        return retval
    }
    private func utilityDateFullSmart(delta: TimeInterval,
                                      in timeZone: TimeZone) -> String {
        return self.utilityDateFullSmart(startDelta: delta, in: timeZone)
    }
    private func utilityDateFullSmart(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil,
                                      in timeZone: TimeZone) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        let weekdayFormatSubString = (self.isSameDay(as: end ?? Date()) && (end != self)) ? "" : "EEEE, "
        let yearFormatSubString = (self.isSameYear(as: end ?? Date()) && (end != self)) ? "" : ", yyyy"
        let dateFormatString = "\(weekdayFormatSubString)MMMM d\(yearFormatSubString)"
        dateFormatter.dateFormat = dateFormatString
        var retval = dateFormatter.string(from: self)
        guard end != nil && end != self else { return retval }

        let endString = end!.utilityDateFullSmart(startDelta: endDelta!, to: end, endDelta: endDelta, in: timeZone)
        guard retval != endString else { return retval }
        retval += " - " + endString
        return retval
    }
    private func utilityDateFullPretty(delta: TimeInterval,
                                       in timeZone: TimeZone) -> String {
        return self.utilityDateFullPretty(startDelta: delta, in: timeZone)
    }
    private func utilityDateFullPretty(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil,
                                       in timeZone: TimeZone) -> String {
        var retval = ""

        if startDelta < Seconds.deltaOneDay {
            retval = C.Localizations.DatePretty.today
        } else if startDelta < Seconds.deltaTwoDays {
            retval = C.Localizations.DatePretty.yesterday
        } else if startDelta < Seconds.deltaOneWeek {
            let daysAgo = Int(floor(startDelta / Seconds.deltaOneDay))
            retval = String(format: C.Localizations.DatePretty.daysAgo, "\(daysAgo)")
        } else if startDelta < Seconds.deltaTwoWeeks {
            retval = C.Localizations.DatePretty.lastWeek
        } else if startDelta < Seconds.deltaSixWeeks {
            let weeksAgo = Int(floor(startDelta / Seconds.deltaOneWeek))
            retval = String(format: C.Localizations.DatePretty.weeksAgo, "\(weeksAgo)")
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = timeZone
            dateFormatter.dateStyle = DateFormatter.Style.full
            retval = dateFormatter.string(from: self)
        }
        guard end != nil && end != self else { return retval }

        let endString = end!.utilityDateFullPretty(startDelta: endDelta!, to: end, endDelta: endDelta, in: timeZone)
        guard retval != endString else { return retval }
        retval += " \(C.Localizations.DatePretty.to) " + endString
        return retval
    }

    private func utilityTimeFullSimple(delta: TimeInterval,
                                       in timeZone: TimeZone) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.dateStyle = DateFormatter.Style.none
        dateFormatter.timeStyle = DateFormatter.Style.full
        let retval = dateFormatter.string(from: self)
        return Date.utilityMinimizeAmPm(of: retval)
    }
    private func utilityTimeFullSimple(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil,
                                       in timeZone: TimeZone) -> String {
        let dateStyle = DateFormatter.Style.full
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.dateStyle = dateStyle
        dateFormatter.timeStyle = DateFormatter.Style.full
        var retval = dateFormatter.string(from: self)
        retval = Date.utilityMinimizeAmPm(of: retval)
        guard end != nil && end != self else { return retval }

        let endDateString = end!.utilityDateFullSimple(delta: endDelta!, in: timeZone)
        let endTimeString = end!.utilityTimeFullSimple(startDelta: endDelta!, to: end, endDelta: endDelta, in: timeZone)
        let endString = endDateString + " \(C.Localizations.DatePretty.at) " + endTimeString
        guard retval != endString else { return retval }
        retval += " - " + endString
        return retval
    }
    private func utilityTimeFullSmart(delta: TimeInterval,
                                      in timeZone: TimeZone) -> String {
        var timeFormatString = "h:mm\(self.dnsSecond() > 0 ? ":ss" : "")a"
        if timeZone != TimeZone.current {
            timeFormatString += " zzzz"
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = timeFormatString
        let retval = dateFormatter.string(from: self)
        return Date.utilityMinimizeAmPm(of: retval)
    }
    private func utilityTimeFullSmart(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil,
                                      in timeZone: TimeZone) -> String {
        let weekdayFormatSubString = (self.isSameDay(as: end ?? Date()) && (end != self)) ? "" : "EEEE, "
        let yearFormatSubString = (self.isSameYear(as: end ?? Date()) && (end != self)) ? "" : ", yyyy"
        let dayFormatString = self.isSameDate(as: end ?? Date()) ? "" :
            "\(weekdayFormatSubString)MMMM d\(yearFormatSubString) '\(C.Localizations.DatePretty.at)' "
        var timeFormatString = "\(dayFormatString)h:mm\(self.dnsSecond() > 0 ? ":ss" : "")a"
        if timeZone != TimeZone.current {
            if end == nil || end == self {
                timeFormatString += " zzzz"
            }
        }

        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = timeFormatString
        var retval = dateFormatter.string(from: self)
        retval = Date.utilityMinimizeAmPm(of: retval)
        guard end != nil && end != self else { return retval }

        let endDateString = end!.utilityDateFullSmart(delta: endDelta!, in: timeZone)
        let endTimeString = end!.utilityTimeFullSmart(startDelta: endDelta!, to: end, endDelta: endDelta, in: timeZone)
        let endString = endDateString + " \(C.Localizations.DatePretty.at) " + endTimeString
        guard retval != endString else { return retval }
        retval += " - " + endString
        return retval
    }
    private func utilityTimeFullPretty(delta: TimeInterval,
                                       in timeZone: TimeZone) -> String {
        return self.utilityTimeFullPretty(startDelta: delta, in: timeZone)
    }
    private func utilityTimeFullPretty(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil,
                                       in timeZone: TimeZone) -> String {
        var retval = ""

        if startDelta < Seconds.deltaOneMinute {
            retval = C.Localizations.DatePretty.justNow
        } else if startDelta < Seconds.deltaTwoMinutes {
            retval = C.Localizations.DatePretty.oneMinuteAgo
        } else if startDelta < Seconds.deltaOneHour {
            let minutesAgo = Int(floor(startDelta / Seconds.deltaOneMinute))
            retval = String(format: C.Localizations.DatePretty.minutesAgo, "\(minutesAgo)")
        } else if startDelta < Seconds.deltaTwoHours {
            retval = C.Localizations.DatePretty.oneHourAgo
        } else if startDelta < Seconds.deltaOneDay {
            let hoursAgo = Int(floor(startDelta / Seconds.deltaOneHour))
            retval = String(format: C.Localizations.DatePretty.hoursAgo, "\(hoursAgo)")
        } else if startDelta < Seconds.deltaTwoDays {
            retval = C.Localizations.DatePretty.yesterday
        } else if startDelta < Seconds.deltaOneWeek {
            let daysAgo = Int(floor(startDelta / Seconds.deltaOneDay))
            retval = String(format: C.Localizations.DatePretty.daysAgo, "\(daysAgo)")
        } else if startDelta < Seconds.deltaTwoWeeks {
            retval = C.Localizations.DatePretty.lastWeek
        } else if startDelta < Seconds.deltaSixWeeks {
            let weeksAgo = Int(floor(startDelta / Seconds.deltaOneWeek))
            retval = String(format: C.Localizations.DatePretty.weeksAgo, "\(weeksAgo)")
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = timeZone
            dateFormatter.dateStyle = DateFormatter.Style.full
            retval = "\(dateFormatter.string(from: self))"
        }
        guard end != nil && end != self else { return retval }

        let endString = end!.utilityTimeFullPretty(startDelta: endDelta!, to: end, endDelta: endDelta, in: timeZone)
        guard retval != endString else { return retval }
        retval += " \(C.Localizations.DatePretty.to) " + endString
        return retval
    }
}
