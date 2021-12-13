//
//  DNSDataTranslation+TokenString.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import DNSCoreThreading
import UIKit

public extension DNSDataTranslation {
    // MARK: - tokenString...
    // swiftlint:disable:next cyclomatic_complexity
    func tokenString(from any: Any?) -> String? {
        guard any != nil else { return nil }
        return self.tokenString(from: any as? String)
    }
    func tokenString(from string: String?) -> String? {
        guard var string = string else { return nil }
        self.tokenReplacements.keys.forEach {
            string = string.replacingOccurrences(of: "%\($0)%",
                                                 with: self.tokenReplacements[$0] ?? "")
        }
        return string
    }
}