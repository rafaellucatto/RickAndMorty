//
//  RMLocationViewController.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 6/27/23.
//

import Foundation
import UIKit

final class RMLocationViewController: UIViewController {
    
    private let locationView: RMLocationView
    
    init(locationView: RMLocationView) {
        self.locationView = locationView
        super.init(nibName: nil, bundle: nil)
        self.locationView.viewModel.controller = self
        title = K.Title.locations
    }
    
    @available(*, unavailable) required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func loadView() {
        view = locationView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationView.viewModel.shouldFirstFetchLocation()
    }
    
}
