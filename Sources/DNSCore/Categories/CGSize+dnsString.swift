//
//  CGSize+dnsString.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

#if !os(macOS)
import UIKit

public extension CGSize {
    init(with string: String) {
        var width = Double(0)
        var height = Double(0)
        if string.contains(",") {
            let strings = string.components(separatedBy: ",")
            if strings.count > 1 {
                width = Self.xlt.double(from: strings[0]) ?? 0
                height = Self.xlt.double(from: strings[1]) ?? 0
            }
        }
        self.init(width: width, height: height)
    }
}
#endif
