//
//  UIColor+dnsString.swift
//  DNSCore
//
//  Created by Darren Ehlers on 8/22/19.
//  Copyright © 2019 DoubleNode.com. All rights reserved.
//

import SFSymbol
import UIKit

public extension UIImage {
    convenience init(systemSymbol symbol: SFSymbol) {
        self.init(systemName: symbol.rawValue)!
    }
}
