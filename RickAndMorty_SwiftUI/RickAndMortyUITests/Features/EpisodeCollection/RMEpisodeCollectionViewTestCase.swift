//
//  RMEpisodeCollectionViewTestCase.swift
//  RickAndMortyUITests
//
//  Created by Rafael Lucatto on 2/25/24.
//

import Foundation
import iOSSnapshotTestCase
import SwiftUI

@testable import RickAndMortyUI

final class RMEpisodeCollectionViewTestCase: FBSnapshotTestCase {
    
    var viewModel: SpyRMEpisodeCollectionViewModel!
    var sut: RMEpisodeCollectionView<SpyRMEpisodeCollectionViewModel>!
    
    override func setUp() {
        super.setUp()
        viewModel = SpyRMEpisodeCollectionViewModel()
        sut = RMEpisodeCollectionView(viewModel: viewModel)
    }
    
    override func tearDown() {
        sut = nil
        viewModel = nil
        super.tearDown()
    }
    
    func test_whenInitialized_shouldReturnExpectedView() {
        let vc: UIHostingController<RMEpisodeCollectionView<SpyRMEpisodeCollectionViewModel>?> = UIHostingController(rootView: sut)
        vc.makeWindow()
        FBSnapshotVerifyViewController(vc)
    }
    
    func test_whenInitializedWithoutCharacters_shouldReturnExpectedView() {
        let vc: UIHostingController<RMEpisodeCollectionView<SpyRMEpisodeCollectionViewModel>?> = UIHostingController(rootView: sut)
        viewModel.episodeCollection.removeAll()
        viewModel.episodeCount = 10
        viewModel.loadingMaximumEpisodeCount = 14
        viewModel.characterCount = 60
        viewModel.loadingMaximumCharacterCount = 100
        viewModel.imageCount = 59
        viewModel.loadingMaximumImageCount = 100
        viewModel.episodePercentage = "\(Int((Double(viewModel.episodeCount) / Double(viewModel.loadingMaximumEpisodeCount) * 100.0).rounded(.up)))%"
        viewModel.characterPercentage = "\(Int((Double(viewModel.characterCount) / Double(viewModel.loadingMaximumCharacterCount) * 100.0).rounded(.up)))%"
        viewModel.imagePercentage = "\(Int((Double(viewModel.imageCount) / Double(viewModel.loadingMaximumImageCount) * 100.0).rounded(.up)))%"
        vc.makeWindow()
        FBSnapshotVerifyViewController(vc)
    }
    
}
