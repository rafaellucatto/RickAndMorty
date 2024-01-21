//
//  PagePickerView.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 6/22/23.
//

import Foundation
import UIKit

final class PagePickerView: UIView {

    private lazy var darkView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .black
        $0.layer.opacity = 0.5
        return $0
    }(UIView())

    private lazy var centeredView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .systemBackground
        $0.addCornerRadius()
        return $0
    }(UIView())

    var viewModel: PagePickerViewModelProtocol

    init(viewModel: PagePickerViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        layer.opacity = 0
        self.viewModel.delegate = self
        backgroundColor = .clear
        pagePicker.dataSource = viewModel
        pagePicker.delegate = viewModel
        addSubview(darkView)
        addSubview(centeredView)
        [dismissButton, pageChoosingButton, pagePicker].forEach(centeredView.addSubview)
        setUpAllConstraints()
    }

    private func setUpAllConstraints() {
        NSLayoutConstraint.activate([
            darkView.leftAnchor.constraint(equalTo: leftAnchor),
            darkView.topAnchor.constraint(equalTo: topAnchor),
            darkView.rightAnchor.constraint(equalTo: rightAnchor),
            darkView.bottomAnchor.constraint(equalTo: bottomAnchor),
            centeredView.centerXAnchor.constraint(equalTo: centerXAnchor),
            centeredView.centerYAnchor.constraint(equalTo: centerYAnchor),
            centeredView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.8),
            centeredView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.5),
            dismissButton.bottomAnchor.constraint(equalTo: centeredView.bottomAnchor, constant: -5),
            dismissButton.leftAnchor.constraint(equalTo: centeredView.leftAnchor, constant: 5),
            dismissButton.rightAnchor.constraint(equalTo: centeredView.centerXAnchor, constant: -5),
            dismissButton.heightAnchor.constraint(equalToConstant: 40),
            pageChoosingButton.bottomAnchor.constraint(equalTo: centeredView.bottomAnchor, constant: -5),
            pageChoosingButton.leftAnchor.constraint(equalTo: centeredView.centerXAnchor, constant: 5),
            pageChoosingButton.rightAnchor.constraint(equalTo: centeredView.rightAnchor, constant: -5),
            pageChoosingButton.heightAnchor.constraint(equalToConstant: 40),
            pagePicker.leftAnchor.constraint(equalTo: centeredView.leftAnchor),
            pagePicker.topAnchor.constraint(equalTo: centeredView.topAnchor),
            pagePicker.rightAnchor.constraint(equalTo: centeredView.rightAnchor),
            pagePicker.bottomAnchor.constraint(equalTo: pageChoosingButton.topAnchor, constant: -10),
        ])
    }

    @available(*, unavailable) required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    private lazy var pagePicker: UIPickerView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.tintColor = .activityIndicatorColor
        return $0
    }(UIPickerView())

    private lazy var pageChoosingButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle(K.pageChoosingButton, for: .normal)
        $0.addTarget(self, action: #selector(didSelectPage), for: .touchUpInside)
        $0.backgroundColor = .detailInfoButtonColor
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.addCornerRadius()
        return $0
    }(UIButton(type: .system))

    @objc private func didSelectPage(_ sender: UIButton) {
        viewModel.didSelectPage()
    }

    private lazy var dismissButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle(K.dismissButton, for: .normal)
        $0.addTarget(self, action: #selector(dismissPage), for: .touchUpInside)
        $0.backgroundColor = .systemBackground
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.detailInfoButtonColor.cgColor
        $0.setTitleColor(.detailInfoButtonColor, for: .normal)
        $0.addCornerRadius()
        return $0
    }(UIButton(type: .system))

    @objc private func dismissPage(_ sender: UIButton) {
        viewModel.dismissPickerPage()
    }

    private lazy var separatorBetweenPickerAndButtons: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .darkGray
        return $0
    }(UIView())

    private func setUpPickerViewConstraints() {
        pagePicker.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        pagePicker.topAnchor.constraint(equalTo: separatorBetweenPickerAndButtons.bottomAnchor).isActive = true
        pagePicker.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        pagePicker.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    private func setUpDismissButtonConstraints() {
        dismissButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        dismissButton.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        dismissButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        dismissButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }

    private func setUpSeparatorBetweenPickerAndButtonsConstraints() {
        separatorBetweenPickerAndButtons.leftAnchor.constraint(equalTo: dismissButton.leftAnchor).isActive = true
        separatorBetweenPickerAndButtons.topAnchor.constraint(equalTo: dismissButton.bottomAnchor, constant: 10).isActive = true
        separatorBetweenPickerAndButtons.rightAnchor.constraint(equalTo: pageChoosingButton.rightAnchor).isActive = true
        separatorBetweenPickerAndButtons.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }

    private func setUpPageChoosingButtonConstraints() {
        pageChoosingButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        pageChoosingButton.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        pageChoosingButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        pageChoosingButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }

    private enum K {
        static let dismissButton: String = String(localized: "navDismiss")
        static let pageChoosingButton: String = String(localized: "navChoosePage")
    }
}

extension PagePickerView: PagePickerViewModelDelegate {
    func show() {
        layer.opacity = 1
    }
    func fade() {
        layer.opacity = 0
    }
}
