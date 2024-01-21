//
//  RMCellInfoDisplayViewModel.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 6/19/23.
//

import Foundation
import UIKit

protocol RMCellInfoDisplayViewModelDelegate: AnyObject {
    func fade()
    func show()
}

protocol RMCellInfoDisplayViewModelProtocol {
    var controller: UIViewController? { get set }
    var delegate: RMCellInfoDisplayViewModelDelegate? { get set }
    var getText: String { get }

    func dismissController()
    func presentView()
}

final class RMCellInfoDisplayViewModel: RMCellInfoDisplayViewModelProtocol {

    weak var controller: UIViewController?
    weak var delegate: RMCellInfoDisplayViewModelDelegate?

    struct RMCellModel {
        let title: String
        let value: String
    }

    private let cellModel: RMCellModel

    init(cellModel: RMCellModel) {
        self.cellModel = cellModel
    }

    var getText: String {
        return "\(cellModel.title): \(cellModel.value)"
    }

    func dismissController() {
        UIView.rmanimate(withDuration: 0.3) { [weak self] in
            self?.delegate?.fade()
        } completion: { [weak self] hasFaded in
            if hasFaded {
                self?.controller?.dismiss(animated: false)
            }
        }
    }

    func presentView() {
        UIView.rmanimate(withDuration: 0.3) { [weak self] in
            self?.delegate?.show()
        }
    }
    
}
