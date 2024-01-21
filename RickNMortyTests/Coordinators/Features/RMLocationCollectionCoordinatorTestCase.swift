//
//  RMLocationCollectionCoordinatorTestCase.swift
//  RickNMortyTests
//
//  Created by Rafael Lucatto on 1/12/24.
//

import Foundation
import XCTest

@testable import RickNMorty

final class RMLocationCollectionCoordinatorTestCase: XCTestCase {
    
    var sut: RMLocationCollectionCoordinator!
    
    override func setUp() {
        super.setUp()
        sut = .init()
        sut.start()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_whenInitialized_shouldReturnExpectedController() {
        XCTAssert(sut.viewController is UINavigationController)
        XCTAssertEqual((sut.viewController as? UINavigationController)?.children.count, 1)
        XCTAssert((sut.viewController as? UINavigationController)?.topViewController is RMLocationViewController)
    }
    
    func test_whenResidentButtonIsTapped_shouldReturnExpectedController() {
        sut.didTapResidents(chars: [])
        XCTAssertEqual((sut.viewController as? UINavigationController)?.children.count, 2)
        XCTAssert((sut.viewController as? UINavigationController)?.topViewController is RMCharacterCollectionFromLocationViewController)
    }
    
    func test_whenCharacterIsTapped_shouldReturnExpectedController() {
        sut.didTapResidents(chars: [])
        sut.didTapCharacter(character: .stub())
        XCTAssertEqual((sut.viewController as? UINavigationController)?.children.count, 3)
        XCTAssert((sut.viewController as? UINavigationController)?.topViewController is RMCharacterCollectionDetailViewController)
    }
    
    func test_whenCharacterInfoGetsClicked_shouldReturnExpectedController() {
        UIWindow.makeWindowForModalPresentation(with: sut.viewController)
        sut.didTapResidents(chars: [])
        sut.didTapCharacter(character: .stub())
        sut.didTapCharacterInfo(cellModel: .stub())
        XCTAssert((sut.viewController as? UINavigationController)?.presentedViewController is RMCellInfoDisplayViewController)
    }
    
}
