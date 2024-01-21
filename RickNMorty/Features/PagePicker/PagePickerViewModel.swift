//
//  PagePickerViewModel.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 6/22/23.
//

import Foundation
import UIKit

protocol PagePickerViewModelDelegate: AnyObject {
    func show()
    func fade()
}

protocol PagePickerViewModelProtocol: UIPickerViewDataSource, UIPickerViewDelegate {
    var delegate: PagePickerViewModelDelegate? { get set }
    var totalOfPages: Int { get }
    var controller: UIViewController? { get set }
    var chosenPage: Int { get }
    var completionHandler: (Int) -> Void { get }
    var pageCountRange: [Int] { get }

    func didSelectPage()
    func dismissPickerPage()
    func showView()
}

final class PagePickerViewModel: NSObject, PagePickerViewModelProtocol {

    weak var delegate: PagePickerViewModelDelegate?
    weak var controller: UIViewController?

    let totalOfPages: Int
    let completionHandler: (Int) -> Void

    var chosenPage: Int = 1
    lazy var pageCountRange: [Int] = Array(1...totalOfPages)

    init(totalOfPages: Int, completionHandler: @escaping (Int) -> Void) {
        self.totalOfPages = totalOfPages
        self.completionHandler = completionHandler
    }

    func didSelectPage() {
        UIView.rmanimate(withDuration: 0.3, animations: { [weak self] in
            self?.delegate?.fade()
        }, completion: { [weak self] hasFaded in
            guard let self = self else { return }
            if hasFaded {
                self.controller?.dismiss(animated: false)
                self.completionHandler(chosenPage)
            }
        })
    }

    func dismissPickerPage() {
        UIView.rmanimate(withDuration: 0.3, animations: { [weak self] in
            self?.delegate?.fade()
        }, completion: { [weak self] hasFaded in
            if hasFaded {
                self?.controller?.dismiss(animated: false)
            }
        })
    }

    func showView() {
        UIView.rmanimate(withDuration: 0.3) { [weak self] in
            self?.delegate?.show()
        }
    }
}

extension PagePickerViewModel: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return totalOfPages
    }
}

extension PagePickerViewModel: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pageCountRange[row].description
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        chosenPage = pageCountRange[row]
    }
}
