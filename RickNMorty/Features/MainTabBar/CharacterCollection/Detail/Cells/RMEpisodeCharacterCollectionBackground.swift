//
//  RMEpisodeCharacterCollectionBackground.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 7/2/23.
//

import Foundation
import UIKit

final class RMEpisodeCharacterCollectionBackground: UICollectionReusableView {

    private lazy var backgroundView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .systemGray6
        return $0
    }(UIView())

    override func layoutSubviews() {
        super.layoutSubviews()
        self.addShadow(radius: 2, offset: CGSize(width: 0, height: 2))
        addSubview(backgroundView)
        NSLayoutConstraint.activate([
            backgroundView.leftAnchor.constraint(equalTo: leftAnchor),
            backgroundView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            backgroundView.rightAnchor.constraint(equalTo: rightAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
}
