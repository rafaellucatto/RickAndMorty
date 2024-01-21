//
//  RMLocationViewModelAPITestCase.swift
//  RickNMortyTests
//
//  Created by Rafael Lucatto on 1/14/24.
//

import Foundation
import XCTest

@testable import RickNMorty

final class RMLocationViewModelAPITestCase: XCTestCase {
    
    var alamofire: SpyAlamofireHandler!
    var sut: RMLocationViewModelAPI!
    
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
        sut.getLocations(from: "") { _ in }
        XCTAssertEqual(alamofire.requestGotCalled, true)
    }
    
    func test_whenGettingCharacters_shouldTriggerExpectedFunction() {
        sut.getCharacters(with: "") { _ in }
        XCTAssertEqual(alamofire.requestGotCalled, true)
    }
    
    func test_whenGettingImage_shouldTriggerExpectedFunction() {
        sut.getImage(from: "") { _ in }
        XCTAssertEqual(alamofire.requestDataGotCalled, true)
    }
    
}
