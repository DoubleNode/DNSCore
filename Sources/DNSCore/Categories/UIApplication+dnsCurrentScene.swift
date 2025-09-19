//
//  UIApplication+dnsCurrentScene.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

import StoreKit
#if canImport(UIKit)
import UIKit
#endif

#if canImport(UIKit)
extension UIApplication {
    public static func dnsCurrentScene() -> UIScene? {
        return Self.shared.connectedScenes.first(where: {
            $0.activationState == .foregroundActive
        })
    }
}
#endif
