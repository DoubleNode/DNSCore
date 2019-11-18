//
//  DNSDataTranslation.swift
//  DNSCore
//
//  Created by Darren Ehlers on 8/14/19.
//  Copyright © 2019 DoubleNode.com. All rights reserved.
//

import Foundation

open class DNSDataTranslation: NSObject {
    let boolTrueCharacters = "YyTt1+"
    let firebaseDateDictionaryISOKey = "iso"
    let firebaseKeyInvalidCharacterSet = CharacterSet.init(charactersIn: "[].#$/")

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

    static var localTimeFormatter: DateFormatter {
        let retval = DateFormatter.init()
        retval.timeZone     = NSTimeZone.local
        retval.dateFormat   = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZ"
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

    // MARK: - Reentrancy Checks

    var boolEntryCount = 0
    var colorEntryCount = 0
    var dateEntryCount = 0
    var decimalEntryCount = 0
    var doubleEntryCount = 0
    var firebaseKeyEntryCount = 0
    var idEntryCount = 0
    var intEntryCount = 0
    var numberEntryCount = 0
    var stringEntryCount = 0
    var timeEntryCount = 0
    var uintEntryCount = 0
    var urlEntryCount = 0

    public override init() {

    }
}
