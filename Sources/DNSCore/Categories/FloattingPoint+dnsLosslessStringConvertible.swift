//
//  FloattingPoint+dnsLosslessStringConvertible.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

extension LosslessStringConvertible {
    var string: String { .init(self) }
}
extension FloatingPoint where Self: LosslessStringConvertible {
    var decimal: Decimal? { Decimal(string: string) }
}
