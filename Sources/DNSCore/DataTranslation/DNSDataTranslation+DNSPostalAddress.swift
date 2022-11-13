//
//  DNSDataTranslation+DNSPostalAddress.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import DNSCoreThreading
import Foundation

public extension DNSDataTranslation {
    // MARK: - string...
    func dnsPostalAddress<K>(from container: KeyedDecodingContainer<K>,
                             forKey key: KeyedDecodingContainer<K>.Key) -> DNSPostalAddress? where K: CodingKey {
        do { return dnsPostalAddress(from: try container.decodeIfPresent(DNSPostalAddress.self, forKey: key)) } catch { }
        do { return dnsPostalAddress(from: try container.decodeIfPresent([String: String].self, forKey: key)) } catch { }
        do { return dnsPostalAddress(from: try container.decodeIfPresent(String.self, forKey: key)) } catch { }
        return nil
    }
    // swiftlint:disable:next cyclomatic_complexity
    func dnsPostalAddress(from any: Any?) -> DNSPostalAddress? {
        guard let any else { return nil }
        if any is DNSPostalAddress {
            return self.dnsPostalAddress(from: any as? DNSPostalAddress)
        } else if any is [String: String] {
            return self.dnsPostalAddress(from: any as? [String: String])
        }
        return self.dnsPostalAddress(from: any as? String)
    }
    func dnsPostalAddress(from data: [String: String]?) -> DNSPostalAddress? {
        guard let data else { return nil }
        return DNSPostalAddress(from: data)
    }
    func dnsPostalAddress(from string: String?) -> DNSPostalAddress? {
        guard let string else { return nil }
        return DNSPostalAddress(string)
    }
    func dnsPostalAddress(from postalAddress: DNSPostalAddress?) -> DNSPostalAddress? {
        guard let postalAddress else { return nil }
        return postalAddress
    }
}
