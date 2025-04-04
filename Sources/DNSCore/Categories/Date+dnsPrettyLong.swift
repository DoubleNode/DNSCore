//
//  Date+dnsPrettyLong.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public extension Date {
    func utilityAtLong(style: Format.Style) -> String {
        switch style {
        case .simple:
            return " \(C.Localizations.DatePretty.at) "
        case .smart:
            return " @ "
        case .pretty:
            return ", "
        case .iso, .military, .militaryPlus:
            return " "
        }
    }
    func utilityDateLong(delta: TimeInterval, style: Format.Style,
                         in timeZone: TimeZone) -> String {
        switch style {
        case .simple:
            return utilityDateLongSimple(delta: delta, in: timeZone)
        case .smart:
            return utilityDateLongSmart(delta: delta, in: timeZone)
        case .pretty:
            return utilityDateLongPretty(delta: delta, in: timeZone)
        case .iso, .military, .militaryPlus:
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
        case .iso, .military, .militaryPlus:
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
        case .iso, .military, .militaryPlus:
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
        case .iso, .military, .militaryPlus:
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
        let endTime = end?.zeroDate(in: timeZone)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        let yearFormatSubString = (self.isSameYear(as: /*endTime ?? */Date(), in: timeZone) && (endTime != self)) ? "" : ", yyyy"
        let dateFormatString = "MMMM d\(yearFormatSubString)"
        dateFormatter.dateFormat = dateFormatString
        var retval = dateFormatter.string(from: self)
        guard let endTime, let endDelta, endTime != self else { return retval }

        let endString = endTime.utilityDateLongSmart(startDelta: endDelta, to: endTime, endDelta: endDelta, in: timeZone)
        guard retval != endString else { return retval }
        retval += " - " + endString
        return retval
    }
    private func utilityDateLongPretty(delta: TimeInterval, in timeZone: TimeZone) -> String {
        return self.utilityDateLongPretty(startDelta: delta, in: timeZone)
    }
    // swiftlint:disable:next cyclomatic_complexity
    private func utilityDateLongPretty(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil,
                                       in timeZone: TimeZone) -> String {
        var retval = ""

        if startDelta > 0 {
            if startDelta < Seconds.deltaOneDay {
                retval = self.isToday ? C.Localizations.DatePretty.today :
                    C.Localizations.DatePretty.tomorrow
            } else if startDelta < Seconds.deltaTwoDays {
                retval = self.isTomorrow ? C.Localizations.DatePretty.tomorrow :
                    String(format: C.Localizations.DatePretty.inDays, "2")
            } else if startDelta < Seconds.deltaOneWeek {
                let inDays = Int(floor(startDelta / Seconds.deltaOneDay))
                retval = String(format: C.Localizations.DatePretty.inDays, "\(inDays)")
            } else if startDelta < Seconds.deltaTwoWeeks {
                retval = C.Localizations.DatePretty.nextWeek
            } else if startDelta < Seconds.deltaSixWeeks {
                let inWeeks = Int(floor(startDelta / Seconds.deltaOneWeek))
                retval = String(format: C.Localizations.DatePretty.inWeeks, "\(inWeeks)")
            } else {
                let dateFormatter = DateFormatter()
                dateFormatter.timeZone = timeZone
                dateFormatter.dateStyle = DateFormatter.Style.long
                retval = dateFormatter.string(from: self)
            }
        } else {
            if -startDelta < Seconds.deltaOneDay {
                retval = self.isToday ? C.Localizations.DatePretty.today :
                    C.Localizations.DatePretty.yesterday
            } else if -startDelta < Seconds.deltaTwoDays {
                retval = self.isTomorrow ? C.Localizations.DatePretty.yesterday :
                    String(format: C.Localizations.DatePretty.daysAgo, "2")
            } else if -startDelta < Seconds.deltaOneWeek {
                let daysAgo = Int(floor(-startDelta / Seconds.deltaOneDay))
                retval = String(format: C.Localizations.DatePretty.daysAgo, "\(daysAgo)")
            } else if -startDelta < Seconds.deltaTwoWeeks {
                retval = C.Localizations.DatePretty.lastWeek
            } else if -startDelta < Seconds.deltaSixWeeks {
                let weeksAgo = Int(floor(-startDelta / Seconds.deltaOneWeek))
                retval = String(format: C.Localizations.DatePretty.weeksAgo, "\(weeksAgo)")
            } else {
                let dateFormatter = DateFormatter()
                dateFormatter.timeZone = timeZone
                dateFormatter.dateStyle = DateFormatter.Style.long
                retval = dateFormatter.string(from: self)
            }
        }
        guard end != nil && end != self else { return retval }

        let endString = end!.utilityDateLongPretty(startDelta: endDelta!, to: end, endDelta: endDelta, in: timeZone)
        guard retval != endString else { return retval }
        retval += " \(C.Localizations.DatePretty.to) " + endString
        return retval
    }

    private func utilityTimeLongSimple(delta: TimeInterval, in timeZone: TimeZone) -> String {
        var timeFormatString = "h:mma"
        if timeZone != TimeZone.current {
            timeFormatString += " zzz"
        }
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = timeFormatString
        let retval = dateFormatter.string(from: self)
        return Date.utilityMinimizeAmPm(of: retval)
    }
    private func utilityTimeLongSimple(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil,
                                       in timeZone: TimeZone) -> String {
        let dayFormatString = "MMMM d, yyyy'\(self.utilityAtLong(style: .simple))'"
        var timeFormatString = "\(dayFormatString)h:mma"
        if timeZone != TimeZone.current {
            if end == nil || end == self {
                timeFormatString += " zzz"
            }
        }
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = timeFormatString
        var retval = dateFormatter.string(from: self)
        retval = Date.utilityMinimizeAmPm(of: retval)
        guard end != nil && end != self else { return retval }

        let endString = end!.utilityTimeLongSimple(startDelta: endDelta!, to: end, endDelta: endDelta, in: timeZone)
        guard retval != endString else { return retval }
        retval += " - " + endString
        return retval
    }
    private func utilityTimeLongSmart(delta: TimeInterval,
                                      in timeZone: TimeZone) -> String {
        var timeFormatString = "h:mm\(self.dnsSecond > 0 ? ":ss" : "")a"
        if timeZone != TimeZone.current {
            timeFormatString += " zzz"
        }
        if self.isZeroTime(in: timeZone) {
            timeFormatString = ""
        }

        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = timeFormatString
        let retval = dateFormatter.string(from: self)
        return Date.utilityMinimizeAmPm(of: retval)
    }
    private func utilityTimeLongSmart(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil,
                                      in timeZone: TimeZone) -> String {
        let endTime = end?.zeroDate(in: timeZone)
        let yearFormatSubString = (self.isSameYear(as: /*endTime ?? */Date(), in: timeZone) && (endTime != self)) ? "" : ", yyyy"
        let dayFormatString = (self.isSameDate(as: /*endTime ?? */Date(), in: timeZone) && (endTime != self)) ? "" :
            "MMMM d\(yearFormatSubString)"
        var timeFormatString = "\(dayFormatString)'\(self.utilityAtLong(style: .smart))'h:mm\(self.dnsSecond > 0 ? ":ss" : "")a"
        if timeZone != TimeZone.current {
            if endTime == nil || endTime == self {
                timeFormatString += " zzz"
            }
        }
        if self.isZeroTime(in: timeZone) {
            timeFormatString = dayFormatString
        }

        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = timeFormatString
        var retval = dateFormatter.string(from: self)
        retval = Date.utilityMinimizeAmPm(of: retval)
        guard let end, let endTime, let endDelta, endTime != self else { return retval }

        let endDateString = self.isSameDate(as: endTime, in: timeZone) ? "" :
            endTime.utilityDateLongSmart(delta: endDelta, in: timeZone)
        let endTimeString = end.utilityTimeLongSmart(delta: endDelta, in: timeZone)
        let endAtString = (endDateString.isEmpty || endTimeString.isEmpty) ? "" : self.utilityAtLong(style: .smart)
        let endString = endDateString + endAtString + endTimeString
        guard retval != endString else { return retval }
        retval += " - " + endString
        return retval
    }
    private func utilityTimeLongPretty(delta: TimeInterval, in timeZone: TimeZone) -> String {
        return utilityTimeLongPretty(startDelta: delta, in: timeZone)
    }
    // swiftlint:disable:next cyclomatic_complexity function_body_length
    private func utilityTimeLongPretty(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil,
                                       in timeZone: TimeZone) -> String {
        var retval = ""

        if startDelta > 0 {
            if startDelta < Seconds.deltaOneMinute {
                retval = C.Localizations.DatePretty.justNow
            } else if startDelta < Seconds.deltaTwoMinutes {
                retval = C.Localizations.DatePretty.inOneMinute
            } else if startDelta < Seconds.deltaOneHour {
                let inMinutes = Int(floor(startDelta / Seconds.deltaOneMinute))
                retval = String(format: C.Localizations.DatePretty.inMinutes, "\(inMinutes)")
            } else if startDelta < Seconds.deltaTwoHours {
                retval = C.Localizations.DatePretty.inOneHour
            } else if startDelta < Seconds.deltaOneDay {
                let inHours = Int(floor(startDelta / Seconds.deltaOneHour))
                retval = String(format: C.Localizations.DatePretty.inHours, "\(inHours)")
            } else if startDelta < Seconds.deltaTwoDays {
                retval = C.Localizations.DatePretty.today
            } else if startDelta < Seconds.deltaOneWeek {
                let inDays = Int(floor(startDelta / Seconds.deltaOneDay))
                retval = String(format: C.Localizations.DatePretty.inDays, "\(inDays)")
            } else if startDelta < Seconds.deltaTwoWeeks {
                retval = C.Localizations.DatePretty.nextWeek
            } else if startDelta < Seconds.deltaSixWeeks {
                let inWeeks = Int(floor(startDelta / Seconds.deltaOneWeek))
                retval = String(format: C.Localizations.DatePretty.inWeeks, "\(inWeeks)")
            } else {
                if end == nil || end == self {
                    var timeFormatString = "h:mma"
                    if timeZone != TimeZone.current {
                        if end == nil || end == self {
                            timeFormatString += " zzz"
                        }
                    }
                    let dateFormatter = DateFormatter()
                    dateFormatter.timeZone = timeZone
                    dateFormatter.dateFormat = timeFormatString
                    retval = dateFormatter.string(from: self)
                        .replacingOccurrences(of: "AM", with: "am")
                        .replacingOccurrences(of: "PM", with: "pm")
                }
            }
        } else {
            if -startDelta < Seconds.deltaOneMinute {
                retval = C.Localizations.DatePretty.justNow
            } else if -startDelta < Seconds.deltaTwoMinutes {
                retval = C.Localizations.DatePretty.oneMinuteAgo
            } else if -startDelta < Seconds.deltaOneHour {
                let minutesAgo = Int(floor(-startDelta / Seconds.deltaOneMinute))
                retval = String(format: C.Localizations.DatePretty.minutesAgo, "\(minutesAgo)")
            } else if -startDelta < Seconds.deltaTwoHours {
                retval = C.Localizations.DatePretty.oneHourAgo
            } else if -startDelta < Seconds.deltaOneDay {
                let hoursAgo = Int(floor(-startDelta / Seconds.deltaOneHour))
                retval = String(format: C.Localizations.DatePretty.hoursAgo, "\(hoursAgo)")
            } else if -startDelta < Seconds.deltaTwoDays {
                retval = C.Localizations.DatePretty.yesterday
            } else if -startDelta < Seconds.deltaOneWeek {
                let daysAgo = Int(floor(-startDelta / Seconds.deltaOneDay))
                retval = String(format: C.Localizations.DatePretty.daysAgo, "\(daysAgo)")
            } else if -startDelta < Seconds.deltaTwoWeeks {
                retval = C.Localizations.DatePretty.lastWeek
            } else if -startDelta < Seconds.deltaSixWeeks {
                let weeksAgo = Int(floor(-startDelta / Seconds.deltaOneWeek))
                retval = String(format: C.Localizations.DatePretty.weeksAgo, "\(weeksAgo)")
            } else {
                if end == nil || end == self {
                    var timeFormatString = "h:mma"
                    if timeZone != TimeZone.current {
                        if end == nil || end == self {
                            timeFormatString += " zzz"
                        }
                    }
                    let dateFormatter = DateFormatter()
                    dateFormatter.timeZone = timeZone
                    dateFormatter.dateFormat = timeFormatString
                    retval = dateFormatter.string(from: self)
                        .replacingOccurrences(of: "AM", with: "am")
                        .replacingOccurrences(of: "PM", with: "pm")
                }
            }
        }
        guard end != nil && end != self else { return retval }

        let endDateString = end!.utilityDateLongPretty(startDelta: endDelta!, to: end, endDelta: endDelta, in: timeZone)
        let endTimeString = end!.utilityTimeLongPretty(startDelta: endDelta!, to: end, endDelta: endDelta, in: timeZone)
        let endString = endDateString + self.utilityAtLong(style: .pretty) + endTimeString
        guard retval != endString else { return retval }
        retval += " " + C.Localizations.DatePretty.to + " " + endString
        return retval
    }
}
