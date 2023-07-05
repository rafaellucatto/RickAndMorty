//
//  RMDetailCellTestCase.swift
//  RickAndMortyTests
//
//  Created by Rafael Lucatto on 7/4/23.
//

import Foundation
import XCTest

@testable import RickAndMorty

final class RMDetailCellTestCase: XCTestCase {

    var sut: RMLocationViewModel.RMDetailCell!

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_RMDetailCell_whenInitializedAsName_shouldReturnExpectedValues() {
        sut = .name
        XCTAssertEqual(sut.getTitle, "Name")
        XCTAssertEqual(sut.getValue(for: .stub()), "Earth")
    }

    func test_RMDetailCell_whenInitializedAsDimension_shouldReturnExpectedValues() {
        sut = .dimension
        XCTAssertEqual(sut.getTitle, "Dimension")
        XCTAssertEqual(sut.getValue(for: .stub()), "Dimension")
    }

    func test_RMDetailCell_whenInitializedAsId_shouldReturnExpectedValues() {
        sut = .id
        XCTAssertEqual(sut.getTitle, "Id")
        XCTAssertEqual(sut.getValue(for: .stub()), "1")
    }

    func test_RMDetailCell_whenInitializedAsType_shouldReturnExpectedValues() {
        sut = .type
        XCTAssertEqual(sut.getTitle, "Type")
        XCTAssertEqual(sut.getValue(for: .stub()), "Type")
    }
}
