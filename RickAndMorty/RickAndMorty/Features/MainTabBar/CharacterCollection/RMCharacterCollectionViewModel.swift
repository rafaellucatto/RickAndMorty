//
//  RMCharacterCollectionViewModel.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 6/10/23.
//

import Foundation
import UIKit

protocol RMCharacterCollectionViewModelDelegate: AnyObject {
    func reloadCollection()
    func startLoading()
    func stopLoading()
    func showCoverScreen()
    func hideCoverScreen()
    func setUserInteraction(to bool: Bool)
}

protocol RMCharacterCollectionViewModelProtocol: NavigationBarViewModel, UICollectionViewDataSource, UICollectionViewDelegate {
    var delegate: RMCharacterCollectionViewModelDelegate?  { get set }
    var characters: [RMCharacterResultsJson] { get }
    var requestManager: RMRequestManagerProtocol { get }

    func getCharacters(with url: String?)
}

final class RMCharacterCollectionViewModel: NavigationBarViewModel, RMCharacterCollectionViewModelProtocol {

    weak var delegate: RMCharacterCollectionViewModelDelegate?

    var characters: [RMCharacterResultsJson] = []

    let requestManager: RMRequestManagerProtocol
    let animationHandler: RMAnimationHandlerProtocol

    init(requestManager: RMRequestManagerProtocol = RMRequestManager.shared,
         animationHandler: RMAnimationHandlerProtocol = RMAnimationHandler()) {
        self.requestManager = requestManager
        self.animationHandler = animationHandler
        super.init(searchType: .character)
        super.getModel = { [weak self] in
            self?.getCharacters(with: $0)
        }
    }

    func getCharacters(with url: String?) {
        let url: String = (url?.isEmpty ?? true) ? ("\(SearchType.character.rawValue)1") : (url ?? "")
        delegate?.setUserInteraction(to: false)
        animationHandler.animate { [weak self] in
            self?.delegate?.showCoverScreen()
        } completionHandler: { [weak self] in
            self?.delegate?.startLoading()
            self?.requestManager.request(url: url, httpMethod: .get, object: RMCharacterEndpointJson.self) { [weak self] result in
                switch result {
                case .success(let charJson):
                    self?.handleChar(charJson: charJson)
                case .failure(let error):
                    print("Error from \(#function): " + error.localizedDescription)
                }
            }
        }
    }

    private func handleChar(charJson: RMCharacterEndpointJson) {
        var charJson: RMCharacterEndpointJson = charJson
        let dispatchGroup: DispatchGroup = DispatchGroup()
        for n in 0..<charJson.results.count {
            dispatchGroup.enter()
            requestManager.request(url: charJson.results[n].image, httpMethod: .get) { result in
                defer { dispatchGroup.leave() }
                switch result {
                case .success(let data):
                    charJson.results[n].charImageData = data
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self else { return }
            self.characters.removeAll()
            self.controlNavBarPage(totalOfPages: charJson.info.pages,
                                    nextPageURL: charJson.info.next,
                                    previousPageURL: charJson.info.prev)
            self.characters.append(contentsOf: charJson.results)
            self.delegate?.reloadCollection()
            self.setNavBarLeftSideTitle()
            self.delegate?.stopLoading()
            self.animationHandler.animate {
                self.delegate?.hideCoverScreen()
            } completionHandler: {
                self.delegate?.setUserInteraction(to: true)
            }
        }
    }
}

extension RMCharacterCollectionViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: RMCharacterCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionCell.identifier, for: indexPath) as? RMCharacterCollectionCell else { return UICollectionViewCell() }
        let imageData: Data? = characters[indexPath.row].charImageData
        let viewModel: RMCharacterCollectionCellViewModel = RMCharacterCollectionCellViewModel(imageData: imageData)
        cell.configure(with: viewModel)
        return cell
    }
}

extension RMCharacterCollectionViewModel: UICollectionViewDelegate {
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
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self: RMCharacterCollectionViewModel = self else { return }
            var character: RMCharacterResultsJson = self.characters[indexPath.row]
            character.episode.removeAll()
            episodeNames.sort { return $0 < $1 }
            character.episode.append(contentsOf: episodeNames)
            let viewModel: RMCharacterCollectionDetailViewModelProtocol = RMCharacterCollectionDetailViewModel(character: character) {
                self.delegate?.setUserInteraction(to: true)
            }
            let detailView: RMCharacterCollectionDetailView = RMCharacterCollectionDetailView(viewModel: viewModel)
            let vc: RMCharacterCollectionDetailViewController = RMCharacterCollectionDetailViewController(characterCollectionDetailView: detailView)
            self.delegate?.stopLoading()
            self.controller?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
