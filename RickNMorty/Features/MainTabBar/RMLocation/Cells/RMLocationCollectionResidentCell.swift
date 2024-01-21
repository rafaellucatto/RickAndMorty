//
//  RMLocationCollectionResidentCell.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 6/28/23.
//

import Foundation
import UIKit

final class RMLocationCollectionResidentCell: UICollectionViewCell {

    private lazy var residentLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 0
        $0.textAlignment = .left
        return $0
    }(UILabel())

    private lazy var arrowImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.tintColor = .activityIndicatorColor
        $0.image?.withRenderingMode(.alwaysTemplate)
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView(image: UIImage(systemName: "chevron.forward")))

    override func layoutSubviews() {
        super.layoutSubviews()
        self.addShadow(radius: 2)
        contentView.addCornerRadius()
        [residentLabel, arrowImageView].forEach(contentView.addSubview)
        NSLayoutConstraint.activate([
            residentLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            residentLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            residentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            arrowImageView.widthAnchor.constraint(equalToConstant: 15),
            arrowImageView.heightAnchor.constraint(equalToConstant: 15),
            arrowImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            arrowImageView.centerYAnchor.constraint(equalTo: residentLabel.centerYAnchor),
        ])
    }

    func configure(with viewModel: RMLocationCollectionResidentCellViewModel) {
        arrowImageView.isHidden = !viewModel.shouldShowArrow
        residentLabel.text = viewModel.buttonTitle
        contentView.backgroundColor = viewModel.buttonColor
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        arrowImageView.traitCollectionDidChange(previousTraitCollection)
    }
    
}
