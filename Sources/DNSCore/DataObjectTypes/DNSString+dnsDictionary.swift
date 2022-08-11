//
//  DNSString+dnsDictionary.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation
import LocalAuthentication
#if !os(macOS)
import UIKit
#endif

public extension DNSString {
    convenience init(from data: [DNSString.Language: String]) {
        self.init()
        var newData: [String: String] = [:]
        data.keys.forEach {
            let string = Self.xlt.string(from: data[$0] as Any?) ?? ""
            newData[$0.rawValue] = DNSString.utilityCleanupString(string)
        }
        _strings = newData
    }
    convenience init(from data: DNSDataDictionary) {
        self.init()
        var newData: [String: String] = [:]
        data.keys.forEach {
            let string = Self.xlt.string(from: data[$0] as Any?) ?? ""
            newData[$0] = DNSString.utilityCleanupString(string)
        }
        _strings = newData
    }
    var asDictionary: [String: String] {
        return _strings
    }
}
