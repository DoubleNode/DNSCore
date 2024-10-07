//
//  DNSDataTranslation+UIShadow.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

#if !os(macOS)
import DNSCoreThreading
import UIKit

public extension DNSDataTranslation {
    // MARK: - dnsuishadow...
    func dnsshadow<K>(from container: KeyedDecodingContainer<K>,
                      forKey key: KeyedDecodingContainer<K>.Key) -> DNSUIShadow? where K: CodingKey {
        do { return dnsshadow(from: try container.decodeIfPresent(DNSUIShadow.self, forKey: key)) } catch { }
        do { return dnsshadow(from: try container.decodeIfPresent(String.self, forKey: key)) } catch { }
        return nil
    }
    func dnsshadow(from any: Any?) -> DNSUIShadow? {
        guard let any else { return nil }
        if any is DNSUIShadow {
            return self.dnsshadow(from: any as? DNSUIShadow)
        } else if any is String {
            return self.dnsshadow(from: any as? String)
        }
        return self.dnsshadow(from: any as? DNSDataDictionary)
    }
    func dnsshadow(from dnsshadow: DNSUIShadow?) -> DNSUIShadow? {
        guard let dnsshadow else { return nil }
        return dnsshadow
    }
    func dnsshadow(from dictionary: DNSDataDictionary?) -> DNSUIShadow? {
        guard let dictionary else { return nil }
        return DNSUIShadow.init(from: dictionary)
    }
    func dnsshadow(from string: String?) -> DNSUIShadow? {
        guard let string else { return nil }
        return DNSUIShadow(with: string)
    }
}
#endif
