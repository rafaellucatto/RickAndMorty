//
//  RMMainCoordinatorTestCase.swift
//  RickNMortyTests
//
//  Created by Rafael Lucatto on 1/11/24.
//

import Foundation
import XCTest

@testable import RickNMorty

final class RMMainCoordinatorTestCase: XCTestCase {
    
    private var window: UIWindow!
    private var sut: RMMainCoordinator!
    
    override func setUp() {
        super.setUp()
        window = UIWindow(frame: .zero)
        sut = RMMainCoordinator(window: window)
    }
    
    override func tearDown() {
        sut = nil
        window = nil
        super.tearDown()
    }
    
    func test_whenStarting_shouldReturnViewControllerAsTabBar() {
        sut.start()
        XCTAssert(sut.viewController is UITabBarController)
    }
    
}
