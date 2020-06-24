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
public extension DNSAppConstants {
    enum BuildType {
        case unknown, dev, qa, alpha, beta, prod
    }

    @nonobjc
    static var appBuildType: BuildType = .unknown

    static var appGroupPath: String {
        do {
            return try self.constant(from: "appGroupPath") as String
        } catch { return "" }
    }
    static var appFontScaling: Double {
        do {
            return try self.constant(from: "appFontScaling") as Double
        } catch { return 0 }
    }

    // MARK: - App Request Review Constants
    static var requestReviews: Bool {
        do {
            return try self.constant(from: "requestReviews") as Bool
        } catch { return false }
    }
    static var requestReviewFirstMinimumLaunches: UInt {
        do {
            return try self.constant(from: "requestReviewFirstMinimumLaunches") as UInt
        } catch { return 0 }
    }
    static var requestReviewFirstMaximumLaunches: UInt {
        do {
            return try self.constant(from: "requestReviewFirstMaximumLaunches") as UInt
        } catch { return 0 }
    }
    static var requestReviewFrequency: UInt {
        do {
            return try self.constant(from: "requestReviewFrequency") as UInt
        } catch { return 0 }
    }
    static var requestReviewDaysSinceFirstLaunch: UInt {
        do {
            return try self.constant(from: "requestReviewDaysSinceFirstLaunch") as UInt
        } catch { return 0 }
    }
    static var requestReviewHoursSinceLastLaunch: UInt {
        do {
            return try self.constant(from: "requestReviewHoursSinceLastLaunch") as UInt
        } catch { return 0 }
    }
    static var requestReviewDaysSinceLastReview: UInt {
        do {
            return try self.constant(from: "requestReviewDaysSinceLastReview") as UInt
        } catch { return 0 }
    }
}
