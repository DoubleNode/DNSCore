//
//  DNSDataTranslation.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

public extension DNSDataTranslation {
    // MARK: - url...
    // swiftlint:disable:next cyclomatic_complexity
    func url(from any: Any?) -> URL? {
        guard urlEntryCount == 0 else {
            assertionFailure("DNSDataTranslation.url(from any) reentered!")
            return nil
        }
        urlEntryCount += 1
        defer { urlEntryCount -= 1 }
        guard any != nil else { return nil }

        if any as? Date != nil {
            return self.url(from: any as? Date)
        } else if any as? UIColor != nil {
            return self.url(from: any as? UIColor)
        } else if any as? URL != nil {
            return self.url(from: any as? URL)
        } else if any as? NSNumber != nil {
            return self.url(from: any as? NSNumber)
        } else if any as? Decimal != nil {
            return self.url(from: any as? Decimal)
        } else if any as? Double != nil {
            return self.url(from: any as? Double)
        } else if any as? UInt != nil {
            return self.url(from: any as? UInt)
        } else if any as? Int != nil {
            return self.url(from: any as? Int)
        } else if any as? Bool != nil {
            return self.url(from: any as? Bool)
        }

        return self.url(from: any as? String)
    }
    func url(from string: String?) -> URL? {
        guard string != nil else { return nil }

        return URL.init(string: string!)
    }
    func url(from url: URL?) -> URL? {
        guard url != nil else { return nil }

        return url
    }
}
