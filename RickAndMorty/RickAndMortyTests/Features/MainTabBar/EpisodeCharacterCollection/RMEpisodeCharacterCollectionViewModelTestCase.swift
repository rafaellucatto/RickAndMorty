//
//  RMEpisodeCharacterCollectionViewModelTestCase.swift
//  RickAndMortyTests
//
//  Created by Rafael Lucatto on 7/4/23.
//

import Foundation
import XCTest

@testable import RickAndMorty

final class RMEpisodeCharacterCollectionViewModelTestCase: XCTestCase {

    var delegate: RMEpisodeCharacterCollectionViewModelDelegateSpy!
    var dispatchQueue: MockRMDispatchQueueHandler!
    var animationHandler: MockRMAnimationHandler!
    var requestManager: MockRMRequestManager!
    var sut: RMEpisodeCharacterCollectionViewModel!

    override func setUp() {
        super.setUp()
        delegate = RMEpisodeCharacterCollectionViewModelDelegateSpy()
        dispatchQueue = MockRMDispatchQueueHandler()
        animationHandler = MockRMAnimationHandler()
        requestManager = MockRMRequestManager()
        sut = RMEpisodeCharacterCollectionViewModel(requestManager: requestManager,
                                                    animationHandler: animationHandler,
                                                    dispatchQueue: dispatchQueue)
        sut.delegate = self.delegate
    }

    override func tearDown() {
        sut = nil
        requestManager = nil
        animationHandler = nil
        dispatchQueue = nil
        delegate = nil
        super.tearDown()
    }

    func test_RMEpisodeCharacterCollectionViewModel_whenInitialized_shouldReturnSomething() {
        sut.fetchEpisodeList(with: nil)
        XCTAssertEqual(self.delegate.didCallReloadCollectionCount, 1)
        XCTAssertEqual(self.delegate.didCallStartLoadingCount, 1)
        XCTAssertEqual(self.delegate.didCallStopLoadingCount, 1)
        XCTAssertEqual(self.delegate.didCallSetUserInteractionCount, 2)
        XCTAssertEqual(self.delegate.didCallShowCoverScreenCount, 1)
        XCTAssertEqual(self.delegate.didCallHideCoverScreenCount, 1)
    }
}

final class RMEpisodeCharacterCollectionViewModelDelegateSpy: RMEpisodeCharacterCollectionViewModelDelegate {

    var didCallReloadCollectionCount: Int = 0
    var didCallStartLoadingCount: Int = 0
    var didCallStopLoadingCount: Int = 0
    var didCallShowCoverScreenCount: Int = 0
    var didCallHideCoverScreenCount: Int = 0
    var didCallSetUserInteractionCount: Int = 0

    var userInteractionValue: Bool = false

    func reloadCollection() {
        self.didCallReloadCollectionCount += 1
    }

    func startLoading() {
        self.didCallStartLoadingCount += 1
    }

    func stopLoading() {
        self.didCallStopLoadingCount += 1
    }

    func showCoverScreen() {
        self.didCallShowCoverScreenCount += 1
    }

    func hideCoverScreen() {
        self.didCallHideCoverScreenCount += 1
    }

    func setUserInteraction(to bool: Bool) {
        self.userInteractionValue = bool
        self.didCallSetUserInteractionCount += 1
    }
}
