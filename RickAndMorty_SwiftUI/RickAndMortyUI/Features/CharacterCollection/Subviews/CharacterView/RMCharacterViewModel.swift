//
//  RMCharacterViewModel.swift
//  RickAndMortyUI
//
//  Created by Rafael Lucatto on 2/15/24.
//

import Combine
import Foundation

protocol RMCharacterViewModelProtocol: ObservableObject {
    var episodes: [String] { get }
    var character: RMCharacter { get }
    func getEpisodes() async
}

final class RMCharacterViewModel: RMCharacterViewModelProtocol {
    
    @Published var episodes: [String] = []
    
    private var hasFetchedEpisodes: Bool = false
    
    let character: RMCharacter
    let api: RMCharacterViewModelApiProtocol
    
    init(character: RMCharacter, api: RMCharacterViewModelApiProtocol = RMCharacterViewModelApi()) {
        self.character = character
        self.api = api
    }
    
    func getEpisodes() async {
        guard !hasFetchedEpisodes else { return }
        hasFetchedEpisodes = true
        let episodeTitles: [String] = await api.getEpisodeTitles(for: self.character).sorted { $0 < $1 }
        RMDispatchQueue.async { [weak self] in
            self?.episodes.append(contentsOf: episodeTitles)
        }
    }
    
}
