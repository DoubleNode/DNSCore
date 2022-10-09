//
//  DNSDataTranslation+UIColor.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

#if !os(macOS)
import DNSCoreThreading
import UIKit

public extension DNSDataTranslation {
    // MARK: - dnsuicolor...
    func dnscolor<K>(from container: KeyedDecodingContainer<K>,
                     forKey key: KeyedDecodingContainer<K>.Key) -> DNSUIColor? where K: CodingKey {
        do { return dnscolor(from: try container.decodeIfPresent(DNSUIColor.self, forKey: key)) } catch { }
        do { return dnscolor(from: try container.decodeIfPresent(String.self, forKey: key)) } catch { }
        return nil
    }
    // swiftlint:disable:next cyclomatic_complexity
    func dnscolor(from any: Any?) -> DNSUIColor? {
        guard let any else { return nil }
        if any is DNSUIColor {
            return self.dnscolor(from: any as? DNSUIColor)
        } else if any is String {
            return self.dnscolor(from: any as? String)
        }
        return self.dnscolor(from: any as? DNSDataDictionary)
    }
    func dnscolor(from dnscolor: DNSUIColor?) -> DNSUIColor? {
        guard let dnscolor else { return nil }
        return dnscolor
    }
    func dnscolor(from dictionary: DNSDataDictionary?) -> DNSUIColor? {
        guard let dictionary else { return nil }
        return DNSUIColor.init(from: dictionary)
    }
    func dnscolor(from string: String?) -> DNSUIColor? {
        guard let string else { return nil }
        return DNSUIColor(with: string)
    }
}
#endif
