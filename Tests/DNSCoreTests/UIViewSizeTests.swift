//
//  UIViewSizeTests.m
//  DNSCoreTests
//
//  Created by Darren Ehlers on 10/23/16.
//  Copyright © 2019 - 2016 DoubleNode.com. All rights reserved.
//

import XCTest

@testable import DNSCore

class UIViewSizeTests: XCTestCase {
    let defaultFrame = CGRect(x: 105, y: 23, width: 55, height: 73)
    let alternateFrame = CGRect(x: 162, y: 57, width: 28, height: 91)

    private var sut: UIView!

    override func setUp() {
        super.setUp()
        sut = UIView()
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_visible_withDisplayedView_shouldReturnTrue() {
        let viewController = UIViewController()
        viewController.view.addSubview(sut)
        let result: Bool = sut.visible
        XCTAssertEqual(result, true)
    }
    func test_visible_withHiddenView_shouldReturnFalse() {
        let result: Bool = sut.visible
        XCTAssertEqual(result, false)
    }
    func test_originGet_withDefaultFrame_shouldReturnDefaultOrigin() {
        sut.frame = defaultFrame
        let result: CGPoint = sut.origin
        XCTAssertEqual(result, defaultFrame.origin)
    }
    func test_xGet_withDefaultFrame_shouldReturnDefaultX() {
        sut.frame = defaultFrame
        let result: CGFloat = sut.x
        XCTAssertEqual(result, defaultFrame.origin.x)
    }
    func test_yGet_withDefaultFrame_shouldReturnDefaultY() {
        sut.frame = defaultFrame
        let result: CGFloat = sut.y
        XCTAssertEqual(result, defaultFrame.origin.y)
    }
    func test_sizeGet_withDefaultFrame_shouldReturnDefaultSize() {
        sut.frame = defaultFrame
        let result: CGSize = sut.size
        XCTAssertEqual(result, defaultFrame.size)
    }
    func test_widthGet_withDefaultFrame_shouldReturnDefaultWidth() {
        sut.frame = defaultFrame
        let result: CGFloat = sut.width
        XCTAssertEqual(result, defaultFrame.size.width)
    }
    func test_heightGet_withDefaultFrame_shouldReturnDefaultHeight() {
        sut.frame = defaultFrame
        let result: CGFloat = sut.height
        XCTAssertEqual(result, defaultFrame.size.height)
    }
    func test_originSet_withAlternateOrigin_shouldReturnAlternateOrigin() {
        sut.frame = defaultFrame
        sut.origin = alternateFrame.origin
        let result: CGPoint = sut.frame.origin
        XCTAssertEqual(result, alternateFrame.origin)
    }
    func test_xSet_withAlternateX_shouldReturnAlternateX() {
        sut.frame = defaultFrame
        sut.x = alternateFrame.origin.x
        let result: CGFloat = sut.frame.origin.x
        XCTAssertEqual(result, alternateFrame.origin.x)
    }
    func test_ySet_withAlternateY_shouldReturnAlternateY() {
        sut.frame = defaultFrame
        sut.y = alternateFrame.origin.y
        let result: CGFloat = sut.frame.origin.y
        XCTAssertEqual(result, alternateFrame.origin.y)
    }
    func test_sizeSet_withAlternateOrigin_shouldReturnAlternateSize() {
        sut.frame = defaultFrame
        sut.size = alternateFrame.size
        let result: CGSize = sut.frame.size
        XCTAssertEqual(result, alternateFrame.size)
    }
    func test_widthSet_withAlternateX_shouldReturnAlternateWidth() {
        sut.frame = defaultFrame
        sut.width = alternateFrame.size.width
        let result: CGFloat = sut.frame.size.width
        XCTAssertEqual(result, alternateFrame.size.width)
    }
    func test_heightSet_withAlternateY_shouldReturnAlternateHeight() {
        sut.frame = defaultFrame
        sut.height = alternateFrame.size.height
        let result: CGFloat = sut.frame.size.height
        XCTAssertEqual(result, alternateFrame.size.height)
    }
}
