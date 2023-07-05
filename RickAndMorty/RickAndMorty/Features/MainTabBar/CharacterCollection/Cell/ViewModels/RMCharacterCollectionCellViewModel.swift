//
//  RMCharacterCollectionCellViewModel.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 6/13/23.
//

import Foundation
import UIKit

protocol RMCharacterCollectionCellViewModelDelegate: AnyObject {
    func updateImage(with data: Data)
}

final class RMCharacterCollectionCellViewModel {

    let imageData: Data?

    init(imageData: Data?) {
        self.imageData = imageData
    }
}
