//
//  Date+dnsPretty.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public extension Date {
    func utilityDateFull(delta: TimeInterval, style: Format.Style) -> String {
        switch style {
        case .simple:
            return utilityDateFullSimple(delta: delta)
        case .smart:
            return utilityDateFullSmart(delta: delta)
        case .pretty:
            return utilityDateFullPretty(delta: delta)
        case .military:
            return ""
        }
    }
    func utilityTimeFull(delta: TimeInterval, style: Format.Style) -> String {
        switch style {
        case .simple:
            return utilityTimeFullSimple(delta: delta)
        case .smart:
            return utilityTimeFullSmart(delta: delta)
        case .pretty:
            return utilityTimeFullPretty(delta: delta)
        case .military:
            return ""
        }
    }
    func utilityDateFull(startDelta: TimeInterval, to end: Date? = nil,
                         endDelta: TimeInterval? = nil, style: Format.Style) -> String {
        switch style {
        case .simple:
            return utilityDateFullSimple(startDelta: startDelta, to: end, endDelta: endDelta)
        case .smart:
            return utilityDateFullSmart(startDelta: startDelta, to: end, endDelta: endDelta)
        case .pretty:
            return utilityDateFullPretty(startDelta: startDelta, to: end, endDelta: endDelta)
        case .military:
            return ""
        }
    }
    func utilityTimeFull(startDelta: TimeInterval, to end: Date? = nil,
                         endDelta: TimeInterval? = nil, style: Format.Style) -> String {
        switch style {
        case .simple:
            return utilityTimeFullSimple(startDelta: startDelta, to: end, endDelta: endDelta)
        case .smart:
            return utilityTimeFullSmart(startDelta: startDelta, to: end, endDelta: endDelta)
        case .pretty:
            return utilityTimeFullPretty(startDelta: startDelta, to: end, endDelta: endDelta)
        case .military:
            return ""
        }
    }

    private func utilityDateFullSimple(delta: TimeInterval) -> String {
        return self.utilityDateFullSimple(startDelta: delta)
    }
    private func utilityDateFullSimple(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
        var retval = DateFormatter.localizedString(from: self,
                                                   dateStyle: DateFormatter.Style.full,
                                                   timeStyle: DateFormatter.Style.none)
        guard end != nil && end != self else { return retval }

        let endString = end!.utilityDateFullSimple(startDelta: endDelta!, to: end, endDelta: endDelta)
        guard retval != endString else { return retval }
        retval += " - " + endString
        return retval
    }
    private func utilityDateFullSmart(delta: TimeInterval) -> String {
        return self.utilityDateFullSmart(startDelta: delta)
    }
    private func utilityDateFullSmart(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
        let dateFormatter = DateFormatter()
        let weekdayFormatSubString = self.isSameDay(as: end) ? "" : "EEEE, "
        let yearFormatSubString = self.isSameYear(as: end) ? "" : ", yyyy"
        let dateFormatString = "\(weekdayFormatSubString)MMMM d\(yearFormatSubString)"
        dateFormatter.dateFormat = dateFormatString
        var retval = dateFormatter.string(from: self)
        guard end != nil && end != self else { return retval }

        let endString = end!.utilityDateFullSmart(startDelta: endDelta!, to: end, endDelta: endDelta)
        guard retval != endString else { return retval }
        retval += " - " + endString
        return retval
    }
    private func utilityDateFullPretty(delta: TimeInterval) -> String {
        return self.utilityDateFullPretty(startDelta: delta)
    }
    private func utilityDateFullPretty(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
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
            retval = Formatters.dateFull.string(from: self)
        }
        guard end != nil && end != self else { return retval }

        let endString = end!.utilityDateFullPretty(startDelta: endDelta!, to: end, endDelta: endDelta)
        guard retval != endString else { return retval }
        retval += " \(C.Localizations.DatePretty.to) " + endString
        return retval
    }

    private func utilityTimeFullSimple(delta: TimeInterval) -> String {
        let retval = DateFormatter.localizedString(from: self,
                                                   dateStyle: DateFormatter.Style.none,
                                                   timeStyle: DateFormatter.Style.full)
        return Date.utilityMinimizeAmPm(of: retval)
    }
    private func utilityTimeFullSimple(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
        let dateStyle = self.isSameDate(as: end) ? DateFormatter.Style.none : DateFormatter.Style.full
        var retval = DateFormatter.localizedString(from: self,
                                                   dateStyle: dateStyle,
                                                   timeStyle: DateFormatter.Style.full)
        retval = Date.utilityMinimizeAmPm(of: retval)
        guard end != nil && end != self else { return retval }

        let endString = end!.utilityTimeFullSimple(startDelta: endDelta!, to: end, endDelta: endDelta)
        guard retval != endString else { return retval }
        retval += " - " + endString
        return retval
    }
    private func utilityTimeFullSmart(delta: TimeInterval) -> String {
        let timeFormatString = "h:mm\(self.dnsSecond() > 0 ? ":ss" : "")a zzzz"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = timeFormatString
        let retval = dateFormatter.string(from: self)
        return Date.utilityMinimizeAmPm(of: retval)
    }
    private func utilityTimeFullSmart(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
        let weekdayFormatSubString = self.isSameDay(as: end) ? "" : "EEEE, "
        let yearFormatSubString = self.isSameYear(as: end) ? "" : ", yyyy"
        let dayFormatString = self.isSameDate(as: end) ? "" :
            "\(weekdayFormatSubString)MMMM d\(yearFormatSubString) '\(C.Localizations.DatePretty.at)' "
        let timeFormatString = "\(dayFormatString)h:mm\(self.dnsSecond() > 0 ? ":ss" : "")a zzzz"

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = timeFormatString
        var retval = dateFormatter.string(from: self)
        retval = Date.utilityMinimizeAmPm(of: retval)
        guard end != nil && end != self else { return retval }

        let endString = end!.utilityTimeFullSmart(startDelta: endDelta!, to: end, endDelta: endDelta)
        guard retval != endString else { return retval }
        retval += " - " + endString
        return retval
    }
    private func utilityTimeFullPretty(delta: TimeInterval) -> String {
        return self.utilityTimeFullPretty(startDelta: delta)
    }
    private func utilityTimeFullPretty(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
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
            retval = "\(Formatters.dateFull.string(from: self))"
        }
        guard end != nil && end != self else { return retval }

        let endString = end!.utilityTimeFullPretty(startDelta: endDelta!, to: end, endDelta: endDelta)
        guard retval != endString else { return retval }
        retval += " \(C.Localizations.DatePretty.to) " + endString
        return retval
    }
}
