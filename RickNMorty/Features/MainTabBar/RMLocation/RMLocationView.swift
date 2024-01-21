//
//  RMLocationView.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 6/27/23.
//

import Foundation
import UIKit

final class RMLocationView: UIView {

    let viewModel: RMLocationViewModelProtocol

    init(viewModel: RMLocationViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        self.viewModel.delegate = self
        [locationCollectionView, coverView, activityIndicator].forEach(addSubview)
        setUpLocationTableViewConstraints()
    }

    @available(*, unavailable) required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    private lazy var activityIndicator: UIActivityIndicatorView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.color = .activityIndicatorColor
        $0.startAnimating()
        $0.hidesWhenStopped = true
        return $0
    }(UIActivityIndicatorView(style: .large))

    private lazy var coverView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .systemBackground
        return $0
    }(UIView())

    private func setUpLocationTableViewConstraints() {
        NSLayoutConstraint.activate([
            locationCollectionView.leftAnchor.constraint(equalTo: leftAnchor),
            locationCollectionView.topAnchor.constraint(equalTo: topAnchor),
            locationCollectionView.rightAnchor.constraint(equalTo: rightAnchor),
            locationCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
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

    private lazy var locationCollectionView: UICollectionView = {
        let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.getCompositionalLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
        collectionView.register(RMLocationCollectionTitleCell.self, forCellWithReuseIdentifier: RMLocationCollectionTitleCell.identifier)
        collectionView.register(RMLocationCollectionGeneralInfoCell.self, forCellWithReuseIdentifier: RMLocationCollectionGeneralInfoCell.identifier)
        collectionView.register(RMLocationCollectionResidentCell.self, forCellWithReuseIdentifier: RMLocationCollectionResidentCell.identifier)
        return collectionView
    }()

    private func getCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let titleItem: NSCollectionLayoutItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                                                          heightDimension: .fractionalHeight(1)))
        titleItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        let titleGroup: NSCollectionLayoutGroup = .horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                                                 heightDimension: .fractionalHeight(0.75/3)),
                                                              subitems: [titleItem])
        titleGroup.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        let generalInfoItem: NSCollectionLayoutItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3),
                                                                                                                heightDimension: .fractionalHeight(1)))
        generalInfoItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        let generalInfoGroup: NSCollectionLayoutGroup = .horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                                                       heightDimension: .fractionalHeight(1.25/3)),
                                                                    subitems: [generalInfoItem])
        generalInfoGroup.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        let residentButton: NSCollectionLayoutItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                                                               heightDimension: .fractionalHeight(1)))
        residentButton.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        let residentGroup: NSCollectionLayoutGroup = .horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                                                    heightDimension: .fractionalHeight(1/3)),
                                                                 subitems: [residentButton])
        residentGroup.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 15, trailing: 5)
        let mainGroup: NSCollectionLayoutGroup = .vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                                              heightDimension: .absolute(240)),
                                                           subitems: [titleGroup, generalInfoGroup, residentGroup])
        mainGroup.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 5, bottom: 5, trailing: 5)
        let section: NSCollectionLayoutSection = NSCollectionLayoutSection(group: mainGroup)
        section.decorationItems = [
            .background(elementKind: RMLocationCellBackgroundView.identifier)
        ]
        let layout: UICollectionViewCompositionalLayout = UICollectionViewCompositionalLayout(section: section)
        layout.register(RMLocationCellBackgroundView.self, forDecorationViewOfKind: RMLocationCellBackgroundView.identifier)
        return layout
    }
}

extension RMLocationView: RMLocationViewModelDelegate {
    func reloadTable() {
        locationCollectionView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: false)
        locationCollectionView.reloadData()
    }
    func startLoading() {
        activityIndicator.startAnimating()
    }
    func stopLoading() {
        activityIndicator.stopAnimating()
    }
    func showCoverView() {
        coverView.layer.opacity = 1
    }
    func hideCoverView() {
        coverView.layer.opacity = 0
    }
    func setUserInteraction(to bool: Bool) {
        locationCollectionView.isUserInteractionEnabled = bool
    }
}
