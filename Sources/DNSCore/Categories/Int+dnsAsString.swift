//
//  Int+asPrettyString.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public extension Int {
    var prettyString: String { self.asPrettyString() }
    func asPrettyString() -> String {
        Double(self).asPrettyString()
    }
}
