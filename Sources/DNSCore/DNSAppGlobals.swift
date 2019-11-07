//
//  DNSAppGlobals.swift
//  DNSCore
//
//  Created by Darren Ehlers on 9/30/19.
//  Copyright © 2019 DoubleNode.com. All rights reserved.
//

import DNSProtocols
import Foundation

open class DNSAppGlobals {
    static let shared   = DNSAppGlobals()

    public var appDidCrashLastRun: Bool = false
    public var appReviewWorker: PTCLAppReview_Protocol?

    var askedDeviceForPushNotifications: Bool = false

    public class func checkAndAskForReview() -> Bool {
        return self.shared.checkAndAskForReview()
    }

    required public init() {
        commonInit()
    }

    open func commonInit() {
        let launchedCount           = 1 + (DNSCore.appSetting(for: C.AppGlobals.launchedCount,
                                                              withDefault: 0) as? UInt ?? 0)
        let launchedFirstTime       = DNSCore.appSetting(for: C.AppGlobals.launchedFirstTime,
                                                         withDefault: Date()) as? Date ?? Date()
        let launchedLastTime        = DNSCore.appSetting(for: C.AppGlobals.launchedLastTime,
                                                         withDefault: Date(timeIntervalSince1970: 0)) as? Date

        _ = DNSCore.appSetting(set: C.AppGlobals.launchedCount, with: launchedCount)
        _ = DNSCore.appSetting(set: C.AppGlobals.launchedFirstTime, with: launchedFirstTime)
        _ = DNSCore.appSetting(set: C.AppGlobals.launchedLastTime, with: launchedLastTime)
    }

    // MARK: - Application methods

    open func applicationDidBecomeActive() {
    }
    open func applicationWillResignActive() {
    }

    // MARK: - Review methods

    func checkAndAskForReview() -> Bool {
        guard appReviewWorker != nil else { return false }

        // swiftlint:disable force_cast
        appReviewWorker!.launchedCount = DNSCore.appSetting(for: C.AppGlobals.launchedCount,
                                                            withDefault: 0) as! UInt
        appReviewWorker!.launchedFirstTime = DNSCore.appSetting(for: C.AppGlobals.launchedFirstTime,
                                                                withDefault: Date()) as! Date
        appReviewWorker!.launchedLastTime = DNSCore.appSetting(for: C.AppGlobals.launchedLastTime,
                                                               withDefault: Date(timeIntervalSince1970: 0)) as? Date
        appReviewWorker!.reviewRequestLastTime = DNSCore.appSetting(for: C.AppGlobals.reviewRequestLastTime,
                                                                    withDefault: Date(timeIntervalSince1970: 0)) as? Date
        // swiftlint:enable force_cast

        appReviewWorker!.appDidCrashLastRun = appDidCrashLastRun
        appReviewWorker!.daysUntilPrompt = Int(DNSAppConstants.requestReviewDaysSinceFirstLaunch)
        appReviewWorker!.usesUntilPrompt = Int(DNSAppConstants.requestReviewFirstMinimumLaunches)
        appReviewWorker!.daysBeforeReminding = Int(DNSAppConstants.requestReviewDaysSinceLastReview)

        var reviewed = false

        do {
            reviewed = try appReviewWorker!.doReview()
            if reviewed {
                _ = DNSCore.appSetting(set: C.AppGlobals.reviewRequestLastTime, with: Date())
            }
        } catch {
        }

        return reviewed
    }
}
