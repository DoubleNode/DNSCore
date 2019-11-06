//
//  Date+dnsPretty.swift
//  DNSCore
//
//  Created by Darren Ehlers on 10/7/19.
//  Copyright © 2019 DoubleNode.com. All rights reserved.
//

import Foundation

public extension Date {
    func utilityDateShort(delta: TimeInterval,
                          to end: Date? = nil,
                          endDelta: TimeInterval? = nil,
                          style: Format.Style) -> String {
        switch style {
        case .simple:
            return utilityDateShortSimple(delta: delta, to: end, endDelta: endDelta)
        case .smart:
            return utilityDateShortSmart(delta: delta, to: end, endDelta: endDelta)
        case .pretty:
            return utilityDateShortPretty(delta: delta, to: end, endDelta: endDelta)
        }
    }
    func utilityTimeShort(delta: TimeInterval,
                          to end: Date? = nil,
                          endDelta: TimeInterval? = nil,
                          style: Format.Style) -> String {
        switch style {
        case .simple:
            return utilityTimeShortSimple(delta: delta, to: end, endDelta: endDelta)
        case .smart:
            return utilityTimeShortSmart(delta: delta, to: end, endDelta: endDelta)
        case .pretty:
            return utilityTimeShortPretty(delta: delta, to: end, endDelta: endDelta)
        }
    }

    private func utilityDateShortSimple(delta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
        var retval = DateFormatter.localizedString(from: self,
                                                   dateStyle: DateFormatter.Style.short,
                                                   timeStyle: DateFormatter.Style.none)
        guard end != nil else { return retval }

        retval += " - " + end!.utilityDateShortSimple(delta: endDelta!)
        return retval
    }
    private func utilityDateShortSmart(delta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
        let dateFormatter = DateFormatter()
        let yearFormatSubString = self.isSameYear(as: end) ? "" : "/yy"
        let dateFormatString = "M/d\(yearFormatSubString)"
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: dateFormatString,
                                                            options: 0,
                                                            locale: Locale.current)
        var retval = dateFormatter.string(from: self)
        guard end != nil else { return retval }

