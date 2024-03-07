//
//  RMCharacterPageChoosingViewTestCase.swift
//  RickAndMortyUITests
//
//  Created by Rafael Lucatto on 2/27/24.
//

import Foundation
import iOSSnapshotTestCase
import SwiftUI

@testable import RickAndMortyUI

final class RMCharacterPageChoosingViewTestCase: FBSnapshotTestCase {
    
    var viewModel: SpyRMCharacterCollectionViewModel!
    var sut: RMCharacterPageChoosingView<SpyRMCharacterCollectionViewModel>!
    
    override func setUp() {
        super.setUp()
        viewModel = SpyRMCharacterCollectionViewModel()
        sut = RMCharacterPageChoosingView(viewModel: viewModel)
    }
    
    override func tearDown() {
        sut = nil
        viewModel = nil
        super.tearDown()
    }
    
    func test_whenInitialized_mustReturnExpectedLayout() {
        let vc = UIHostingController(rootView: sut)
        vc.makeWindow()
        vc.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 250)
        FBSnapshotVerifyView(vc.view)
    }
    
}
