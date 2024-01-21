//
//  EpisodeCharacterCollectionView.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 6/25/23.
//

import Foundation
import UIKit

final class RMEpisodeCharacterCollectionView: UIView {

    let viewModel: RMEpisodeCharacterCollectionViewModelProtocol

    private lazy var coverView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .systemBackground
        return $0
    }(UIView())

    private lazy var activityIndicator: UIActivityIndicatorView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.hidesWhenStopped = true
        $0.color = .activityIndicatorColor
        $0.startAnimating()
        return $0
    }(UIActivityIndicatorView(style: .large))

    init(viewModel: RMEpisodeCharacterCollectionViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        self.viewModel.delegate = self
        [collectionView, coverView, activityIndicator].forEach(addSubview)
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            coverView.leftAnchor.constraint(equalTo: leftAnchor),
            coverView.topAnchor.constraint(equalTo: topAnchor),
            coverView.rightAnchor.constraint(equalTo: rightAnchor),
            coverView.bottomAnchor.constraint(equalTo: bottomAnchor),
            activityIndicator.leftAnchor.constraint(equalTo: leftAnchor),
            activityIndicator.topAnchor.constraint(equalTo: topAnchor),
            activityIndicator.rightAnchor.constraint(equalTo: rightAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    @available(*, unavailable) required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    lazy var collectionView: UICollectionView = {
        let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.getCompositionalLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGray6
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
        collectionView.register(EpisodeCharacterCollectionCell.self,
                                forCellWithReuseIdentifier: EpisodeCharacterCollectionCell.identifier)
        collectionView.register(EpisodeCollectionSectionHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: EpisodeCollectionSectionHeader.identifier)
        return collectionView
    }()

    private func getCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let item: NSCollectionLayoutItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                                                     heightDimension: .fractionalHeight(1/2)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        let group: NSCollectionLayoutGroup = .vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3),
                                                                                          heightDimension: .fractionalWidth(2/3)),
                                                       subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0)
        let section: NSCollectionLayoutSection = NSCollectionLayoutSection(group: group)
        let sectionHeader: NSCollectionLayoutBoundarySupplementaryItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                                                                                                        heightDimension: .absolute(50)),
                                                                                                                     elementKind: UICollectionView.elementKindSectionHeader,
                                                                                                                     alignment: .top)
        section.boundarySupplementaryItems = [sectionHeader]
        section.orthogonalScrollingBehavior = UICollectionLayoutSectionOrthogonalScrollingBehavior.continuousGroupLeadingBoundary
        section.decorationItems = [
            .background(elementKind: RMEpisodeCharacterCollectionBackground.identifier)
        ]
        let compositionalLayout: UICollectionViewCompositionalLayout = UICollectionViewCompositionalLayout(section: section)
        compositionalLayout.register(RMEpisodeCharacterCollectionBackground.self, forDecorationViewOfKind: RMEpisodeCharacterCollectionBackground.identifier)
        return compositionalLayout
    }
}

extension RMEpisodeCharacterCollectionView: RMEpisodeCharacterCollectionViewModelDelegate {
    
    func reloadCollection() {
        collectionView.reloadData()
        collectionView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: false)
    }
    
    func startLoading() {
        activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        activityIndicator.stopAnimating()
    }
    
    func showCoverScreen() {
        coverView.layer.opacity = 1
    }
    
    func hideCoverScreen() {
        coverView.layer.opacity = 0
    }
    
    func setUserInteraction(to bool: Bool) {
        collectionView.isUserInteractionEnabled = bool
    }
    
}
