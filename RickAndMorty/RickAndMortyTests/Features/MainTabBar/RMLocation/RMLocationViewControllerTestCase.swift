//
//  RMLocationViewControllerTestCase.swift
//  RickAndMortyTests
//
//  Created by Rafael Lucatto on 7/4/23.
//

import Foundation
import iOSSnapshotTestCase

@testable import RickAndMorty

final class RMLocationViewControllerTestCase: FBSnapshotTestCase {

    var requestManager: MockRMRequestManager!
    var viewModel: MockRMLocationViewModel!
    var locationView: RMLocationView!
    var sut: RMLocationViewController!

    override func setUp() {
        super.setUp()
        requestManager = MockRMRequestManager()
        viewModel = MockRMLocationViewModel(requestManager: requestManager)
        locationView = RMLocationView(viewModel: viewModel)
    }

    override func tearDown() {
        sut = nil
        locationView = nil
        viewModel = nil
        requestManager = nil
        super.tearDown()
    }

    func test_RMLocationViewControllerTestCase_whenInitialized_shouldReturnExpectedLayout() {
        sut = RMLocationViewController(locationView: locationView)
        sut.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        sut.overrideUserInterfaceStyle = .light
        viewModel.fetchLocation(with: nil)
        FBSnapshotVerifyViewController(sut)
    }

    func test_RMLocationViewControllerTestCase_whenInitializedInDarkMode_shouldReturnExpectedLayout() {
        sut = RMLocationViewController(locationView: locationView)
        sut.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        sut.overrideUserInterfaceStyle = .dark
        viewModel.fetchLocation(with: nil)
        FBSnapshotVerifyViewController(sut)
    }
}
