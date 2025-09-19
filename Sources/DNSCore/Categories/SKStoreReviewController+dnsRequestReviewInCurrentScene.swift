//
//  SKStoreReviewController+dnsRequestReviewInCurrentScene.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

import StoreKit
#if canImport(UIKit)
import UIKit
#endif

@available(iOS 10.3, macOS 10.14, tvOS 10.3, watchOS 6.2, *)
extension SKStoreReviewController {
    public static func dnsRequestReviewInCurrentScene() {
        #if canImport(UIKit)
        if let scene = UIApplication.dnsCurrentScene() as? UIWindowScene {
            DispatchQueue.main.async {
                requestReview(in: scene)
            }
        }
        #endif
    }
}
