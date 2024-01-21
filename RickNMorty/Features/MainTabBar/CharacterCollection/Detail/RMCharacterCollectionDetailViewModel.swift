//
//  RMCharacterCollectionDetailViewModel.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 6/13/23.
//

import Hero
import Foundation
import UIKit

protocol RMCharacterCollectionDetailViewModelDelegate: AnyObject {
    func reloadCollectionView()
}

protocol RMCharacterCollectionDetailViewModelProtocol: UICollectionViewDataSource, UICollectionViewDelegate {
    var character: RMCharacterResultsJson { get }
    var controllerTitle: String { get }
    var screenDelegate: RMCharacterCollectionDetailViewModelScreenDelegate? { get set }
    var delegate: RMCharacterCollectionDetailViewModelDelegate? { get set }
    var hasSingleEpisode: Bool { get }
    var episodeAreaHeight: CGFloat { get }
    var episodeFractionalHeight: CGFloat { get }
    var sections: [RMCharacterCollectionDetailViewModel.DetailSection] { get }
    
    func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection
}

final class RMCharacterCollectionDetailViewModel: NSObject, RMCharacterCollectionDetailViewModelProtocol {

    let character: RMCharacterResultsJson

    let hasSingleEpisode: Bool

    var episodeAreaHeight: CGFloat {
        return hasSingleEpisode ? 65 : 130
    }

    var episodeFractionalHeight: CGFloat {
        return hasSingleEpisode ? 1 : 0.5
    }

    weak var screenDelegate: RMCharacterCollectionDetailViewModelScreenDelegate?
    weak var delegate: RMCharacterCollectionDetailViewModelDelegate?
    weak var controller: UIViewController?

    init(character: RMCharacterResultsJson) {
        self.character = character
        self.hasSingleEpisode = self.character.episode.count == 1
        super.init()
        handleEpisodeCollectionBackground(for: character.episode.count)
    }

    private enum RMInfoCellType: CaseIterable {

        case id, name, species, status, origin, location, created, type, gender

        var rawValue: String {
            switch self {
            case .id:
                return K.CharDetail.Info.id
            case .name:
                return K.CharDetail.Info.name
            case .species:
                return K.CharDetail.Info.species
            case .status:
                return K.CharDetail.Info.status
            case .origin:
                return K.CharDetail.Info.origin
            case .location:
                return K.CharDetail.Info.location
            case .created:
                return K.CharDetail.Info.created
            case .type:
                return K.CharDetail.Info.type
            case .gender:
                return K.CharDetail.Info.gender
            }
        }
        
        func getInfoCell(character: RMCharacterResultsJson) -> RMCharacterInfoCellViewModel {
            return RMCharacterInfoCellViewModel(title: self.rawValue.capitalized, value: getCharacterDetail(character))
        }

        private func getCharacterCreationDate(for date: String) -> String {
            let formatter: ISO8601DateFormatter = .init()
            formatter.formatOptions.insert(.withFractionalSeconds)
            if let date: Date = formatter.date(from: date) {
                let formatter2: DateFormatter = DateFormatter()
                formatter2.locale = Locale(identifier: "en_US")
                formatter2.dateFormat = "MMM/dd/yyyy"
                return formatter2.string(from: date)
            }
            return ""
        }

        private func getCharacterDetail(_ character: RMCharacterResultsJson) -> String {
            switch self {
            case .id:
                return character.id.description
            case .name:
                return character.name
            case .species:
                return character.species
            case .status:
                return character.status
            case .origin:
                return character.origin.name
            case .location:
                return character.location.name
            case .created:
                return getCharacterCreationDate(for: character.created)
            case .type:
                return character.type
            case .gender:
                return character.gender
            }
        }
    }

    var controllerTitle: String { return character.name }

    var sections: [DetailSection] {
        return [
            .characterImage(imageData: character.charImageData ?? Data()),
            .characterInfo(viewModel: handleInfoViewModel(character: character)),
            .characterEpisodes(episodes: character.episode)
        ]
    }

    private func handleInfoViewModel(character: RMCharacterResultsJson) -> [RMCharacterInfoCellViewModel] {
        var infoViewModel: [RMCharacterInfoCellViewModel] = []
        RMInfoCellType.allCases.forEach {
            infoViewModel.append($0.getInfoCell(character: character))
        }
        infoViewModel.removeAll {
            return $0.title.isEmpty || $0.value.isEmpty
        }
        return infoViewModel
    }

    @available(*, unavailable) required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    enum DetailSection {
        case characterImage(imageData: Data)
        case characterInfo(viewModel: [RMCharacterInfoCellViewModel])
        case characterEpisodes(episodes: [String])
    }

