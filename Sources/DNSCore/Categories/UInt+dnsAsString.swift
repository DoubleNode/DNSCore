//
//  UInt+asPrettyString.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public extension UInt {
    var prettyString: String { self.asPrettyString() }
    func asPrettyString() -> String {
        Int(self).asPrettyString()
    }
}
