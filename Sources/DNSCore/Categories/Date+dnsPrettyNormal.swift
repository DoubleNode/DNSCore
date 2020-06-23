//
//  Date+dnsPretty.swift
//  DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public extension Date {
    func utilityDateNormal(delta: TimeInterval,
                           to end: Date? = nil,
                           endDelta: TimeInterval? = nil,
                           style: Format.Style) -> String {
        switch style {
        case .simple:
            return utilityDateNormalSimple(delta: delta, to: end, endDelta: endDelta)
        case .smart:
            return utilityDateNormalSmart(delta: delta, to: end, endDelta: endDelta)
        case .pretty:
            return utilityDateNormalPretty(delta: delta, to: end, endDelta: endDelta)
        }
    }
    func utilityTimeNormal(delta: TimeInterval,
                           to end: Date? = nil,
                           endDelta: TimeInterval? = nil,
                           style: Format.Style) -> String {
        switch style {
        case .simple:
            return utilityTimeNormalSimple(delta: delta, to: end, endDelta: endDelta)
        case .smart:
            return utilityTimeNormalSmart(delta: delta, to: end, endDelta: endDelta)
        case .pretty:
            return utilityTimeNormalPretty(delta: delta, to: end, endDelta: endDelta)
        }
    }

    private func utilityDateNormalSimple(delta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
        var retval = DateFormatter.localizedString(from: self,
                                                   dateStyle: DateFormatter.Style.medium,
                                                   timeStyle: DateFormatter.Style.none)
        guard end != nil else { return retval }

        retval += " - " + end!.utilityDateNormalSimple(delta: endDelta!)
        return retval
    }
    private func utilityDateNormalSmart(delta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
        let dateFormatter = DateFormatter()
        let yearFormatSubString = self.isSameYear(as: end) ? "" : ", yyyy"
        let dateFormatString = "MMM d\(yearFormatSubString)"
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: dateFormatString,
                                                            options: 0,
                                                            locale: Locale.current)
        var retval = dateFormatter.string(from: self)
        guard end != nil else { return retval }

        retval += " - " + end!.utilityDateNormalSmart(delta: endDelta!)
        return retval
    }
    private func utilityDateNormalPretty(delta: TimeInterval,
                                         to end: Date? = nil,
                                         endDelta: TimeInterval? = nil) -> String {
        var retval = ""

        if delta < 0 {
            retval = utilityDateShortPrettyPast(delta: delta)
        } else {
            retval = utilityDateShortPrettyFuture(delta: delta)
        }
        guard end != nil else { return retval }

        let endString = end!.utilityDateNormalPretty(delta: endDelta!)
        guard retval != endString else { return retval }

        retval += " - " + endString
        return retval
    }
    private func utilityDateShortPrettyFuture(delta: TimeInterval) -> String {
        var retval = ""

        switch delta {
        case 0..<Seconds.deltaOneDay:
            retval = NSLocalizedString("today", comment: "")
        case 0..<Seconds.deltaTwoDays:
            retval = NSLocalizedString("tomorrow", comment: "")
        case 0..<Seconds.deltaThreeDays:
            retval = NSLocalizedString("2 days", comment: "")
        case 0..<Seconds.deltaOneWeek:
            retval = NSLocalizedString("3+ days", comment: "")
        case 0..<Seconds.deltaTwoWeeks:
            retval = NSLocalizedString("1 week", comment: "")
        case 0..<Seconds.deltaThreeWeeks:
            retval = NSLocalizedString("2 weeks", comment: "")
        case 0..<Seconds.deltaSixWeeks:
            retval = NSLocalizedString("3+ weeks", comment: "")
        default:
            retval = NSLocalizedString("\(Formatters.dateShort.string(from: self))", comment: "")
        }

        return retval
    }
    private func utilityDateShortPrettyPast(delta: TimeInterval) -> String {
        let deltaPast = 0 - delta
        var retval = ""

        switch deltaPast {
        case 0..<Seconds.deltaOneDay:
            retval = NSLocalizedString("today", comment: "")
        case 0..<Seconds.deltaTwoDays:
            retval = NSLocalizedString("yesterday", comment: "")
        case 0..<Seconds.deltaThreeDays:
            retval = NSLocalizedString("2 days ago", comment: "")
        case 0..<Seconds.deltaOneWeek:
            retval = NSLocalizedString("3+ days ago", comment: "")
        case 0..<Seconds.deltaTwoWeeks:
            retval = NSLocalizedString("1 week ago", comment: "")
        case 0..<Seconds.deltaThreeWeeks:
            retval = NSLocalizedString("2 weeks ago", comment: "")
        case 0..<Seconds.deltaSixWeeks:
            retval = NSLocalizedString("3+ weeks ago", comment: "")
        default:
            retval = NSLocalizedString("\(Formatters.dateShort.string(from: self))", comment: "")
        }

        return retval
    }

    private func utilityTimeNormalSimple(delta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
        let dateStyle = self.isSameDate(as: end) ? DateFormatter.Style.none : DateFormatter.Style.medium
        var retval = DateFormatter.localizedString(from: self,
                                                   dateStyle: dateStyle,
                                                   timeStyle: DateFormatter.Style.medium)
        retval = retval.replacingOccurrences(of: " PM", with: "pm")
        retval = retval.replacingOccurrences(of: " AM", with: "am")
        guard end != nil else { return retval }

        retval += " - " + end!.utilityTimeNormalSimple(delta: endDelta!)
        return retval
    }
    private func utilityTimeNormalSmart(delta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
        let dateFormatter = DateFormatter()
        let yearFormatSubString = self.isSameYear(as: end) ? "" : ", yyyy"
        let dayFormatString = self.isSameDate(as: end) ? "" : "MMM d\(yearFormatSubString) @ "
        let timeFormatString = "\(dayFormatString)h:mm:ssa"
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: timeFormatString,
                                                            options: 0,
                                                            locale: Locale.current)
        var retval = dateFormatter.string(from: self)
        retval = retval.replacingOccurrences(of: ":00", with: "")
        retval = retval.replacingOccurrences(of: " PM", with: "pm")
        retval = retval.replacingOccurrences(of: " AM", with: "am")
        guard end != nil else { return retval }

        retval += " - " + end!.utilityTimeNormalSmart(delta: endDelta!)
        return retval
    }

    private func utilityTimeNormalPretty(delta: TimeInterval,
                                         to end: Date? = nil,
                                         endDelta: TimeInterval? = nil) -> String {
        var retval = ""

        if delta < 0 {
            retval = utilityTimeNormalPrettyPast(delta: delta)
        } else {
            retval = utilityTimeNormalPrettyFuture(delta: delta)
        }
        guard end != nil else { return retval }

        let endString = end!.utilityTimeNormalPretty(delta: endDelta!)
        guard retval != endString else { return retval }

        retval += " - " + endString
        return retval
    }
    // swiftlint:disable:next cyclomatic_complexity
    private func utilityTimeNormalPrettyFuture(delta: TimeInterval) -> String {
        var retval = ""

        switch delta {
        case 0..<Seconds.deltaOneMinute:
            retval = NSLocalizedString("just now", comment: "")
        case 0..<Seconds.deltaTwoMinutes:
            retval = NSLocalizedString("1 minute", comment: "")
        case 0..<Seconds.deltaThreeMinutes:
            retval = NSLocalizedString("2 minutes", comment: "")
        case 0..<Seconds.deltaSixMinutes:
            retval = NSLocalizedString("3+ minutes", comment: "")
        case 0..<Seconds.deltaOneHour:
            let minutes = Int(floor(delta / Seconds.deltaOneMinute))
            retval = NSLocalizedString("\(minutes) minutes", comment: "")
        case 0..<Seconds.deltaTwoHours:
            retval = NSLocalizedString("1 hour", comment: "")
        case 0..<Seconds.deltaThreeHours:
            retval = NSLocalizedString("2 hours", comment: "")
        case 0..<Seconds.deltaSixHours:
            retval = NSLocalizedString("3+ hours", comment: "")
        case 0..<Seconds.deltaOneDay:
            retval = NSLocalizedString("today", comment: "")
        case 0..<Seconds.deltaTwoDays:
            retval = NSLocalizedString("tomorrow", comment: "")
        case 0..<Seconds.deltaThreeDays:
            retval = NSLocalizedString("2 days", comment: "")
        case 0..<Seconds.deltaOneWeek:
            retval = NSLocalizedString("3+ days", comment: "")
        case 0..<Seconds.deltaTwoWeeks:
            retval = NSLocalizedString("1 week", comment: "")
        case 0..<Seconds.deltaThreeWeeks:
            retval = NSLocalizedString("2 weeks", comment: "")
        case 0..<Seconds.deltaSixWeeks:
            retval = NSLocalizedString("3+ weeks", comment: "")
        default:
            retval = NSLocalizedString("\(Formatters.dateShort.string(from: self))", comment: "")
        }

        return retval
    }
    // swiftlint:disable:next cyclomatic_complexity
    private func utilityTimeNormalPrettyPast(delta: TimeInterval) -> String {
        let deltaPast = 0 - delta
        var retval = ""

        switch deltaPast {
        case 0..<Seconds.deltaOneMinute:
            retval = NSLocalizedString("just now", comment: "")
        case 0..<Seconds.deltaTwoMinutes:
            retval = NSLocalizedString("1 minute ago", comment: "")
        case 0..<Seconds.deltaThreeMinutes:
            retval = NSLocalizedString("2 minutes ago", comment: "")
        case 0..<Seconds.deltaSixMinutes:
            retval = NSLocalizedString("3+ minutes ago", comment: "")
        case 0..<Seconds.deltaOneHour:
            let minutesAgo = Int(floor(deltaPast / Seconds.deltaOneMinute))
            retval = NSLocalizedString("\(minutesAgo) minutes ago", comment: "")
        case 0..<Seconds.deltaTwoHours:
            retval = NSLocalizedString("1 hour ago", comment: "")
        case 0..<Seconds.deltaThreeHours:
            retval = NSLocalizedString("2 hours ago", comment: "")
        case 0..<Seconds.deltaSixHours:
            retval = NSLocalizedString("3+ hours ago", comment: "")
        case 0..<Seconds.deltaOneDay:
            retval = NSLocalizedString("today", comment: "")
        case 0..<Seconds.deltaTwoDays:
            retval = NSLocalizedString("yesterday", comment: "")
        case 0..<Seconds.deltaThreeDays:
            retval = NSLocalizedString("2 days ago", comment: "")
        case 0..<Seconds.deltaOneWeek:
            retval = NSLocalizedString("3+ days ago", comment: "")
        case 0..<Seconds.deltaTwoWeeks:
            retval = NSLocalizedString("1 week ago", comment: "")
        case 0..<Seconds.deltaThreeWeeks:
            retval = NSLocalizedString("2 weeks ago", comment: "")
        case 0..<Seconds.deltaSixWeeks:
            retval = NSLocalizedString("3+ weeks ago", comment: "")
        default:
            retval = NSLocalizedString("\(Formatters.dateShort.string(from: self))", comment: "")
        }

        return retval
    }
}
