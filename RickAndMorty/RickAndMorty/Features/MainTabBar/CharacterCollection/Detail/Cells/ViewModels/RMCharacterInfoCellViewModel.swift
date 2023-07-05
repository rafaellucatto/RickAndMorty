//
//  RMCharacterInfoCellViewModel.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 6/13/23.
//

import Foundation

protocol RMCharacterInfoCellViewModelProtocol {
    var title: String { get }
    var value: String { get }
}

final class RMCharacterInfoCellViewModel: RMCharacterInfoCellViewModelProtocol {

    let title: String
    let value: String

    init(title: String, value: String) {
        self.title = title
        self.value = value
    }
}
