//
//  DNSCoreCodeLocation.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import DNSError

public extension DNSCodeLocation {
    typealias core = DNSCoreCodeLocation // swiftlint:disable:this type_name
}
open class DNSCoreCodeLocation: DNSCodeLocation {
    override open class var domainPreface: String { "com.doublenode.core." }
}
