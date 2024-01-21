//
//  RMLocationCollectionTitleCellTestCase.swift
//  RickNMortyTests
//
//  Created by Rafael Lucatto on 1/12/24.
//

import Foundation
import iOSSnapshotTestCase

@testable import RickNMorty

final class RMLocationCollectionTitleCellTestCase: FBSnapshotTestCase {
    
    var sut: RMLocationCollectionTitleCell!
    
    override func setUp() {
        super.setUp()
        sut = .init(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_whenInitialized_shouldReturnExpectedLayout() {
        sut.configure(with: "locationTest")
        FBSnapshotVerifyView(sut)
    }
    
}
