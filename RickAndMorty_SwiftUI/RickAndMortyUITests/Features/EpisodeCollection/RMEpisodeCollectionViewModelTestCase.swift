//
//  RMEpisodeCollectionViewModelTestCase.swift
//  RickAndMortyUITests
//
//  Created by Rafael Lucatto on 2/26/24.
//

import Foundation
import XCTest

@testable import RickAndMortyUI

final class RMEpisodeCollectionViewModelTestCase: XCTestCase {
    
    var sut: RMEpisodeCollectionViewModel!
    var api: SpyRMEpisodeCollectionViewModelApi!
    
    override func setUp() {
        super.setUp()
        api = SpyRMEpisodeCollectionViewModelApi()
        sut = RMEpisodeCollectionViewModel(api: api)
    }
    
    override func tearDown() {
        sut = nil
        api = nil
        super.tearDown()
    }
    
    func test_whenInitialized_shouldTriggerExpectedFunction() async {
        await sut.getEpisodes()
        XCTAssertTrue(api.didCallGetFirstEpisodes)
        XCTAssertTrue(api.didCallGetCharacter)
        XCTAssertTrue(api.didCallGetCharacterImage)
    }
    
    func test_whenTappingOnNextPage_shouldTriggerExpectedFunction() async {
        await sut.getEpisodes()
        await sut.didTapNextPage()
        XCTAssertTrue(api.didCallGetEpisodes)
        XCTAssertTrue(api.didCallGetCharacter)
        XCTAssertTrue(api.didCallGetCharacterImage)
    }
    
    func test_whenTappingPreviousPage_shouldTriggerExpectedFunction() async {
        await sut.getEpisodes()
        await sut.didTapPreviousPage()
        XCTAssertTrue(api.didCallGetEpisodes)
        XCTAssertTrue(api.didCallGetCharacter)
        XCTAssertTrue(api.didCallGetCharacterImage)
    }
    
    func test_whenChoosingSpecificPage_shouldTriggerExpectedFunction() async {
        await sut.didTapPage(with: 1)
        XCTAssertTrue(api.didCallGetEpisodes)
        XCTAssertTrue(api.didCallGetCharacter)
        XCTAssertTrue(api.didCallGetCharacterImage)
    }
    
}
