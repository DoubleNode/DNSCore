//
//  DNSDataTranslation.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import AtomicSwift
import Foundation
import os.lock

open class DNSDataTranslation: NSObject, @unchecked Sendable {
    let boolTrueCharacters = "YyTt1+"
    let firebaseDateDictionaryISOKey = "iso"
    let firebaseKeyInvalidCharacterSet = CharacterSet.init(charactersIn: "[].#$/")
    let firebaseTimestampDictionarySecondsKey = "_seconds"

    // MARK: - Static Formatters
    static var defaultNumberFormatter: NumberFormatter {
        let retval = NumberFormatter.init()
        retval.numberStyle  = NumberFormatter.Style.decimal
        return retval
    }
    static var defaultCurrencyFormatter: NumberFormatter {
        let retval = NumberFormatter.init()
        retval.numberStyle  = NumberFormatter.Style.currency
        return retval
    }
    static var defaultDateFormatter1: DateFormatter {
        let retval = DateFormatter.init()
        retval.timeZone     = NSTimeZone.local
        retval.dateFormat   = "yyyy-MM-dd"
        return retval
    }
    static var defaultDateFormatter2: DateFormatter {
        let retval = DateFormatter.init()
        retval.timeZone     = NSTimeZone.local
        retval.dateFormat   = "MM/dd/yyyy"
        return retval
    }
    static var defaultDateFormatter3: DateFormatter {
        let retval = DateFormatter.init()
        retval.timeZone     = NSTimeZone.local
        retval.dateFormat   = "yyyyMMdd"
        return retval
    }
    static var defaultDateFormatter4: DateFormatter {
        let retval = DateFormatter.init()
        retval.timeZone     = NSTimeZone.local
        retval.dateFormat   = "MM-dd"
        return retval
    }
    static var defaultDateFormatter5: DateFormatter {
        let retval = DateFormatter.init()
        retval.timeZone     = NSTimeZone.local
        retval.dateFormat   = "MM/dd"
        return retval
    }
    static var defaultTimeFormatter1: DateFormatter {
        let retval = DateFormatter.init()
        retval.timeZone     = TimeZone(secondsFromGMT: 0)
        retval.dateFormat   = "yyyyMMddHHmm"
        return retval
    }
    static var firebaseDateFormatter: DateFormatter {
        let retval = DateFormatter.init()
        retval.timeZone     = NSTimeZone.local
        retval.dateFormat   = "yyyy'-'MM'-'dd'"
        return retval
    }
    static var firebaseTimeFormatter: DateFormatter {
        let retval = DateFormatter.init()
        retval.timeZone     = NSTimeZone.local
        retval.dateFormat   = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZ"
        return retval
    }
    static var firebaseTimeFormatterMilliseconds: DateFormatter {
        let retval = DateFormatter.init()
        retval.timeZone     = NSTimeZone.local
        retval.dateFormat   = "yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSSZ"
        return retval
    }
    static var firebaseTimeFormatterMilliseconds2: DateFormatter {
        let retval = DateFormatter.init()
        retval.timeZone     = NSTimeZone.local
        retval.dateFormat   = "yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSZ"
        return retval
    }
    static var localTimeFormatter: DateFormatter {
        let retval = DateFormatter.init()
        retval.timeZone     = NSTimeZone.local
        retval.dateFormat   = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZ"
        return retval
    }
    static var localTimeAltFormatter: DateFormatter {
        let retval = DateFormatter.init()
        retval.timeZone     = NSTimeZone.local
        retval.dateFormat   = "MM/dd/yyyy HH:mma z"
        return retval
    }
    static var localTimeFormatterWithoutTimezone: DateFormatter {
        let retval = DateFormatter.init()
        retval.timeZone     = NSTimeZone.local
        retval.dateFormat   = "yyyy'-'MM'-'dd'T'HH':'mm':'ss"
        return retval
    }
    static var localTimeFormatterMilliseconds: DateFormatter {
        let retval = DateFormatter.init()
        retval.timeZone     = NSTimeZone.local
        retval.dateFormat   = "yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSSZ"
        return retval
    }
    static var localTimeFormatterMillisecondsWithoutTimezone: DateFormatter {
        let retval = DateFormatter.init()
        retval.timeZone     = NSTimeZone.local
        retval.dateFormat   = "yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSS"
        return retval
    }
    static var localTimeFormatterMilliseconds2WithoutTimezone: DateFormatter {
        let retval = DateFormatter.init()
        retval.timeZone     = NSTimeZone.local
        retval.dateFormat   = "yyyy'-'MM'-'dd'T'HH':'mm':'ss.SS"
        return retval
    }

    static let defaultDateFormatters = [
        defaultDateFormatter1,
        defaultDateFormatter2,
        defaultDateFormatter3,
        firebaseDateFormatter,
        defaultDateFormatter4,
        defaultDateFormatter5,
        // defaultTimeFormatters
        firebaseTimeFormatterMilliseconds,
        firebaseTimeFormatterMilliseconds2,
        firebaseTimeFormatter,
        defaultTimeFormatter1,
        localTimeFormatter,
        localTimeAltFormatter,
        localTimeFormatterWithoutTimezone,
        localTimeFormatterMillisecondsWithoutTimezone,
        localTimeFormatterMilliseconds2WithoutTimezone,
    ]
    static let defaultTimeFormatters = [
        firebaseTimeFormatterMilliseconds,
        firebaseTimeFormatterMilliseconds2,
        firebaseTimeFormatter,
        defaultTimeFormatter1,
        defaultDateFormatter1,
        defaultDateFormatter2,
        localTimeFormatter,
        localTimeAltFormatter,
        localTimeFormatterWithoutTimezone,
        localTimeFormatterMillisecondsWithoutTimezone,
        localTimeFormatterMilliseconds2WithoutTimezone,
        defaultDateFormatter3,
        firebaseDateFormatter,
        defaultDateFormatter4,
        defaultDateFormatter5,
    ]

    private let tokenLock = OSAllocatedUnfairLock(initialState: [String: String]())

    public override init() { }

    public func localized(_ object: Any??) -> Any {
        guard let dictionary = object as? [String: Any] else {
            return object as Any
        }
        return (dictionary[DNSCore.languageCode] ?? dictionary["en"]) ?? object as Any
    }

    public func addTokenReplacement(token: String,
                                    replacement: String) {
        tokenLock.withLock { tokens in
            tokens[token] = replacement
        }
    }

    public func clearTokenReplacements() {
        tokenLock.withLock { tokens in
            tokens.removeAll()
        }
    }

    public func removeTokenReplacement(token: String) {
        _ = tokenLock.withLock { tokens in
            tokens.removeValue(forKey: token)
        }
    }

    public func replaceTokens(in string: String) -> String {
        return tokenLock.withLock { tokens in
            var string = string
            tokens.keys.forEach {
                string = string.replacingOccurrences(of: "%\($0)%",
                                                     with: tokens[$0] ?? "")
            }
            return string
        }
    }
}
