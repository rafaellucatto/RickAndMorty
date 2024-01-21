//
//  RMLocationCollectionGeneralInfoCell.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 6/28/23.
//

import Foundation
import UIKit

final class RMLocationCollectionGeneralInfoCell: UICollectionViewCell {

    private lazy var dataLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 14)
        return $0
    }(UILabel())

    private lazy var divisor: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .gray
        return $0
    }(UIView())

    private lazy var valueLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.font = .boldSystemFont(ofSize: 14)
        return $0
    }(UILabel())

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = .systemBackground
        contentView.addCornerRadius()
        [dataLabel, valueLabel, divisor].forEach(contentView.addSubview)
        NSLayoutConstraint.activate([
            dataLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            dataLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            dataLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            dataLabel.bottomAnchor.constraint(equalTo: contentView.centerYAnchor),
            valueLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            valueLabel.topAnchor.constraint(equalTo: contentView.centerYAnchor),
            valueLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            valueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            divisor.heightAnchor.constraint(equalToConstant: 1),
            divisor.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            divisor.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            divisor.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    func configure(with data: RMLocationViewModel.RMDetailCell, value: String) {
        dataLabel.text = data.getTitle
        valueLabel.text = value
    }
}
