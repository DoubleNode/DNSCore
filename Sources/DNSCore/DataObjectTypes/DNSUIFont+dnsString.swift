//
//  DNSUIFont+dnsString.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

#if canImport(UIKit)
import UIKit
#endif

#if canImport(UIKit)

public extension DNSUIFont {
    convenience init?(with string: String) {
        guard let font = UIFont(with: string) else { return nil }
        self.init(font)
    }
}
#endif
