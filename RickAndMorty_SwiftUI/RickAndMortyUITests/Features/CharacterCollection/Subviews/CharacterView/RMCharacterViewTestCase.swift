//
//  RMCharacterViewTestCase.swift
//  RickAndMortyUITests
//
//  Created by Rafael Lucatto on 2/26/24.
//

import Foundation
import iOSSnapshotTestCase
import SwiftUI

@testable import RickAndMortyUI

final class RMCharacterViewTestCase: FBSnapshotTestCase {
    
    var coordinatorType: RMCoordinatorType!
    var viewModel: SpyRMCharacterViewModel!
    var sut: RMCharacterView<SpyRMCharacterViewModel>!
    
    override func setUp() {
        super.setUp()
        coordinatorType = .character
        viewModel = SpyRMCharacterViewModel()
        sut = RMCharacterView(coordinator: coordinatorType, viewModel: viewModel)
    }
    
    override func tearDown() {
        sut = nil
        viewModel = nil
        coordinatorType = nil
        super.tearDown()
    }
    
    func test_whenInitialized_shouldReturnExpectedLayout() {
        let vc = UIHostingController(rootView: sut)
        vc.makeWindow()
        let view: UIView = vc.view
        view.frame = CGRect(x: 0, y: -1, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 1.2)
        FBSnapshotVerifyView(view)
    }
    
}
