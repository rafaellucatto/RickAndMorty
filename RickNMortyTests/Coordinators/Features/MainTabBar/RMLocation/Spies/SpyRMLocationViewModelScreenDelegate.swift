//
//  SpyRMLocationViewModelScreenDelegate.swift
//  RickNMortyTests
//
//  Created by Rafael Lucatto on 1/13/24.
//

import Foundation

@testable import RickNMorty

final class SpyRMLocationViewModelScreenDelegate: RMLocationViewModelScreenDelegate {
    
    var didTapResidentsGotCalled: Bool = false
    
    func didTapResidents(chars: [RickNMorty.RMCharacterResultsJson]) {
        didTapResidentsGotCalled = true
    }
    
}
