//
//  SpyRMCharacterViewModel.swift
//  RickAndMortyUITests
//
//  Created by Rafael Lucatto on 2/26/24.
//

import Foundation

@testable import RickAndMortyUI

final class SpyRMCharacterViewModel: RMCharacterViewModelProtocol {
    
    var episodes: [String] = Array(repeating: "https://", count: 7)
    var character: RMCharacter = .stub()
    
    var didCallGetEpisodes: Bool = false
    
    func getEpisodes() async {
        didCallGetEpisodes = true
    }
    
}
