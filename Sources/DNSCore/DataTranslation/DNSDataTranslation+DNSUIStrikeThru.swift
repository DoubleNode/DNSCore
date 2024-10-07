//
//  DNSDataTranslation+DNSUIStrikeThru.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

#if !os(macOS)
import DNSCoreThreading
import UIKit

public extension DNSDataTranslation {
    // MARK: - color...
    func dnsstrikethru<K>(from container: KeyedDecodingContainer<K>,
                          forKey key: KeyedDecodingContainer<K>.Key) -> DNSUIStrikeThru? where K: CodingKey {
        do { return dnsstrikethru(from: try container.decodeIfPresent(DNSUIStrikeThru.self, forKey: key)) } catch { }
        do { return dnsstrikethru(from: try container.decodeIfPresent(String.self, forKey: key)) } catch { }
        return nil
    }
    func dnsstrikethru(from any: Any?) -> DNSUIStrikeThru? {
        guard let any else { return nil }
        if any is DNSUIStrikeThru {
            return self.dnsstrikethru(from: any as? DNSUIStrikeThru)
        }
        return self.dnsstrikethru(from: any as? DNSDataDictionary)
    }
    func dnsstrikethru(from dnsborder: DNSUIStrikeThru?) -> DNSUIStrikeThru? {
        guard let dnsborder else { return nil }
        return dnsborder
    }
    func dnsstrikethru(from dictionary: DNSDataDictionary?) -> DNSUIStrikeThru? {
        guard let dictionary else { return nil }
        return DNSUIStrikeThru.init(from: dictionary)
    }
    func dnsstrikethru(from string: String?) -> DNSUIStrikeThru? {
        guard let string else { return nil }
        return DNSUIStrikeThru.init(with: string)
    }
}
#endif
