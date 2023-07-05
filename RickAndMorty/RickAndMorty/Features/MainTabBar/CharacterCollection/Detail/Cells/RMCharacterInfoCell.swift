//
//  RMCharacterInfoCell.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 6/13/23.
//

import Foundation
import UIKit

final class RMCharacterInfoCell: UICollectionViewCell {

    private let separator: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .gray
        return $0
    }(UIView())

    private lazy var titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = NSTextAlignment.center
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .activityIndicatorColor
        return $0
    }(UILabel())

    private lazy var valueLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        $0.font = .boldSystemFont(ofSize: 14)
        $0.textColor = .activityIndicatorColor
        return $0
    }(UILabel())

    private func setUpShadowAndCorner() {
        contentView.addCornerRadius()
        contentView.backgroundColor = .systemBackground
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpShadowAndCorner()
        [titleLabel, separator, valueLabel].forEach(contentView.addSubview)
        setUpAllConstraints()
    }

    func configure(with viewModel: RMCharacterInfoCellViewModelProtocol) {
        self.titleLabel.text = viewModel.title
        self.valueLabel.text = viewModel.value
    }

    private func setUpAllConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.centerYAnchor),
            separator.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            separator.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            separator.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            separator.heightAnchor.constraint(equalToConstant: 1),
            valueLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            valueLabel.topAnchor.constraint(equalTo: contentView.centerYAnchor),
            valueLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            valueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
