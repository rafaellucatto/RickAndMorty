//
//  RMCharacterCollectionCoordinator.swift
//  RickNMorty
//
//  Created by Rafael Lucatto on 12/5/23.
//

import Hero
import Foundation
import UIKit

final class RMCharacterCollectionCoordinator: RMBaseCoordinator {

    var viewController: UIViewController?

    func start() {
        let viewModel: RMCharacterCollectionViewModelProtocol = RMCharacterCollectionViewModel()
        let view: RMCharacterCollectionView = .init(viewModel: viewModel)
        let vc: RMCharacterCollectionViewController = .init(characterCollectionView: view)
        self.viewController = UINavigationController(rootViewController: vc)
        viewModel.screenDelegate = self
        self.viewController?.isHeroEnabled = true
    }
    
}

extension RMCharacterCollectionCoordinator: RMCharacterDetailScreenDelegate {
    
    func didTapCharacter(character: RMCharacterResultsJson) {
        let viewModel: RMCharacterCollectionDetailViewModelProtocol = RMCharacterCollectionDetailViewModel(character: character)
        viewModel.screenDelegate = self
        let detailView: RMCharacterCollectionDetailView = .init(viewModel: viewModel)
        let vc: RMCharacterCollectionDetailViewController = .init(characterCollectionDetailView: detailView)
        self.viewController?.pushVC(vc, animated: true)
    }
    
}

extension RMCharacterCollectionCoordinator: RMCharacterCollectionDetailViewModelScreenDelegate {
    
    func didTapCharacterInfo(cellModel: RMCellInfoDisplayViewModel.RMCellModel) {
        let viewModel: RMCellInfoDisplayViewModelProtocol = RMCellInfoDisplayViewModel(cellModel: cellModel)
        let infoDisplayView: RMCellInfoDisplayView = .init(viewModel: viewModel)
        let infoDisplayController: RMCellInfoDisplayViewController = .init(cellInfoDisplayView: infoDisplayView)
        infoDisplayController.modalPresentationStyle = .overFullScreen
        self.viewController?.present(infoDisplayController, animated: false)
    }
    
}
