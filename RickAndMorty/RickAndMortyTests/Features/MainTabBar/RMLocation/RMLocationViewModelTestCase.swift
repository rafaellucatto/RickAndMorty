//
//  RMLocationViewModelTestCase.swift
//  RickAndMortyTests
//
//  Created by Rafael Lucatto on 7/4/23.
//

import Foundation
import XCTest

@testable import RickAndMorty

final class RMLocationViewModelTestCase: XCTestCase {

    var dispatchQueueHandler: MockRMDispatchQueueHandler!
    var animationHandler: MockRMAnimationHandler!
    var delegate: RMLocationViewModelDelegateSpy!
    var requestManager: MockRMRequestManager!
    var sut: RMLocationViewModel!

    override func setUp() {
        super.setUp()
        dispatchQueueHandler = MockRMDispatchQueueHandler()
        animationHandler = MockRMAnimationHandler()
        delegate = RMLocationViewModelDelegateSpy()
        requestManager = MockRMRequestManager()
        sut = RMLocationViewModel(requestManager: requestManager,
                                  animationHandler: animationHandler,
                                  dispatchQueueHandler: dispatchQueueHandler)
        sut.delegate = delegate
    }

    override func tearDown() {
        sut = nil
        requestManager = nil
        delegate = nil
        animationHandler = nil
        super.tearDown()
    }

    func test_RMLocationViewModel_whenFetchLocationGetsCalled_shouldTriggerExpectedFunctions() {
        sut.fetchLocation(with: nil)
        XCTAssertEqual(delegate.didCallShowCoverViewCount, 1)
        XCTAssertEqual(delegate.didCallStartLoadingCount, 1)
        XCTAssertEqual(delegate.didCallStopLoadingCount, 1)
        XCTAssertEqual(delegate.didCallReloadTableCount, 1)
        XCTAssertEqual(delegate.didCallHideCoverViewCount, 1)
        XCTAssertEqual(delegate.didCallSetUserInteractionCount, 1)
        XCTAssertEqual(delegate.hasUserInteraction, true)
    }
}
