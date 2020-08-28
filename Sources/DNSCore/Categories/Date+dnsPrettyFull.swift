//
//  Date+dnsPretty.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public extension Date {
    func utilityDateFull(delta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil, style: Format.Style) -> String {
        switch style {
        case .simple:
            return utilityDateFullSimple(delta: delta, to: end, endDelta: endDelta)
        case .smart:
            return utilityDateFullSmart(delta: delta, to: end, endDelta: endDelta)
        case .pretty:
            return utilityDateFullPretty(delta: delta, to: end, endDelta: endDelta)
        }
    }

    func utilityTimeFull(delta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil, style: Format.Style) -> String {
        switch style {
        case .simple:
            return utilityTimeFullSimple(delta: delta, to: end, endDelta: endDelta)
        case .smart:
            return utilityTimeFullSmart(delta: delta, to: end, endDelta: endDelta)
        case .pretty:
            return utilityTimeFullPretty(delta: delta, to: end, endDelta: endDelta)
        }
    }

    private func utilityDateFullSimple(delta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
        var retval = DateFormatter.localizedString(from: self,
                                                   dateStyle: DateFormatter.Style.full,
                                                   timeStyle: DateFormatter.Style.none)
        guard end != nil else { return retval }

        retval += " - " + end!.utilityDateFullSimple(delta: endDelta!)
        return retval
    }
    private func utilityDateFullSmart(delta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
        let dateFormatter = DateFormatter()
        let weekdayFormatSubString = self.isSameDay(as: end) ? "" : "EEEE, "
        let yearFormatSubString = self.isSameYear(as: end) ? "" : ", yyyy"
        let dateFormatString = "\(weekdayFormatSubString)MMMM d\(yearFormatSubString)"
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: dateFormatString,
                                                            options: 0,
                                                            locale: Locale.current)
        var retval = dateFormatter.string(from: self)
        guard end != nil else { return retval }

        retval += " - " + end!.utilityDateFullSmart(delta: endDelta!)
        return retval
    }
    private func utilityDateFullPretty(delta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
        var retval = ""

        if delta < Seconds.deltaOneDay {
            retval = C.Localizations.DatePretty.today
        } else if delta < Seconds.deltaTwoDays {
            retval = C.Localizations.DatePretty.yesterday
        } else if delta < Seconds.deltaOneWeek {
            let daysAgo = Int(floor(delta / Seconds.deltaOneDay))
            retval = String(format: C.Localizations.DatePretty.daysAgo, "\(daysAgo)")
        } else if delta < Seconds.deltaTwoWeeks {
            retval = C.Localizations.DatePretty.lastWeek
        } else if delta < Seconds.deltaSixWeeks {
            let weeksAgo = Int(floor(delta / Seconds.deltaOneWeek))
            retval = String(format: C.Localizations.DatePretty.weeksAgo, "\(weeksAgo)")
        } else {
            retval = Formatters.dateFull.string(from: self)
        }
        guard end != nil else { return retval }

        retval += " \(C.Localizations.DatePretty.to) " + end!.utilityDateFullPretty(delta: endDelta!)
        return retval
    }

    private func utilityTimeFullSimple(delta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
        let dateStyle = self.isSameDate(as: end) ? DateFormatter.Style.none : DateFormatter.Style.full
        var retval = DateFormatter.localizedString(from: self,
                                                   dateStyle: dateStyle,
                                                   timeStyle: DateFormatter.Style.full)
        retval = utilityMinimizeAmPm(of: retval)
        guard end != nil else { return retval }

        retval += " - " + end!.utilityTimeFullSimple(delta: endDelta!)
        return retval
    }
    private func utilityTimeFullSmart(delta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
        let weekdayFormatSubString = self.isSameDay(as: end) ? "" : "EEEE, "
        let yearFormatSubString = self.isSameYear(as: end) ? "" : ", yyyy"
        let dayFormatString = self.isSameDate(as: end) ? "" :
            "\(weekdayFormatSubString)MMMM d\(yearFormatSubString) '\(C.Localizations.DatePretty.at)' "
        let timeFormatString = "\(dayFormatString)h:mm\(self.dnsSecond() > 0 ? ":ss" : "")a zzzz"

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: timeFormatString,
                                                            options: 0,
                                                            locale: Locale.current)
        var retval = dateFormatter.string(from: self)
        retval = utilityMinimizeAmPm(of: retval)
        guard end != nil else { return retval }

        retval += " - " + end!.utilityTimeFullSmart(delta: endDelta!)
        return retval
    }
    private func utilityTimeFullPretty(delta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
        var retval = ""

        if delta < Seconds.deltaOneMinute {
            retval = C.Localizations.DatePretty.justNow
        } else if delta < Seconds.deltaTwoMinutes {
            retval = C.Localizations.DatePretty.oneMinuteAgo
        } else if delta < Seconds.deltaOneHour {
            let minutesAgo = Int(floor(delta / Seconds.deltaOneMinute))
            retval = String(format: C.Localizations.DatePretty.minutesAgo, "\(minutesAgo)")
        } else if delta < Seconds.deltaTwoHours {
            retval = C.Localizations.DatePretty.oneHourAgo
        } else if delta < Seconds.deltaOneDay {
            let hoursAgo = Int(floor(delta / Seconds.deltaOneHour))
            retval = String(format: C.Localizations.DatePretty.hoursAgo, "\(hoursAgo)")
        } else if delta < Seconds.deltaTwoDays {
            retval = C.Localizations.DatePretty.yesterday
        } else if delta < Seconds.deltaOneWeek {
            let daysAgo = Int(floor(delta / Seconds.deltaOneDay))
            retval = String(format: C.Localizations.DatePretty.daysAgo, "\(daysAgo)")
        } else if delta < Seconds.deltaTwoWeeks {
            retval = C.Localizations.DatePretty.lastWeek
        } else if delta < Seconds.deltaSixWeeks {
            let weeksAgo = Int(floor(delta / Seconds.deltaOneWeek))
            retval = String(format: C.Localizations.DatePretty.weeksAgo, "\(weeksAgo)")
        } else {
            retval = "\(Formatters.dateFull.string(from: self))"
        }
        guard end != nil else { return retval }

        retval += " \(C.Localizations.DatePretty.to) " + end!.utilityTimeFullPretty(delta: endDelta!)
        return retval
    }
}
