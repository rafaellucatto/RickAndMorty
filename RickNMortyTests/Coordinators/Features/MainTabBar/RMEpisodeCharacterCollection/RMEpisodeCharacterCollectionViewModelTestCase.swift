//
//  RMEpisodeCharacterCollectionViewModelTestCase.swift
//  RickNMortyTests
//
//  Created by Rafael Lucatto on 1/13/24.
//

import Foundation
import iOSSnapshotTestCase

@testable import RickNMorty

final class RMEpisodeCharacterCollectionViewModelTestCase: FBSnapshotTestCase {
    
    var coordinator: SpyRMCharacterDetailScreenDelegate!
    var sut: RMEpisodeCharacterCollectionViewModel!
    
    override func setUp() {
        super.setUp()
        coordinator = .init()
        sut = .init(api: MockRMEpisodeCharacterCollectionViewModelAPI())
        sut.episodeCollection = .stub()
        sut.screenDelegate = coordinator
    }
    
    override func tearDown() {
        sut = nil
        coordinator = nil
        super.tearDown()
    }
    
    func test_whenCollectionViewCellIsClicked() {
        sut.collectionView(UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()),
                           didSelectItemAt: IndexPath(item: 0, section: 0))
        XCTAssertEqual(coordinator.didTapDidTapCharacter, true)
    }
    
}
