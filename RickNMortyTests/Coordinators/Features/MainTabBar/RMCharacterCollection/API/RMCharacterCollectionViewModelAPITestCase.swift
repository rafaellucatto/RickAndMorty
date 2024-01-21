//
//  RMCharacterCollectionViewModelAPITestCase.swift
//  RickNMortyTests
//
//  Created by Rafael Lucatto on 1/14/24.
//

import Foundation
import XCTest

@testable import RickNMorty

final class RMCharacterCollectionViewModelAPITestCase: XCTestCase {
    
    var alamofire: SpyAlamofireHandler!
    var sut: RMCharacterCollectionViewModelAPI!
    
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
    
    func test_whenGettingLocation_shouldTriggerExpectedFunction() {
        sut.requestCharacters(with: "") { _ in }
        XCTAssertEqual(alamofire.requestGotCalled, true)
    }
    
    func test_whenGettingCharacters_shouldTriggerExpectedFunction() {
        sut.getImageData(with: "") { _ in }
        XCTAssertEqual(alamofire.requestDataGotCalled, true)
    }
    
    func test_whenGettingImage_shouldTriggerExpectedFunction() {
        sut.getCharacterEpisodes(from: "") { _ in }
        XCTAssertEqual(alamofire.requestGotCalled, true)
    }
    
}
