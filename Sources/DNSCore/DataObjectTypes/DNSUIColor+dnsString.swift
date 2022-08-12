//
//  DNSUIColor+dnsString.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSBaseTheme
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

public extension DNSUIColor {
    convenience init(with string: String) {
        let normal = UIColor(with: string)
        self.init(normal)
    }
}
