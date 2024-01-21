//
//  RMCharacterDetailEpisodeBackground.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 7/2/23.
//

import Foundation
import UIKit

final class RMCharacterDetailEpisodeBackground: UICollectionReusableView {

    static var sideConstraintConstant: CGFloat = 0
    static var cornerRadius: CGFloat = 0
    static var masksToBounds: Bool = false

    private lazy var backgroundView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .systemGray6
        $0.layer.cornerRadius = RMCharacterDetailEpisodeBackground.cornerRadius
        $0.layer.masksToBounds = RMCharacterDetailEpisodeBackground.masksToBounds
        return $0
    }(UIView())

    override func layoutSubviews() {
        super.layoutSubviews()
        self.addShadow(radius: 2, offset: CGSize(width: 0, height: 2))
        addSubview(backgroundView)
        NSLayoutConstraint.activate([
            backgroundView.leftAnchor.constraint(equalTo: leftAnchor, constant: RMCharacterDetailEpisodeBackground.sideConstraintConstant),
            backgroundView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            backgroundView.rightAnchor.constraint(equalTo: rightAnchor, constant: RMCharacterDetailEpisodeBackground.sideConstraintConstant * -1),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
}
