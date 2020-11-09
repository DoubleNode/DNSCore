//
//  DatePrettyNormalTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCoreTests
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import XCTest

@testable import DNSCore

class DatePrettyNormalTests: XCTestCase {
    static let defaultDateTimeIntervalSince1970: TimeInterval = 1602267641      // 2020-10-09T18:20:41+00:00
    static let defaultDateYear: String = "2020"
    static let defaultEndDateTimeIntervalSince1970: TimeInterval = 1946219541   // 2031-09-03T16:32:21+00:00
    
    let defaultDate = Date(timeIntervalSince1970: defaultDateTimeIntervalSince1970)
    let defaultDateYear = DatePrettyNormalTests.defaultDateYear
    let defaultEndDate = Date(timeIntervalSince1970: defaultEndDateTimeIntervalSince1970)

    private var sut: Date!

    override func setUp() {
        super.setUp()
        NSTimeZone.default = TimeZone(abbreviation: "CDT")!
        sut = Date()
    }
    override func tearDown() {
        sut = nil
        NSTimeZone.resetSystemTimeZone()
        super.tearDown()
    }

    func test_dnsDate_withDefaultAndFormatNormalSimple_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsDate(as: .normalSimple)
        XCTAssertEqual(result, "Oct 9, \(defaultDateYear)")
    }
    func test_dnsDate_withDefaultAndFormatNormalSmart_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsDate(as: .normalSmart)
        XCTAssertEqual(result, "Oct 9")
    }
    func test_dnsDate_withNowAndFormatNormalPretty_shouldReturnString() {
        let result: String = sut.dnsDate(as: .normalPretty)
        XCTAssertEqual(result, C.Localizations.DatePretty.today)
    }

    func test_dnsTime_withDefaultAndFormatNormalSimple_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsTime(as: .normalSimple)
        XCTAssertEqual(result, "Oct 9, \(defaultDateYear) at 1:20:41pm")
    }
    func test_dnsTime_withDefaultAndFormatNormalSmart_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsTime(as: .normalSmart)
        XCTAssertEqual(result, "Oct 9 @ 1:20pm")
    }
    func test_dnsTime_withNowAndFormatNormalPretty_shouldReturnString() {
        let result: String = sut.dnsTime(as: .normalPretty)
        XCTAssertEqual(result, C.Localizations.DatePretty.justNow)
    }

    func test_dnsDate_withDefaultAndEndDateFormatNormalSimple_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsDate(to: end, as: .normalSimple)
        XCTAssertEqual(result, "Oct 9, \(defaultDateYear) - Sep 3, 2031")
    }
    func test_dnsDate_withDefaultAndEndDateFormatNormalSmart_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsDate(to: end, as: .normalSmart)
        XCTAssertEqual(result, "Oct 9, \(defaultDateYear) - Sep 3, 2031")
    }
    func test_dnsDate_withNowAndEndDateFormatNormalPretty_shouldReturnString() {
        let end = defaultEndDate
        let result: String = sut.dnsDate(to: end, as: .normalPretty)
        XCTAssertEqual(result, "\(C.Localizations.DatePretty.today) - 9/3/31")
    }

    func test_dnsTime_withDefaultAndEndDateFormatNormalSimple_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsTime(to: end, as: .normalSimple)
        XCTAssertEqual(result, "Oct 9, \(defaultDateYear) at 1:20:41pm - Sep 3, 2031 at 11:32:21am")
    }
    func test_dnsTime_withDefaultAndEndDateFormatNormalSmart_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsTime(to: end, as: .normalSmart)
        XCTAssertEqual(result, "Oct 9, \(defaultDateYear) @ 1:20pm - Sep 3, 2031 @ 11:32am")
    }
    func test_dnsTime_withNowAndEndDateFormatNormalPretty_shouldReturnString() {
        let end = defaultEndDate
        let result: String = sut.dnsTime(to: end, as: .normalPretty)
        XCTAssertEqual(result, "\(C.Localizations.DatePretty.justNow) - 9/3/31")
    }
}
