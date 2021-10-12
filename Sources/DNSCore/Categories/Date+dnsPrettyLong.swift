//
//  Date+dnsPrettyLong.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public extension Date {
    func utilityDateLong(delta: TimeInterval, style: Format.Style,
                         in timeZone: TimeZone) -> String {
        switch style {
        case .simple:
            return utilityDateLongSimple(delta: delta, in: timeZone)
        case .smart:
            return utilityDateLongSmart(delta: delta, in: timeZone)
        case .pretty:
            return utilityDateLongPretty(delta: delta, in: timeZone)
        case .military:
            return ""
        }
    }
    func utilityTimeLong(delta: TimeInterval, style: Format.Style,
                         in timeZone: TimeZone) -> String {
        switch style {
        case .simple:
            return utilityTimeLongSimple(delta: delta, in: timeZone)
        case .smart:
            return utilityTimeLongSmart(delta: delta, in: timeZone)
        case .pretty:
            return utilityTimeLongPretty(delta: delta, in: timeZone)
        case .military:
            return ""
        }
    }
    func utilityDateLong(startDelta: TimeInterval, to end: Date? = nil,
                         endDelta: TimeInterval? = nil, style: Format.Style,
                         in timeZone: TimeZone) -> String {
        switch style {
        case .simple:
            return utilityDateLongSimple(startDelta: startDelta, to: end, endDelta: endDelta, in: timeZone)
        case .smart:
            return utilityDateLongSmart(startDelta: startDelta, to: end, endDelta: endDelta, in: timeZone)
        case .pretty:
            return utilityDateLongPretty(startDelta: startDelta, to: end, endDelta: endDelta, in: timeZone)
        case .military:
            return ""
        }
    }
    func utilityTimeLong(startDelta: TimeInterval, to end: Date? = nil,
                         endDelta: TimeInterval? = nil, style: Format.Style,
                         in timeZone: TimeZone) -> String {
        switch style {
        case .simple:
            return utilityTimeLongSimple(startDelta: startDelta, to: end, endDelta: endDelta, in: timeZone)
        case .smart:
            return utilityTimeLongSmart(startDelta: startDelta, to: end, endDelta: endDelta, in: timeZone)
        case .pretty:
            return utilityTimeLongPretty(startDelta: startDelta, to: end, endDelta: endDelta, in: timeZone)
        case .military:
            return ""
        }
    }

    private func utilityDateLongSimple(delta: TimeInterval, in timeZone: TimeZone) -> String {
        return self.utilityDateLongSimple(startDelta: delta, in: timeZone)
    }
    private func utilityDateLongSimple(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil,
                                       in timeZone: TimeZone) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.dateStyle = DateFormatter.Style.long
        dateFormatter.timeStyle = DateFormatter.Style.none
        var retval = dateFormatter.string(from: self)
        guard end != nil && end != self else { return retval }

        let endString = end!.utilityDateLongSimple(startDelta: endDelta!, to: end, endDelta: endDelta, in: timeZone)
        guard retval != endString else { return retval }
        retval += " - " + endString
        return retval
    }
    private func utilityDateLongSmart(delta: TimeInterval, in timeZone: TimeZone) -> String {
        return self.utilityDateLongSmart(startDelta: delta, in: timeZone)
    }
    private func utilityDateLongSmart(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil,
                                      in timeZone: TimeZone) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        let yearFormatSubString = self.isSameYear(as: end ?? Date()) ? "" : ", yyyy"
        let dateFormatString = "MMMM d\(yearFormatSubString)"
        dateFormatter.dateFormat = dateFormatString
        var retval = dateFormatter.string(from: self)
        guard end != nil && end != self else { return retval }

        let endString = end!.utilityDateLongSmart(startDelta: endDelta!, to: end, endDelta: endDelta, in: timeZone)
        guard retval != endString else { return retval }
        retval += " - " + endString
        return retval
    }
    private func utilityDateLongPretty(delta: TimeInterval, in timeZone: TimeZone) -> String {
        return self.utilityDateLongPretty(startDelta: delta, in: timeZone)
    }
    private func utilityDateLongPretty(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil,
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
            dateFormatter.dateStyle = DateFormatter.Style.long
            retval = dateFormatter.string(from: self)
        }
        guard end != nil && end != self else { return retval }

        let endString = end!.utilityDateLongPretty(startDelta: endDelta!, to: end, endDelta: endDelta, in: timeZone)
        guard retval != endString else { return retval }
        retval += " \(C.Localizations.DatePretty.to) " + endString
        return retval
    }

    private func utilityTimeLongSimple(delta: TimeInterval, in timeZone: TimeZone) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.dateStyle = DateFormatter.Style.none
        dateFormatter.timeStyle = DateFormatter.Style.long
        let retval = dateFormatter.string(from: self)
        return Date.utilityMinimizeAmPm(of: retval)
    }
    private func utilityTimeLongSimple(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil,
                                       in timeZone: TimeZone) -> String {
        let dateStyle = self.isSameDate(as: end ?? Date()) ? DateFormatter.Style.none : DateFormatter.Style.long
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.dateStyle = dateStyle
        dateFormatter.timeStyle = DateFormatter.Style.long
        var retval = dateFormatter.string(from: self)
        retval = Date.utilityMinimizeAmPm(of: retval)
        guard end != nil && end != self else { return retval }

        let endDateString = end!.utilityDateLongSimple(delta: endDelta!, in: timeZone)
        let endTimeString = end!.utilityTimeLongSimple(startDelta: endDelta!, to: end, endDelta: endDelta, in: timeZone)
        let endString = endDateString + " \(C.Localizations.DatePretty.at) " + endTimeString
        guard retval != endString else { return retval }
        retval += " - " + endString
        return retval
    }
    private func utilityTimeLongSmart(delta: TimeInterval, in timeZone: TimeZone) -> String {
        let timeFormatString = "h:mm\(self.dnsSecond() > 0 ? ":ss" : "")a zzz"

        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = timeFormatString
        let retval = dateFormatter.string(from: self)
        return Date.utilityMinimizeAmPm(of: retval)
    }
    private func utilityTimeLongSmart(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil,
                                      in timeZone: TimeZone) -> String {
        let yearFormatSubString = self.isSameYear(as: end ?? Date()) ? "" : ", yyyy"
        let dayFormatString = self.isSameDate(as: end ?? Date()) ? "" : "MMMM d\(yearFormatSubString) @ "
        let timeFormatString = "\(dayFormatString)h:mm\(self.dnsSecond() > 0 ? ":ss" : "")a zzz"

        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = timeFormatString
        var retval = dateFormatter.string(from: self)
        retval = Date.utilityMinimizeAmPm(of: retval)
        guard end != nil && end != self else { return retval }

        let endDateString = end!.utilityDateLongSmart(delta: endDelta!, in: timeZone)
        let endTimeString = end!.utilityTimeLongSmart(startDelta: endDelta!, to: end, endDelta: endDelta, in: timeZone)
        let endString = endDateString + " @ " + endTimeString
        guard retval != endString else { return retval }
        retval += " - " + endString
        return retval
    }
    private func utilityTimeLongPretty(delta: TimeInterval, in timeZone: TimeZone) -> String {
        return utilityTimeLongPretty(startDelta: delta, in: timeZone)
    }
    private func utilityTimeLongPretty(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil,
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
            dateFormatter.dateStyle = DateFormatter.Style.long
            retval = dateFormatter.string(from: self)
        }
        guard end != nil && end != self else { return retval }

        let endString = end!.utilityTimeLongPretty(startDelta: endDelta!, to: end, endDelta: endDelta, in: timeZone)
        guard retval != endString else { return retval }
        retval += " \(C.Localizations.DatePretty.to) " + endString
        return retval
    }
}
