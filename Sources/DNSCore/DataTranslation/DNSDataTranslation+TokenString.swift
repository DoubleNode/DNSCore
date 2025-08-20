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
    func tokenString(from any: Any?) -> String? {
        guard let any else { return nil }
        return self.tokenString(from: any as? String)
    }
    func tokenString(from string: String?) -> String? {
        guard let string else { return nil }
        return self.replaceTokens(in: string)
    }
}
