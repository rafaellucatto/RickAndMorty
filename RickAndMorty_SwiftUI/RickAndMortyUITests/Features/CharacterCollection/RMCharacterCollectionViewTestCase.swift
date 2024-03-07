//
//  RMCharacterCollectionViewTestCase.swift
//  RickAndMortyUITests
//
//  Created by Rafael Lucatto on 2/25/24.
//

import Foundation
import iOSSnapshotTestCase
import SwiftUI

@testable import RickAndMortyUI

final class RMCharacterCollectionViewTestCase: FBSnapshotTestCase {
    
    var viewModel: SpyRMCharacterCollectionViewModel!
    var sut: RMCharacterCollectionView<SpyRMCharacterCollectionViewModel>!
    
    override func setUp() {
        super.setUp()
        viewModel = .init()
        sut = .init(viewModel: viewModel)
    }
    
    override func tearDown() {
        sut = nil
        viewModel = nil
        super.tearDown()
    }
    
    func test_whenInitialized_shouldReturnExpectedView() {
        let vc = UIHostingController(rootView: sut)
        vc.makeWindow()
        FBSnapshotVerifyViewController(vc)
    }
    
}
