//
//  RMCharacterCollectionViewController.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 6/10/23.
//

import Foundation
import UIKit

final class RMCharacterCollectionViewController: UIViewController {
    
    let characterCollectionView: RMCharacterCollectionView
    
    init(characterCollectionView: RMCharacterCollectionView) {
        self.characterCollectionView = characterCollectionView
        super.init(nibName: nil, bundle: nil)
        characterCollectionView.viewModel.controller = self
        title = K.Title.characters
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
