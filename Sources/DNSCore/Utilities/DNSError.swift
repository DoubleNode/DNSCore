//
//  DNSError.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public protocol DNSError: LocalizedError {
    var nsError: NSError! { get }
}
