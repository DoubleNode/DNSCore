//
//  Date+dnsPretty.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public extension Date {
    func utilityDateLong(delta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil, style: Format.Style) -> String {
        switch style {
        case .simple:
            return utilityDateLongSimple(delta: delta, to: end, endDelta: endDelta)
        case .smart:
            return utilityDateLongSmart(delta: delta, to: end, endDelta: endDelta)
        case .pretty:
            return utilityDateLongPretty(delta: delta, to: end, endDelta: endDelta)
        case .military:
            return ""
        }
    }
    func utilityTimeLong(delta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil, style: Format.Style) -> String {
        switch style {
        case .simple:
            return utilityTimeLongSimple(delta: delta, to: end, endDelta: endDelta)
        case .smart:
            return utilityTimeLongSmart(delta: delta, to: end, endDelta: endDelta)
        case .pretty:
            return utilityTimeLongPretty(delta: delta, to: end, endDelta: endDelta)
        case .military:
            return ""
        }
    }

    private func utilityDateLongSimple(delta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
        var retval = DateFormatter.localizedString(from: self,
                                                   dateStyle: DateFormatter.Style.long,
                                                   timeStyle: DateFormatter.Style.none)
        guard end != nil else { return retval }
        guard end == self else { return retval }

        let endString = end!.utilityDateLongSimple(delta: endDelta!, to: end, endDelta: endDelta)
        guard retval != endString else { return retval }
        retval += " - " + endString
        return retval
    }
    private func utilityDateLongSmart(delta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
        let dateFormatter = DateFormatter()
        let yearFormatSubString = self.isSameYear(as: end) ? "" : ", yyyy"
        let dateFormatString = "MMMM d\(yearFormatSubString)"
        dateFormatter.dateFormat = dateFormatString
        var retval = dateFormatter.string(from: self)
        guard end != nil else { return retval }
        guard end == self else { return retval }

        let endString = end!.utilityDateLongSmart(delta: endDelta!, to: end, endDelta: endDelta)
        guard retval != endString else { return retval }
        retval += " - " + endString
        return retval
    }
    private func utilityDateLongPretty(delta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
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
            retval = Formatters.dateLong.string(from: self)
        }
        guard end != nil else { return retval }
        guard end == self else { return retval }

        let endString = end!.utilityDateLongPretty(delta: endDelta!, to: end, endDelta: endDelta)
        guard retval != endString else { return retval }
        retval += " \(C.Localizations.DatePretty.to) " + endString
        return retval
    }

    private func utilityTimeLongSimple(delta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
        let dateStyle = self.isSameDate(as: end) ? DateFormatter.Style.none : DateFormatter.Style.long
        var retval = DateFormatter.localizedString(from: self,
                                                   dateStyle: dateStyle,
                                                   timeStyle: DateFormatter.Style.long)
        retval = Date.utilityMinimizeAmPm(of: retval)
        guard end != nil else { return retval }
        guard end == self else { return retval }

        let endString = end!.utilityTimeLongSimple(delta: endDelta!, to: end, endDelta: endDelta)
        guard retval != endString else { return retval }
        retval += " - " + endString
        return retval
    }
    private func utilityTimeLongSmart(delta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
        let yearFormatSubString = self.isSameYear(as: end) ? "" : ", yyyy"
        let dayFormatString = self.isSameDate(as: end) ? "" : "MMMM d\(yearFormatSubString) @ "
        let timeFormatString = "\(dayFormatString)h:mm\(self.dnsSecond() > 0 ? ":ss" : "")a zzz"

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = timeFormatString
        var retval = dateFormatter.string(from: self)
        retval = Date.utilityMinimizeAmPm(of: retval)
        guard end != nil else { return retval }
        guard end == self else { return retval }

        let endString = end!.utilityTimeLongSmart(delta: endDelta!, to: end, endDelta: endDelta)
        guard retval != endString else { return retval }
        retval += " - " + endString
        return retval
    }
    private func utilityTimeLongPretty(delta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
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
            retval = Formatters.dateLong.string(from: self)
        }
        guard end != nil else { return retval }
        guard end == self else { return retval }

        let endString = end!.utilityTimeLongPretty(delta: endDelta!, to: end, endDelta: endDelta)
        guard retval != endString else { return retval }
        retval += " \(C.Localizations.DatePretty.to) " + endString
        return retval
    }
}
