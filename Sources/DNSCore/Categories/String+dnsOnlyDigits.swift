//
//  String+dnsOnlyLetters.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public extension String {
    func dnsOnlyLetters() -> String {
        let filtredUnicodeScalars = unicodeScalars.filter { CharacterSet.letters.contains($0) }
        return String(String.UnicodeScalarView(filtredUnicodeScalars))
    }
}
