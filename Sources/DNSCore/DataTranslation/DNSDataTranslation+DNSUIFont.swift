//
//  DNSDataTranslation+UIFont.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

#if !os(macOS)
import DNSCoreThreading
import UIKit

public extension DNSDataTranslation {
    // MARK: - dnsuifont...
    func dnsfont<K>(from container: KeyedDecodingContainer<K>,
                    forKey key: KeyedDecodingContainer<K>.Key) -> DNSUIFont? where K: CodingKey {
        do { return dnsfont(from: try container.decodeIfPresent(DNSUIFont.self, forKey: key)) } catch { }
        do { return dnsfont(from: try container.decodeIfPresent(String.self, forKey: key)) } catch { }
        return nil
    }
    func dnsfont(from any: Any?) -> DNSUIFont? {
        guard let any else { return nil }
        if any is DNSUIFont {
            return self.dnsfont(from: any as? DNSUIFont)
        } else if any is String {
            return self.dnsfont(from: any as? String)
        }
        return self.dnsfont(from: any as? DNSDataDictionary)
    }
    func dnsfont(from dnsfont: DNSUIFont?) -> DNSUIFont? {
        guard let dnsfont else { return nil }
        return dnsfont
    }
    func dnsfont(from dictionary: DNSDataDictionary?) -> DNSUIFont? {
        guard let dictionary else { return nil }
        return DNSUIFont.init(from: dictionary)
    }
    func dnsfont(from string: String?) -> DNSUIFont? {
        guard let string else { return nil }
        return DNSUIFont(with: string)
    }
}
#endif
