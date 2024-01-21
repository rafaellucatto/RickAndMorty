//
//  RMCellInfoDisplayViewController.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 6/19/23.
//

import Foundation
import UIKit

final class RMCellInfoDisplayViewController: UIViewController {

    let cellInfoDisplayView: RMCellInfoDisplayView

    init(cellInfoDisplayView: RMCellInfoDisplayView) {
        self.cellInfoDisplayView = cellInfoDisplayView
        super.init(nibName: nil, bundle: nil)
        self.cellInfoDisplayView.viewModel.controller = self
    }

    @available(*, unavailable) required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func loadView() {
        view = cellInfoDisplayView
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        cellInfoDisplayView.viewModel.presentView()
    }
}
