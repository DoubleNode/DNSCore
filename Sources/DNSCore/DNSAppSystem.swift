//
//  DNSAppSystem.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation
import UIKit

public class DNSAppSystem {
    public enum Status {
        case green, yellow, red
    }

    var code: String
    var name: String
    var status: Status = .green

    required init(code: String, name: String) {
        self.code = code
        self.name = name
    }
}

public extension NSAttributedString {
    func rangeOf(string: String) -> Range<String.Index>? {
        return self.string.range(of: string)
    }
}
public extension RangeExpression where Bound == String.Index  {
    func nsRange<S: StringProtocol>(in string: S) -> NSRange { .init(self, in: string) }
}
