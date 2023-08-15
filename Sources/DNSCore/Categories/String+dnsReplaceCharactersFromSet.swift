//
//  String+dnsReplaceCharactersFromSet.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public extension String {
    func dnsReplaceCharactersFromSet(characterSet: CharacterSet, replacementString: String = "") -> String {
        return self.components(separatedBy: characterSet).joined(separator: replacementString)
    }
}
