//
//  DNS_C.swift
//  DNSCore
//
//  Created by Darren Ehlers on 8/14/19.
//  Copyright © 2019 DoubleNode.com. All rights reserved.
//

import Foundation

public extension Notification.Name {
    static let reachabilityStatusChanged = Notification.Name("DNS_C_reachabilityStatusChanged")
}

public enum C {
    public enum AppConstants {
        static let appConstantsNoUI = "appConstantsNoUI"
        static let button = "button"
        static let `default` = "default"
        static let `false` = "false"
        static let filenameDefault = "Constants"
        static let filenameOverride = "appConstantsFilenameOverride"
        static let key = "key"
        static let iconCheckmarkOff = "iconCheckmarkOff"
        static let iconCheckmarkOn = "iconCheckmarkOn"
        static let label = "label"
        static let message = "message"
        static let noUI = "noUI"
        static let options = "options"
        static let state = "state"
        static let title = "toggles"
        static let toggles = "toggles"
        static let `true` = "true"
    }
    public enum AppGlobals {
        static let launchedCount = "appLaunchedCount"
        static let launchedFirstTime = "appLaunchedFirstTime"
        static let launchedLastTime = "appLaunchedLastTime"
        static let reviewRequestLastTime = "appReviewRequestLastTime"

        public enum ReachabilityStatus {
            case unknown, notReachable
            case reachableViaWWAN, reachableViaWWANWithoutInternet
            case reachableViaWiFi, reachableViaWiFiWithoutInternet
        }
    }
}

// MARK: - General Block Types

public typealias DNSBoolBlock = (Bool) -> Void
public typealias DNSBoolBoolBlock = (Bool, Bool) -> Void
