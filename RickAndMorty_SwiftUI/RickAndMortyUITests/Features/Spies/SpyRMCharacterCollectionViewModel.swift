//
//  SpyRMCharacterCollectionViewModel.swift
//  RickAndMortyUITests
//
//  Created by Rafael Lucatto on 2/25/24.
//

import Foundation

@testable import RickAndMortyUI

final class SpyRMCharacterCollectionViewModel: RMCharacterCollectionViewModelProtocol {
    
    var characters: [RMCharacter] = Array(repeating: .stub(), count: 7)
    var navBarTitle: String = "Characters (1/23)"
    var menu: RMMenuDirection = .onlyNext
    var lastPage: Int = 23
    
    var didCallGetFirstCharacters: Bool = false
    var didCallGetNextCharacters: Bool = false
    var didCallGetPreviousCharacters: Bool = false
    var didCallGetCustomPage: Bool = false
    
    func getFirstCharacters() async {
        didCallGetFirstCharacters = true
    }
    
    func getNextCharacters() async {
        didCallGetNextCharacters = true
    }
    
    func getPreviousCharacters() async {
        didCallGetPreviousCharacters = true
    }
    
    func getCustomPage(with number: Int) async {
        didCallGetCustomPage = true
    }
    
}
