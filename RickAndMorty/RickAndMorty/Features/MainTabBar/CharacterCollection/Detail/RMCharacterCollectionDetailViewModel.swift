//
//  RMCharacterCollectionDetailViewModel.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 6/13/23.
//

import Foundation
import UIKit

protocol RMCharacterCollectionDetailViewModelDelegate: AnyObject {
    func reloadCollectionView()
}

protocol RMCharacterCollectionDetailViewModelProtocol: UICollectionViewDataSource, UICollectionViewDelegate {
    var character: RMCharacterResultsJson { get }
    var hasSingleEpisode: Bool { get }
    var onDismiss: (() -> Void)? { get }
    var episodeAreaHeight: CGFloat { get }
    var episodeFractionalHeight: CGFloat { get }
    var delegate: RMCharacterCollectionDetailViewModelDelegate? { get set }
    var controller: UIViewController? { get set }
    var controllerTitle: String { get }
    var sections: [RMCharacterCollectionDetailViewModel.DetailSection] { get }
    func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection
}

final class RMCharacterCollectionDetailViewModel: NSObject, RMCharacterCollectionDetailViewModelProtocol {

    let character: RMCharacterResultsJson

    let hasSingleEpisode: Bool
    let onDismiss: (() -> Void)?

    var episodeAreaHeight: CGFloat {
        return hasSingleEpisode ? 65 : 130
    }

    var episodeFractionalHeight: CGFloat {
        return hasSingleEpisode ? 1 : 0.5
    }

    weak var delegate: RMCharacterCollectionDetailViewModelDelegate?
    weak var controller: UIViewController?

    init(character: RMCharacterResultsJson, onDismiss: (() -> Void)?) {
        self.character = character
        self.hasSingleEpisode = self.character.episode.count == 1
        self.onDismiss = onDismiss
        super.init()
        handleEpisodeCollectionBackground(for: character.episode.count)
    }

    private enum RMInfoCellType: String, CaseIterable {

        case id, name, species, status, origin, location, created, type, gender

        func getInfoCell(character: RMCharacterResultsJson) -> RMCharacterInfoCellViewModel {
            return RMCharacterInfoCellViewModel(title: self.rawValue.capitalized, value: getCharacterDetail(character))
        }

        private func getCharacterCreationDate(for date: String) -> String {
            let formatter: ISO8601DateFormatter = ISO8601DateFormatter()
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

    var controllerTitle: String {
        return character.name
    }

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
        let item: NSCollectionLayoutItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                                                     heightDimension: .fractionalHeight(1)))
        let group: NSCollectionLayoutGroup = .vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                                          heightDimension: .fractionalWidth(1)),
                                                       subitems: [item])
        return NSCollectionLayoutSection(group: group)
    }

    private func createInfoSectionLayout() -> NSCollectionLayoutSection {
        let item: NSCollectionLayoutItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                                                                     heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        let group: NSCollectionLayoutGroup = .horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                                            heightDimension: .absolute(70)),
                                                         subitems: [item])
        let section: NSCollectionLayoutSection = NSCollectionLayoutSection(group: group)
        let header: NSCollectionLayoutBoundarySupplementaryItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                                                                                                 heightDimension: .absolute(50)),
                                                                                                              elementKind: UICollectionView.elementKindSectionHeader,
                                                                                                              alignment: NSRectAlignment.top)
        section.boundarySupplementaryItems = [header]
        section.decorationItems = [NSCollectionLayoutDecorationItem.background(elementKind: RMCharacterDetailBackground.identifier)]
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10)
        return section
    }

    private func createEpisodeSectionLayout() -> NSCollectionLayoutSection {
        let item: NSCollectionLayoutItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                                                     heightDimension: .fractionalHeight(episodeFractionalHeight)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        let group: NSCollectionLayoutGroup = .vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8),
                                                                                          heightDimension: .absolute(episodeAreaHeight)),
                                                       subitems: [item])
        let section: NSCollectionLayoutSection = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        let header: NSCollectionLayoutBoundarySupplementaryItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                                                                                                 heightDimension: .absolute(50)),
                                                                                                              elementKind: UICollectionView.elementKindSectionHeader,
                                                                                                              alignment: NSRectAlignment.top)
        section.boundarySupplementaryItems = [header]
        section.decorationItems = [NSCollectionLayoutDecorationItem.background(elementKind: RMCharacterDetailEpisodeBackground.identifier)]
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10)
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
            let cell: RMCharacterImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterImageCell.identifier, for: indexPath) as! RMCharacterImageCell
            let viewModel: RMCharacterImageCellViewModelProtocol = RMCharacterImageCellViewModel(imageData: imageData)
            cell.configure(with: viewModel)
            return cell
        case .characterInfo(let viewModel):
            let cell: RMCharacterInfoCell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterInfoCell.identifier, for: indexPath) as! RMCharacterInfoCell
            let viewModel: RMCharacterInfoCellViewModelProtocol = viewModel[indexPath.row]
            cell.configure(with: viewModel)
            return cell
        case .characterEpisodes(let urls):
            let cell: RMCharacterEpisodeCell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterEpisodeCell.identifier, for: indexPath) as! RMCharacterEpisodeCell
            let viewModel: RMCharacterEpisodeCellViewModelProtocol = RMCharacterEpisodeCellViewModel(episodeName: urls[indexPath.row])
            cell.configure(with: viewModel)
            return cell
        }
        delegate?.reloadCollectionView()
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                             withReuseIdentifier: RMGenericHeader.identifier,
                                                                             for: indexPath) as? RMGenericHeader else {
                return UICollectionReusableView()
            }
            cell.configure(with: indexPath.section == 1 ? "Generic Info" : "Episodes")
            return cell
        }
        return UICollectionReusableView()
    }
}

extension RMCharacterCollectionDetailViewModel: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let chosenSection: RMCharacterCollectionDetailViewModel.DetailSection = sections[indexPath.section]
        switch chosenSection {
        case .characterImage:
            break
        case .characterInfo(let viewModels):
            let cellModel: RMCellInfoDisplayViewModel.RMCellModel = RMCellInfoDisplayViewModel.RMCellModel(title: viewModels[indexPath.row].title,
                                                                                                           value: viewModels[indexPath.row].value)
            let viewModel: RMCellInfoDisplayViewModel = RMCellInfoDisplayViewModel(cellModel: cellModel)
            let infoDisplayView: RMCellInfoDisplayView = RMCellInfoDisplayView(viewModel: viewModel)
            let infoDisplayController: RMCellInfoDisplayViewController = RMCellInfoDisplayViewController(cellInfoDisplayView: infoDisplayView)
            infoDisplayController.modalPresentationStyle = .overFullScreen
            controller?.present(infoDisplayController, animated: false, completion: {
                viewModel.presentView()
            })
        case .characterEpisodes(let episodes):
            let episode: (String, String) = separateEpisodeNameFromItsNumber(episodes[indexPath.row])
            let cellModel: RMCellInfoDisplayViewModel.RMCellModel = RMCellInfoDisplayViewModel.RMCellModel(title: episode.0, value: episode.1)
            let viewModel: RMCellInfoDisplayViewModel = RMCellInfoDisplayViewModel(cellModel: cellModel)
            let infoDisplayView: RMCellInfoDisplayView = RMCellInfoDisplayView(viewModel: viewModel)
            let infoDisplayController: RMCellInfoDisplayViewController = RMCellInfoDisplayViewController(cellInfoDisplayView: infoDisplayView)
            infoDisplayController.modalPresentationStyle = .overFullScreen
            controller?.present(infoDisplayController, animated: false, completion: {
                viewModel.presentView()
            })
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
