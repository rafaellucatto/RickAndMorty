//
//  PagePickerViewController.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 6/22/23.
//

import Foundation
import UIKit

final class PagePickerViewController: UIViewController {

    let pagePickerView: PagePickerView

    init(pagePickerView: PagePickerView) {
        self.pagePickerView = pagePickerView
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable) required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func loadView() {
        view = pagePickerView
    }
}
