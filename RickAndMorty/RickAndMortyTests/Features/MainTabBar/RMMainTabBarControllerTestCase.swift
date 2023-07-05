//
//  RMMainTabBarControllerTestCase.swift
//  RickAndMortyTests
//
//  Created by Rafael Lucatto on 7/2/23.
//

import Foundation
import UIKit
import XCTest

@testable import RickAndMorty

final class RMMainTabBarControllerTestCase: XCTestCase {

    var requestManager: MockRMRequestManager!
    var sut: RMMainTabBarController!

    override func setUp() {
        super.setUp()
        requestManager = MockRMRequestManager()
        sut = RMMainTabBarController(requestManager: requestManager)
    }

    override func tearDown() {
        sut = nil
        requestManager = nil
        super.tearDown()
    }

    func test_whenInitialized_shouldExpectedTabBarItemCount() {
        XCTAssertEqual(sut.tabBar.items?.count, 3)
    }
}
