//
//  DNSUIBorder+dnsString.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSBaseTheme
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

public extension DNSUIBorder {
    convenience init?(with string: String) {
        var color: DNSUIColor?
        var width: Double?
        var cornerRadius: Double?
        guard string.contains("|") else { return nil }
        let strings = string.components(separatedBy: "|")
        if strings.isEmpty { return nil }
        if strings.count >= 1 {
            color = Self.xlt.dnscolor(from: strings[0])
        }
        guard let color else { return nil }
        if strings.count >= 2 {
            width = Self.xlt.double(from: strings[1])
        }
        guard let width else {
            self.init(color: color)
            return
        }
        if strings.count >= 3 {
            cornerRadius = Self.xlt.double(from: strings[2])
        }
        guard let cornerRadius else {
            self.init(color: color, width: width)
            return
        }
        self.init(color: color, cornerRadius: cornerRadius, width: width)
    }
}
