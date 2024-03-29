//
//  SKStoreReviewController+dnsRequestReviewInCurrentScene.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import StoreKit
import UIKit

extension SKStoreReviewController {
    public static func dnsRequestReviewInCurrentScene() {
        if let scene = UIApplication.dnsCurrentScene() as? UIWindowScene {
            DispatchQueue.main.async {
                requestReview(in: scene)
            }
        }
    }
}
