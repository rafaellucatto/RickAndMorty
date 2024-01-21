//
//  RMCharacterCollectionViewControllerTestCase.swift
//  RickNMortyTests
//
//  Created by Rafael Lucatto on 1/13/24.
//

import Foundation
import iOSSnapshotTestCase

@testable import RickNMorty

final class RMCharacterCollectionViewControllerTestCase: FBSnapshotTestCase {
    
    var viewModel: RMCharacterCollectionViewModel!
    var view: RMCharacterCollectionView!
    var sut: RMCharacterCollectionViewController!
    
    override func setUp() {
        super.setUp()
        viewModel = .init(api: MockRMCharacterCollectionViewModelAPI())
        view = .init(viewModel: viewModel)
        sut = .init(characterCollectionView: view)
    }
    
    override func tearDown() {
        sut = nil
        view = nil
        viewModel = nil
        super.tearDown()
    }
    
    func test_whenInitialized_shouldReturnExpectedLayout() {
        view.frame = UIScreen.main.bounds
        UIWindow.makeWindowForModalPresentation(with: sut)
        FBSnapshotVerifyViewController(sut)
    }
    
}
