//
//  DNS_C.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public enum DNSCoreError: Error, Equatable {
    case constantNotFound(key: String, filter: String)
}

public extension Notification.Name {
    static let reachabilityStatusChanged = Notification.Name("DNS_C_reachabilityStatusChanged")
}

public enum C {
    public enum AppConstants {
        public static let appConstantsNoUI = "appConstantsNoUI"
        public static let button = "button"
        public static let `default` = "default"
        public static let `false` = "false"
        public static let filenameDefault = "Constants"
        public static let filenameOverride = "appConstantsFilenameOverride"
        public static let key = "key"
        public static let dnsCheckmarkOff = "dnsCheckmarkOff"
        public static let dnsCheckmarkOn = "dnsCheckmarkOn"
        public static let label = "label"
        public static let message = "message"
        public static let noUI = "noUI"
        public static let options = "options"
        public static let state = "state"
        public static let title = "title"
        public static let toggles = "toggles"
        public static let `true` = "true"
    }
    public enum AppGlobals {
        public static let launchedCount = "appLaunchedCount"
        public static let launchedFirstTime = "appLaunchedFirstTime"
        public static let launchedLastTime = "appLaunchedLastTime"
        public static let reviewRequestLastTime = "appReviewRequestLastTime"

        public enum ReachabilityStatus {
            case unknown, notReachable
            case reachableViaWWAN, reachableViaWWANWithoutInternet
            case reachableViaWiFi, reachableViaWiFiWithoutInternet
        }
    }
    // swiftlint:disable line_length
    public enum Localizations {
        enum DatePretty {
            static let at = NSLocalizedString("DNSCoreDatePrettyAt", comment: "DNSCoreDatePrettyAt")
            static let days = NSLocalizedString("DNSCoreDatePrettyDays", comment: "DNSCoreDatePrettyDays")
            static let daysShort = NSLocalizedString("DNSCoreDatePrettyDaysShort", comment: "DNSCoreDatePrettyDaysShort")
            static let daysAgo = NSLocalizedString("DNSCoreDatePrettyDaysAgo", comment: "DNSCoreDatePrettyDaysAgo")
            static let daysAgoShort = NSLocalizedString("DNSCoreDatePrettyDaysAgoShort", comment: "DNSCoreDatePrettyDaysAgoShort")
            static let hour = NSLocalizedString("DNSCoreDatePrettyHour", comment: "DNSCoreDatePrettyHour")
            static let hourShort = NSLocalizedString("DNSCoreDatePrettyHourShort", comment: "DNSCoreDatePrettyHourShort")
            static let hourAgo = NSLocalizedString("DNSCoreDatePrettyHourAgo", comment: "DNSCoreDatePrettyHourAgo")
            static let hourAgoShort = NSLocalizedString("DNSCoreDatePrettyHourAgoShort", comment: "DNSCoreDatePrettyHourAgoShort")
            static let hours = NSLocalizedString("DNSCoreDatePrettyHours", comment: "DNSCoreDatePrettyHours")
            static let hoursShort = NSLocalizedString("DNSCoreDatePrettyHoursShort", comment: "DNSCoreDatePrettyHoursShort")
            static let hoursAgo = NSLocalizedString("DNSCoreDatePrettyHoursAgo", comment: "DNSCoreDatePrettyHoursAgo")
            static let hoursAgoShort = NSLocalizedString("DNSCoreDatePrettyHoursAgoShort", comment: "DNSCoreDatePrettyHoursAgoShort")
            static let justNow = NSLocalizedString("DNSCoreDatePrettyJustNow", comment: "DNSCoreDatePrettyJustNow")
            static let lastWeek = NSLocalizedString("DNSCoreDatePrettyLastWeek", comment: "DNSCoreDatePrettyLastWeek")
            static let minute = NSLocalizedString("DNSCoreDatePrettyMinute", comment: "DNSCoreDatePrettyMinute")
            static let minuteShort = NSLocalizedString("DNSCoreDatePrettyMinuteShort", comment: "DNSCoreDatePrettyMinuteShort")
            static let minuteAgo = NSLocalizedString("DNSCoreDatePrettyMinuteAgo", comment: "DNSCoreDatePrettyMinuteAgo")
            static let minuteAgoShort = NSLocalizedString("DNSCoreDatePrettyMinuteAgoShort", comment: "DNSCoreDatePrettyMinuteAgoShort")
            static let minutes = NSLocalizedString("DNSCoreDatePrettyMinutes", comment: "DNSCoreDatePrettyMinutes")
            static let minutesAbbrev = NSLocalizedString("DNSCoreDatePrettyMinutesAbbrev", comment: "DNSCoreDatePrettyMinutesAbbrev")
            static let minutesShort = NSLocalizedString("DNSCoreDatePrettyMinutesShort", comment: "DNSCoreDatePrettyMinutesShort")
            static let minutesAgo = NSLocalizedString("DNSCoreDatePrettyMinutesAgo", comment: "DNSCoreDatePrettyMinutesAgo")
            static let minutesAgoAbbrev = NSLocalizedString("DNSCoreDatePrettyMinutesAgoAbbrev", comment: "DNSCoreDatePrettyMinutesAgoAbbrev")
            static let minutesAgoShort = NSLocalizedString("DNSCoreDatePrettyMinutesAgoShort", comment: "DNSCoreDatePrettyMinutesAgoShort")
            static let now = NSLocalizedString("DNSCoreDatePrettyNow", comment: "DNSCoreDatePrettyNow")
            static let oneHourAgo = NSLocalizedString("DNSCoreDatePrettyOneHourAgo", comment: "DNSCoreDatePrettyOneHourAgo")
            static let oneMinuteAgo = NSLocalizedString("DNSCoreDatePrettyOneMinuteAgo", comment: "DNSCoreDatePrettyOneMinuteAgo")
            static let to = NSLocalizedString("DNSCoreDatePrettyTo", comment: "DNSCoreDatePrettyTo")
            static let today = NSLocalizedString("DNSCoreDatePrettyToday", comment: "DNSCoreDatePrettyToday")
            static let todayShort = NSLocalizedString("DNSCoreDatePrettyTodayShort", comment: "DNSCoreDatePrettyTodayShort")
            static let tomorrow = NSLocalizedString("DNSCoreDatePrettyTomorrow", comment: "DNSCoreDatePrettyTomorrow")
            static let tomorrowShort = NSLocalizedString("DNSCoreDatePrettyTomorrowShort", comment: "DNSCoreDatePrettyTomorrowShort")
            static let week = NSLocalizedString("DNSCoreDatePrettyWeek", comment: "DNSCoreDatePrettyWeek")
            static let weekShort = NSLocalizedString("DNSCoreDatePrettyWeekShort", comment: "DNSCoreDatePrettyWeekShort")
            static let weekAgo = NSLocalizedString("DNSCoreDatePrettyWeekAgo", comment: "DNSCoreDatePrettyWeekAgo")
            static let weekAgoShort = NSLocalizedString("DNSCoreDatePrettyWeekAgoShort", comment: "DNSCoreDatePrettyWeekAgoShort")
            static let weeks = NSLocalizedString("DNSCoreDatePrettyWeeks", comment: "DNSCoreDatePrettyWeeks")
            static let weeksShort = NSLocalizedString("DNSCoreDatePrettyWeeksShort", comment: "DNSCoreDatePrettyWeeksShort")
            static let weeksAgo = NSLocalizedString("DNSCoreDatePrettyWeeksAgo", comment: "DNSCoreDatePrettyWeeksAgo")
            static let weeksAgoShort = NSLocalizedString("DNSCoreDatePrettyWeeksAgoShort", comment: "DNSCoreDatePrettyWeeksAgoShort")
            static let yesterday = NSLocalizedString("DNSCoreDatePrettyYesterday", comment: "DNSCoreDatePrettyYesterday")
            static let yesterdayShort = NSLocalizedString("DNSCoreDatePrettyYesterdayShort", comment: "DNSCoreDatePrettyYesterdayShort")
        }
    }
    // swiftlint:enable line_length
}

// MARK: - General Block Types

public typealias DNSBoolBlock = (Bool) -> Void
public typealias DNSBoolBoolBlock = (Bool, Bool) -> Void
