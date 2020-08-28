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
        }
    }

    private func utilityDateLongSimple(delta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
        var retval = DateFormatter.localizedString(from: self,
                                                   dateStyle: DateFormatter.Style.long,
                                                   timeStyle: DateFormatter.Style.none)
        guard end != nil else { return retval }

        retval += " - " + end!.utilityDateLongSimple(delta: endDelta!)
        return retval
    }
    private func utilityDateLongSmart(delta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
        let dateFormatter = DateFormatter()
        let yearFormatSubString = self.isSameYear(as: end) ? "" : ", yyyy"
        let dateFormatString = "MMMM d\(yearFormatSubString)"
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: dateFormatString,
                                                            options: 0,
                                                            locale: Locale.current)
        var retval = dateFormatter.string(from: self)
        guard end != nil else { return retval }

        retval += " - " + end!.utilityDateLongSmart(delta: endDelta!)
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

        retval += " \(C.Localizations.DatePretty.to) " + end!.utilityDateLongPretty(delta: endDelta!)
        return retval
    }

    private func utilityTimeLongSimple(delta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
        let dateStyle = self.isSameDate(as: end) ? DateFormatter.Style.none : DateFormatter.Style.long
        var retval = DateFormatter.localizedString(from: self,
                                                   dateStyle: dateStyle,
                                                   timeStyle: DateFormatter.Style.long)

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        retval = retval.replacingOccurrences(of: " \(dateFormatter.pmSymbol ?? "")", with: dateFormatter.pmSymbol)
        retval = retval.replacingOccurrences(of: " \(dateFormatter.amSymbol ?? "")", with: dateFormatter.amSymbol)
        guard end != nil else { return retval }

        retval += " - " + end!.utilityTimeLongSimple(delta: endDelta!)
        return retval
    }
    private func utilityTimeLongSmart(delta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
        let yearFormatSubString = self.isSameYear(as: end) ? "" : ", yyyy"
        let dayFormatString = self.isSameDate(as: end) ? "" : "MMMM d\(yearFormatSubString) @ "
        let timeFormatString = "\(dayFormatString)h:mm\(self.dnsSecond() > 0 ? ":ss" : "")a zzz"

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: timeFormatString,
                                                            options: 0,
                                                            locale: Locale.current)
        var retval = dateFormatter.string(from: self)
        retval = retval.replacingOccurrences(of: " \(dateFormatter.pmSymbol ?? "")", with: dateFormatter.pmSymbol)
        retval = retval.replacingOccurrences(of: " \(dateFormatter.amSymbol ?? "")", with: dateFormatter.amSymbol)
        guard end != nil else { return retval }

        retval += " - " + end!.utilityTimeLongSmart(delta: endDelta!)
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

        retval += " \(C.Localizations.DatePretty.to) " + end!.utilityTimeLongPretty(delta: endDelta!)
        return retval
    }
}
