//
//  String+dnsMD5.swift
//  DNSCore
//
//  Created by Darren Ehlers on 10/7/19.
//  Copyright © 2019 DoubleNode.com. All rights reserved.
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
