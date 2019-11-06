//
//  DNSAppConstants+Defaults.swift
//  DNSCore
//
//  Created by Darren Ehlers on 8/14/19.
//  Copyright © 2019 DoubleNode.com. All rights reserved.
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
        return self.constant(from: "appGroupPath") as String
    }
    static var appFontScaling: Double {
        return self.constant(from: "appFontScaling") as Double
    }

    // MARK: - App Request Review Constants
    static var requestReviews: Bool {
        return self.constant(from: "requestReviews") as Bool
    }
    static var requestReviewFirstMinimumLaunches: UInt {
        return self.constant(from: "requestReviewFirstMinimumLaunches") as UInt
    }
    static var requestReviewFirstMaximumLaunches: UInt {
        return self.constant(from: "requestReviewFirstMaximumLaunches") as UInt
    }
    static var requestReviewFrequency: UInt {
        return self.constant(from: "requestReviewFrequency") as UInt
    }
    static var requestReviewDaysSinceFirstLaunch: UInt {
        return self.constant(from: "requestReviewDaysSinceFirstLaunch") as UInt
    }
    static var requestReviewHoursSinceLastLaunch: UInt {
        return self.constant(from: "requestReviewHoursSinceLastLaunch") as UInt
    }
    static var requestReviewDaysSinceLastReview: UInt {
        return self.constant(from: "requestReviewDaysSinceLastReview") as UInt
    }
}
