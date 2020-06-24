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
            retval = NSLocalizedString("today", comment: "")
        } else if delta < Seconds.deltaTwoDays {
            retval = NSLocalizedString("yesterday", comment: "")
        } else if delta < Seconds.deltaOneWeek {
            let daysAgo = Int(floor(delta / Seconds.deltaOneDay))
            retval = NSLocalizedString("\(daysAgo) days ago", comment: "")
        } else if delta < Seconds.deltaTwoWeeks {
            retval = NSLocalizedString("last week", comment: "")
        } else if delta < Seconds.deltaSixWeeks {
            let weeksAgo = Int(floor(delta / Seconds.deltaOneWeek))
            retval = NSLocalizedString("\(weeksAgo) weeks ago", comment: "")
        } else {
            retval = NSLocalizedString("\(Formatters.dateLong.string(from: self))", comment: "")
        }
        guard end != nil else { return retval }

        retval += " to " + end!.utilityDateLongPretty(delta: endDelta!)
        return retval
    }

    private func utilityTimeLongSimple(delta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
        let dateStyle = self.isSameDate(as: end) ? DateFormatter.Style.none : DateFormatter.Style.long
        var retval = DateFormatter.localizedString(from: self,
                                                   dateStyle: dateStyle,
                                                   timeStyle: DateFormatter.Style.long)
        retval = retval.replacingOccurrences(of: " PM", with: "pm")
        retval = retval.replacingOccurrences(of: " AM", with: "am")
        guard end != nil else { return retval }

        retval += " - " + end!.utilityTimeLongSimple(delta: endDelta!)
        return retval
    }
    private func utilityTimeLongSmart(delta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
        let dateFormatter = DateFormatter()
        let yearFormatSubString = self.isSameYear(as: end) ? "" : ", yyyy"
        let dayFormatString = self.isSameDate(as: end) ? "" : "MMMM d\(yearFormatSubString) @ "
        let timeFormatString = "\(dayFormatString)h:mm:ssa zzz"
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: timeFormatString,
                                                            options: 0,
                                                            locale: Locale.current)
        var retval = dateFormatter.string(from: self)
        retval = retval.replacingOccurrences(of: ":00", with: "")
        retval = retval.replacingOccurrences(of: " PM", with: "pm")
        retval = retval.replacingOccurrences(of: " AM", with: "am")
        guard end != nil else { return retval }

        retval += " - " + end!.utilityTimeLongSmart(delta: endDelta!)
        return retval
    }
    private func utilityTimeLongPretty(delta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
        var retval = ""

        if delta < Seconds.deltaOneMinute {
            retval = NSLocalizedString("just now", comment: "")
        } else if delta < Seconds.deltaTwoMinutes {
            retval = NSLocalizedString("one minute ago", comment: "")
        } else if delta < Seconds.deltaOneHour {
            let minutesAgo = Int(floor(delta / Seconds.deltaOneMinute))
            retval = NSLocalizedString("\(minutesAgo) minutes ago", comment: "")
        } else if delta < Seconds.deltaTwoHours {
            retval = NSLocalizedString("one hour ago", comment: "")
        } else if delta < Seconds.deltaOneDay {
            let hoursAgo = Int(floor(delta / Seconds.deltaOneHour))
            retval = NSLocalizedString("\(hoursAgo) hours ago", comment: "")
        } else if delta < Seconds.deltaTwoDays {
            retval = NSLocalizedString("yesterday", comment: "")
        } else if delta < Seconds.deltaOneWeek {
            let daysAgo = Int(floor(delta / Seconds.deltaOneDay))
            retval = NSLocalizedString("\(daysAgo) days ago", comment: "")
        } else if delta < Seconds.deltaTwoWeeks {
            retval = NSLocalizedString("last week", comment: "")
        } else if delta < Seconds.deltaSixWeeks {
            let weeksAgo = Int(floor(delta / Seconds.deltaOneWeek))
            retval = NSLocalizedString("\(weeksAgo) weeks ago", comment: "")
        } else {
            retval = NSLocalizedString("\(Formatters.dateLong.string(from: self))", comment: "")
        }
        guard end != nil else { return retval }

        retval += " to " + end!.utilityTimeLongPretty(delta: endDelta!)
        return retval
    }
}
