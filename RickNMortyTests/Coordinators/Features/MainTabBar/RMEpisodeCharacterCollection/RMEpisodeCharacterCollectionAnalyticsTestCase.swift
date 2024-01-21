//
//  RMEpisodeCharacterCollectionAnalyticsTestCase.swift
//  RickNMortyTests
//
//  Created by Rafael Lucatto on 1/14/24.
//

import Foundation
import XCTest

@testable import RickNMorty

final class RMEpisodeCharacterCollectionAnalyticsTestCase: XCTestCase {
    
    var sut: RMEpisodeCharacterCollectionAnalytics!
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_whenInitializedAsPage_shouldReturnExpectedValues() {
        sut = .page
        XCTAssertEqual(sut.parameters[ParameterKey.hash], "p-001.000.000.001.002")
        XCTAssertEqual(sut.parameters[ParameterKey.pagename], "episode-collection")
    }
    
    func test_whenInitializedAsCharacter_shouldReturnExpectedValues() {
        sut = .didTapCharacter(name: "characterName", episode: "characterEpisode")
        XCTAssertEqual(sut.parameters[ParameterKey.hash], "a-001.000.000.002.004")
        XCTAssertEqual(sut.parameters[ParameterKey.charactername], "characterName")
        XCTAssertEqual(sut.parameters[ParameterKey.episodename], "characterEpisode")
    }
    
}
