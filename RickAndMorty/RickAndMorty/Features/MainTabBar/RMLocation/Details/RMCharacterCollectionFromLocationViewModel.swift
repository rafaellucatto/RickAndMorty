//
//  RMCharacterCollectionFromLocationViewModel.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 6/28/23.
//

import Foundation
import UIKit

protocol RMCharacterCollectionFromLocationViewModelDelegate: AnyObject {
    func reloadCollection()
    func startLoading()
    func stopLoading()
    func setUserInteraction(to bool: Bool)
}

final class RMCharacterCollectionFromLocationViewModel: NSObject {

    weak var controller: UIViewController?
    weak var delegate: RMCharacterCollectionFromLocationViewModelDelegate?

    var characters: [RMCharacterResultsJson]

    let requestManager: RMRequestManagerProtocol

    init(characters: [RMCharacterResultsJson], requestManager: RMRequestManagerProtocol = RMRequestManager.shared) {
        self.characters = characters
        self.requestManager = requestManager
        super.init()
    }

    private func handleMainQueueEvent(episodeNames: [String], row: Int) {
        var episodeNames: [String] = episodeNames
        var character: RMCharacterResultsJson = self.characters[row]
        character.episode.removeAll()
        episodeNames.sort { return $0 < $1 }
        character.episode.append(contentsOf: episodeNames)
        let viewModel: RMCharacterCollectionDetailViewModelProtocol = RMCharacterCollectionDetailViewModel(character: character) {
            self.delegate?.setUserInteraction(to: true)
            self.delegate?.stopLoading()
        }
        let detailView: RMCharacterCollectionDetailView = RMCharacterCollectionDetailView(viewModel: viewModel)
        let vc: RMCharacterCollectionDetailViewController = RMCharacterCollectionDetailViewController(characterCollectionDetailView: detailView)
        self.delegate?.stopLoading()
        self.controller?.navigationController?.pushViewController(vc, animated: true)
    }
}

extension RMCharacterCollectionFromLocationViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: RMCharacterCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionCell.identifier, for: indexPath) as? RMCharacterCollectionCell else {
            return UICollectionViewCell()
        }
        let imageData: Data? = characters[indexPath.row].charImageData
        let viewModel: RMCharacterCollectionCellViewModel = RMCharacterCollectionCellViewModel(imageData: imageData)
        cell.configure(with: viewModel)
        return cell
    }
}

extension RMCharacterCollectionFromLocationViewModel: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.setUserInteraction(to: false)
        let dispatchGroup: DispatchGroup = DispatchGroup()
        var episodeNames: [String] = []
        delegate?.startLoading()
        for url in characters[indexPath.row].episode {
            dispatchGroup.enter()
            requestManager.request(url: url, httpMethod: .get, object: RMEpisodeResults.self) { result in
                defer { dispatchGroup.leave() }
                switch result {
                case .success(let episode):
                    episodeNames.append("\(episode.episode)-\(episode.name)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.handleMainQueueEvent(episodeNames: episodeNames, row: indexPath.row)
        }
    }
}
