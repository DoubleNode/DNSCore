//
//  DNSDataTranslation+DNSPhone.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import DNSCoreThreading
import Foundation

public extension DNSDataTranslation {
    // MARK: - string...
    func dnsPhone<K>(from container: KeyedDecodingContainer<K>,
                     forKey key: KeyedDecodingContainer<K>.Key) -> DNSPhone? where K: CodingKey {
        do { return dnsPhone(from: try container.decodeIfPresent(DNSPhone.self, forKey: key)) } catch { }
        do { return dnsPhone(from: try container.decodeIfPresent(String.self, forKey: key)) } catch { }
        return nil
    }
    func dnsPhone(from any: Any?) -> DNSPhone? {
        guard let any else { return nil }
        if any is DNSPhone {
            return self.dnsPhone(from: any as? DNSPhone)
        }
        return self.dnsPhone(from: any as? String)
    }
    func dnsPhone(from string: String?) -> DNSPhone? {
        guard let string else { return nil }
        return DNSPhone(string)
    }
    func dnsPhone(from postalAddress: DNSPhone?) -> DNSPhone? {
        guard let postalAddress else { return nil }
        return postalAddress
    }
}
