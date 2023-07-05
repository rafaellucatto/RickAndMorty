//
//  RMCharacterEpisodeCell.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 6/13/23.
//

import Foundation
import UIKit

final class RMCharacterEpisodeCell: UICollectionViewCell {

    private lazy var episodeNumberLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .activityIndicatorColor
        $0.font = .systemFont(ofSize: 14)
        $0.textAlignment = .center
        return $0
    }(UILabel())

    private lazy var divisor: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .gray
        return $0
    }(UIView())

    private lazy var titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .activityIndicatorColor
        $0.textAlignment = .center
        $0.font = .boldSystemFont(ofSize: 14)
        return $0
    }(UILabel())

    override func layoutSubviews() {
        super.layoutSubviews()
        addCornerRadius()
        contentView.backgroundColor = .systemBackground
        [episodeNumberLabel, titleLabel, divisor].forEach(contentView.addSubview)
        setUpConstraints()
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            episodeNumberLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            episodeNumberLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            episodeNumberLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            episodeNumberLabel.bottomAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            titleLabel.topAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            divisor.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            divisor.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            divisor.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            divisor.heightAnchor.constraint(equalToConstant: 1)
        ])
    }

    func configure(with viewModel: RMCharacterEpisodeCellViewModelProtocol) {
        episodeNumberLabel.text = viewModel.episode
        titleLabel.text = viewModel.title
    }
}

