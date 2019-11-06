//
//  DatePrettyTests.m
//  DNSCoreTests
//
//  Created by Darren Ehlers on 10/23/16.
//  Copyright © 2019 - 2016 DoubleNode.com. All rights reserved.
//

import XCTest

@testable import DNSCore

class DatePrettyLongTests: XCTestCase {
    static let defaultDateTimeIntervalSince1970: TimeInterval = 1570645241      // 2019-10-09T18:20:41+00:00
    static let defaultEndDateTimeIntervalSince1970: TimeInterval = 1946219541   // 2031-09-03T16:32:21+00:00

    let defaultDate = Date(timeIntervalSince1970: defaultDateTimeIntervalSince1970)
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

    func test_dnsDate_withDefaultAndFormatLongSimple_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsDate(as: .longSimple)
        XCTAssertEqual(result, "October 9, 2019")
    }
    func test_dnsDate_withDefaultAndFormatLongSmart_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsDate(as: .longSmart)
        XCTAssertEqual(result, "October 9")
    }
    func test_dnsDate_withNowAndFormatLongPretty_shouldReturnString() {
        let result: String = sut.dnsDate(as: .longPretty)
        XCTAssertEqual(result, NSLocalizedString("today", comment: ""))
    }

    func test_dnsTime_withDefaultAndFormatLongSimple_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsTime(as: .longSimple)
        XCTAssertEqual(result, "October 9, 2019 at 1:20:41pm CDT")
    }
    func test_dnsTime_withDefaultAndFormatLongSmart_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsTime(as: .longSmart)
        XCTAssertEqual(result, "October 9, 1:20:41pm CDT")
    }
    func test_dnsTime_withNowAndFormatLongPretty_shouldReturnString() {
        let result: String = sut.dnsTime(as: .longPretty)
        XCTAssertEqual(result, NSLocalizedString("just now", comment: ""))
    }

    func test_dnsDate_withDefaultAndEndDateFormatLongSimple_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsDate(to: end, as: .longSimple)
        XCTAssertEqual(result, "October 9, 2019 - September 3, 2031")
    }
    func test_dnsDate_withDefaultAndEndDateFormatLongSmart_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsDate(to: end, as: .longSmart)
        XCTAssertEqual(result, "October 9, 2019 - September 3, 2031")
    }
    func test_dnsDate_withNowAndEndDateFormatLongPretty_shouldReturnString() {
        let end = defaultEndDate
        let result: String = sut.dnsDate(to: end, as: .longPretty)
        XCTAssertEqual(result, "today to September 3, 2031")
    }

    func test_dnsTime_withDefaultAndEndDateFormatLongSimple_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsTime(to: end, as: .longSimple)
        XCTAssertEqual(result, "October 9, 2019 at 1:20:41pm CDT - September 3, 2031 at 11:32:21am CDT")
    }
    func test_dnsTime_withDefaultAndEndDateFormatLongSmart_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsTime(to: end, as: .longSmart)
        XCTAssertEqual(result, "October 9, 2019, 1:20:41pm CDT - September 3, 2031, 11:32:21am CDT")
    }
    func test_dnsTime_withNowAndEndDateFormatLongPretty_shouldReturnString() {
        let end = defaultEndDate
        let result: String = sut.dnsTime(to: end, as: .longPretty)
        XCTAssertEqual(result, "just now to September 3, 2031")
    }
}
