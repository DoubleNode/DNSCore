//
//  DoubleOptional+dnsZero.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public extension Optional where Wrapped == Double {
    var isNilOrZero: Bool {
        self == nil || self == 0.0
    }
    var orZero: Double {
        self ?? 0.0
    }
}
