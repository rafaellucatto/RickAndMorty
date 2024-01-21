//
//  RMCharacterCollectionDetailView.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 6/13/23.
//

import Foundation
import UIKit

final class RMCharacterCollectionDetailView: UIView {

    var viewModel: RMCharacterCollectionDetailViewModelProtocol

    lazy var characterDetailCollection: UICollectionView = {
        let layout: UICollectionViewCompositionalLayout = .init(sectionProvider: { sectionInt, _ in
            return self.viewModel.createSection(for: sectionInt)
        })
        layout.register(RMCharacterDetailBackground.self, forDecorationViewOfKind: RMCharacterDetailBackground.identifier)
        layout.register(RMCharacterDetailEpisodeBackground.self, forDecorationViewOfKind: RMCharacterDetailEpisodeBackground.identifier)
        let collection: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .systemGray5
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.dataSource = viewModel
        collection.delegate = viewModel
        collection.register(RMCharacterImageCell.self, forCellWithReuseIdentifier: RMCharacterImageCell.identifier)
        collection.register(RMCharacterInfoCell.self, forCellWithReuseIdentifier: RMCharacterInfoCell.identifier)
        collection.register(RMCharacterEpisodeCell.self, forCellWithReuseIdentifier: RMCharacterEpisodeCell.identifier)
        collection.register(RMGenericHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: RMGenericHeader.identifier)
        return collection
    }()

    init(viewModel: RMCharacterCollectionDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        self.viewModel.delegate = self
        backgroundColor = .clear
        addSubview(characterDetailCollection)
        NSLayoutConstraint.activate([
            characterDetailCollection.leftAnchor.constraint(equalTo: leftAnchor),
            characterDetailCollection.topAnchor.constraint(equalTo: topAnchor),
            characterDetailCollection.rightAnchor.constraint(equalTo: rightAnchor),
            characterDetailCollection.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    @available(*, unavailable) required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

extension RMCharacterCollectionDetailView: RMCharacterCollectionDetailViewModelDelegate {
    func reloadCollectionView() {
        self.characterDetailCollection.reloadData()
    }
}
