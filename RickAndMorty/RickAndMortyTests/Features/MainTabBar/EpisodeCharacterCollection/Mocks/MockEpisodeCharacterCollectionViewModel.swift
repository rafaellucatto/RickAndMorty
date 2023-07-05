//
//  MockEpisodeCharacterCollectionViewModel.swift
//  RickAndMortyTests
//
//  Created by Rafael Lucatto on 7/4/23.
//

import Foundation
import UIKit

@testable import RickAndMorty

final class MockRMEpisodeCharacterCollectionViewModel: NavigationBarViewModel, RMEpisodeCharacterCollectionViewModelProtocol {

    let requestManager: RickAndMorty.RMRequestManagerProtocol

    var gotFirstTimeData: Bool = false
    var episodeCollection: RickAndMorty.RMEpisodeMainResponse?

    weak var delegate: RickAndMorty.RMEpisodeCharacterCollectionViewModelDelegate?

    init(requestManager: RickAndMorty.RMRequestManagerProtocol) {
        self.requestManager = requestManager
        super.init(searchType: .episode)
    }

    func fetchEpisodeList(with url: String?) {
        requestManager.request(url: "", httpMethod: .get, object: RickAndMorty.RMEpisodeMainResponse.self) { result in
            switch result {
            case .success(var episodeCollection):
                for n in 0..<episodeCollection.results.count {
                    episodeCollection.results[n].listOfCharacters = Array(repeating: RMCharacterResultsJson.stub(), count: episodeCollection.results[n].characters.count)
                }
                self.episodeCollection = episodeCollection
                self.delegate?.reloadCollection()
                self.delegate?.stopLoading()
                self.delegate?.hideCoverScreen()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
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

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return episodeCollection?.results.count ?? 0
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
