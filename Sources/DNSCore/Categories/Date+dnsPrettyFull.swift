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
            retval = NSLocalizedString("\(Formatters.dateFull.string(from: self))", comment: "")
        }
        guard end != nil else { return retval }

        retval += " to " + end!.utilityDateFullPretty(delta: endDelta!)
        return retval
    }

    private func utilityTimeFullSimple(delta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
        let dateStyle = self.isSameDate(as: end) ? DateFormatter.Style.none : DateFormatter.Style.full
        var retval = DateFormatter.localizedString(from: self,
                                                   dateStyle: dateStyle,
                                                   timeStyle: DateFormatter.Style.full)
        retval = retval.replacingOccurrences(of: " PM", with: "pm")
        retval = retval.replacingOccurrences(of: " AM", with: "am")
        guard end != nil else { return retval }

        retval += " - " + end!.utilityTimeFullSimple(delta: endDelta!)
        return retval
    }
    private func utilityTimeFullSmart(delta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
        let dateFormatter = DateFormatter()
        let weekdayFormatSubString = self.isSameDay(as: end) ? "" : "EEEE, "
        let yearFormatSubString = self.isSameYear(as: end) ? "" : ", yyyy"
        let dayFormatString = self.isSameDate(as: end) ? "" : "\(weekdayFormatSubString)MMMM d\(yearFormatSubString) 'at' "
        let timeFormatString = "\(dayFormatString)h:mm:ssa zzzz"
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: timeFormatString,
                                                            options: 0,
                                                            locale: Locale.current)
        var retval = dateFormatter.string(from: self)
        retval = retval.replacingOccurrences(of: ":00", with: "")
        retval = retval.replacingOccurrences(of: " PM", with: "pm")
        retval = retval.replacingOccurrences(of: " AM", with: "am")
        guard end != nil else { return retval }

        retval += " - " + end!.utilityTimeFullSmart(delta: endDelta!)
        return retval
    }
    private func utilityTimeFullPretty(delta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
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
            retval = NSLocalizedString("\(Formatters.dateFull.string(from: self))", comment: "")
        }
        guard end != nil else { return retval }

        retval += " to " + end!.utilityTimeFullPretty(delta: endDelta!)
        return retval
    }
}
