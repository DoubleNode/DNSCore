//
//  DNSDataTranslation.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import DNSCoreThreading
import UIKit

public extension DNSDataTranslation {
    // MARK: - url...
    // swiftlint:disable:next cyclomatic_complexity
    func url(from any: Any?) -> URL? {
        guard any != nil else { return nil }
        let currentThread = Thread.current
        guard !(urlEntryCounts[Thread.current] ?? false) else {
            let dnsError = DNSDataTranslationError.reentered(domain: "com.doublenode.\(type(of: self))",
                                                             file: DNSCore.shortenErrorPath("\(#file)"),
                                                             line: "\(#line)",
                                                             method: "\(#function)")
            DNSCore.reportError(dnsError.nsError)
            assertionFailure(dnsError.errorDescription!)
            return nil
        }
#if DEBUG
        dnsLog.debug("urlEntryCounts.start = \(currentThread)")
#endif
        urlEntryCounts[Thread.current] = true
        defer {
            urlEntryCounts.removeValue(forKey: currentThread)
#if DEBUG
            dnsLog.debug("urlEntryCounts.end = \(currentThread)")
#endif
        }

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
        } else if any as? Float != nil {
            return self.url(from: any as? Float)
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
