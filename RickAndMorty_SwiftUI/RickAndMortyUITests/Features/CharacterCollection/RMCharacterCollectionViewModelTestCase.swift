//
//  RMCharacterCollectionViewModelTestCase.swift
//  RickAndMortyUITests
//
//  Created by Rafael Lucatto on 2/25/24.
//

import Foundation
import XCTest

@testable import RickAndMortyUI

final class RMCharacterCollectionViewModelTestCase: XCTestCase {
    
    var api: SpyRMCharacterCollectionViewModelApi!
    var sut: RMCharacterCollectionViewModel!
    
    override func setUp() {
        super.setUp()
        api = .init()
        sut = .init(api: api)
    }
    override  func tearDown() {
        sut = nil
        api = nil
        super.tearDown()
    }
    
    func test_whenInitialized_shouldTriggerExpectedFunction() async {
        XCTAssertFalse(api.didCallGetFirstPageCharacters)
        await sut.getFirstCharacters()
        XCTAssertTrue(api.didCallGetFirstPageCharacters)
    }
    
    func test_whenTappingOnNextCharacters_shouldTriggerExpectedFunction() async {
        await sut.getFirstCharacters()
        XCTAssertFalse(api.didCallGetCharacters)
        await sut.getNextCharacters()
        XCTAssertTrue(api.didCallGetCharacters)
    }
    
    func test_whenTappingOnPreviousCharacters_shouldTriggerExpectedFunction() async {
        await sut.getFirstCharacters()
        XCTAssertFalse(api.didCallGetCharacters)
        await sut.getPreviousCharacters()
        XCTAssertTrue(api.didCallGetCharacters)
    }
    
    func test_whenChoosingSpecificPage_shouldTriggerExpectedFunction() async {
        XCTAssertFalse(api.didCallGetCharacters)
        await sut.getCustomPage(with: 2)
        XCTAssertTrue(api.didCallGetCharacters)
    }
    
}
