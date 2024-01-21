//
//  RMGenericHeader.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 7/1/23.
//

import Foundation
import UIKit

final class RMGenericHeader: UICollectionReusableView {

    private lazy var titleOverView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addCornerRadius()
        return $0
    }(UIView())

    private lazy var titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .activityIndicatorColor
        $0.textAlignment = .center
        $0.backgroundColor = .systemBackground
        $0.addCornerRadius()
        return $0
    }(UILabel())

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .clear
        self.addShadow(radius: 2, offset: CGSize(width: 0, height: 2))
        addSubview(titleOverView)
        titleOverView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleOverView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 5),
            titleOverView.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleOverView.heightAnchor.constraint(equalToConstant: 30),
            titleOverView.widthAnchor.constraint(equalToConstant: Locale.current.language.languageCode?.identifier == "pt" ? 180 : 120),
            titleLabel.leftAnchor.constraint(equalTo: titleOverView.leftAnchor),
            titleLabel.topAnchor.constraint(equalTo: titleOverView.topAnchor),
            titleLabel.rightAnchor.constraint(equalTo: titleOverView.rightAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleOverView.bottomAnchor)
        ])
    }

    func configure(with title: String) {
        titleLabel.text = title
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        titleLabel.traitCollectionDidChange(previousTraitCollection)
    }
}
