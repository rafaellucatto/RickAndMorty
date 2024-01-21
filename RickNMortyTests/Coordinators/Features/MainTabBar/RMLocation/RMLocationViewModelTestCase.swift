//
//  RMLocationViewModelTestCase.swift
//  RickNMortyTests
//
//  Created by Rafael Lucatto on 1/13/24.
//

import Foundation
import iOSSnapshotTestCase

@testable import RickNMorty

final class RMLocationViewModelTestCase: FBSnapshotTestCase {
    
    var coordinator: SpyRMLocationViewModelScreenDelegate!
    var sut: RMLocationViewModel!
    
    override func setUp() {
        super.setUp()
        coordinator = .init()
        sut = .init(api: MockRMLocationViewModelAPI())
        sut.screenDelegate = coordinator
    }
    
    override func tearDown() {
        sut = nil
        coordinator = nil
        super.tearDown()
    }
    
    func test_() {
        sut.locationResult = [.stub(residents: ["", ""]), .stub()]
        sut.collectionView(UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()),
                           didSelectItemAt: IndexPath(row: 4, section: 0))
        XCTAssertEqual(coordinator.didTapResidentsGotCalled, true)
    }
    
}
