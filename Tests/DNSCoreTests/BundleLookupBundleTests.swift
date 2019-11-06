//
//  BundleLookupBundleTests.m
//  DNSCoreTests
//
//  Created by Darren Ehlers on 10/23/16.
//  Copyright © 2019 - 2016 DoubleNode.com. All rights reserved.
//

import DNSCoreThreading
import XCTest

@testable import DNSCore

class TestViewController: UIViewController {
}

class BundleLookupBundleTests: XCTestCase {
    func test_dnsLookupNibBundleForClasstype_withNil_shouldReturnNil() {
        let result: Bundle? = Bundle.dnsLookupNibBundle(for: nil)
        XCTAssertEqual(result, nil)
    }
    func test_dnsLookupNibBundleForClasstype_withDNSThread_shouldReturnNil() {
        let result: Bundle? = Bundle.dnsLookupNibBundle(for: DNSThread.self)
        XCTAssertEqual(result, nil)
    }
    func test_dnsLookupNibBundleForClasstype_withTestViewController_shouldReturnMainBundle() {
        let result: Bundle? = Bundle.dnsLookupNibBundle(for: TestViewController.self)
        XCTAssertEqual(result, Bundle.main)
    }
    func test_dnsLookupBundleForClasstype_withNil_shouldReturnNil() {
        let result: Bundle? = Bundle.dnsLookupBundle(for: nil)
        XCTAssertEqual(result, nil)
    }
    func test_dnsLookupBundleForClasstype_withDNSThread_shouldReturnMainBundle() {
        let result: Bundle? = Bundle.dnsLookupBundle(for: DNSThread.self)
        XCTAssertEqual(result, Bundle.main)
    }
    func test_dnsLookupBundleForClassname_withEmptyClassname_shouldReturnNil() {
        let className = ""
        let result: Bundle? = Bundle.dnsLookupBundle(for: className)
        XCTAssertEqual(result, nil)
    }
    func test_dnsLookupBundleForClassname_withInvalidClassname_shouldReturnNil() {
        let className = "NonExistantClass"
        let result: Bundle? = Bundle.dnsLookupBundle(for: className)
        XCTAssertEqual(result, nil)
    }
    func test_dnsLookupBundleForClassname_withDNSThreadClassname_shouldReturnMainBundle() {
        let className = NSStringFromClass(DNSThread.self)
        let result: Bundle? = Bundle.dnsLookupBundle(for: className)
        XCTAssertEqual(result, Bundle.main)
    }
}