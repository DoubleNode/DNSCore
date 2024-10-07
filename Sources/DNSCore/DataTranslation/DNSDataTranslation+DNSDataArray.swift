//
//  DNSDataTranslation+DNSDataArray.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public extension DNSDataTranslation {
    // MARK: - array...
    func dataarray(from any: Any?) -> DNSDataArray {
        guard any != nil else { return .empty }
        if any is Data {
            return self.dataarray(from: any as? Data)
        } else if any is DNSDataArray {
            return self.dataarray(from: any as? DNSDataArray)
        } else if any is DNSDataDictionary {
            return self.dataarray(from: any as? DNSDataDictionary)
        } else if any is DNSString {
            return self.dataarray(from: any as? DNSString)
        } else if any is DNSURL {
            return self.dataarray(from: any as? DNSURL)
        } else if any is String {
            return self.dataarray(from: any as? String)
        }
        return self.dataarray(from: any as? DNSDataArray)
    }
    func dataarray(from data: Data?) -> DNSDataArray {
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
    func dataarray(from array: DNSDataArray?) -> DNSDataArray {
        guard let array else { return DNSDataArray.empty }
        return array
    }
    func dataarray(from dictionary: DNSDataDictionary?) -> DNSDataArray {
        guard let dictionary else { return DNSDataArray.empty }
        return [dictionary]
    }
    func dataarray(from dnsstring: DNSString?) -> DNSDataArray {
        guard let dnsstring else { return DNSDataArray.empty }
        return [dnsstring.asDictionary]
    }
    func dataarray(from dnsurl: DNSURL?) -> DNSDataArray {
        guard let dnsurl else { return DNSDataArray.empty }
        return [dnsurl.asDictionary]
    }
    func dataarray(from string: String?) -> DNSDataArray {
        guard let string else { return DNSDataArray.empty }
        guard !string.isEmpty else { return DNSDataArray.empty }
        let jsonData = Data.init(base64Encoded: string) ?? Data(string.utf8)
        return self.dataarray(from: jsonData)
    }
}
