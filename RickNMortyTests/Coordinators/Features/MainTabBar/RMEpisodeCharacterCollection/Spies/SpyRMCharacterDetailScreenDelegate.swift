//
//  SpyRMCharacterDetailScreenDelegate.swift
//  RickNMortyTests
//
//  Created by Rafael Lucatto on 1/13/24.
//

import Foundation

@testable import RickNMorty

final class SpyRMCharacterDetailScreenDelegate: RMCharacterDetailScreenDelegate {
    
    var didTapDidTapCharacter: Bool = false
    
    func didTapCharacter(character: RickNMorty.RMCharacterResultsJson) {
        didTapDidTapCharacter = true
    }
    
}
