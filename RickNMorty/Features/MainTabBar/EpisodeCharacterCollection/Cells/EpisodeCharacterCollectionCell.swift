//
//  EpisodeCharacterCollectionCell.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 6/25/23.
//

import Foundation
import UIKit

final class EpisodeCharacterCollectionCell: UICollectionViewCell {

    lazy var imageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())

    override func layoutSubviews() {
        super.layoutSubviews()
        self.addShadow(radius: 2)
        contentView.addCornerRadius()
        contentView.addSubview(imageView)
        contentView.backgroundColor = .white
        NSLayoutConstraint.activate([
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }

    override func prepareForReuse() {
        imageView.image = nil
    }
}
