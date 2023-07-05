//
//  RMCharacterCollectionDetailViewControllerTestCase.swift
//  RickAndMortyTests
//
//  Created by Rafael Lucatto on 7/2/23.
//

import Foundation
import iOSSnapshotTestCase

@testable import RickAndMorty

final class RMCharacterCollectionDetailViewControllerTestCase: FBSnapshotTestCase {

    var sut: RMCharacterCollectionDetailViewController!

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_RMCharacterCollectionDetailViewController_whenInitializedWith3Episodes_shouldReturnExpectedLayout() {
        let viewModel: RMCharacterCollectionDetailViewModelProtocol = RMCharacterCollectionDetailViewModel(character: .stub(), onDismiss: nil)
        let view: RMCharacterCollectionDetailView = RMCharacterCollectionDetailView(viewModel: viewModel)
        sut = RMCharacterCollectionDetailViewController.init(characterCollectionDetailView: view)
        sut.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1000)
        sut.overrideUserInterfaceStyle = .light
        FBSnapshotVerifyViewController(sut)
    }

    func test_RMCharacterCollectionDetailViewController_whenInitializedWith3EpisodesInDarkMode_shouldReturnExpectedLayout() {
        let viewModel: RMCharacterCollectionDetailViewModelProtocol = RMCharacterCollectionDetailViewModel(character: .stub(), onDismiss: nil)
        let view: RMCharacterCollectionDetailView = RMCharacterCollectionDetailView(viewModel: viewModel)
        sut = RMCharacterCollectionDetailViewController.init(characterCollectionDetailView: view)
        sut.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1000)
        sut.overrideUserInterfaceStyle = .dark
        FBSnapshotVerifyViewController(sut)
    }

    func test_RMCharacterCollectionDetailViewController_whenInitializedWith1Episode_shouldReturnExpectedLayout() {
        let viewModel: RMCharacterCollectionDetailViewModelProtocol = RMCharacterCollectionDetailViewModel(character: .stub(episode: [""]), onDismiss: nil)
        let view: RMCharacterCollectionDetailView = RMCharacterCollectionDetailView(viewModel: viewModel)
        sut = RMCharacterCollectionDetailViewController.init(characterCollectionDetailView: view)
        sut.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1000)
        sut.overrideUserInterfaceStyle = .light
        FBSnapshotVerifyViewController(sut)
    }

    func test_RMCharacterCollectionDetailViewController_whenInitializedWith1EpisodeInDarkMode_shouldReturnExpectedLayout() {
        let viewModel: RMCharacterCollectionDetailViewModelProtocol = RMCharacterCollectionDetailViewModel(character: .stub(episode: [""]), onDismiss: nil)
        let view: RMCharacterCollectionDetailView = RMCharacterCollectionDetailView(viewModel: viewModel)
        sut = RMCharacterCollectionDetailViewController.init(characterCollectionDetailView: view)
        sut.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1000)
        sut.overrideUserInterfaceStyle = .dark
        FBSnapshotVerifyViewController(sut)
    }
}
