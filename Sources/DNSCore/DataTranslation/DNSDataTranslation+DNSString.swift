//
//  DNSDataTranslation+DNSString.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import DNSCoreThreading
import Foundation
#if !os(macOS)
import UIKit
#endif

public extension DNSDataTranslation {
    // MARK: - dnsstring...
    func dnsstring<K>(from container: KeyedDecodingContainer<K>,
                      forKey key: KeyedDecodingContainer<K>.Key) -> DNSString? where K: CodingKey {
        do { return dnsstring(from: try container.decodeIfPresent(DNSString.self, forKey: key)) } catch { }
        do { return dnsstring(from: try container.decodeIfPresent([String: String].self, forKey: key)) } catch { }
        do { return dnsstring(from: try container.decodeIfPresent(String.self, forKey: key)) } catch { }
        return nil
    }
    func dnsstring(from any: Any?) -> DNSString? {
        guard let any = any else { return nil }
        if any is DNSString {
            return self.dnsstring(from: any as? DNSString)
        } else if any is [String: String] {
            return self.dnsstring(from: any as? [String: String])
        }
        return self.dnsstring(from: any as? String)
    }
    func dnsstring(from dictionary: [String: String]?) -> DNSString? {
        guard let dictionary else { return nil }
        return DNSString(from: dictionary)
    }
    func dnsstring(from dnsstring: DNSString?) -> DNSString? {
        guard let dnsstring else { return nil }
        return dnsstring
    }
    func dnsstring(from string: String?) -> DNSString? {
        guard let string else { return nil }
        return DNSString(with: string)
    }
}
