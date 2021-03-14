//
//  Date+dnsPretty.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public extension Date {
    func utilityDateLong(delta: TimeInterval, style: Format.Style) -> String {
        switch style {
        case .simple:
            return utilityDateLongSimple(delta: delta)
        case .smart:
            return utilityDateLongSmart(delta: delta)
        case .pretty:
            return utilityDateLongPretty(delta: delta)
        case .military:
            return ""
        }
    }
    func utilityTimeLong(delta: TimeInterval, style: Format.Style) -> String {
        switch style {
        case .simple:
            return utilityTimeLongSimple(delta: delta)
        case .smart:
            return utilityTimeLongSmart(delta: delta)
        case .pretty:
            return utilityTimeLongPretty(delta: delta)
        case .military:
            return ""
        }
    }
    func utilityDateLong(startDelta: TimeInterval, to end: Date? = nil,
                         endDelta: TimeInterval? = nil, style: Format.Style) -> String {
        switch style {
        case .simple:
            return utilityDateLongSimple(startDelta: startDelta, to: end, endDelta: endDelta)
        case .smart:
            return utilityDateLongSmart(startDelta: startDelta, to: end, endDelta: endDelta)
        case .pretty:
            return utilityDateLongPretty(startDelta: startDelta, to: end, endDelta: endDelta)
        case .military:
            return ""
        }
    }
    func utilityTimeLong(startDelta: TimeInterval, to end: Date? = nil,
                         endDelta: TimeInterval? = nil, style: Format.Style) -> String {
        switch style {
        case .simple:
            return utilityTimeLongSimple(startDelta: startDelta, to: end, endDelta: endDelta)
        case .smart:
            return utilityTimeLongSmart(startDelta: startDelta, to: end, endDelta: endDelta)
        case .pretty:
            return utilityTimeLongPretty(startDelta: startDelta, to: end, endDelta: endDelta)
        case .military:
            return ""
        }
    }

    private func utilityDateLongSimple(delta: TimeInterval) -> String {
        return self.utilityDateLongSimple(startDelta: delta)
    }
    private func utilityDateLongSimple(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
        var retval = DateFormatter.localizedString(from: self,
                                                   dateStyle: DateFormatter.Style.long,
                                                   timeStyle: DateFormatter.Style.none)
        guard end != nil && end != self else { return retval }

        let endString = end!.utilityDateLongSimple(startDelta: endDelta!, to: end, endDelta: endDelta)
        guard retval != endString else { return retval }
        retval += " - " + endString
        return retval
    }
    private func utilityDateLongSmart(delta: TimeInterval) -> String {
        return self.utilityDateLongSmart(startDelta: delta)
    }
    private func utilityDateLongSmart(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
        let dateFormatter = DateFormatter()
        let yearFormatSubString = self.isSameYear(as: end) ? "" : ", yyyy"
        let dateFormatString = "MMMM d\(yearFormatSubString)"
        dateFormatter.dateFormat = dateFormatString
        var retval = dateFormatter.string(from: self)
        guard end != nil && end != self else { return retval }

        let endString = end!.utilityDateLongSmart(startDelta: endDelta!, to: end, endDelta: endDelta)
        guard retval != endString else { return retval }
        retval += " - " + endString
        return retval
    }
    private func utilityDateLongPretty(delta: TimeInterval) -> String {
        return self.utilityDateLongPretty(startDelta: delta)
    }
    private func utilityDateLongPretty(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
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
            retval = Formatters.dateLong.string(from: self)
        }
        guard end != nil && end != self else { return retval }

        let endString = end!.utilityDateLongPretty(startDelta: endDelta!, to: end, endDelta: endDelta)
        guard retval != endString else { return retval }
        retval += " \(C.Localizations.DatePretty.to) " + endString
        return retval
    }

    private func utilityTimeLongSimple(delta: TimeInterval) -> String {
        let retval = DateFormatter.localizedString(from: self,
                                                   dateStyle: DateFormatter.Style.none,
                                                   timeStyle: DateFormatter.Style.long)
        return Date.utilityMinimizeAmPm(of: retval)
    }
    private func utilityTimeLongSimple(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
        let dateStyle = self.isSameDate(as: end) ? DateFormatter.Style.none : DateFormatter.Style.long
        var retval = DateFormatter.localizedString(from: self,
                                                   dateStyle: dateStyle,
                                                   timeStyle: DateFormatter.Style.long)
        retval = Date.utilityMinimizeAmPm(of: retval)
        guard end != nil && end != self else { return retval }

        let endString = end!.utilityTimeLongSimple(startDelta: endDelta!, to: end, endDelta: endDelta)
        guard retval != endString else { return retval }
        retval += " - " + endString
        return retval
    }
    private func utilityTimeLongSmart(delta: TimeInterval) -> String {
        let timeFormatString = "h:mm\(self.dnsSecond() > 0 ? ":ss" : "")a zzz"

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = timeFormatString
        let retval = dateFormatter.string(from: self)
        return Date.utilityMinimizeAmPm(of: retval)
    }
    private func utilityTimeLongSmart(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
        let yearFormatSubString = self.isSameYear(as: end) ? "" : ", yyyy"
        let dayFormatString = self.isSameDate(as: end) ? "" : "MMMM d\(yearFormatSubString) @ "
        let timeFormatString = "\(dayFormatString)h:mm\(self.dnsSecond() > 0 ? ":ss" : "")a zzz"

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = timeFormatString
        var retval = dateFormatter.string(from: self)
        retval = Date.utilityMinimizeAmPm(of: retval)
        guard end != nil && end != self else { return retval }

        let endString = end!.utilityTimeLongSmart(startDelta: endDelta!, to: end, endDelta: endDelta)
        guard retval != endString else { return retval }
        retval += " - " + endString
        return retval
    }
    private func utilityTimeLongPretty(delta: TimeInterval) -> String {
        return utilityTimeLongPretty(startDelta: delta)
    }
    private func utilityTimeLongPretty(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
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
            retval = Formatters.dateLong.string(from: self)
        }
        guard end != nil && end != self else { return retval }

        let endString = end!.utilityTimeLongPretty(startDelta: endDelta!, to: end, endDelta: endDelta)
        guard retval != endString else { return retval }
        retval += " \(C.Localizations.DatePretty.to) " + endString
        return retval
    }
}
