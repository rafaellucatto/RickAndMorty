//
//  RMLocationCollectionViewModelTestCase.swift
//  RickAndMortyUITests
//
//  Created by Rafael Lucatto on 2/25/24.
//

import Foundation
import XCTest

@testable import RickAndMortyUI

final class RMLocationCollectionViewModelTestCase: XCTestCase {
    
    var viewModel: MockRMLocationCollectionViewModelApi!
    var sut: RMLocationCollectionViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = .init()
        sut = .init(api: viewModel)
    }
    
    override func tearDown() {
        sut = nil
        viewModel = nil
        super.tearDown()
    }
    
    func test_whenInitialized_shouldTriggerExpectedFunction() async {
        XCTAssertFalse(viewModel.didCallGetFirstPage)
        await sut.getFirstLocations()
        XCTAssertTrue(viewModel.didCallGetFirstPage)
    }
    
    func test_whenTappingNextPage_shouldTriggerExpectedFunction() async {
        await sut.getFirstLocations()
        XCTAssertFalse(viewModel.didCallGetLocations)
        await sut.didTapNextPage()
        XCTAssertTrue(viewModel.didCallGetLocations)
    }
    
    func test_whenTappingPreviousPage_shouldTriggerExpectedFunction() async {
        await sut.getFirstLocations()
        XCTAssertFalse(viewModel.didCallGetLocations)
        await sut.didTapPreviousPage()
        XCTAssertTrue(viewModel.didCallGetLocations)
    }
    
    func test_whenChoosingCustomPage_shouldTriggerExpectedFunction() async {
        XCTAssertFalse(viewModel.didCallGetLocations)
        await sut.didTapPage(with: 2)
        XCTAssertTrue(viewModel.didCallGetLocations)
    }
}

final class MockRMLocationCollectionViewModelApi: RMLocationCollectionViewModelApiProtocol {
    
    var didCallGetFirstPage: Bool = false
    var didCallGetLocations: Bool = false
    
    var shouldSucceed: Bool
    
    init(shouldSucceed: Bool = true) {
        self.shouldSucceed = shouldSucceed
    }
    
    func getFirstPage() async -> RMLocationMainResopnse? {
        didCallGetFirstPage = true
        if shouldSucceed {
            return .stub()
        }
        return nil
    }
    
    func getLocations(from page: String) async -> RMLocationMainResopnse? {
        didCallGetLocations = true
        if shouldSucceed {
            return .stub()
        }
        return nil
    }
    
}

extension RMLocationMainResopnse {
    static func stub(info: RMInfoJson = .stub(), results: [RMLocation] = Array(repeating: .stub(), count: 4)) -> RMLocationMainResopnse {
        return RMLocationMainResopnse(info: info, results: results)
    }
}

extension RMInfoJson {
    static func stub(count: Int = 23, pages: Int = 7, next: String? = "next", prev: String? = "previous") -> RMInfoJson {
        return RMInfoJson(count: count, pages: pages, next: next, prev: prev)
    }
}

extension RMLocation {
    static func stub(id: Int = 3,
                     name: String = "location name",
                     type: String = "loc type",
                     dimension: String = "loc dimension",
                     residents: [String] = ["1", "1", "1", "1", "1", "1"],
                     url: String = "",
                     created: String = "May 27, 2017") -> RMLocation {
        return RMLocation(id: id,
                          name: name,
                          type: type,
                          dimension: dimension,
                          residents: residents,
                          url: url,
                          created: created)
    }
}
