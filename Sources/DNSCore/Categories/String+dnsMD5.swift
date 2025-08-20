//
//  String+dnsMD5.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import CryptoKit
import Foundation

public extension String {
    /// Generates an MD5-equivalent hash using SHA256 (for compatibility)
    /// Note: This method now uses SHA256 instead of deprecated MD5 for security reasons.
    /// The method name is kept for backward compatibility but provides stronger hashing.
    func dnsMD5() -> String {
        let data = Data(utf8)
        let hash = SHA256.hash(data: data)
        return hash.compactMap { String(format: "%02hhx", $0) }.joined()
    }

    /// Generates a SHA256 hash (recommended for new code)
    func dnsSHA256() -> String {
        let data = Data(utf8)
        let hash = SHA256.hash(data: data)
        return hash.compactMap { String(format: "%02hhx", $0) }.joined()
    }
}
