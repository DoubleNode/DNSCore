//
//  SKStoreReviewController+dnsRequestReviewInCurrentScene.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import StoreKit
import UIKit

#if canImport(AppStore) && (os(iOS) || targetEnvironment(macCatalyst))
import AppStore
#endif

@MainActor
extension SKStoreReviewController {
    public static func dnsRequestReviewInCurrentScene() {
        guard let scene = UIApplication.dnsCurrentScene() as? UIWindowScene else {
            return
        }

        // Use the new AppStore API when available (iOS 18.0+, Mac Catalyst 18.0+)
        if #available(iOS 18.0, macCatalyst 18.0, *) {
            #if canImport(AppStore) && (os(iOS) || targetEnvironment(macCatalyst))
            AppStore.requestReview(in: scene)
            #else
            // Fallback to the legacy API if AppStore framework is not available
            requestReview(in: scene)
            #endif
        } else {
            // Use the legacy API for older versions
            requestReview(in: scene)
        }
    }
}
