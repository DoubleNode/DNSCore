//
//  DatePrettyTests.m
//  DNSCoreTests
//
//  Created by Darren Ehlers on 10/23/16.
//  Copyright © 2019 - 2016 DoubleNode.com. All rights reserved.
//

import XCTest

@testable import DNSCore

class DatePrettyFullTests: XCTestCase {
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

    func test_dnsDate_withDefaultAndFormatFullSimple_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsDate(as: .fullSimple)
        XCTAssertEqual(result, "Wednesday, October 9, 2019")
    }
    func test_dnsDate_withDefaultAndFormatFullSmart_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsDate(as: .fullSmart)
        XCTAssertEqual(result, "Wednesday, October 9")
    }
    func test_dnsDate_withNowAndFormatFullPretty_shouldReturnString() {
        let result: String = sut.dnsDate(as: .fullPretty)
        XCTAssertEqual(result, NSLocalizedString("today", comment: ""))
    }

    func test_dnsTime_withDefaultAndFormatFullSimple_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsTime(as: .fullSimple)
        XCTAssertEqual(result, "Wednesday, October 9, 2019 at 1:20:41pm Central Daylight Time")
    }
    func test_dnsTime_withDefaultAndFormatFullSmart_shouldReturnString() {
        sut = defaultDate
        let result: String = sut.dnsTime(as: .fullSmart)
        XCTAssertEqual(result, "Wednesday, October 9, 1:20:41pm Central Daylight Time")
    }
    func test_dnsTime_withNowAndFormatFullPretty_shouldReturnString() {
        let result: String = sut.dnsTime(as: .fullPretty)
        XCTAssertEqual(result, NSLocalizedString("just now", comment: ""))
    }

    func test_dnsDate_withDefaultAndEndDateFormatFullSimple_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsDate(to: end, as: .fullSimple)
        XCTAssertEqual(result, "Wednesday, October 9, 2019 - Wednesday, September 3, 2031")
    }
    func test_dnsDate_withDefaultAndEndDateFormatFullSmart_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsDate(to: end, as: .fullSmart)
        XCTAssertEqual(result, "Wednesday, October 9, 2019 - Wednesday, September 3, 2031")
    }
    func test_dnsDate_withNowAndEndDateFormatFullPretty_shouldReturnString() {
        let end = defaultEndDate
        let result: String = sut.dnsDate(to: end, as: .fullPretty)
        XCTAssertEqual(result, "today to Wednesday, September 3, 2031")
    }

    func test_dnsTime_withDefaultAndEndDateFormatFullSimple_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsTime(to: end, as: .fullSimple)
        XCTAssertEqual(result, "Wednesday, October 9, 2019 at 1:20:41pm Central Daylight Time - " +
            "Wednesday, September 3, 2031 at 11:32:21am Central Daylight Time")
    }
    func test_dnsTime_withDefaultAndEndDateFormatFullSmart_shouldReturnString() {
        sut = defaultDate
        let end = defaultEndDate
        let result: String = sut.dnsTime(to: end, as: .fullSmart)
        XCTAssertEqual(result, "Wednesday, October 9, 2019, 1:20:41pm Central Daylight Time - " +
            "Wednesday, September 3, 2031, 11:32:21am Central Daylight Time")
    }
    func test_dnsTime_withNowAndEndDateFormatFullPretty_shouldReturnString() {
        let end = defaultEndDate
        let result: String = sut.dnsTime(to: end, as: .fullPretty)
        XCTAssertEqual(result, "just now to Wednesday, September 3, 2031")
    }
}
