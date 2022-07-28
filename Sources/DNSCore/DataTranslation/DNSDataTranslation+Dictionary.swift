//
//  DNSDataTranslation+Dictionary.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public extension DNSDataTranslation {
    // MARK: - dictionary...
    // swiftlint:disable:next cyclomatic_complexity
    func dictionary(from any: Any?) -> DNSDataDictionary {
        guard any != nil else { return DNSDataDictionary.empty }
        if any is Data {
            return self.dictionary(from: any as? Data)
        } else if any is DNSDataArray {
            return self.dictionary(from: any as? DNSDataArray)
        } else if any is DNSDataDictionary {
            return self.dictionary(from: any as? DNSDataDictionary)
        } else if any is DNSString {
            return self.dictionary(from: any as? DNSString)
        } else if any is DNSURL {
            return self.dictionary(from: any as? DNSURL)
        } else if any is String {
            return self.dictionary(from: any as? String)
        }
        return self.dictionary(from: any as? Data)
    }
    func dictionary(from data: Data?) -> DNSDataDictionary {
        guard let data else { return DNSDataDictionary.empty }
        guard !data.isEmpty else { return DNSDataDictionary.empty }
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data)
            guard jsonObject is DNSDataDictionary else { return ["array": jsonObject] }
            return jsonObject as! DNSDataDictionary
        } catch {
            return DNSDataDictionary.empty
        }
    }
    func dictionary(from array: DNSDataArray?) -> DNSDataDictionary {
        guard let array else { return DNSDataDictionary.empty }
        return ["array": array]
    }
    func dictionary(from dictionary: DNSDataDictionary?) -> DNSDataDictionary {
        guard let dictionary else { return DNSDataDictionary.empty }
        return dictionary
    }
    func dictionary(from dnsstring: DNSString?) -> DNSDataDictionary {
        guard let dnsstring else { return DNSDataDictionary.empty }
        return dnsstring.asDictionary
    }
    func dictionary(from dnsurl: DNSURL?) -> DNSDataDictionary {
        guard let dnsurl else { return DNSDataDictionary.empty }
        return dnsurl.asDictionary
    }
    func dictionary(from string: String?) -> DNSDataDictionary {
        guard let string else { return DNSDataDictionary.empty }
        guard !string.isEmpty else { return DNSDataDictionary.empty }
        let jsonData = Data.init(base64Encoded: string) ?? Data(string.utf8)
        return self.dictionary(from: jsonData)
    }
}
