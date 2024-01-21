//
//  EpisodeCollectionSectionHeader.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 6/26/23.
//

import Foundation
import UIKit

final class EpisodeCollectionSectionHeader: UICollectionReusableView {

    private lazy var overView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .systemBackground
        $0.addCornerRadius()
        return $0
    }(UIView())

    private lazy var titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 1
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 14)
        return $0
    }(UILabel())

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .clear
        addSubview(overView)
        overView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            overView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 7.5),
            overView.centerXAnchor.constraint(equalTo: centerXAnchor),
            overView.heightAnchor.constraint(equalToConstant: 30),
            overView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40),
            titleLabel.leftAnchor.constraint(equalTo: overView.leftAnchor),
            titleLabel.topAnchor.constraint(equalTo: overView.topAnchor),
            titleLabel.rightAnchor.constraint(equalTo: overView.rightAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: overView.bottomAnchor),
        ])
    }

    func configure(with title: String) {
        titleLabel.text = title
    }
}
