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
    static var appGroupPath: String = DNSAppConstants.shared.appGroupPath()
    open func appGroupPath() -> String {
        do {
            return try DNSAppConstants.constant(from: "appGroupPath") as String
        } catch { return "" }
    }
    static var appFontScaling: Double = DNSAppConstants.shared.appFontScaling()
    open func appFontScaling() -> Double {
        do {
            return try DNSAppConstants.constant(from: "appFontScaling") as Double
        } catch { return 0 }
    }

    // MARK: - App Request Review Constants
    static var requestReviews: Bool { DNSAppConstants.shared.requestReviews() }
    open func requestReviews() -> Bool {
        do {
            return try DNSAppConstants.constant(from: "requestReviews") as Bool
        } catch { return false }
    }
    static var requestReviewFirstMinimumLaunches: UInt { DNSAppConstants.shared.requestReviewFirstMinimumLaunches() }
    open func requestReviewFirstMinimumLaunches() -> UInt {
        do {
            return try DNSAppConstants.constant(from: "requestReviewFirstMinimumLaunches") as UInt
        } catch { return 0 }
    }
    static var requestReviewFirstMaximumLaunches: UInt { DNSAppConstants.shared.requestReviewFirstMaximumLaunches() }
    open func requestReviewFirstMaximumLaunches() -> UInt {
        do {
            return try DNSAppConstants.constant(from: "requestReviewFirstMaximumLaunches") as UInt
        } catch { return 0 }
    }
    static var requestReviewFrequency: UInt { DNSAppConstants.shared.requestReviewFrequency() }
    open func requestReviewFrequency() -> UInt {
        do {
            return try DNSAppConstants.constant(from: "requestReviewFrequency") as UInt
        } catch { return 0 }
    }
    static var requestReviewDaysSinceFirstLaunch: UInt { DNSAppConstants.shared.requestReviewDaysSinceFirstLaunch() }
    open func requestReviewDaysSinceFirstLaunch() -> UInt {
        do {
            return try DNSAppConstants.constant(from: "requestReviewDaysSinceFirstLaunch") as UInt
        } catch { return 0 }
    }
    static var requestReviewHoursSinceLastLaunch: UInt { DNSAppConstants.shared.requestReviewHoursSinceLastLaunch() }
    open func requestReviewHoursSinceLastLaunch() -> UInt {
        do {
            return try DNSAppConstants.constant(from: "requestReviewHoursSinceLastLaunch") as UInt
        } catch { return 0 }
    }
    static var requestReviewDaysSinceLastReview: UInt { DNSAppConstants.shared.requestReviewDaysSinceLastReview() }
    open func requestReviewDaysSinceLastReview() -> UInt {
        do {
            return try DNSAppConstants.constant(from: "requestReviewDaysSinceLastReview") as UInt
        } catch { return 0 }
    }
}
