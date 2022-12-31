//
//  Int+asPrettyString.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public extension Int {
    var prettyString: String { self.asPrettyString(filled: false) }
    var prettyFilledString: String { self.asPrettyString(filled: true) }
    func asPrettyString(filled: Bool = false) -> String {
        Double(self).asPrettyString(filled: filled)
    }
}
