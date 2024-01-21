//
//  RMCharacterCollectionAnalytics.swift
//  RickNMorty
//
//  Created by Rafael Lucatto on 12/17/23.
//

import Foundation

@frozen enum RMCharacterCollectionAnalytics: AnalyticsProtocol {
    
    case page
    case navMenu
    
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
            return [.hash: "p-001.000.000.001.001", .pagename: "character-collection"]
        case .navMenu:
            return [.hash: "a-001.000.000.001.002", .buttonname: "openmenu"]
        }
    }
    
}