    func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        let section: RMCharacterCollectionDetailViewModel.DetailSection = self.sections[sectionIndex]
        switch section {
        case .characterImage:
            return createPhotoSectionLayout()
        case .characterInfo:
            return createInfoSectionLayout()
        case .characterEpisodes:
            return createEpisodeSectionLayout()
        }
    }

    private func createPhotoSectionLayout() -> NSCollectionLayoutSection {
        let item: NSCollectionLayoutItem = .init(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                   heightDimension: .fractionalHeight(1)))
        let group: NSCollectionLayoutGroup = .vertical(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                         heightDimension: .fractionalWidth(1)),
                                                       subitems: [item])
        return .init(group: group)
    }

    private func createInfoSectionLayout() -> NSCollectionLayoutSection {
        let item: NSCollectionLayoutItem = .init(layoutSize: .init(widthDimension: .fractionalWidth(0.5),
                                                                   heightDimension: .fractionalHeight(1)))
        item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        let group: NSCollectionLayoutGroup = .horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                                            heightDimension: .absolute(70)),
                                                         subitems: [item])
        let section: NSCollectionLayoutSection = .init(group: group)
        let header: NSCollectionLayoutBoundarySupplementaryItem = .init(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                                          heightDimension: .absolute(50)),
                                                                        elementKind: UICollectionView.elementKindSectionHeader,
                                                                        alignment: NSRectAlignment.top)
        section.boundarySupplementaryItems = [header]
        section.decorationItems = [NSCollectionLayoutDecorationItem.background(elementKind: RMCharacterDetailBackground.identifier)]
        section.contentInsets = .init(top: 0, leading: 10, bottom: 10, trailing: 10)
        return section
    }

    private func createEpisodeSectionLayout() -> NSCollectionLayoutSection {
        let item: NSCollectionLayoutItem = .init(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                   heightDimension: .fractionalHeight(episodeFractionalHeight)))
        item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        let group: NSCollectionLayoutGroup = .vertical(layoutSize: .init(widthDimension: .fractionalWidth(0.8),
                                                                         heightDimension: .absolute(episodeAreaHeight)),
                                                       subitems: [item])
        let section: NSCollectionLayoutSection = .init(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        let header: NSCollectionLayoutBoundarySupplementaryItem = .init(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                                          heightDimension: .absolute(50)),
                                                                        elementKind: UICollectionView.elementKindSectionHeader,
                                                                        alignment: NSRectAlignment.top)
        section.boundarySupplementaryItems = [header]
        section.decorationItems = [NSCollectionLayoutDecorationItem.background(elementKind: RMCharacterDetailEpisodeBackground.identifier)]
        section.contentInsets = .init(top: 0, leading: 10, bottom: 10, trailing: 10)
        return section
    }

    private func handleEpisodeCollectionBackground(for cellCount: Int) {
        if cellCount > 2 {
            RMCharacterDetailEpisodeBackground.sideConstraintConstant = 0
            RMCharacterDetailEpisodeBackground.cornerRadius = 0
            RMCharacterDetailEpisodeBackground.masksToBounds = false
            return
        }
        RMCharacterDetailEpisodeBackground.sideConstraintConstant = 5
        RMCharacterDetailEpisodeBackground.cornerRadius = 8
        RMCharacterDetailEpisodeBackground.masksToBounds = true
    }
}

extension RMCharacterCollectionDetailViewModel: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType: RMCharacterCollectionDetailViewModel.DetailSection = sections[section]
        switch sectionType {
        case .characterImage:
            return 1
        case .characterInfo(let viewModels):
            return viewModels.count
        case .characterEpisodes(let episodes):
            return episodes.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType: RMCharacterCollectionDetailViewModel.DetailSection = sections[indexPath.section]
        switch sectionType {
        case .characterImage(let imageData):
            let cell: RMCharacterImageCell = UICollectionView.getCell(of: RMCharacterImageCell.self, for: collectionView, and: indexPath)
            let viewModel: RMCharacterImageCellViewModelProtocol = RMCharacterImageCellViewModel(imageData: imageData)
            cell.configure(with: viewModel)
            cell.heroID = K.Hero.characterCollectionCellId
            return cell
        case .characterInfo(let viewModel):
            let cell: RMCharacterInfoCell = UICollectionView.getCell(of: RMCharacterInfoCell.self, for: collectionView, and: indexPath)
            let viewModel: RMCharacterInfoCellViewModelProtocol = viewModel[indexPath.row]
            cell.configure(with: viewModel)
            return cell
        case .characterEpisodes(let urls):
            let cell: RMCharacterEpisodeCell = UICollectionView.getCell(of: RMCharacterEpisodeCell.self, for: collectionView, and: indexPath)
            let viewModel: RMCharacterEpisodeCellViewModelProtocol = RMCharacterEpisodeCellViewModel(episodeName: urls[indexPath.row])
            cell.configure(with: viewModel)
            return cell
        }
        delegate?.reloadCollectionView()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int { return sections.count }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let cell: RMGenericHeader = UICollectionView.getReusableView(of: RMGenericHeader.self, for: collectionView, and: indexPath)
            cell.configure(with: indexPath.section == 1 ? K.CharDetail.genericInfo : K.CharDetail.episodes)
            return cell
        }
        return UICollectionReusableView()
    }
    
}

protocol RMCharacterCollectionDetailViewModelScreenDelegate: AnyObject {
    func didTapCharacterInfo(cellModel: RMCellInfoDisplayViewModel.RMCellModel)
}

extension RMCharacterCollectionDetailViewModel: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let chosenSection: RMCharacterCollectionDetailViewModel.DetailSection = sections[indexPath.section]
        switch chosenSection {
        case .characterImage:
            break
        case .characterInfo(let viewModels):
            let cellModel: RMCellInfoDisplayViewModel.RMCellModel = .init(title: viewModels[indexPath.row].title, value: viewModels[indexPath.row].value)
            screenDelegate?.didTapCharacterInfo(cellModel: cellModel)
        case .characterEpisodes(let episodes):
            let episode: (String, String) = separateEpisodeNameFromItsNumber(episodes[indexPath.row])
            let cellModel: RMCellInfoDisplayViewModel.RMCellModel = .init(title: episode.0, value: episode.1)
            screenDelegate?.didTapCharacterInfo(cellModel: cellModel)
        }
    }
    
}

extension RMCharacterCollectionDetailViewModel {
    
    func separateEpisodeNameFromItsNumber(_ episode: String) -> (String, String) {
        if let index: String.Index = episode.firstIndex(of: "-") {
           let number: String = (episode[index...]).description.replacingOccurrences(of: "-", with: "")
           let episode: String = (episode[..<index]).description
            return (episode, number)
        }
        return ("No title", "S00E00")
    }
    
}
