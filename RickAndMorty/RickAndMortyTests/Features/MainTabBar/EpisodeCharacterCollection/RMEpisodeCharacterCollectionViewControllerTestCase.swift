//
//  RMEpisodeCharacterCollectionViewControllerTestCase.swift
//  RickAndMortyTests
//
//  Created by Rafael Lucatto on 7/3/23.
//

import Foundation
import iOSSnapshotTestCase

@testable import RickAndMorty

final class RMEpisodeCharacterCollectionViewControllerTestCase: FBSnapshotTestCase {

    var requestManager: MockRMRequestManager!
    var viewModel: MockRMEpisodeCharacterCollectionViewModel!
    var sutView: RMEpisodeCharacterCollectionView!
    var sut: RMEpisodeCharacterCollectionViewController!

    override func setUp() {
        super.setUp()
        requestManager = MockRMRequestManager()
        viewModel = MockRMEpisodeCharacterCollectionViewModel(requestManager: requestManager)
        sutView = RMEpisodeCharacterCollectionView(viewModel: viewModel)
        sut = RMEpisodeCharacterCollectionViewController(episodeView: sutView)
    }

    override func tearDown() {
        sut = nil
        sutView = nil
        viewModel = nil
        requestManager = nil
        super.tearDown()
    }

    func test_EpisodeCharacterCollectionViewController_whenInitialized_shouldReturnExpectedLayout() {
        viewModel.fetchEpisodeList(with: nil)
        sut.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1200)
        sut.overrideUserInterfaceStyle = .light
        FBSnapshotVerifyViewController(sut)
    }

    func test_EpisodeCharacterCollectionViewController_whenInitializedInDarkMode_shouldReturnExpectedLayout() {
        viewModel.fetchEpisodeList(with: nil)
        sut.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1200)
        sut.overrideUserInterfaceStyle = .dark
        FBSnapshotVerifyViewController(sut)
    }
}
