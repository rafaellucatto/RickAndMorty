//
//  RMCharacterCollectionCoordinatorTestCase.swift
//  RickNMortyTests
//
//  Created by Rafael Lucatto on 1/11/24.
//

import Alamofire
import Foundation
import UIKit
import XCTest

@testable import RickNMorty

final class RMCharacterCollectionCoordinatorTestCase: XCTestCase {
    
    private var sut: RMCharacterCollectionCoordinator!
    
    override func setUp() {
        super.setUp()
        sut = .init()
        sut.start()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_whenInitialized_shouldReturnViewControllerAsNavController() {
        XCTAssertTrue(sut.viewController is UINavigationController)
        XCTAssertEqual(sut.viewController?.children.count, 1)
        XCTAssertTrue(sut.viewController?.children.first is RMCharacterCollectionViewController)
    }
    
    func test_whenDidTapCharacterIsCalled_shouldReturnExpectedController() {
        sut.didTapCharacter(character: .stub())
        XCTAssertEqual((sut.viewController as? UINavigationController)?.children.count, 2)
        XCTAssert((sut.viewController as? UINavigationController)?.topViewController is RMCharacterCollectionDetailViewController)
    }
    
    func test_whenDidTapCharacterInfoIsCalled_shouldReturnExpectedController() {
        UIWindow.makeWindowForModalPresentation(with: sut.viewController)
        sut.didTapCharacter(character: .stub())
        sut.didTapCharacterInfo(cellModel: .stub())
        XCTAssert((sut.viewController as? UINavigationController)?.presentedViewController is RMCellInfoDisplayViewController)
    }
    
}
