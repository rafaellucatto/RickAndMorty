//
//  EpisodeCharacterCollectionViewController.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 6/25/23.
//

import Foundation
import UIKit

final class RMEpisodeCharacterCollectionViewController: UIViewController {

    let episodeView: RMEpisodeCharacterCollectionView

    init(episodeView: RMEpisodeCharacterCollectionView) {
        self.episodeView = episodeView
        super.init(nibName: nil, bundle: nil)
        self.episodeView.viewModel.controller = self
        title = "Episodes"
    }

    @available(*, unavailable) required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func loadView() {
        view = episodeView
    }
}
