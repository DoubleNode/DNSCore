//
//  DNS_C.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import DNSError
import Foundation

public extension DNSError {
    typealias Core = DNSCoreError
}
public enum DNSCoreError: DNSError {
    // Common Errors
    case unknown(_ codeLocation: DNSCodeLocation)
    case notImplemented(_ codeLocation: DNSCodeLocation)
    case notFound(field: String, value: String, _ codeLocation: DNSCodeLocation)
    case invalidParameters(parameters: [String], _ codeLocation: DNSCodeLocation)
    case lowerError(error: Error, _ codeLocation: DNSCodeLocation)
    // Domain-Specific Errors

    public static let domain = "CORE"
    public enum Code: Int
    {
        // Common Errors
        case unknown = 1001
        case notImplemented = 1002
        case notFound = 1003
        case invalidParameters = 1004
        case lowerError = 1005
        // Domain-Specific Errors
    }
    
    public var nsError: NSError! {
        switch self {
            // Common Errors
        case .unknown(let codeLocation):
            var userInfo = codeLocation.userInfo
            userInfo[NSLocalizedDescriptionKey] = self.errorString
            return NSError.init(domain: Self.domain,
                                code: Self.Code.unknown.rawValue,
                                userInfo: userInfo)
        case .notImplemented(let codeLocation):
            var userInfo = codeLocation.userInfo
            userInfo[NSLocalizedDescriptionKey] = self.errorString
            return NSError.init(domain: Self.domain,
                                code: Self.Code.notImplemented.rawValue,
                                userInfo: userInfo)
        case .notFound(let field, let value, let codeLocation):
            var userInfo = codeLocation.userInfo
            userInfo["field"] = field
            userInfo["value"] = value
            userInfo[NSLocalizedDescriptionKey] = self.errorString
            return NSError.init(domain: Self.domain,
                                code: Self.Code.notFound.rawValue,
                                userInfo: userInfo)
        case .invalidParameters(let parameters, let codeLocation):
            var userInfo = codeLocation.userInfo
            userInfo[NSLocalizedDescriptionKey] = self.errorString
            userInfo["Parameters"] = parameters
            return NSError.init(domain: Self.domain,
                                code: Self.Code.invalidParameters.rawValue,
                                userInfo: userInfo)
        case .lowerError(let error, let codeLocation):
            var userInfo = codeLocation.userInfo
            userInfo["Error"] = error
            userInfo[NSLocalizedDescriptionKey] = self.errorString
            return NSError.init(domain: Self.domain,
                                code: Self.Code.lowerError.rawValue,
                                userInfo: userInfo)
            // Domain-Specific Errors
        }
    }
    public var errorDescription: String? {
        return self.errorString
    }
    public var errorString: String {
        switch self {
            // Common Errors
        case .unknown:
            return String(format: NSLocalizedString("CORE-Unknown Error%@", comment: ""),
                          " (\(Self.domain):\(Self.Code.unknown.rawValue))")
        case .notImplemented:
            return String(format: NSLocalizedString("CORE-Not Implemented%@", comment: ""),
                          " (\(Self.domain):\(Self.Code.notImplemented.rawValue))")
        case .notFound(let field, let value, _):
            return String(format: NSLocalizedString("CORE-Not Found%@%@%@", comment: ""),
                          "\(field)", "\(value)",
                          "(\(Self.domain):\(Self.Code.notFound.rawValue))")
        case .invalidParameters(let parameters, _):
            let parametersString = parameters.reduce("") { $0 + ($0.isEmpty ? "" : ", ") + $1 }
            return String(format: NSLocalizedString("CORE-Invalid Parameters%@%@", comment: ""),
                          "\(parametersString)",
                          " (\(Self.domain):\(Self.Code.invalidParameters.rawValue))")
        case .lowerError(let error, _):
            return String(format: NSLocalizedString("CORE-Lower Error%@%@", comment: ""),
                          error.localizedDescription,
                          " (\(Self.domain):\(Self.Code.lowerError.rawValue))")
            // Domain-Specific Errors
        }
    }
    public var failureReason: String? {
        switch self {
            // Common Errors
        case .unknown(let codeLocation),
             .notImplemented(let codeLocation),
             .notFound(_, _, let codeLocation),
             .invalidParameters(_, let codeLocation),
             .lowerError(_, let codeLocation):
            // Domain-Specific Errors
            return codeLocation.failureReason
        }
    }
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
            static let at = NSLocalizedString("DNSCoreDatePrettyAt", bundle: Bundle.module, comment: "DNSCoreDatePrettyAt")
            static let days = NSLocalizedString("DNSCoreDatePrettyDays", bundle: Bundle.module, comment: "DNSCoreDatePrettyDays")
            static let daysShort = NSLocalizedString("DNSCoreDatePrettyDaysShort", bundle: Bundle.module, comment: "DNSCoreDatePrettyDaysShort")
            static let daysAgo = NSLocalizedString("DNSCoreDatePrettyDaysAgo", bundle: Bundle.module, comment: "DNSCoreDatePrettyDaysAgo")
            static let daysAgoShort = NSLocalizedString("DNSCoreDatePrettyDaysAgoShort", bundle: Bundle.module, comment: "DNSCoreDatePrettyDaysAgoShort")
            static let hour = NSLocalizedString("DNSCoreDatePrettyHour", bundle: Bundle.module, comment: "DNSCoreDatePrettyHour")
            static let hourShort = NSLocalizedString("DNSCoreDatePrettyHourShort", bundle: Bundle.module, comment: "DNSCoreDatePrettyHourShort")
            static let hourAgo = NSLocalizedString("DNSCoreDatePrettyHourAgo", bundle: Bundle.module, comment: "DNSCoreDatePrettyHourAgo")
            static let hourAgoShort = NSLocalizedString("DNSCoreDatePrettyHourAgoShort", bundle: Bundle.module, comment: "DNSCoreDatePrettyHourAgoShort")
            static let hours = NSLocalizedString("DNSCoreDatePrettyHours", bundle: Bundle.module, comment: "DNSCoreDatePrettyHours")
            static let hoursShort = NSLocalizedString("DNSCoreDatePrettyHoursShort", bundle: Bundle.module, comment: "DNSCoreDatePrettyHoursShort")
            static let hoursAgo = NSLocalizedString("DNSCoreDatePrettyHoursAgo", bundle: Bundle.module, comment: "DNSCoreDatePrettyHoursAgo")
            static let hoursAgoShort = NSLocalizedString("DNSCoreDatePrettyHoursAgoShort", bundle: Bundle.module, comment: "DNSCoreDatePrettyHoursAgoShort")
            static let inDays = NSLocalizedString("DNSCoreDatePrettyInDays", bundle: Bundle.module, comment: "DNSCoreDatePrettyInDays")
            static let inDaysShort = NSLocalizedString("DNSCoreDatePrettyInDaysShort", bundle: Bundle.module, comment: "DNSCoreDatePrettyInDaysShort")
            static let inHour = NSLocalizedString("DNSCoreDatePrettyInHour", bundle: Bundle.module, comment: "DNSCoreDatePrettyInHour")
            static let inHourShort = NSLocalizedString("DNSCoreDatePrettyInHourShort", bundle: Bundle.module, comment: "DNSCoreDatePrettyInHourShort")
            static let inHours = NSLocalizedString("DNSCoreDatePrettyInHours", bundle: Bundle.module, comment: "DNSCoreDatePrettyInHours")
            static let inHoursShort = NSLocalizedString("DNSCoreDatePrettyInHoursShort", bundle: Bundle.module, comment: "DNSCoreDatePrettyInHoursShort")
            static let inMinute = NSLocalizedString("DNSCoreDatePrettyInMinute", bundle: Bundle.module, comment: "DNSCoreDatePrettyInMinute")
            static let inMinuteAbbrev = NSLocalizedString("DNSCoreDatePrettyInMinuteAbbrev", bundle: Bundle.module, comment: "DNSCoreDatePrettyInMinuteAbbrev")
            static let inMinuteShort = NSLocalizedString("DNSCoreDatePrettyInMinuteShort", bundle: Bundle.module, comment: "DNSCoreDatePrettyInMinuteShort")
            static let inMinutes = NSLocalizedString("DNSCoreDatePrettyInMinutes", bundle: Bundle.module, comment: "DNSCoreDatePrettyInMinutes")
            static let inMinutesAbbrev = NSLocalizedString("DNSCoreDatePrettyInMinutesAbbrev", bundle: Bundle.module, comment: "DNSCoreDatePrettyInMinutesAbbrev")
            static let inMinutesShort = NSLocalizedString("DNSCoreDatePrettyInMinutesShort", bundle: Bundle.module, comment: "DNSCoreDatePrettyInMinutesShort")
            static let inOneHour = NSLocalizedString("DNSCoreDatePrettyInOneHour", bundle: Bundle.module, comment: "DNSCoreDatePrettyInOneHour")
            static let inOneMinute = NSLocalizedString("DNSCoreDatePrettyInOneMinute", bundle: Bundle.module, comment: "DNSCoreDatePrettyInOneMinute")
            static let inWeek = NSLocalizedString("DNSCoreDatePrettyInWeek", bundle: Bundle.module, comment: "DNSCoreDatePrettyInWeek")
            static let inWeekShort = NSLocalizedString("DNSCoreDatePrettyInWeekShort", bundle: Bundle.module, comment: "DNSCoreDatePrettyInWeekShort")
            static let inWeeks = NSLocalizedString("DNSCoreDatePrettyInWeeks", bundle: Bundle.module, comment: "DNSCoreDatePrettyInWeeks")
            static let inWeeksShort = NSLocalizedString("DNSCoreDatePrettyInWeeksShort", bundle: Bundle.module, comment: "DNSCoreDatePrettyInWeeksShort")
            static let justNow = NSLocalizedString("DNSCoreDatePrettyJustNow", bundle: Bundle.module, comment: "DNSCoreDatePrettyJustNow")
            static let lastWeek = NSLocalizedString("DNSCoreDatePrettyLastWeek", bundle: Bundle.module, comment: "DNSCoreDatePrettyLastWeek")
            static let minute = NSLocalizedString("DNSCoreDatePrettyMinute", bundle: Bundle.module, comment: "DNSCoreDatePrettyMinute")
            static let minuteAbbrev = NSLocalizedString("DNSCoreDatePrettyMinuteAbbrev", bundle: Bundle.module, comment: "DNSCoreDatePrettyMinuteAbbrev")
            static let minuteShort = NSLocalizedString("DNSCoreDatePrettyMinuteShort", bundle: Bundle.module, comment: "DNSCoreDatePrettyMinuteShort")
            static let minuteAgo = NSLocalizedString("DNSCoreDatePrettyMinuteAgo", bundle: Bundle.module, comment: "DNSCoreDatePrettyMinuteAgo")
            static let minuteAgoAbbrev = NSLocalizedString("DNSCoreDatePrettyMinuteAgoAbbrev", bundle: Bundle.module, comment: "DNSCoreDatePrettyMinuteAgoAbbrev")
            static let minuteAgoShort = NSLocalizedString("DNSCoreDatePrettyMinuteAgoShort", bundle: Bundle.module, comment: "DNSCoreDatePrettyMinuteAgoShort")
            static let minutes = NSLocalizedString("DNSCoreDatePrettyMinutes", bundle: Bundle.module, comment: "DNSCoreDatePrettyMinutes")
            static let minutesAbbrev = NSLocalizedString("DNSCoreDatePrettyMinutesAbbrev", bundle: Bundle.module, comment: "DNSCoreDatePrettyMinutesAbbrev")
            static let minutesShort = NSLocalizedString("DNSCoreDatePrettyMinutesShort", bundle: Bundle.module, comment: "DNSCoreDatePrettyMinutesShort")
            static let minutesAgo = NSLocalizedString("DNSCoreDatePrettyMinutesAgo", bundle: Bundle.module, comment: "DNSCoreDatePrettyMinutesAgo")
            static let minutesAgoAbbrev = NSLocalizedString("DNSCoreDatePrettyMinutesAgoAbbrev", bundle: Bundle.module, comment: "DNSCoreDatePrettyMinutesAgoAbbrev")
            static let minutesAgoShort = NSLocalizedString("DNSCoreDatePrettyMinutesAgoShort", bundle: Bundle.module, comment: "DNSCoreDatePrettyMinutesAgoShort")
            static let nextWeek = NSLocalizedString("DNSCoreDatePrettyNextWeek", bundle: Bundle.module, comment: "DNSCoreDatePrettyNextWeek")
            static let now = NSLocalizedString("DNSCoreDatePrettyNow", bundle: Bundle.module, comment: "DNSCoreDatePrettyNow")
            static let oneHourAgo = NSLocalizedString("DNSCoreDatePrettyOneHourAgo", bundle: Bundle.module, comment: "DNSCoreDatePrettyOneHourAgo")
            static let oneMinuteAgo = NSLocalizedString("DNSCoreDatePrettyOneMinuteAgo", bundle: Bundle.module, comment: "DNSCoreDatePrettyOneMinuteAgo")
            static let to = NSLocalizedString("DNSCoreDatePrettyTo", bundle: Bundle.module, comment: "DNSCoreDatePrettyTo")
            static let today = NSLocalizedString("DNSCoreDatePrettyToday", bundle: Bundle.module, comment: "DNSCoreDatePrettyToday")
            static let todayShort = NSLocalizedString("DNSCoreDatePrettyTodayShort", bundle: Bundle.module, comment: "DNSCoreDatePrettyTodayShort")
            static let tomorrow = NSLocalizedString("DNSCoreDatePrettyTomorrow", bundle: Bundle.module, comment: "DNSCoreDatePrettyTomorrow")
            static let tomorrowShort = NSLocalizedString("DNSCoreDatePrettyTomorrowShort", bundle: Bundle.module, comment: "DNSCoreDatePrettyTomorrowShort")
            static let week = NSLocalizedString("DNSCoreDatePrettyWeek", bundle: Bundle.module, comment: "DNSCoreDatePrettyWeek")
            static let weekShort = NSLocalizedString("DNSCoreDatePrettyWeekShort", bundle: Bundle.module, comment: "DNSCoreDatePrettyWeekShort")
            static let weekAgo = NSLocalizedString("DNSCoreDatePrettyWeekAgo", bundle: Bundle.module, comment: "DNSCoreDatePrettyWeekAgo")
            static let weekAgoShort = NSLocalizedString("DNSCoreDatePrettyWeekAgoShort", bundle: Bundle.module, comment: "DNSCoreDatePrettyWeekAgoShort")
            static let weeks = NSLocalizedString("DNSCoreDatePrettyWeeks", bundle: Bundle.module, comment: "DNSCoreDatePrettyWeeks")
            static let weeksShort = NSLocalizedString("DNSCoreDatePrettyWeeksShort", bundle: Bundle.module, comment: "DNSCoreDatePrettyWeeksShort")
            static let weeksAgo = NSLocalizedString("DNSCoreDatePrettyWeeksAgo", bundle: Bundle.module, comment: "DNSCoreDatePrettyWeeksAgo")
            static let weeksAgoShort = NSLocalizedString("DNSCoreDatePrettyWeeksAgoShort", bundle: Bundle.module, comment: "DNSCoreDatePrettyWeeksAgoShort")
            static let yesterday = NSLocalizedString("DNSCoreDatePrettyYesterday", bundle: Bundle.module, comment: "DNSCoreDatePrettyYesterday")
            static let yesterdayShort = NSLocalizedString("DNSCoreDatePrettyYesterdayShort", bundle: Bundle.module, comment: "DNSCoreDatePrettyYesterdayShort")
        }
    }
    // swiftlint:enable line_length
}

// MARK: - General Block Types

public typealias DNSBoolBlock = (Bool) -> Void
public typealias DNSBoolBoolBlock = (Bool, Bool) -> Void
public typealias DNSBoolErrorBlock = (Bool, DNSError) -> Void
public typealias DNSErrorBlock = (DNSError) -> Void
