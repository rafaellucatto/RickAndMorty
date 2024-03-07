//
//  RMCharacterViewModelApi.swift
//  RickAndMortyUI
//
//  Created by Rafael Lucatto on 3/2/24.
//

import Foundation

protocol RMCharacterViewModelApiProtocol {
    func getEpisodeTitles(for character: RMCharacter) async -> [String]
}

final class RMCharacterViewModelApi: RMCharacterViewModelApiProtocol {
    
    private let requestManager: RMRequestManagerProtocol?
    
    init(requestManager: RMRequestManagerProtocol? = RMRequestManager.shared) {
        self.requestManager = requestManager
    }
    
    func getEpisodeTitles(for character: RMCharacter) async -> [String] {
        return await withTaskGroup(of: RMEpisode?.self) { taskGroup in
            for url in character.episode {
                taskGroup.addTask { await self.requestManager?.request(with: url, for: RMEpisode.self) }
            }
            var episodes: [String] = []
            for await episode in taskGroup {
                if let episode: RMEpisode = episode {
                    episodes.append(episode.episode + " - " + episode.name)
                }
            }
            return episodes
        }
    }
    
}
