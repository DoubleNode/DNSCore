//
//  Date+dnsPrettyLonger.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public extension Date {
    func utilityAtLonger(style: Format.Style) -> String {
        switch style {
        case .simple:
            return " \(C.Localizations.DatePretty.at) "
        case .smart:
            return " \(C.Localizations.DatePretty.at) "
        case .pretty:
            return ", "
        case .military:
            return " "
        }
    }
    func utilityDateLonger(delta: TimeInterval, style: Format.Style,
                         in timeZone: TimeZone) -> String {
        switch style {
        case .simple:
            return utilityDateLongerSimple(delta: delta, in: timeZone)
        case .smart:
            return utilityDateLongerSmart(delta: delta, in: timeZone)
        case .pretty:
            return utilityDateLongerPretty(delta: delta, in: timeZone)
        case .military:
            return ""
        }
    }
    func utilityTimeLonger(delta: TimeInterval, style: Format.Style,
                         in timeZone: TimeZone) -> String {
        switch style {
        case .simple:
            return utilityTimeLongerSimple(delta: delta, in: timeZone)
        case .smart:
            return utilityTimeLongerSmart(delta: delta, in: timeZone)
        case .pretty:
            return utilityTimeLongerPretty(delta: delta, in: timeZone)
        case .military:
            return ""
        }
    }
    func utilityDateLonger(startDelta: TimeInterval, to end: Date? = nil,
                         endDelta: TimeInterval? = nil, style: Format.Style,
                         in timeZone: TimeZone) -> String {
        switch style {
        case .simple:
            return utilityDateLongerSimple(startDelta: startDelta, to: end, endDelta: endDelta, in: timeZone)
        case .smart:
            return utilityDateLongerSmart(startDelta: startDelta, to: end, endDelta: endDelta, in: timeZone)
        case .pretty:
            return utilityDateLongerPretty(startDelta: startDelta, to: end, endDelta: endDelta, in: timeZone)
        case .military:
            return ""
        }
    }
    func utilityTimeLonger(startDelta: TimeInterval, to end: Date? = nil,
                         endDelta: TimeInterval? = nil, style: Format.Style,
                         in timeZone: TimeZone) -> String {
        switch style {
        case .simple:
            return utilityTimeLongerSimple(startDelta: startDelta, to: end, endDelta: endDelta, in: timeZone)
        case .smart:
            return utilityTimeLongerSmart(startDelta: startDelta, to: end, endDelta: endDelta, in: timeZone)
        case .pretty:
            return utilityTimeLongerPretty(startDelta: startDelta, to: end, endDelta: endDelta, in: timeZone)
        case .military:
            return ""
        }
    }

    private func utilityDateLongerSimple(delta: TimeInterval,
                                       in timeZone: TimeZone) -> String {
        return self.utilityDateLongerSimple(startDelta: delta, in: timeZone)
    }
    private func utilityDateLongerSimple(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil,
                                       in timeZone: TimeZone) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        let dateFormatString = "E, MMMM d, yyyy"
        dateFormatter.dateFormat = dateFormatString
        var retval = dateFormatter.string(from: self)
        guard end != nil && end != self else { return retval }

        let endString = end!.utilityDateLongerSimple(startDelta: endDelta!, to: end, endDelta: endDelta, in: timeZone)
        guard retval != endString else { return retval }
        retval += " - " + endString
        return retval
    }
    private func utilityDateLongerSmart(delta: TimeInterval,
                                      in timeZone: TimeZone) -> String {
        return self.utilityDateLongerSmart(startDelta: delta, in: timeZone)
    }
    private func utilityDateLongerSmart(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil,
                                      in timeZone: TimeZone) -> String {
        let endTime = end?.zeroDate(in: timeZone)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        let weekdayFormatSubString = (self.isSameDay(as: /*endTime ?? */Date(), in: timeZone) && (endTime != self)) ? "" : "E, "
        let yearFormatSubString = (self.isSameYear(as: /*endTime ?? */Date(), in: timeZone) && (endTime != self)) ? "" : ", yyyy"
        let dateFormatString = "\(weekdayFormatSubString)MMMM d\(yearFormatSubString)"
        dateFormatter.dateFormat = dateFormatString
        var retval = dateFormatter.string(from: self)
        guard let endTime, let endDelta, endTime != self else { return retval }

        let endString = endTime.utilityDateLongerSmart(startDelta: endDelta, to: endTime, endDelta: endDelta, in: timeZone)
        guard retval != endString else { return retval }
        retval += " - " + endString
        return retval
    }
    private func utilityDateLongerPretty(delta: TimeInterval,
                                       in timeZone: TimeZone) -> String {
        return self.utilityDateLongerPretty(startDelta: delta, in: timeZone)
    }
    private func utilityDateLongerPretty(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil,
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

        let endString = end!.utilityDateLongerPretty(startDelta: endDelta!, to: end, endDelta: endDelta, in: timeZone)
        guard retval != endString else { return retval }
        retval += " \(C.Localizations.DatePretty.to) " + endString
        return retval
    }

    private func utilityTimeLongerSimple(delta: TimeInterval,
                                       in timeZone: TimeZone) -> String {
        var timeFormatString = "h:mma"
        if timeZone != TimeZone.current {
            timeFormatString += " zzzz"
        }
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = timeFormatString
        let retval = dateFormatter.string(from: self)
        return Date.utilityMinimizeAmPm(of: retval)
    }
    private func utilityTimeLongerSimple(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil,
                                       in timeZone: TimeZone) -> String {
        let dayFormatString = "E, MMMM d, yyyy'\(self.utilityAtLonger(style: .simple))'"
        var timeFormatString = "\(dayFormatString)h:mma"
        if timeZone != TimeZone.current {
            if end == nil || end == self {
                timeFormatString += " zzzz"
            }
        }
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = timeFormatString
        var retval = dateFormatter.string(from: self)
        retval = Date.utilityMinimizeAmPm(of: retval)
        guard end != nil && end != self else { return retval }

        let endString = end!.utilityTimeLongerSimple(startDelta: endDelta!, to: end, endDelta: endDelta, in: timeZone)
        guard retval != endString else { return retval }
        retval += " - " + endString
        return retval
    }
    private func utilityTimeLongerSmart(delta: TimeInterval,
                                        in timeZone: TimeZone) -> String {
        var timeFormatString = "h:mm\(self.dnsSecond > 0 ? ":ss" : "")a"
        if timeZone != TimeZone.current {
            timeFormatString += " zzzz"
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
    private func utilityTimeLongerSmart(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil,
                                      in timeZone: TimeZone) -> String {
        let endTime = end?.zeroDate(in: timeZone)
        let weekdayFormatSubString = (self.isSameDay(as: /*endTime ?? */Date(), in: timeZone) && (endTime != self)) ? "" : "E, "
        let yearFormatSubString = (self.isSameYear(as: /*endTime ?? */Date(), in: timeZone) && (endTime != self)) ? "" : ", yyyy"
        let dayFormatString = (self.isSameDate(as: /*endTime ?? */Date(), in: timeZone) && (endTime != self)) ? "" :
            "\(weekdayFormatSubString)MMMM d\(yearFormatSubString)"
        var timeFormatString = "\(dayFormatString)'\(self.utilityAtLonger(style: .smart))'h:mm\(self.dnsSecond > 0 ? ":ss" : "")a"
        if timeZone != TimeZone.current {
            if endTime == nil || endTime == self {
                timeFormatString += " zzzz"
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
            endTime.utilityDateLongerSmart(delta: endDelta, in: timeZone)
        let endTimeString = end.utilityTimeLongerSmart(delta: endDelta, in: timeZone)
        let endAtString = (endDateString.isEmpty || endTimeString.isEmpty) ? "" : self.utilityAtLonger(style: .smart)
        let endString = endDateString + endAtString + endTimeString
        guard retval != endString else { return retval }
        retval += " - " + endString
        return retval
    }
    private func utilityTimeLongerPretty(delta: TimeInterval,
                                       in timeZone: TimeZone) -> String {
        return self.utilityTimeLongerPretty(startDelta: delta, in: timeZone)
    }
    private func utilityTimeLongerPretty(startDelta: TimeInterval, to end: Date? = nil, endDelta: TimeInterval? = nil,
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
                retval = C.Localizations.DatePretty.tomorrow
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
                let dateFormatter = DateFormatter()
                dateFormatter.timeZone = timeZone
                dateFormatter.dateStyle = DateFormatter.Style.long
                retval = dateFormatter.string(from: self)
            }
        }
        guard end != nil && end != self else { return retval }

        let endString = end!.utilityTimeLongerPretty(startDelta: endDelta!, to: end, endDelta: endDelta, in: timeZone)
        guard retval != endString else { return retval }
        retval += " " + C.Localizations.DatePretty.to + " " + endString
        return retval
    }
}
