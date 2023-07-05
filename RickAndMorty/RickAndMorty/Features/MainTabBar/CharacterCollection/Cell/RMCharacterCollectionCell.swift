//
//  RMCharacterCollectionCell.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 6/10/23.
//

import Foundation
import UIKit

final class RMCharacterCollectionCell: UICollectionViewCell {

    lazy var characterImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(characterImageView)
        self.addShadow(radius: 2, height: 1)
        contentView.addCornerRadius()
        NSLayoutConstraint.activate([
            characterImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            characterImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            characterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        characterImageView.image = nil
    }

    func configure(with viewModel: RMCharacterCollectionCellViewModel) {
        if let imageData: Data = viewModel.imageData {
            self.characterImageView.image = UIImage(data: imageData)
        }
    }
}

extension RMCharacterCollectionCell: RMCharacterCollectionCellViewModelDelegate {
    func updateImage(with data: Data) {
        characterImageView.image = UIImage(data: data)
    }
}
