//
//  RMLocationCollectionViewTestCase.swift
//  RickAndMortyUITests
//
//  Created by Rafael Lucatto on 2/25/24.
//

import Foundation
import iOSSnapshotTestCase
import SwiftUI

@testable import RickAndMortyUI

final class RMLocationCollectionViewTestCase: FBSnapshotTestCase {
    
    var viewModel: SpyRMLocationCollectionViewModel!
    var sut: RMLocationCollectionView<SpyRMLocationCollectionViewModel>!
    
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
    
    func test_whenInitialized_shouldReturnExpectedLayout() {
        let vc: UIHostingController<RMLocationCollectionView<SpyRMLocationCollectionViewModel>?> = UIHostingController(rootView: sut)
        vc.makeWindow()
        FBSnapshotVerifyViewController(vc)
    }
    
}
