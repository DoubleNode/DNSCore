//
//  String+dnsReplaceDigitsWithText.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public extension String {
    func dnsReplaceDigitsWithText() -> String {
        return self
            .replacingOccurrences(of: "0", with: "_zero_")
            .replacingOccurrences(of: "1", with: "_one_")
            .replacingOccurrences(of: "2", with: "_two_")
            .replacingOccurrences(of: "3", with: "_three_")
            .replacingOccurrences(of: "4", with: "_four_")
            .replacingOccurrences(of: "5", with: "_five_")
            .replacingOccurrences(of: "6", with: "_six_")
            .replacingOccurrences(of: "7", with: "_seven_")
            .replacingOccurrences(of: "8", with: "_eight_")
            .replacingOccurrences(of: "9", with: "_nine_")
            .replacingOccurrences(of: "__", with: "_")
            .trimmingCharacters(in: CharacterSet(charactersIn: "_"))
    }
}
