//
//  DNSDataTranslation+DNSURL.swift
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
    func dnsurl<K>(from container: KeyedDecodingContainer<K>,
                   forKey key: KeyedDecodingContainer<K>.Key) -> DNSURL? where K: CodingKey {
        do { return dnsurl(from: try container.decodeIfPresent(DNSURL.self, forKey: key)) } catch { }
        do { return dnsurl(from: try container.decodeIfPresent(URL.self, forKey: key)) } catch { }
        do { return dnsurl(from: try container.decodeIfPresent(String.self, forKey: key)) } catch { }
        do { return dnsurl(from: try container.decodeIfPresent([String: URL?].self, forKey: key)) } catch { }
        do { return dnsurl(from: try container.decodeIfPresent([String: String].self, forKey: key)) } catch { }
        return nil
    }
    // swiftlint:disable:next cyclomatic_complexity
    func dnsurl(from any: Any?) -> DNSURL? {
        guard let any = any else { return nil }
        if any is [DNSURL.Language: URL?] {
            return self.dnsurl(from: any as? [DNSURL.Language: URL?])
        } else if any is [String: URL?] {
            return self.dnsurl(from: any as? [String: URL?])
        } else if any is [DNSURL.Language: String] {
            return self.dnsurl(from: any as? [DNSURL.Language: String])
        } else if any is [String: String] {
            return self.dnsurl(from: any as? [String: String])
        } else if any is String {
            return self.dnsurl(from: any as? String)
        }
        return self.dnsurl(from: any as? URL)
    }
    func dnsurl(from dictionary: [DNSURL.Language: URL?]?) -> DNSURL? {
        guard let dictionary else { return nil }
        return DNSURL(from: dictionary)
    }
    func dnsurl(from dictionary: [String: URL?]?) -> DNSURL? {
        guard let dictionary else { return nil }
        return DNSURL(from: dictionary)
    }
    func dnsurl(from dictionary: [DNSURL.Language: String]?) -> DNSURL? {
        guard let dictionary else { return nil }
        return DNSURL(from: dictionary)
    }
    func dnsurl(from dictionary: [String: String]?) -> DNSURL? {
        guard let dictionary else { return nil }
        return DNSURL(from: dictionary)
    }
    func dnsurl(from url: URL?) -> DNSURL? {
        guard let url else { return nil }
        return DNSURL(with: url)
    }
    func dnsurl(from string: String?) -> DNSURL? {
        guard let string else { return nil }
        return dnsurl(from: URL(string: string))
    }
}
