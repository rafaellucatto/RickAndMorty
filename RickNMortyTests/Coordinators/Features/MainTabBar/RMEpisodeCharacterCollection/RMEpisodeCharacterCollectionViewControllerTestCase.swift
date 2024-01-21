//
//  RMEpisodeCharacterCollectionViewControllerTestCase.swift
//  RickNMortyTests
//
//  Created by Rafael Lucatto on 1/13/24.
//

import Foundation
import iOSSnapshotTestCase

@testable import RickNMorty

final class RMEpisodeCharacterCollectionViewControllerTestCase: FBSnapshotTestCase {
    
    var viewModel: RMEpisodeCharacterCollectionViewModel!
    var view: RMEpisodeCharacterCollectionView!
    var sut: RMEpisodeCharacterCollectionViewController!
    
    override func setUp() {
        super.setUp()
        viewModel = .init(api: MockRMEpisodeCharacterCollectionViewModelAPI())
        view = .init(viewModel: viewModel)
        sut = .init(episodeView: view)
    }
    
    override func tearDown() {
        sut = nil
        view = nil
        viewModel = nil
        super.tearDown()
    }
    
    func test_whenInitialized_shouldReturnExpectedLayout() {
        view.frame = UIScreen.main.bounds
        UIWindow.makeWindowForModalPresentation(with: sut)
        viewModel.fetchEpisodeList(with: nil)
        FBSnapshotVerifyViewController(sut)
    }
    
}
