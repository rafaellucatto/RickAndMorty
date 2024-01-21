//
//  RMCharacterCollectionFromLocationViewController.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 6/28/23.
//

import Foundation
import UIKit

final class RMCharacterCollectionFromLocationViewController: UIViewController {

    private let characterCollectionView: RMCharacterCollectionFromLocationView

    init(characterCollectionView: RMCharacterCollectionFromLocationView) {
        self.characterCollectionView = characterCollectionView
        super.init(nibName: nil, bundle: nil)
        self.characterCollectionView.viewModel.controller = self
    }

    @available(*, unavailable) required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func loadView() {
        view = characterCollectionView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        characterCollectionView.viewModel.deleteHeroIdOfCells(from: characterCollectionView.characterCollection)
    }
    
}
