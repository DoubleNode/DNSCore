//
//  CLLocation+dnsDictionary.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import CoreLocation
import Foundation

public extension CLLocation {
    convenience init(with string: String) {
        var latitude = Double(0)
        var longitude = Double(0)
        if string.contains(",") {
            let strings = string.components(separatedBy: ",")
            if strings.count > 1 {
                latitude = Self.xlt.double(from: strings[0]) ?? 0
                longitude = Self.xlt.double(from: strings[1]) ?? 0
            }
        }
        self.init(latitude: latitude, longitude: longitude)
    }
}
