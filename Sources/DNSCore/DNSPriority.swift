//
//  DNSPriority.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//
//  DEPRECATED: This file re-exports DNSPriority from DNSDataTypes
//  Import DNSDataTypes directly instead.

import Foundation

// Re-export DNSPriority constants for backward compatibility
public enum DNSPriority {
    public static let none = 0
    public static let low = 250
    public static let normal = 500
    public static let high = 750
    public static let highest = 1000
}