        retval += " - " + end!.utilityDateShortSmart(delta: endDelta!)
        return retval
    }
    private func utilityDateShortPretty(delta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
        var retval = ""

        if delta < 0 {
            retval = utilityDateShortPrettyPast(delta: delta)
        } else {
            retval = utilityDateShortPrettyFuture(delta: delta)
        }
        guard end != nil else { return retval }

        let endString = end!.utilityDateShortPretty(delta: endDelta!)
        guard retval != endString else { return retval }

        retval += " - " + endString
        return retval
    }
    private func utilityDateShortPrettyFuture(delta: TimeInterval) -> String {
        var retval = ""

        switch delta {
        case 0..<Seconds.deltaOneDay:
            retval = NSLocalizedString("tdy", comment: "")
        case 0..<Seconds.deltaTwoDays:
            retval = NSLocalizedString("tmw", comment: "")
        case 0..<Seconds.deltaThreeDays:
            retval = NSLocalizedString("2days", comment: "")
        case 0..<Seconds.deltaOneWeek:
            retval = NSLocalizedString("3+days", comment: "")
        case 0..<Seconds.deltaTwoWeeks:
            retval = NSLocalizedString("1wk", comment: "")
        case 0..<Seconds.deltaThreeWeeks:
            retval = NSLocalizedString("2wks", comment: "")
        case 0..<Seconds.deltaSixWeeks:
            retval = NSLocalizedString("3+wks", comment: "")
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
            retval = NSLocalizedString("tdy", comment: "")
        case 0..<Seconds.deltaTwoDays:
            retval = NSLocalizedString("yda", comment: "")
        case 0..<Seconds.deltaThreeDays:
            retval = NSLocalizedString("2days ago", comment: "")
        case 0..<Seconds.deltaOneWeek:
            retval = NSLocalizedString("3+days ago", comment: "")
        case 0..<Seconds.deltaTwoWeeks:
            retval = NSLocalizedString("1wk ago", comment: "")
        case 0..<Seconds.deltaThreeWeeks:
            retval = NSLocalizedString("2wks ago", comment: "")
        case 0..<Seconds.deltaSixWeeks:
            retval = NSLocalizedString("3+wks ago", comment: "")
        default:
            retval = NSLocalizedString("\(Formatters.dateShort.string(from: self))", comment: "")
        }

        return retval
    }

    private func utilityTimeShortSimple(delta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
        let dateStyle = self.isSameDate(as: end) ? DateFormatter.Style.none : DateFormatter.Style.short
        var retval = DateFormatter.localizedString(from: self,
                                                   dateStyle: dateStyle,
                                                   timeStyle: DateFormatter.Style.short)
        retval = retval.replacingOccurrences(of: " PM", with: "p")
        retval = retval.replacingOccurrences(of: " AM", with: "a")
        guard end != nil else { return retval }

        retval += " - " + end!.utilityTimeShortSimple(delta: endDelta!)
        return retval
    }

    private func utilityTimeShortSmart(delta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
        let dateFormatter = DateFormatter()
        let yearFormatSubString = self.isSameYear(as: end) ? "" : "/yy"
        let dayFormatString = self.isSameDate(as: end) ? "" : "M/d\(yearFormatSubString) '@' "
        let timeFormatString = "\(dayFormatString)h:mma"
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: timeFormatString,
                                                            options: 0,
                                                            locale: Locale.current)
        var retval = dateFormatter.string(from: self)
        retval = retval.replacingOccurrences(of: ":00", with: "")
        retval = retval.replacingOccurrences(of: " PM", with: "p")
        retval = retval.replacingOccurrences(of: " AM", with: "a")
        guard end != nil else { return retval }

        retval += " - " + end!.utilityTimeShortSmart(delta: endDelta!)
        return retval
    }

    private func utilityTimeShortPretty(delta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil) -> String {
        var retval = ""

        if delta < 0 {
            retval = utilityTimeShortPrettyPast(delta: delta)
        } else {
            retval = utilityTimeShortPrettyFuture(delta: delta)
        }
        guard end != nil else { return retval }

        let endString = end!.utilityTimeShortPretty(delta: endDelta!)
        guard retval != endString else { return retval }

        retval += " - " + endString
        return retval
    }
    // swiftlint:disable:next cyclomatic_complexity
    private func utilityTimeShortPrettyFuture(delta: TimeInterval) -> String {
        var retval = ""

        switch delta {
        case 0..<Seconds.deltaOneMinute:
            retval = NSLocalizedString("now", comment: "")
        case 0..<Seconds.deltaTwoMinutes:
            retval = NSLocalizedString("1m", comment: "")
        case 0..<Seconds.deltaThreeMinutes:
            retval = NSLocalizedString("2m", comment: "")
        case 0..<Seconds.deltaSixMinutes:
            retval = NSLocalizedString("3+m", comment: "")
        case 0..<Seconds.deltaOneHour:
            let minutes = Int(floor(delta / Seconds.deltaOneMinute))
            retval = NSLocalizedString("\(minutes)mins", comment: "")
        case 0..<Seconds.deltaTwoHours:
            retval = NSLocalizedString("1hr", comment: "")
        case 0..<Seconds.deltaThreeHours:
            retval = NSLocalizedString("2hrs", comment: "")
        case 0..<Seconds.deltaSixHours:
            retval = NSLocalizedString("3+hrs", comment: "")
        case 0..<Seconds.deltaOneDay:
            retval = NSLocalizedString("tdy", comment: "")
        case 0..<Seconds.deltaTwoDays:
            retval = NSLocalizedString("tmw", comment: "")
        case 0..<Seconds.deltaThreeDays:
            retval = NSLocalizedString("2days", comment: "")
        case 0..<Seconds.deltaOneWeek:
            retval = NSLocalizedString("3+days", comment: "")
        case 0..<Seconds.deltaTwoWeeks:
            retval = NSLocalizedString("1wk", comment: "")
        case 0..<Seconds.deltaThreeWeeks:
            retval = NSLocalizedString("2wks", comment: "")
        case 0..<Seconds.deltaSixWeeks:
            retval = NSLocalizedString("3+wks", comment: "")
        default:
            retval = NSLocalizedString("\(Formatters.dateShort.string(from: self))", comment: "")
        }

        return retval
    }
    // swiftlint:disable:next cyclomatic_complexity
    private func utilityTimeShortPrettyPast(delta: TimeInterval) -> String {
        let deltaPast = 0 - delta
        var retval = ""

        switch deltaPast {
        case 0..<Seconds.deltaOneMinute:
            retval = NSLocalizedString("now", comment: "")
        case 0..<Seconds.deltaTwoMinutes:
            retval = NSLocalizedString("1m ago", comment: "")
        case 0..<Seconds.deltaThreeMinutes:
            retval = NSLocalizedString("2m ago", comment: "")
        case 0..<Seconds.deltaSixMinutes:
            retval = NSLocalizedString("3+m ago", comment: "")
        case 0..<Seconds.deltaOneHour:
            let minutesAgo = Int(floor(deltaPast / Seconds.deltaOneMinute))
            retval = NSLocalizedString("\(minutesAgo)mins ago", comment: "")
        case 0..<Seconds.deltaTwoHours:
            retval = NSLocalizedString("1hr ago", comment: "")
        case 0..<Seconds.deltaThreeHours:
            retval = NSLocalizedString("2hrs ago", comment: "")
        case 0..<Seconds.deltaSixHours:
            retval = NSLocalizedString("3+hrs ago", comment: "")
        case 0..<Seconds.deltaOneDay:
            retval = NSLocalizedString("tdy", comment: "")
        case 0..<Seconds.deltaTwoDays:
            retval = NSLocalizedString("yda", comment: "")
        case 0..<Seconds.deltaThreeDays:
            retval = NSLocalizedString("2days ago", comment: "")
        case 0..<Seconds.deltaOneWeek:
            retval = NSLocalizedString("3+days ago", comment: "")
        case 0..<Seconds.deltaTwoWeeks:
            retval = NSLocalizedString("1wk ago", comment: "")
        case 0..<Seconds.deltaThreeWeeks:
            retval = NSLocalizedString("2wks ago", comment: "")
        case 0..<Seconds.deltaSixWeeks:
            retval = NSLocalizedString("3+wks ago", comment: "")
        default:
            retval = NSLocalizedString("\(Formatters.dateShort.string(from: self))", comment: "")
        }

        return retval
    }
}
