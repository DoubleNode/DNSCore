//
//  DNSDataTranslation+Float.swift
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
    // MARK: - float...
    func float<K>(from container: KeyedDecodingContainer<K>,
                  forKey key: KeyedDecodingContainer<K>.Key) -> Float? where K: CodingKey {
        do { return float(from: try container.decodeIfPresent(Float.self, forKey: key)) } catch { }
        do { return float(from: try container.decodeIfPresent(Date.self, forKey: key)) } catch { }
        do { return float(from: try container.decodeIfPresent(URL.self, forKey: key)) } catch { }
        do { return float(from: try container.decodeIfPresent(Decimal.self, forKey: key)) } catch { }
        do { return float(from: try container.decodeIfPresent(Double.self, forKey: key)) } catch { }
        do { return float(from: try container.decodeIfPresent(UInt.self, forKey: key)) } catch { }
        do { return float(from: try container.decodeIfPresent(Bool.self, forKey: key)) } catch { }
        do { return float(from: try container.decodeIfPresent(String.self, forKey: key)) } catch { }
        return nil
    }
    // swiftlint:disable:next cyclomatic_complexity
    func float(from any: Any?) -> Float? {
        guard let any else { return nil }
#if !os(macOS)
        if any is UIColor {
            return self.float(from: any as? UIColor)
        }
#endif
        if any is Date {
            return self.float(from: any as? Date)
        } else if any is URL {
            return self.float(from: any as? URL)
        } else if any is NSNumber {
            return self.float(from: any as? NSNumber)
        } else if any is Decimal {
            return self.float(from: any as? Decimal)
        } else if any is Double {
            return self.float(from: any as? Double)
        } else if any is Float {
            return self.float(from: any as? Float)
        } else if any is UInt {
            return self.float(from: any as? UInt)
        } else if any is Int {
            return self.float(from: any as? Int)
        } else if any is Bool {
            return self.float(from: any as? Bool)
        }
        return self.float(from: any as? String, nil)
    }
    func float(from float: Float?) -> Float? {
        guard let float else { return 0 }
        return float
    }
    func float(from number: NSNumber?) -> Float? {
        guard let number else { return 0 }
        return number.floatValue
    }
    func float(from string: String?, _ numberFormatter: NumberFormatter?) -> Float? {
        guard let string else { return 0 }
        guard !string.isEmpty else { return 0 }
        return self.number(from: string, numberFormatter)?.floatValue
    }
}
