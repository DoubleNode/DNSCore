//
//  DNSUIFont+dnsString.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSBaseTheme
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

public extension DNSUIFont {
    convenience init(with string: String) {
        let font = UIFont(with: string)
        self.init(font)
    }
}
