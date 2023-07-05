//
//  EpisodeCharacterCollectionViewModel.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 6/25/23.
//

import Foundation
import UIKit

protocol RMEpisodeCharacterCollectionViewModelDelegate: AnyObject {
    func reloadCollection()
    func startLoading()
    func stopLoading()
    func showCoverScreen()
    func hideCoverScreen()
    func setUserInteraction(to bool: Bool)
}

protocol RMEpisodeCharacterCollectionViewModelProtocol: NavigationBarViewModel, UICollectionViewDataSource, UICollectionViewDelegate {
    var gotFirstTimeData: Bool { get }
    var episodeCollection: RMEpisodeMainResponse? { get }
    var delegate: RMEpisodeCharacterCollectionViewModelDelegate? { get set }
    var requestManager: RMRequestManagerProtocol { get }

    func fetchEpisodeList(with url: String?)
}

final class RMEpisodeCharacterCollectionViewModel: NavigationBarViewModel, RMEpisodeCharacterCollectionViewModelProtocol {

    var gotFirstTimeData: Bool = false
    var episodeCollection: RMEpisodeMainResponse?

    weak var delegate: RMEpisodeCharacterCollectionViewModelDelegate?

    let requestManager: RMRequestManagerProtocol
    let animationHandler: RMAnimationHandlerProtocol
    let dispatchQueue: RMDispatchQueueHandlerProtocol

    init(requestManager: RMRequestManagerProtocol = RMRequestManager.shared,
         animationHandler: RMAnimationHandlerProtocol = RMAnimationHandler(),
         dispatchQueue: RMDispatchQueueHandlerProtocol = RMDispatchQueueHandler.handler) {
        self.requestManager = requestManager
        self.animationHandler = animationHandler
        self.dispatchQueue = dispatchQueue
        super.init(searchType: .episode)
        super.getModel = { [weak self] in
            self?.fetchEpisodeList(with: $0)
        }
        fetchEpisodeList(with: nil)
    }

    func fetchEpisodeList(with url: String?) {
        let url: String = (url?.isEmpty ?? true) ? ("\(SearchType.episode.rawValue)1") : (url ?? "")
        delegate?.setUserInteraction(to: false)
        animationHandler.animate { [weak self] in
            self?.delegate?.showCoverScreen()
        } completionHandler: { [weak self] in
            self?.delegate?.startLoading()
            self?.requestManager.request(url: url, httpMethod: .get, object: RMEpisodeMainResponse.self) { result in
                switch result {
                case .success(var episodeCollectionResponse):
                    let group: DispatchGroup = DispatchGroup()
                    for n in 0..<episodeCollectionResponse.results.count {
                        group.enter()
                        let charUrls: [String] = episodeCollectionResponse.results[n].characters
                        self?.getListOfCharacters(with: charUrls) { characterResultsJsonList in
                            defer { group.leave() }
                            episodeCollectionResponse.results[n].listOfCharacters.append(contentsOf: characterResultsJsonList)
                        }
                    }
                    group.notify(queue: .global(qos: .default)) {
                        self?.dispatchQueue.activate(queueType: .main, qualityOfService: nil) {
                            self?.episodeCollection = nil
                            self?.episodeCollection = episodeCollectionResponse
                            self?.controlNavBarPage(totalOfPages: episodeCollectionResponse.info.pages,
                                                    nextPageURL: episodeCollectionResponse.info.next,
                                                    previousPageURL: episodeCollectionResponse.info.prev)
                            self?.delegate?.stopLoading()
                            self?.delegate?.reloadCollection()
                            self?.setNavBarLeftSideTitle()
                            self?.animationHandler.animate {
                                self?.delegate?.hideCoverScreen()
                            } completionHandler: {
                                self?.delegate?.setUserInteraction(to: true)
                            }
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }

    private func getListOfCharacters(with charUrls: [String], completionHandler: @escaping ([RMCharacterResultsJson]) -> Void) {
        let dispatchGroup: DispatchGroup = DispatchGroup()
        var characterList: [RMCharacterResultsJson] = []
        for url in charUrls {
            dispatchGroup.enter()
            requestManager.request(url: url, httpMethod: .get, object: RMCharacterResultsJson.self) { [weak self] result in
                switch result {
                case .success(var char):
                    self?.requestManager.request(url: char.image, httpMethod: .get) { result in
                        defer { dispatchGroup.leave() }
                        switch result {
                        case .success(let data):
                            char.charImageData = data
                            characterList.append(char)
                        case .failure(let error):
                            print("Unable to get image data from request: " + error.localizedDescription)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        dispatchGroup.notify(queue: .global()) {
            characterList.sort { return $0.id < $1.id }
            completionHandler(characterList)
        }
    }

    private func getEpisodes(for char: RMCharacterResultsJson, completionHandler: @escaping ([String]) -> Void) {
        let group: DispatchGroup = DispatchGroup()
        var episodeNames: [String] = []
        for episodeUrl in char.episode {
            group.enter()
            requestManager.request(url: episodeUrl, httpMethod: .get, object: RMEpisodeResults.self) { result in
                switch result {
                case .success(let episode):
                    defer { group.leave() }
                    episodeNames.append("\(episode.episode)-\(episode.name)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        group.notify(queue: .global()) {
            completionHandler(episodeNames)
        }
    }
}

extension RMEpisodeCharacterCollectionViewModel: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return episodeCollection?.results.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return episodeCollection?.results[section].listOfCharacters.count ?? 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: EpisodeCharacterCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodeCharacterCollectionCell.identifier,
                                                                                            for: indexPath) as? EpisodeCharacterCollectionCell else {
            return UICollectionViewCell()
        }
        cell.imageView.image = UIImage(data: episodeCollection?.results[indexPath.section].listOfCharacters[indexPath.row].charImageData ?? Data())
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let cell: EpisodeCollectionSectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                                             withReuseIdentifier: EpisodeCollectionSectionHeader.identifier,
                                                                                                             for: indexPath) as? EpisodeCollectionSectionHeader else {
                return UICollectionReusableView()
            }
            let episode: String = episodeCollection?.results[indexPath.section].episode ?? ""
            let episodeName: String = episodeCollection?.results[indexPath.section].name ?? ""
            cell.configure(with: "\(episode) - \(episodeName)")
            return cell
        }
        return UICollectionReusableView()
    }
}

extension RMEpisodeCharacterCollectionViewModel: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.setUserInteraction(to: false)
        guard let char: RMCharacterResultsJson = episodeCollection?.results[indexPath.section].listOfCharacters[indexPath.row] else { return }
        getEpisodes(for: char) { [weak self] titles in
            var titles: [String] = titles
            self?.dispatchQueue.activate(queueType: .main, qualityOfService: nil) {
                if var char = self?.episodeCollection?.results[indexPath.section].listOfCharacters[indexPath.row] {
                    char.episode.removeAll()
                    titles.sort { return $0 < $1 }
                    char.episode.append(contentsOf: titles)
                    let viewModel: RMCharacterCollectionDetailViewModelProtocol = RMCharacterCollectionDetailViewModel(character: char) {
                        self?.delegate?.setUserInteraction(to: true)
                    }
                    let detailView: RMCharacterCollectionDetailView = RMCharacterCollectionDetailView(viewModel: viewModel)
                    let vc: RMCharacterCollectionDetailViewController = RMCharacterCollectionDetailViewController(characterCollectionDetailView: detailView)
                    self?.controller?.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
}
