//
//  RMSettingsViewController.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 6/29/23.
//

import Foundation
import UIKit

final class RMSettingsViewController: UIViewController {

    private let settingsView: RMSettingsView

    init(settingsView: RMSettingsView) {
        self.settingsView = settingsView
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable) required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func loadView() {
        view = settingsView
    }
}
