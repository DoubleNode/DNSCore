//
//  DNSAppConstants+Defaults.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation
import UIKit

@objc
extension DNSAppConstants {
    static var appGroupPath: String { DNSAppConstants.shared.appGroupPathRead() }
    open func appGroupPathRead() -> String {
        do {
            return try DNSAppConstants.constant(from: "appGroupPath") as String
        } catch { return "" }
    }
    static var appFontScaling: Double { DNSAppConstants.shared.appFontScalingRead() }
    open func appFontScalingRead() -> Double {
        do {
            return try DNSAppConstants.constant(from: "appFontScaling") as Double
        } catch { return 0 }
    }

    // MARK: - App Request Review Constants
    static var requestReviews: Bool { DNSAppConstants.shared.requestReviewsRead() }
    open func requestReviewsRead() -> Bool {
        do {
            return try DNSAppConstants.constant(from: "requestReviews") as Bool
        } catch { return false }
    }
    static var requestReviewFirstMinimumLaunches: UInt { DNSAppConstants.shared.requestReviewFirstMinimumLaunchesRead() }
    open func requestReviewFirstMinimumLaunchesRead() -> UInt {
        do {
            return try DNSAppConstants.constant(from: "requestReviewFirstMinimumLaunches") as UInt
        } catch { return 0 }
    }
    static var requestReviewFirstMaximumLaunches: UInt { DNSAppConstants.shared.requestReviewFirstMaximumLaunchesRead() }
    open func requestReviewFirstMaximumLaunchesRead() -> UInt {
        do {
            return try DNSAppConstants.constant(from: "requestReviewFirstMaximumLaunches") as UInt
        } catch { return 0 }
    }
    static var requestReviewFrequency: UInt { DNSAppConstants.shared.requestReviewFrequencyRead() }
    open func requestReviewFrequencyRead() -> UInt {
        do {
            return try DNSAppConstants.constant(from: "requestReviewFrequency") as UInt
        } catch { return 0 }
    }
    static var requestReviewDaysSinceFirstLaunch: UInt { DNSAppConstants.shared.requestReviewDaysSinceFirstLaunchRead() }
    open func requestReviewDaysSinceFirstLaunchRead() -> UInt {
        do {
            return try DNSAppConstants.constant(from: "requestReviewDaysSinceFirstLaunch") as UInt
        } catch { return 0 }
    }
    static var requestReviewHoursSinceLastLaunch: UInt { DNSAppConstants.shared.requestReviewHoursSinceLastLaunchRead() }
    open func requestReviewHoursSinceLastLaunchRead() -> UInt {
        do {
            return try DNSAppConstants.constant(from: "requestReviewHoursSinceLastLaunch") as UInt
        } catch { return 0 }
    }
    static var requestReviewDaysSinceLastReview: UInt { DNSAppConstants.shared.requestReviewDaysSinceLastReviewRead() }
    open func requestReviewDaysSinceLastReviewRead() -> UInt {
        do {
            return try DNSAppConstants.constant(from: "requestReviewDaysSinceLastReview") as UInt
        } catch { return 0 }
    }
}
