//
//  DNSUniqueCounter.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import AtomicSwift
import Foundation

public class DNSUniqueCounter {
    nonisolated(unsafe) private static var intValue: Int = 0

    private static var value: Int {
        get {
            let retval = intValue
            intValue += 1
            return retval
        }
        set {
            intValue = newValue
        }
    }

    public class func initialize(startValue: Int = 0) {
        value = startValue
    }
    public class func unique() -> Int {
        return value
    }
}
