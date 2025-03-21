//
//  DNSPhone+dnsDictionary.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

public extension DNSPhone {
    convenience init?(from data: DNSDataDictionary) {
        guard !data.isEmpty else { return nil }
        let phoneStr = Self.xlt.string(from: data[Self.field(.phone)] as Any?) ?? ""
        self.init(phoneStr)
    }
    var asDictionary: DNSDataDictionary {
        var retval = DNSDataDictionary()
        retval.merge([
            Self.field(.phone): self.format(toType: .e164)
        ]) { (current, _) in current }
        return retval
    }
}
