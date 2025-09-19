//
//  String+dnsRegEx.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public extension String {
    func dnsCheck(regEx: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: regEx, options: []) else {
            return false
        }
        let range = NSRange(location: 0, length: self.utf16.count)
        return regex.firstMatch(in: self, options: [], range: range) != nil
    }
}
