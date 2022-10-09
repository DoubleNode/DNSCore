//
//  DNSDataTranslation+URL.swift
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
    // MARK: - url...
    func url<K>(from container: KeyedDecodingContainer<K>,
                forKey key: KeyedDecodingContainer<K>.Key) -> URL? where K: CodingKey {
        do { return url(from: try container.decodeIfPresent(URL.self, forKey: key)) } catch { }
        do { return url(from: try container.decodeIfPresent(Date.self, forKey: key)) } catch { }
        do { return url(from: try container.decodeIfPresent(Decimal.self, forKey: key)) } catch { }
        do { return url(from: try container.decodeIfPresent(Double.self, forKey: key)) } catch { }
        do { return url(from: try container.decodeIfPresent(Float.self, forKey: key)) } catch { }
        do { return url(from: try container.decodeIfPresent(UInt.self, forKey: key)) } catch { }
        do { return url(from: try container.decodeIfPresent(Int.self, forKey: key)) } catch { }
        do { return url(from: try container.decodeIfPresent(Bool.self, forKey: key)) } catch { }
        do { return url(from: try container.decodeIfPresent(String.self, forKey: key)) } catch { }
        return nil
    }
    // swiftlint:disable:next cyclomatic_complexity
    func url(from any: Any?) -> URL? {
        guard let any else { return nil }
#if !os(macOS)
        if any is UIColor {
            return self.url(from: any as? UIColor)
        }
#endif
        if any is Date {
            return self.url(from: any as? Date)
        } else if any is URL {
            return self.url(from: any as? URL)
        } else if any is NSNumber {
            return self.url(from: any as? NSNumber)
        } else if any is Decimal {
            return self.url(from: any as? Decimal)
        } else if any is Double {
            return self.url(from: any as? Double)
        } else if any is Float {
            return self.url(from: any as? Float)
        } else if any is UInt {
            return self.url(from: any as? UInt)
        } else if any is Int {
            return self.url(from: any as? Int)
        } else if any is Bool {
            return self.url(from: any as? Bool)
        }
        return self.url(from: any as? String)
    }
    func url(from string: String?) -> URL? {
        guard let string else { return nil }
        guard !string.isEmpty else { return nil }
        return URL.init(string: string)
    }
    func url(from url: URL?) -> URL? {
        guard let url else { return nil }
        return url
    }
}
