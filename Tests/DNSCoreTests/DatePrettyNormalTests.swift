//
//  DatePrettyTests.m
//  DNSCoreTests
//
//  Created by Darren Ehlers on 10/23/16.
//  Copyright © 2019 - 2016 DoubleNode.com. All rights reserved.
//

import XCTest

@testable import DNSCore

class DatePrettyNormalTests: XCTestCase {
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

    func test_dnsDate_withDefaultAndFormatNormalSimple_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsDate(as: .normalSimple)
        XCTAssertEqual(result, "Oct 9, 2019")
    }
    func test_dnsDate_withDefaultAndFormatNormalSmart_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsDate(as: .normalSmart)
        XCTAssertEqual(result, "Oct 9")
    }
    func test_dnsDate_withNowAndFormatNormalPretty_shouldReturnString() {
        let result: String = sut.dnsDate(as: .normalPretty)
        XCTAssertEqual(result, NSLocalizedString("today", comment: ""))
    }

    func test_dnsTime_withDefaultAndFormatNormalSimple_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsTime(as: .normalSimple)
        XCTAssertEqual(result, "Oct 9, 2019 at 1:20:41pm")
    }
    func test_dnsTime_withDefaultAndFormatNormalSmart_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsTime(as: .normalSmart)
        XCTAssertEqual(result, "Oct 9, 1:20:41pm")
    }
    func test_dnsTime_withNowAndFormatNormalPretty_shouldReturnString() {
        let result: String = sut.dnsTime(as: .normalPretty)
        XCTAssertEqual(result, NSLocalizedString("just now", comment: ""))
    }

    func test_dnsDate_withDefaultAndEndDateFormatNormalSimple_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsDate(to: end, as: .normalSimple)
        XCTAssertEqual(result, "Oct 9, 2019 - Sep 3, 2031")
    }
    func test_dnsDate_withDefaultAndEndDateFormatNormalSmart_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsDate(to: end, as: .normalSmart)
        XCTAssertEqual(result, "Oct 9, 2019 - Sep 3, 2031")
    }
    func test_dnsDate_withNowAndEndDateFormatNormalPretty_shouldReturnString() {
        let end = defaultEndDate
        let result: String = sut.dnsDate(to: end, as: .normalPretty)
        XCTAssertEqual(result, "today - 9/3/31")
    }

    func test_dnsTime_withDefaultAndEndDateFormatNormalSimple_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsTime(to: end, as: .normalSimple)
        XCTAssertEqual(result, "Oct 9, 2019 at 1:20:41pm - Sep 3, 2031 at 11:32:21am")
    }
    func test_dnsTime_withDefaultAndEndDateFormatNormalSmart_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsTime(to: end, as: .normalSmart)
        XCTAssertEqual(result, "Oct 9, 2019, 1:20:41pm - Sep 3, 2031, 11:32:21am")
    }
    func test_dnsTime_withNowAndEndDateFormatNormalPretty_shouldReturnString() {
        let end = defaultEndDate
        let result: String = sut.dnsTime(to: end, as: .normalPretty)
        XCTAssertEqual(result, "just now - 9/3/31")
    }
}
