//
//  DNSDataTranslation+TokenString.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import DNSCoreThreading
import Foundation
#if !os(macOS)
import UIKit
#endif

public extension DNSDataTranslation {
    // MARK: - tokenString...
    // swiftlint:disable:next cyclomatic_complexity
    func tokenString(from any: Any?) -> String? {
        guard let any else { return nil }
        return self.tokenString(from: any as? String)
    }
    func tokenString(from string: String?) -> String? {
        guard var string else { return nil }
        self.tokenReplacements.keys.forEach {
            string = string.replacingOccurrences(of: "%\($0)%",
                                                 with: self.tokenReplacements[$0] ?? "")
        }
        return string
    }
}
