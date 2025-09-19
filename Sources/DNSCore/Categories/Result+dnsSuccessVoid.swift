//
//  Result+dnsSuccessVoid.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

extension Result where Success == Void {
    public static var success: Result { .success(()) }
}
