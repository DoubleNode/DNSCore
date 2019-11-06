//
//  UIColorStringTests.m
//  DNSCoreTests
//
//  Created by Darren Ehlers on 10/23/16.
//  Copyright © 2019 - 2016 DoubleNode.com. All rights reserved.
//

import XCTest

@testable import DNSCore

class UIColorStringTests: XCTestCase {
    private var sut: UIColor!

    override func setUp() {
        super.setUp()
        sut = UIColor()
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_initWithString_withHexString_shouldReturnColor() {
        let result: UIColor = UIColor.init(with: "#757575")
        XCTAssertNotNil(result)
        XCTAssertEqual(result, UIColor.init(red: 117/255, green: 117/255, blue: 117/255, alpha: 1))
    }

    func test_initWithString_withTextName_shouldReturnColor() {
        let result: UIColor = UIColor.init(with: "purple")
        XCTAssertNotNil(result)
        XCTAssertEqual(result, UIColor.purple)
    }
}
