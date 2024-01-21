//
//  RMEpisodeCharacterCollectionCoordinatorTestCase.swift
//  RickNMortyTests
//
//  Created by Rafael Lucatto on 1/12/24.
//

import Foundation
import XCTest

@testable import RickNMorty

final class RMEpisodeCharacterCollectionCoordinatorTestCase: XCTestCase {
    
    var sut: RMEpisodeCharacterCollectionCoordinator!
    
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
        XCTAssert((sut.viewController as? UINavigationController)?.topViewController is RMEpisodeCharacterCollectionViewController)
    }
    
    func test_whenCharacterIsTapped_shouldReturnExpectedController() {
        sut.didTapCharacter(character: .stub())
        XCTAssert((sut.viewController as? UINavigationController)?.topViewController is RMCharacterCollectionDetailViewController)
    }
    
    func test_whenCharacterInfoGetsClicked_shouldReturnExpectedController() {
        UIWindow.makeWindowForModalPresentation(with: sut.viewController)
        sut.didTapCharacterInfo(cellModel: .stub())
        XCTAssert((sut.viewController as? UINavigationController)?.presentedViewController is RMCellInfoDisplayViewController)
    }
    
}
