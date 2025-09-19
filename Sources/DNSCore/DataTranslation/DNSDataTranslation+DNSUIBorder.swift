//
//  DNSDataTranslation+DNSUIBorder.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

#if canImport(UIKit)
import DNSCoreThreading
#if canImport(UIKit)
import UIKit
#endif

public extension DNSDataTranslation {
    // MARK: - color...
    func dnsborder<K>(from container: KeyedDecodingContainer<K>,
                      forKey key: KeyedDecodingContainer<K>.Key) -> DNSUIBorder? where K: CodingKey {
        do { return dnsborder(from: try container.decodeIfPresent(DNSUIBorder.self, forKey: key)) } catch { }
        do { return dnsborder(from: try container.decodeIfPresent(String.self, forKey: key)) } catch { }
        return nil
    }
    func dnsborder(from any: Any?) -> DNSUIBorder? {
        guard let any else { return nil }
        if any is DNSUIBorder {
            return self.dnsborder(from: any as? DNSUIBorder)
        }
        return self.dnsborder(from: any as? DNSDataDictionary)
    }
    func dnsborder(from dnsborder: DNSUIBorder?) -> DNSUIBorder? {
        guard let dnsborder else { return nil }
        return dnsborder
    }
    func dnsborder(from dictionary: DNSDataDictionary?) -> DNSUIBorder? {
        guard let dictionary else { return nil }
        return DNSUIBorder.init(from: dictionary)
    }
    func dnsborder(from string: String?) -> DNSUIBorder? {
        guard let string else { return nil }
        return DNSUIBorder.init(with: string)
    }
}
#endif
