//
//  RMEpisodeCharacterCollectionCoordinator.swift
//  RickNMorty
//
//  Created by Rafael Lucatto on 12/9/23.
//

import Foundation
import Hero
import UIKit

final class RMEpisodeCharacterCollectionCoordinator: RMBaseCoordinator {
    
    var viewController: UIViewController?
    
    func start() {
        let viewModel: RMEpisodeCharacterCollectionViewModelProtocol = RMEpisodeCharacterCollectionViewModel()
        let view: RMEpisodeCharacterCollectionView = .init(viewModel: viewModel)
        let vc: RMEpisodeCharacterCollectionViewController = .init(episodeView: view)
        self.viewController = UINavigationController(rootViewController: vc)
        viewModel.screenDelegate = self
        self.viewController?.isHeroEnabled = true
    }
    
}

extension RMEpisodeCharacterCollectionCoordinator: RMCharacterDetailScreenDelegate {
    
    func didTapCharacter(character: RMCharacterResultsJson) {
        let viewModel: RMCharacterCollectionDetailViewModelProtocol = RMCharacterCollectionDetailViewModel(character: character)
        viewModel.screenDelegate = self
        let detailView: RMCharacterCollectionDetailView = .init(viewModel: viewModel)
        let vc: RMCharacterCollectionDetailViewController = .init(characterCollectionDetailView: detailView)
        self.viewController?.pushVC(vc, animated: true)
    }
    
}

extension RMEpisodeCharacterCollectionCoordinator: RMCharacterCollectionDetailViewModelScreenDelegate {
    
    func didTapCharacterInfo(cellModel: RMCellInfoDisplayViewModel.RMCellModel) {
        let viewModel: RMCellInfoDisplayViewModelProtocol = RMCellInfoDisplayViewModel(cellModel: cellModel)
        let infoDisplayView: RMCellInfoDisplayView = .init(viewModel: viewModel)
        let infoDisplayController: RMCellInfoDisplayViewController = .init(cellInfoDisplayView: infoDisplayView)
        infoDisplayController.modalPresentationStyle = .overFullScreen
        self.viewController?.present(infoDisplayController, animated: false)
    }
    
}
