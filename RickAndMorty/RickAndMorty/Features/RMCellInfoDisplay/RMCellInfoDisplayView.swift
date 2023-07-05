//
//  RMCellInfoDisplayView.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 6/19/23.
//

import Foundation
import UIKit

final class RMCellInfoDisplayView: UIView {
    
    var viewModel: RMCellInfoDisplayViewModelProtocol
    
    init(viewModel: RMCellInfoDisplayViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        fade()
        self.viewModel.delegate = self
        backgroundColor = .clear
        addSubview(darkView)
        [darkView, infoView].forEach(addSubview)
        [infoLabel, dismissButton].forEach(infoView.addSubview)
        setUpAllConstraints()
    }
    
    @available(*, unavailable) required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    private lazy var darkView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .black
        $0.layer.opacity = 0.5
        return $0
    }(UIView())

    private lazy var infoView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
        $0.addCornerRadius()
        return $0
    }(UIView())

    private lazy var infoLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
        $0.numberOfLines = 0
        $0.text = viewModel.getText
        $0.textColor = .black
        $0.textAlignment = .center
        return $0
    }(UILabel())

    private lazy var dismissButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Dismiss", for: .normal)
        $0.addCornerRadius()
        $0.backgroundColor = .detailInfoButtonColor
        $0.setTitleColor(.white, for: .normal)
        $0.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))

    @objc func dismissController() {
        viewModel.dismissController()
    }

    private func setUpAllConstraints() {
        NSLayoutConstraint.activate([
            darkView.leftAnchor.constraint(equalTo: leftAnchor),
            darkView.topAnchor.constraint(equalTo: topAnchor),
            darkView.rightAnchor.constraint(equalTo: rightAnchor),
            darkView.bottomAnchor.constraint(equalTo: bottomAnchor),
            infoView.centerXAnchor.constraint(equalTo: centerXAnchor),
            infoView.centerYAnchor.constraint(equalTo: centerYAnchor),
            infoView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.75),
            infoView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.3),
            dismissButton.leftAnchor.constraint(equalTo: infoView.leftAnchor, constant: 20),
            dismissButton.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: -45),
            dismissButton.rightAnchor.constraint(equalTo: infoView.rightAnchor, constant: -20),
            dismissButton.bottomAnchor.constraint(equalTo: infoView.bottomAnchor, constant: -10),
            infoLabel.leftAnchor.constraint(equalTo: infoView.leftAnchor, constant: 20),
            infoLabel.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 20),
            infoLabel.rightAnchor.constraint(equalTo: infoView.rightAnchor, constant: -20),
            infoLabel.bottomAnchor.constraint(equalTo: dismissButton.topAnchor, constant: -20),
        ])
    }
}

extension RMCellInfoDisplayView: RMCellInfoDisplayViewModelDelegate {
    func fade() {
        layer.opacity = 0
    }
    func show() {
        layer.opacity = 1
    }
}
