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
    func array<K>(from container: KeyedDecodingContainer<K>,
                  forKey key: KeyedDecodingContainer<K>.Key) -> [Any] where K: CodingKey {
        do { return array(from: try container.decodeIfPresent(Data.self, forKey: key)) } catch { }
        do { return array(from: try container.decodeIfPresent(DNSString.self, forKey: key)) } catch { }
        do { return array(from: try container.decodeIfPresent(DNSURL.self, forKey: key)) } catch { }
        do { return array(from: try container.decodeIfPresent(String.self, forKey: key)) } catch { }
        return []
    }
    func array(from any: Any?) -> [Any] {
        guard any != nil else { return [] }
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
        return self.array(from: any as? [Any])
    }
    func array(from array: [Any]?) -> [Any] {
        guard let array else { return [] }
        return array
    }
    func array(from data: Data?) -> [Any] {
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
            return []
        }
    }
    func array(from array: DNSDataArray?) -> [Any] {
        guard let array else { return [] }
        return array
    }
    func array(from dictionary: DNSDataDictionary?) -> [Any] {
        guard let dictionary else { return [] }
        return [dictionary]
    }
    func array(from dnsstring: DNSString?) -> [Any] {
        guard let dnsstring else { return [] }
        return [dnsstring.asDictionary]
    }
    func array(from dnsurl: DNSURL?) -> [Any] {
        guard let dnsurl else { return [] }
        return [dnsurl.asDictionary]
    }
    func array(from string: String?) -> [Any] {
        guard let string else { return [] }
        guard !string.isEmpty else { return [] }
        let jsonData = Data.init(base64Encoded: string) ?? Data(string.utf8)
        return self.array(from: jsonData)
    }
}
