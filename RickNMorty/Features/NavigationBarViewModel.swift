//
//  NavigationBarViewModel.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 6/22/23.
//

import Foundation
import UIKit

enum SearchType: String {
    case character = "https://rickandmortyapi.com/api/character?page="
    case episode = "https://rickandmortyapi.com/api/episode?page="
    case location = "https://rickandmortyapi.com/api/location?page="
}

class NavigationBarViewModel: NSObject {

    let searchType: SearchType

    init(searchType: SearchType) {
        self.searchType = searchType
        super.init()
        setNavBarLeftSideTitle()
    }

    var pageTotal: Int = 0
    var currentPage: Int = 1
    var getModel: ((String) -> Void)?
    var nextPage: String?
    var previousPage: String?
    
    weak var controller: UIViewController?

    private var canShowPreviousPage: Bool {
        return previousPage != nil
    }

    private var canShowNextPage: Bool {
        return nextPage != nil
    }

    var barButtonItem: UIBarButtonItem {
        let barButtonItem: UIBarButtonItem = .init()
        barButtonItem.customView = button
        return barButtonItem
    }

    var button: UIButton {
        let button: UIButton = .init(type: .system)
        button.setImage(UIImage(systemName: "slider.horizontal.3"), for: .normal)
        button.showsMenuAsPrimaryAction = true
        var menuButtons: [UIMenuElement] = []
        if canShowPreviousPage {
            let previousPageAction: UIAction = UIAction(title: K.NavBar.previousPage,
                                                        image: UIImage(systemName: "arrow.uturn.left.circle")) { [weak self] _ in
                guard let previousPage: String = self?.previousPage else { return }
                self?.getModel?(previousPage)
                self?.currentPage -= 1
            }
            menuButtons.append(previousPageAction)
        }
        if canShowNextPage {
            let nextPageAction: UIAction = UIAction(title: K.NavBar.nextPage,
                                                    image: UIImage(systemName: "arrow.uturn.right.circle")) { [weak self] _ in
                guard let nextPage: String = self?.nextPage else { return }
                self?.getModel?(nextPage)
                self?.currentPage += 1
            }
            menuButtons.append(nextPageAction)
        }
        let searchPageAction: UIAction = UIAction(title: K.NavBar.choosePage,
                                                  image: UIImage(systemName: "magnifyingglass")) { [weak self] _ in
            let viewModel: PagePickerViewModelProtocol = PagePickerViewModel(totalOfPages: self?.pageTotal ?? 1) {
                if $0 != self?.currentPage {
                    self?.getModel?((self?.searchType.rawValue ?? "") + "\($0)")
                    self?.currentPage = $0
                }
            }
            viewModel.controller = self?.controller
            let pickerView: PagePickerView = PagePickerView(viewModel: viewModel)
            let pickerController: PagePickerViewController = PagePickerViewController(pagePickerView: pickerView)
            pickerController.modalPresentationStyle = .overFullScreen
            self?.controller?.navigationController?.present(pickerController, animated: false) {
                viewModel.showView()
            }
        }
        menuButtons.append(searchPageAction)
        let menuSections: [UIMenu] = [
            UIMenu(options: .displayInline, children: menuButtons)
        ]
        let menu: UIMenu = UIMenu(children: menuSections)
        button.menu = menu
        return button
    }

    func setNavBarLeftSideTitle() {
        let pageCountLabel: UILabel = .init()
        pageCountLabel.text = "\(currentPage)/\(pageTotal)"
        pageCountLabel.sizeToFit()
        let leftButton: UIBarButtonItem = .init(customView: pageCountLabel)
        controller?.navigationItem.leftBarButtonItem = leftButton
    }

    func controlNavBarPage(totalOfPages: Int, nextPageURL: String?, previousPageURL: String?) {
        if pageTotal == 0 {
            pageTotal = totalOfPages
        }
        if let next: String = nextPageURL {
            nextPage = next
        } else {
            nextPage = nil
        }
        if let previous: String = previousPageURL {
            previousPage = previous
        } else {
            previousPage = nil
        }
        controller?.navigationItem.rightBarButtonItem = barButtonItem
    }
    
}
