//
//  String+dnsMD5.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import CommonCrypto
import Foundation

public extension String {
    func dnsMD5() -> String {
        let data = Data(utf8) as NSData
        var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))

        CC_MD5(data.bytes, CC_LONG(data.length), &hash)

        return hash.map { String(format: "%02hhx", $0) }.joined()
    }
}
