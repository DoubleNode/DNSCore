//
//  UIApplication+ddnsVisibleViewController.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

public extension UIApplication {
    var dnsVisibleViewController : UIViewController? {
        return keyWindow?.rootViewController?.dnsTopViewController
    }
}
