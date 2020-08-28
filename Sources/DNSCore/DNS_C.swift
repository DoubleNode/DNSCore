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
            static let at = NSLocalizedString("DNSCoreDatePrettyAt", bundle: .module, comment: "DNSCoreDatePrettyAt")
            static let days = NSLocalizedString("DNSCoreDatePrettyDays", bundle: .module, comment: "DNSCoreDatePrettyDays")
            static let daysShort = NSLocalizedString("DNSCoreDatePrettyDaysShort", bundle: .module, comment: "DNSCoreDatePrettyDaysShort")
            static let daysAgo = NSLocalizedString("DNSCoreDatePrettyDaysAgo", bundle: .module, comment: "DNSCoreDatePrettyDaysAgo")
            static let daysAgoShort = NSLocalizedString("DNSCoreDatePrettyDaysAgoShort", bundle: .module, comment: "DNSCoreDatePrettyDaysAgoShort")
            static let hour = NSLocalizedString("DNSCoreDatePrettyHour", bundle: .module, comment: "DNSCoreDatePrettyHour")
            static let hourShort = NSLocalizedString("DNSCoreDatePrettyHourShort", bundle: .module, comment: "DNSCoreDatePrettyHourShort")
            static let hourAgo = NSLocalizedString("DNSCoreDatePrettyHourAgo", bundle: .module, comment: "DNSCoreDatePrettyHourAgo")
            static let hourAgoShort = NSLocalizedString("DNSCoreDatePrettyHourAgoShort", bundle: .module, comment: "DNSCoreDatePrettyHourAgoShort")
            static let hours = NSLocalizedString("DNSCoreDatePrettyHours", bundle: .module, comment: "DNSCoreDatePrettyHours")
            static let hoursShort = NSLocalizedString("DNSCoreDatePrettyHoursShort", bundle: .module, comment: "DNSCoreDatePrettyHoursShort")
            static let hoursAgo = NSLocalizedString("DNSCoreDatePrettyHoursAgo", bundle: .module, comment: "DNSCoreDatePrettyHoursAgo")
            static let hoursAgoShort = NSLocalizedString("DNSCoreDatePrettyHoursAgoShort", bundle: .module, comment: "DNSCoreDatePrettyHoursAgoShort")
            static let justNow = NSLocalizedString("DNSCoreDatePrettyJustNow", bundle: .module, comment: "DNSCoreDatePrettyJustNow")
            static let lastWeek = NSLocalizedString("DNSCoreDatePrettyLastWeek", bundle: .module, comment: "DNSCoreDatePrettyLastWeek")
            static let minute = NSLocalizedString("DNSCoreDatePrettyMinute", bundle: .module, comment: "DNSCoreDatePrettyMinute")
            static let minuteShort = NSLocalizedString("DNSCoreDatePrettyMinuteShort", bundle: .module, comment: "DNSCoreDatePrettyMinuteShort")
            static let minuteAgo = NSLocalizedString("DNSCoreDatePrettyMinuteAgo", bundle: .module, comment: "DNSCoreDatePrettyMinuteAgo")
            static let minuteAgoShort = NSLocalizedString("DNSCoreDatePrettyMinuteAgoShort", bundle: .module, comment: "DNSCoreDatePrettyMinuteAgoShort")
            static let minutes = NSLocalizedString("DNSCoreDatePrettyMinutes", bundle: .module, comment: "DNSCoreDatePrettyMinutes")
            static let minutesAbbrev = NSLocalizedString("DNSCoreDatePrettyMinutesAbbrev", bundle: .module, comment: "DNSCoreDatePrettyMinutesAbbrev")
            static let minutesShort = NSLocalizedString("DNSCoreDatePrettyMinutesShort", bundle: .module, comment: "DNSCoreDatePrettyMinutesShort")
            static let minutesAgo = NSLocalizedString("DNSCoreDatePrettyMinutesAgo", bundle: .module, comment: "DNSCoreDatePrettyMinutesAgo")
            static let minutesAgoAbbrev = NSLocalizedString("DNSCoreDatePrettyMinutesAgoAbbrev", bundle: .module, comment: "DNSCoreDatePrettyMinutesAgoAbbrev")
            static let minutesAgoShort = NSLocalizedString("DNSCoreDatePrettyMinutesAgoShort", bundle: .module, comment: "DNSCoreDatePrettyMinutesAgoShort")
            static let now = NSLocalizedString("DNSCoreDatePrettyNow", bundle: .module, comment: "DNSCoreDatePrettyNow")
            static let oneHourAgo = NSLocalizedString("DNSCoreDatePrettyOneHourAgo", bundle: .module, comment: "DNSCoreDatePrettyOneHourAgo")
            static let oneMinuteAgo = NSLocalizedString("DNSCoreDatePrettyOneMinuteAgo", bundle: .module, comment: "DNSCoreDatePrettyOneMinuteAgo")
            static let to = NSLocalizedString("DNSCoreDatePrettyTo", bundle: .module, comment: "DNSCoreDatePrettyTo")
            static let today = NSLocalizedString("DNSCoreDatePrettyToday", bundle: .module, comment: "DNSCoreDatePrettyToday")
            static let todayShort = NSLocalizedString("DNSCoreDatePrettyTodayShort", bundle: .module, comment: "DNSCoreDatePrettyTodayShort")
            static let tomorrow = NSLocalizedString("DNSCoreDatePrettyTomorrow", bundle: .module, comment: "DNSCoreDatePrettyTomorrow")
            static let tomorrowShort = NSLocalizedString("DNSCoreDatePrettyTomorrowShort", bundle: .module, comment: "DNSCoreDatePrettyTomorrowShort")
            static let week = NSLocalizedString("DNSCoreDatePrettyWeek", bundle: .module, comment: "DNSCoreDatePrettyWeek")
            static let weekShort = NSLocalizedString("DNSCoreDatePrettyWeekShort", bundle: .module, comment: "DNSCoreDatePrettyWeekShort")
            static let weekAgo = NSLocalizedString("DNSCoreDatePrettyWeekAgo", bundle: .module, comment: "DNSCoreDatePrettyWeekAgo")
            static let weekAgoShort = NSLocalizedString("DNSCoreDatePrettyWeekAgoShort", bundle: .module, comment: "DNSCoreDatePrettyWeekAgoShort")
            static let weeks = NSLocalizedString("DNSCoreDatePrettyWeeks", bundle: .module, comment: "DNSCoreDatePrettyWeeks")
            static let weeksShort = NSLocalizedString("DNSCoreDatePrettyWeeksShort", bundle: .module, comment: "DNSCoreDatePrettyWeeksShort")
            static let weeksAgo = NSLocalizedString("DNSCoreDatePrettyWeeksAgo", bundle: .module, comment: "DNSCoreDatePrettyWeeksAgo")
            static let weeksAgoShort = NSLocalizedString("DNSCoreDatePrettyWeeksAgoShort", bundle: .module, comment: "DNSCoreDatePrettyWeeksAgoShort")
            static let yesterday = NSLocalizedString("DNSCoreDatePrettyYesterday", bundle: .module, comment: "DNSCoreDatePrettyYesterday")
            static let yesterdayShort = NSLocalizedString("DNSCoreDatePrettyYesterdayShort", bundle: .module, comment: "DNSCoreDatePrettyYesterdayShort")
        }
    }
    // swiftlint:enable line_length
}

// MARK: - General Block Types

public typealias DNSBoolBlock = (Bool) -> Void
public typealias DNSBoolBoolBlock = (Bool, Bool) -> Void
