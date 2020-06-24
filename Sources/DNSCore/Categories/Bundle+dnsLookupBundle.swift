//
//  Bundle+dnsLookupBundle.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public extension Bundle {
    class func dnsLookupNibBundle(for classType: AnyClass?) -> Bundle? {
        guard classType != nil else { return nil }

        let className   = String(describing: classType!)
        let classBundle = self.dnsLookupBundle(for: classType)
        let path        = classBundle?.path(forResource: className, ofType: "nib")

        return (path != nil) ? classBundle : nil
    }
    class func dnsLookupBundle(for classType: AnyClass?) -> Bundle? {
        guard classType != nil else { return nil }

        let className   = String(describing: classType!)
        var classBundle = self.utilityBundle(forClass: className)
        if classBundle == nil {
            classBundle = Bundle.init(for: classType!)
        }
        if classBundle == nil {
            classBundle = Bundle(for: classType!)
        }

        return classBundle ?? Bundle.init(for: classType!)
    }
    class func dnsLookupBundle(for className: String) -> Bundle? {
        guard !className.isEmpty else { return nil }

        let classType: AnyClass? = NSClassFromString("\(className)")
        guard classType != nil else { return nil }

        return self.dnsLookupBundle(for: classType)
    }

    class private func utilityBundle(forClass className: String?) -> Bundle? {
        let path = self.utilityBundlePath(forClass: className)
        guard path != nil else { return nil }

        return Bundle.init(path: path!)
    }

    class private func utilityBundlePath(forClass className: String?) -> String? {
        for bundle: Bundle in Bundle.allBundles {
            let path = bundle.path(forResource: className,
                                   ofType: "bundle")
            if path != nil { return path }
        }

        for bundle: Bundle in Bundle.allFrameworks {
            let path = bundle.path(forResource: className,
                                   ofType: "bundle")
            if path != nil { return path }
        }

        return nil
    }
}
