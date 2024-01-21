//
//  RMEpisodeCharacterCollectionAnalytics.swift
//  RickNMorty
//
//  Created by Rafael Lucatto on 12/17/23.
//

import Foundation

enum RMEpisodeCharacterCollectionAnalytics: AnalyticsProtocol {
    
    case page
    case didTapCharacter(name: String, episode: String)
    
    var name: EventName {
        switch self {
        case .page:
            return .page
        default:
            return .action
        }
    }
    
    var parameters: [ParameterKey: String] {
        switch self {
        case .page:
            return [.hash: "p-001.000.000.001.002", .pagename: "episode-collection"]
        case .didTapCharacter(let name, let episode):
            return [.hash: "a-001.000.000.002.004",
                    .charactername: name,
                    .episodename: episode]
        }
    }
    
}
