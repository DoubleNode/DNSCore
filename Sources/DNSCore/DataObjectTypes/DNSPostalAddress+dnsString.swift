//
//  DNSPostalAddress+dnsString.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSBaseTheme
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

public extension DNSPostalAddress {
    convenience init(with string: String) {
        var street = ""
        var city = ""
        var state = ""
        var postalCode = ""
        let stringsByCommas = string
            .replacingOccurrences(of: "\n", with: ",")
            .components(separatedBy: ",")
            .map { $0.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
        let skip = stringsByCommas.count - 2
        if skip >= 0 {
            let stringsBySpaces = stringsByCommas.last!
                .components(separatedBy: " ")
                .map { $0.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) }
                .filter { !$0.isEmpty }
            if !stringsBySpaces.isEmpty {
                postalCode = stringsBySpaces.last ?? ""
            }
            if stringsBySpaces.count > 1 {
                state = stringsBySpaces[stringsBySpaces.count - 2]
            }
            var cityCount = stringsBySpaces.count - 2
            while cityCount >= 0 {
                city = stringsBySpaces[cityCount] + " " + city
                cityCount -= 1
            }
            street = stringsByCommas[skip]
        }
        self.init(street, city: city, state: state, postalCode: postalCode)
    }
}
