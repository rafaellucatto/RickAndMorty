//
//  RMLocationCellBackgroundView.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 6/28/23.
//

import Foundation
import UIKit

final class RMLocationCellBackgroundView: UICollectionReusableView {

    private var coverView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .locationBackground
        $0.addCornerRadius()
        return $0
    }(UIView())

    override func layoutSubviews() {
        super.layoutSubviews()
        self.addShadow()
        addSubview(coverView)
        NSLayoutConstraint.activate([
            coverView.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            coverView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            coverView.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            coverView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
        ])
    }
}
