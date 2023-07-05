//
//  RMLocationCollectionTitleCell.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 6/28/23.
//

import Foundation
import UIKit

final class RMLocationCollectionTitleCell: UICollectionViewCell {

    private lazy var locationNameLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 0
        $0.font = .boldSystemFont(ofSize: 14)
        $0.textAlignment = .center
        return $0
    }(UILabel())

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = .systemBackground
        contentView.addCornerRadius()
        contentView.addSubview(locationNameLabel)
        NSLayoutConstraint.activate([
            locationNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            locationNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            locationNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            locationNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }

    func configure(with locationName: String) {
        locationNameLabel.text = locationName
    }
}
