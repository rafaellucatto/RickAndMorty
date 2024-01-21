//
//  RMCharacterCollectionView.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 6/10/23.
//

import Foundation
import UIKit

final class RMCharacterCollectionView: UIView {

    let viewModel: RMCharacterCollectionViewModelProtocol

    init(viewModel: RMCharacterCollectionViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        self.viewModel.delegate = self
        self.viewModel.getCharacters(with: nil)
        backgroundColor = .white
        [characterCollection, coverView, activityIndicator].forEach(addSubview)
        NSLayoutConstraint.activate([
            characterCollection.leftAnchor.constraint(equalTo: leftAnchor),
            characterCollection.topAnchor.constraint(equalTo: topAnchor),
            characterCollection.rightAnchor.constraint(equalTo: rightAnchor),
            characterCollection.bottomAnchor.constraint(equalTo: bottomAnchor),
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
    
    private lazy var coverView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .systemBackground
        return $0
    }(UIView())

    private lazy var activityIndicator: UIActivityIndicatorView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.color = .activityIndicatorColor
        $0.stopAnimating()
        $0.hidesWhenStopped = true
        return $0
    }(UIActivityIndicatorView(style: .large))

    lazy var characterCollection: UICollectionView = {
        let item: NSCollectionLayoutItem = .init(layoutSize: .init(widthDimension: .fractionalWidth(1/3),
                                                                   heightDimension: .fractionalHeight(1)))
        item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        let group: NSCollectionLayoutGroup = .horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                           heightDimension: .fractionalWidth(1/3)),
                                                         subitems: [item])
        let section: NSCollectionLayoutSection = .init(group: group)
        let layout: UICollectionViewCompositionalLayout = .init(section: section)
        let collection: UICollectionView = .init(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .systemGray6
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.dataSource = viewModel
        collection.delegate = viewModel
        return collection
    }()
    
}

extension RMCharacterCollectionView: RMCharacterCollectionViewModelDelegate {

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

    func showCoverScreen() {
        coverView.layer.opacity = 1
    }

    func hideCoverScreen() {
        coverView.layer.opacity = 0
    }

    func setUserInteraction(to bool: Bool) {
        characterCollection.isUserInteractionEnabled = bool
    }
    
}
