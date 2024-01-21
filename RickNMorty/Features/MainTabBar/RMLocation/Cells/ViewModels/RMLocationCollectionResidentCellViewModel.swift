//
//  RMLocationCollectionResidentCellViewModel.swift
//  RickNMorty
//
//  Created by Rafael Lucatto on 1/11/24.
//

import Foundation
import UIKit

final class RMLocationCollectionResidentCellViewModel {

    private let residentCount: Int

    init(residentCount: Int) {
        self.residentCount = residentCount
    }

    var buttonColor: UIColor {
        return (residentCount > 0) ? .systemBackground : .locationResidentsDisabled
    }

    var shouldShowArrow: Bool {
        return residentCount > 0
    }

    var buttonTitle: String {
        return K.buttonTitle(residentCount.description)
    }

    private enum K {
        static let buttonTitle: (String) -> String = { return "Residents: \($0)"}
    }
    
}
