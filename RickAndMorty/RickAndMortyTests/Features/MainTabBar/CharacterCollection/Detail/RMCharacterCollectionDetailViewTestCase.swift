//
//  RMCharacterCollectionDetailViewTestCase.swift
//  RickAndMortyTests
//
//  Created by Rafael Lucatto on 7/2/23.
//

import Foundation
import iOSSnapshotTestCase

@testable import RickAndMorty

final class RMCharacterCollectionDetailViewTestCase: FBSnapshotTestCase {

    var viewModel: RMCharacterCollectionDetailViewModel!
    var sut: RMCharacterCollectionDetailView!

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        sut = nil
        viewModel = nil
        super.tearDown()
    }

    func test_RMCharacterCollectionDetailView_whenInitializedWith3Episodes_shouldReturnExpectedLayout() {
        viewModel = RMCharacterCollectionDetailViewModel(character: .stub(), onDismiss: nil)
        sut = RMCharacterCollectionDetailView(viewModel: viewModel)
        sut.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 930)
        FBSnapshotVerifyView(sut)
    }

    func test_RMCharacterCollectionDetailView_whenInitializedWith2Episodes_shouldReturnExpectedLayout() {
        viewModel = RMCharacterCollectionDetailViewModel(character: .stub(episode: ["Test2.1", "Test2.2"]), onDismiss: nil)
        sut = RMCharacterCollectionDetailView(viewModel: viewModel)
        sut.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 930)
        FBSnapshotVerifyView(sut)
    }

    func test_RMCharacterCollectionDetailView_whenInitializedWith1Episode_shouldReturnExpectedLayout() {
        viewModel = RMCharacterCollectionDetailViewModel(character: .stub(episode: ["Test1"]), onDismiss: nil)
        sut = RMCharacterCollectionDetailView(viewModel: viewModel)
        sut.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 930)
        sut.window?.rootViewController?.overrideUserInterfaceStyle = .dark
        FBSnapshotVerifyView(sut)
    }
}
