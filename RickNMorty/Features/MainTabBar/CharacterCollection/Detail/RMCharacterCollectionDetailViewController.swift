//
//  RMCharacterCollectionDetailViewController.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 6/13/23.
//

import Foundation
import UIKit

final class RMCharacterCollectionDetailViewController: UIViewController {

    let characterCollectionDetailView: RMCharacterCollectionDetailView

    init(characterCollectionDetailView: RMCharacterCollectionDetailView) {
        self.characterCollectionDetailView = characterCollectionDetailView
        super.init(nibName: nil, bundle: nil)
        title = self.characterCollectionDetailView.viewModel.controllerTitle
    }

    @available(*, unavailable) required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func loadView() {
        view = characterCollectionDetailView
    }

}
