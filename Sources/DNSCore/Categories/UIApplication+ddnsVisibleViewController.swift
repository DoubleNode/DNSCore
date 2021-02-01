//
//  UIApplication+ddnsVisibleViewController.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import DNSCoreThreading
import UIKit

public extension UIApplication {
    var dnsVisibleViewController : UIViewController? {
        var retval: UIViewController?
        DNSUIThread.run(.synchronously) {
            retval = self.keyWindow?.rootViewController?.dnsTopViewController
        }
        return retval
    }
}
