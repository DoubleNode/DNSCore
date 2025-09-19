//
//  StringRegExTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

import XCTest
@testable import DNSCore

final class StringRegExTests: XCTestCase {

    func testDnsCheckValidEmail() {
        let email = "test@example.com"
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        XCTAssertTrue(email.dnsCheck(regEx: emailRegex), "Valid email should match regex")
    }

    func testDnsCheckInvalidEmail() {
        let email = "invalid-email"
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        XCTAssertFalse(email.dnsCheck(regEx: emailRegex), "Invalid email should not match regex")
    }

    func testDnsCheckValidPhoneNumber() {
        let phone = "(555) 123-4567"
        let phoneRegex = #"^\(\d{3}\) \d{3}-\d{4}$"#
        XCTAssertTrue(phone.dnsCheck(regEx: phoneRegex), "Valid phone number should match regex")
    }

    func testDnsCheckInvalidPhoneNumber() {
        let phone = "555-123-4567"
        let phoneRegex = #"^\(\d{3}\) \d{3}-\d{4}$"#
        XCTAssertFalse(phone.dnsCheck(regEx: phoneRegex), "Invalid phone number format should not match regex")
    }

    func testDnsCheckDigitsOnly() {
        let digits = "12345"
        let digitsRegex = #"^\d+$"#
        XCTAssertTrue(digits.dnsCheck(regEx: digitsRegex), "Digits only string should match digits regex")

        let mixedString = "123abc"
        XCTAssertFalse(mixedString.dnsCheck(regEx: digitsRegex), "Mixed string should not match digits only regex")
    }

    func testDnsCheckLettersOnly() {
        let letters = "abcDEF"
        let lettersRegex = #"^[a-zA-Z]+$"#
        XCTAssertTrue(letters.dnsCheck(regEx: lettersRegex), "Letters only string should match letters regex")

        let mixedString = "abc123"
        XCTAssertFalse(mixedString.dnsCheck(regEx: lettersRegex), "Mixed string should not match letters only regex")
    }

    func testDnsCheckEmptyString() {
        let empty = ""
        let anyRegex = #".*"#
        XCTAssertTrue(empty.dnsCheck(regEx: anyRegex), "Empty string should match .* regex")

        let nonEmptyRegex = #".+"#
        XCTAssertFalse(empty.dnsCheck(regEx: nonEmptyRegex), "Empty string should not match .+ regex")
    }

    func testDnsCheckInvalidRegex() {
        let text = "test"
        let invalidRegex = "[invalid"
        XCTAssertFalse(text.dnsCheck(regEx: invalidRegex), "Invalid regex should return false")
    }

    func testDnsCheckComplexRegex() {
        let password = "Password123!"
        // Password with at least 8 chars, one uppercase, one lowercase, one digit, one special char
        let passwordRegex = #"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$"#
        XCTAssertTrue(password.dnsCheck(regEx: passwordRegex), "Complex password should match security regex")

        let weakPassword = "password"
        XCTAssertFalse(weakPassword.dnsCheck(regEx: passwordRegex), "Weak password should not match security regex")
    }

    func testDnsCheckUnicodeStrings() {
        let unicodeText = "Hello 世界"
        let unicodeRegex = #"^Hello 世界$"#
        XCTAssertTrue(unicodeText.dnsCheck(regEx: unicodeRegex), "Unicode text should match unicode regex")
    }

    func testDnsCheckSpecialCharacters() {
        let specialText = "test@#$%^&*()"
        let specialRegex = #"^test[@#$%^&*()]+$"#
        XCTAssertTrue(specialText.dnsCheck(regEx: specialRegex), "Special characters should match properly")
    }

    static var allTests = [
        ("testDnsCheckValidEmail", testDnsCheckValidEmail),
        ("testDnsCheckInvalidEmail", testDnsCheckInvalidEmail),
        ("testDnsCheckValidPhoneNumber", testDnsCheckValidPhoneNumber),
        ("testDnsCheckInvalidPhoneNumber", testDnsCheckInvalidPhoneNumber),
        ("testDnsCheckDigitsOnly", testDnsCheckDigitsOnly),
        ("testDnsCheckLettersOnly", testDnsCheckLettersOnly),
        ("testDnsCheckEmptyString", testDnsCheckEmptyString),
        ("testDnsCheckInvalidRegex", testDnsCheckInvalidRegex),
        ("testDnsCheckComplexRegex", testDnsCheckComplexRegex),
        ("testDnsCheckUnicodeStrings", testDnsCheckUnicodeStrings),
        ("testDnsCheckSpecialCharacters", testDnsCheckSpecialCharacters),
    ]
}