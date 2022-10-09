//
//  DNSDataTranslation+Double.swift
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
    // MARK: - double...
    func double<K>(from container: KeyedDecodingContainer<K>,
                   forKey key: KeyedDecodingContainer<K>.Key) -> Double? where K: CodingKey {
        do { return double(from: try container.decodeIfPresent(Double.self, forKey: key)) } catch { }
        do { return double(from: try container.decodeIfPresent(Date.self, forKey: key)) } catch { }
        do { return double(from: try container.decodeIfPresent(URL.self, forKey: key)) } catch { }
        do { return double(from: try container.decodeIfPresent(Decimal.self, forKey: key)) } catch { }
        do { return double(from: try container.decodeIfPresent(Float.self, forKey: key)) } catch { }
        do { return double(from: try container.decodeIfPresent(UInt.self, forKey: key)) } catch { }
        do { return double(from: try container.decodeIfPresent(Bool.self, forKey: key)) } catch { }
        do { return double(from: try container.decodeIfPresent(String.self, forKey: key)) } catch { }
        return nil
    }
    // swiftlint:disable:next cyclomatic_complexity
    func double(from any: Any?) -> Double? {
        guard let any else { return nil }
#if !os(macOS)
        if any is UIColor {
            return self.double(from: any as? UIColor)
        }
#endif
        if any is Date {
            return self.double(from: any as? Date)
        } else if any is URL {
            return self.double(from: any as? URL)
        } else if any is NSNumber {
            return self.double(from: any as? NSNumber)
        } else if any is Decimal {
            return self.double(from: any as? Decimal)
        } else if any is Double {
            return self.double(from: any as? Double)
        } else if any is Float {
            return self.double(from: any as? Float)
        } else if any is UInt {
            return self.double(from: any as? UInt)
        } else if any is Int {
            return self.double(from: any as? Int)
        } else if any is Bool {
            return self.double(from: any as? Bool)
        }
        return self.double(from: any as? String, nil)
    }
    func double(from double: Double?) -> Double? {
        guard let double else { return 0 }
        return double
    }
    func double(from number: NSNumber?) -> Double? {
        guard let number else { return 0 }
        return number.doubleValue
    }
    func double(from string: String?, _ numberFormatter: NumberFormatter?) -> Double? {
        guard let string else { return 0 }
        guard !string.isEmpty else { return 0 }
        return self.number(from: string, numberFormatter)?.doubleValue
    }
}
