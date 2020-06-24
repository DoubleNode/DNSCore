//
//  DNSAppConstantsTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCoreTests
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import XCTest

@testable import DNSCore

class DNSAppConstantsTests: XCTestCase {
    private var sut: DNSAppConstants!

    override func setUp() {
        super.setUp()
        sut = DNSAppConstants.shared
        sut.merge(constants: [
            "TestValue12345"        : 1.2345,
            "TestValueNeg35269"     : -35269,
            "TestValue57321"        : 57321,
            "TestValueColorString"  : "systemIndigo",
            "TestValueDate"         : "2019-01-01",
            "TestValueString"       : "This is a test string!",
            "TestValueTrue"         : true,
            "TestValueURL"          : "https:8080//www.google.com/search?q=test",
            "TestValueKey"          : "One",
            "TestValueDictionary"   : [
                "TestSubValueOne": [
                    "TestSubSubValueOne": "Test String"
                ],
            ],
        ])
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: - constantBool tests
    func test_constantBool_withTestValueNotThereAndNoFilter_shouldThrow() {
        XCTAssertThrowsError(try DNSAppConstants.constant(from: "TestValueNotThere") as Bool) { error in
            // swiftlint:disable:next force_cast
            XCTAssertEqual(error as! DNSCoreError, DNSCoreError.constantNotFound(key: "TestValueNotThere", filter: ""))
        }
    }
    func test_constantBool_withTestValueTrueAndNoFilter_shouldReturnBoolTrue() {
        var result: Bool = false
        XCTAssertNoThrow(result = try DNSAppConstants.constant(from: "TestValueTrue"))

        XCTAssertEqual(result, true)
    }

    // MARK: - constantCGFloat tests
    func test_constantCGFloat_withTestValueNotThereAndNoFilter_shouldThrow() {
        XCTAssertThrowsError(try DNSAppConstants.constant(from: "TestValueNotThere") as CGFloat) { error in
            // swiftlint:disable:next force_cast
            XCTAssertEqual(error as! DNSCoreError, DNSCoreError.constantNotFound(key: "TestValueNotThere", filter: ""))
        }
    }
    func test_constantCGFloat_withTestValueFloatAndNoFilter_shouldReturnCGFloat1_2345() {
        var result: CGFloat = 0.0
        XCTAssertNoThrow(result = try DNSAppConstants.constant(from: "TestValue12345"))

        XCTAssertEqual(result, CGFloat(1.2345))
    }

    // MARK: - constantDate tests
    func test_constantDate_withTestValueNotThereAndNoFilter_shouldThrow() {
        XCTAssertThrowsError(try DNSAppConstants.constant(from: "TestValueNotThere") as Date) { error in
            // swiftlint:disable:next force_cast
            XCTAssertEqual(error as! DNSCoreError, DNSCoreError.constantNotFound(key: "TestValueNotThere", filter: ""))
        }
    }
    func test_constantDate_withTestValueDateAndNoFilter_shouldReturnReferenceDate() {
        var result: Date = Date(timeIntervalSinceReferenceDate: 0)
        XCTAssertNoThrow(result = try DNSAppConstants.constant(from: "TestValueDate"))

        let dateFormatter = DateFormatter.init()
        dateFormatter.timeZone      = NSTimeZone.local
        dateFormatter.dateFormat    = "yyyyMMdd"
        let referenceDate: Date = DNSDataTranslation().date(from: "2019-01-01")!
        XCTAssertEqual(result, referenceDate)
    }

    // MARK: - constantDouble tests
    func test_constantDouble_withTestValueNotThereAndNoFilter_shouldThrow() {
        XCTAssertThrowsError(try DNSAppConstants.constant(from: "TestValueNotThere") as Double) { error in
            // swiftlint:disable:next force_cast
            XCTAssertEqual(error as! DNSCoreError, DNSCoreError.constantNotFound(key: "TestValueNotThere", filter: ""))
        }
    }
    func test_constantDouble_withTestValueFloatAndNoFilter_shouldReturnDouble1_2345() {
        var result: Double = 0.0
        XCTAssertNoThrow(result = try DNSAppConstants.constant(from: "TestValue12345"))

        XCTAssertEqual(result, Double(1.2345))
    }

    // MARK: - constantInt tests
    func test_constantInt_withTestValueNotThereAndNoFilter_shouldThrow() {
        XCTAssertThrowsError(try DNSAppConstants.constant(from: "TestValueNotThere") as Int) { error in
            // swiftlint:disable:next force_cast
            XCTAssertEqual(error as! DNSCoreError, DNSCoreError.constantNotFound(key: "TestValueNotThere", filter: ""))
        }
    }
    func test_constantInt_withTestValueFloatAndNoFilter_shouldReturnInt57321() {
        var result: Int = 0
        XCTAssertNoThrow(result = try DNSAppConstants.constant(from: "TestValue57321"))

        XCTAssertEqual(result, Int(57321))
    }

    // MARK: - constantString tests
    func test_constantString_withTestValueNotThereAndNoFilter_shouldThrow() {
        XCTAssertThrowsError(try DNSAppConstants.constant(from: "TestValueNotThere") as String) { error in
            // swiftlint:disable:next force_cast
            XCTAssertEqual(error as! DNSCoreError, DNSCoreError.constantNotFound(key: "TestValueNotThere", filter: ""))
        }
    }
    func test_constantString_withTestValueStringAndNoFilter_shouldReturnString() {
        var result: String = ""
        XCTAssertNoThrow(result = try DNSAppConstants.constant(from: "TestValueString"))

        XCTAssertEqual(result, "This is a test string!")
    }

    func test_constantString_withTestValueDictionaryDotTestSubValueOneAndNoFilter_shouldReturnDictionary() {
        var result: [String: Any] = [:]
        let key = "TestValueDictionary.TestSubValueOne"
        XCTAssertNoThrow(result = DNSAppConstants.constant(from: key))

        XCTAssertEqual(result.count, 1)
    }

    func test_constantString_withTestValueDictionaryDotTestSubValueAndNoFilter_shouldReturnString() {
        var result: String = ""
        let key = "TestValueDictionary.TestSubValueOne.TestSubSubValueOne"
        XCTAssertNoThrow(result = try DNSAppConstants.constant(from: key))

        XCTAssertEqual(result, "Test String")
    }

    func test_constantString_withTestValueDictionaryDotTestSubValueTokenAndNoFilter_shouldReturnString() {
        var result: String = ""
        let key = "TestValueDictionary.TestSubValue{{TestValueKey}}.TestSubSubValueOne"
        XCTAssertNoThrow(result = try DNSAppConstants.constant(from: key))

        XCTAssertEqual(result, "Test String")
    }

    // MARK: - constantUIColor tests
    func test_constantUIColor_withTestValueNotThereAndNoFilter_shouldThrow() {
        XCTAssertThrowsError(try DNSAppConstants.constant(from: "TestValueNotThere") as UIColor) { error in
            // swiftlint:disable:next force_cast
            XCTAssertEqual(error as! DNSCoreError, DNSCoreError.constantNotFound(key: "TestValueNotThere", filter: ""))
        }
    }
    func test_constantUIColor_withTestValueStringSystemIndigoAndNoFilter_shouldReturnString() {
        var result: UIColor = UIColor.clear
        XCTAssertNoThrow(result = try DNSAppConstants.constant(from: "TestValueColorString"))

        var resultRed: CGFloat = 0
        var resultGreen: CGFloat = 0
        var resultBlue: CGFloat = 0
        var resultAlpha: CGFloat = 0
        result.getRed(&resultRed, green: &resultGreen, blue: &resultBlue, alpha: &resultAlpha)

        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        UIColor.systemIndigo.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        XCTAssertEqual(resultRed, red)
        XCTAssertEqual(resultGreen, green)
        XCTAssertEqual(resultBlue, blue)
        XCTAssertEqual(resultAlpha, alpha)
    }

    // MARK: - constantUInt tests
    func test_constantUInt_withTestValueNotThereAndNoFilter_shouldThrow() {
        XCTAssertThrowsError(try DNSAppConstants.constant(from: "TestValueNotThere") as UInt) { error in
            // swiftlint:disable:next force_cast
            XCTAssertEqual(error as! DNSCoreError, DNSCoreError.constantNotFound(key: "TestValueNotThere", filter: ""))
        }
    }
    func test_constantUInt_withTestValueFloatAndNoFilter_shouldReturnUInt57321() {
        var result: UInt = 0
        XCTAssertNoThrow(result = try DNSAppConstants.constant(from: "TestValueNeg35269"))

        XCTAssertEqual(result, UInt(35269))
    }

    // MARK: - constantURL tests
    func test_constantURL_withTestValueNotThereAndNoFilter_shouldThrow() {
        XCTAssertThrowsError(try DNSAppConstants.constant(from: "TestValueNotThere") as URL) { error in
            // swiftlint:disable:next force_cast
            XCTAssertEqual(error as! DNSCoreError, DNSCoreError.constantNotFound(key: "TestValueNotThere", filter: ""))
        }
    }
    func test_constantURL_withTestValueStringAndNoFilter_shouldReturnString() {
        var result: URL?
        XCTAssertNoThrow(result = try DNSAppConstants.constant(from: "TestValueURL"))

        XCTAssertEqual(result, URL(string: "https:8080//www.google.com/search?q=test"))
    }
}
