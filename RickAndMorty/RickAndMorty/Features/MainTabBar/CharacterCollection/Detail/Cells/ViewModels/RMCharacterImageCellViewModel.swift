//
//  RMCharacterImageCellViewModel.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 6/13/23.
//

import Foundation
import UIKit

protocol RMCharacterImageCellViewModelProtocol {
    var imageData: Data { get }
    var getCharImage: UIImage? { get }
}

final class RMCharacterImageCellViewModel: RMCharacterImageCellViewModelProtocol {

    let imageData: Data

    init(imageData: Data) {
        self.imageData = imageData
    }

    var getCharImage: UIImage? {
        return UIImage(data: imageData)
    }
}
