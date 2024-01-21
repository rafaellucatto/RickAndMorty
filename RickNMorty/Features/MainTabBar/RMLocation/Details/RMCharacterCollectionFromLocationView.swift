//
//  RMCharacterCollectionFromLocationView.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 6/28/23.
//

import Foundation
import UIKit

final class RMCharacterCollectionFromLocationView: UIView {

    let viewModel: RMCharacterCollectionFromLocationViewModelProtocol

    private lazy var activityIndicator: UIActivityIndicatorView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.color = .activityIndicatorColor
        $0.stopAnimating()
        $0.hidesWhenStopped = true
        return $0
    }(UIActivityIndicatorView(style: .large))

    lazy var characterCollection: UICollectionView = {
        let item: NSCollectionLayoutItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3),
                                                                                                     heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        let group: NSCollectionLayoutGroup = .horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                                            heightDimension: .fractionalWidth(1/3)),
                                                         subitems: [item])
        let section: NSCollectionLayoutSection = NSCollectionLayoutSection(group: group)
        let layout: UICollectionViewCompositionalLayout = UICollectionViewCompositionalLayout(section: section)
        let collection: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .systemGray6
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.dataSource = viewModel
        collection.delegate = viewModel
        collection.register(RMCharacterCollectionCell.self, forCellWithReuseIdentifier: RMCharacterCollectionCell.identifier)
        return collection
    }()

    init(viewModel: RMCharacterCollectionFromLocationViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        self.viewModel.delegate = self
        backgroundColor = .white
        [characterCollection, activityIndicator].forEach(addSubview)
        NSLayoutConstraint.activate([
            characterCollection.leftAnchor.constraint(equalTo: leftAnchor),
            characterCollection.topAnchor.constraint(equalTo: topAnchor),
            characterCollection.rightAnchor.constraint(equalTo: rightAnchor),
            characterCollection.bottomAnchor.constraint(equalTo: bottomAnchor),
            activityIndicator.leftAnchor.constraint(equalTo: leftAnchor),
            activityIndicator.topAnchor.constraint(equalTo: topAnchor),
            activityIndicator.rightAnchor.constraint(equalTo: rightAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    @available(*, unavailable) required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

extension RMCharacterCollectionFromLocationView: RMCharacterCollectionFromLocationViewModelDelegate {
    func reloadCollection() {
        characterCollection.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: false)
        characterCollection.reloadData()
    }
    func startLoading() {
        activityIndicator.startAnimating()
    }
    func stopLoading() {
        activityIndicator.stopAnimating()
    }
    func setUserInteraction(to bool: Bool) {
        characterCollection.isUserInteractionEnabled = bool
    }
}
