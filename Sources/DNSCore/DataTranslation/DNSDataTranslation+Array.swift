//
//  DNSDataTranslation+Array.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public extension DNSDataTranslation {
    // MARK: - array...
    // swiftlint:disable:next cyclomatic_complexity
    func dictionary(from any: Any?) -> DNSDataArray {
        guard any != nil else { return DNSDataArray.empty }
        if any is Data {
            return self.array(from: any as? Data)
        } else if any is DNSDataArray {
            return self.array(from: any as? DNSDataArray)
        } else if any is DNSDataDictionary {
            return self.array(from: any as? DNSDataDictionary)
        } else if any is DNSString {
            return self.array(from: any as? DNSString)
        } else if any is DNSURL {
            return self.array(from: any as? DNSURL)
        } else if any is String {
            return self.array(from: any as? String)
        }
        return self.array(from: any as? Data)
    }
    func array(from data: Data?) -> DNSDataArray {
        guard let data else { return DNSDataArray.empty }
        guard !data.isEmpty else { return DNSDataArray.empty }
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data)
            if let array = jsonObject as? DNSDataArray {
                return array
            }
            if let dictionary = jsonObject as? DNSDataDictionary {
                return [dictionary]
            }
            return [["array": jsonObject]]
        } catch {
            return DNSDataArray.empty
        }
    }
    func array(from array: DNSDataArray?) -> DNSDataArray {
        guard let array else { return DNSDataArray.empty }
        return array
    }
    func array(from dictionary: DNSDataDictionary?) -> DNSDataArray {
        guard let dictionary else { return DNSDataArray.empty }
        return [dictionary]
    }
    func array(from dnsstring: DNSString?) -> DNSDataArray {
        guard let dnsstring else { return DNSDataArray.empty }
        return [dnsstring.asDictionary]
    }
    func array(from dnsurl: DNSURL?) -> DNSDataArray {
        guard let dnsurl else { return DNSDataArray.empty }
        return [dnsurl.asDictionary]
    }
    func array(from string: String?) -> DNSDataArray {
        guard let string else { return DNSDataArray.empty }
        guard !string.isEmpty else { return DNSDataArray.empty }
        let jsonData = Data.init(base64Encoded: string) ?? Data(string.utf8)
        return self.array(from: jsonData)
    }
}
