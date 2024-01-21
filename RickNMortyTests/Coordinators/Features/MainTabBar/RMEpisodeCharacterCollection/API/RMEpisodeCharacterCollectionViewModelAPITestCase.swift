//
//  RMEpisodeCharacterCollectionViewModelAPITestCase.swift
//  RickNMortyTests
//
//  Created by Rafael Lucatto on 1/14/24.
//

import Foundation
import XCTest

@testable import RickNMorty

final class RMEpisodeCharacterCollectionViewModelAPITestCase: XCTestCase {
    
    var alamofire: SpyAlamofireHandler!
    var sut: RMEpisodeCharacterCollectionViewModelAPI!
    
    override func setUp() {
        super.setUp()
        alamofire = .init()
        sut = .init(alamofire: alamofire)
    }
    
    override func tearDown() {
        sut = nil
        alamofire = nil
        super.tearDown()
    }
    
    func test_whenFetchingCharacters_shouldTriggerExpectedFunction() {
        sut.getCharacters(with: "") { _ in }
        XCTAssertEqual(alamofire.requestGotCalled, true)
    }
    
    func test_whenFetchingEpisodes_shouldTriggerExpectedFunction() {
        sut.getEpisodes(with: "") { _ in }
        XCTAssertEqual(alamofire.requestGotCalled, true)
    }
    
    func test_whenFetchingEpisode_shouldTriggerExpectedFunction() {
        sut.getEpisode(with: "") { _ in }
        XCTAssertEqual(alamofire.requestGotCalled, true)
    }
    
    func test_whenFetchingImageData_shouldTriggerExpectedFunction() {
        sut.getImageData(with: "") { _ in }
        XCTAssertEqual(alamofire.requestDataGotCalled, true)
    }
    
}
