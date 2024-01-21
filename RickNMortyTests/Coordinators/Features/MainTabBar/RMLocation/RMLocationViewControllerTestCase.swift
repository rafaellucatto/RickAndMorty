//
//  RMLocationViewControllerTestCase.swift
//  RickNMortyTests
//
//  Created by Rafael Lucatto on 1/13/24.
//

import Foundation
import iOSSnapshotTestCase

@testable import RickNMorty

final class RMLocationViewControllerTestCase: FBSnapshotTestCase {
    
    var viewModel: RMLocationViewModel!
    var view: RMLocationView!
    var sut: RMLocationViewController!
    
    override func setUp() {
        super.setUp()
        viewModel = .init(api: MockRMLocationViewModelAPI())
        view = .init(viewModel: viewModel)
        sut = .init(locationView: view)
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
