//
//  RMLocationViewModelDelegateSpy.swift
//  RickAndMortyTests
//
//  Created by Rafael Lucatto on 7/4/23.
//

import Foundation

@testable import RickAndMorty

final class RMLocationViewModelDelegateSpy: RMLocationViewModelDelegate {

    var didCallReloadTableCount: Int = 0
    var didCallStartLoadingCount: Int = 0
    var didCallStopLoadingCount: Int = 0
    var didCallShowCoverViewCount: Int = 0
    var didCallHideCoverViewCount: Int = 0
    var didCallSetUserInteractionCount: Int = 0
    var hasUserInteraction: Bool = false

    func reloadTable() {
        self.didCallReloadTableCount += 1
    }

    func startLoading() {
        self.didCallStartLoadingCount += 1
    }

    func stopLoading() {
        self.didCallStopLoadingCount += 1
    }

    func showCoverView() {
        self.didCallShowCoverViewCount += 1
    }

    func hideCoverView() {
        self.didCallHideCoverViewCount += 1
    }

    func setUserInteraction(to bool: Bool) {
        self.hasUserInteraction = bool
        self.didCallSetUserInteractionCount += 1
    }
}
