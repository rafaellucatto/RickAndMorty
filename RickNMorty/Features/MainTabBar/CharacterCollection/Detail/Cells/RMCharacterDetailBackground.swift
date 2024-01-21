//
//  RMCharacterDetailBackground.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 7/1/23.
//

import Foundation
import UIKit

final class RMCharacterDetailBackground: UICollectionReusableView {

    private lazy var backgroundView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addCornerRadius()
        $0.backgroundColor = .systemGray6
        return $0
    }(UIView())

    override func layoutSubviews() {
        super.layoutSubviews()
        self.addShadow(radius: 2, offset: CGSize(width: 0, height: 2))
        addSubview(backgroundView)
        NSLayoutConstraint.activate([
            backgroundView.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            backgroundView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            backgroundView.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
}
