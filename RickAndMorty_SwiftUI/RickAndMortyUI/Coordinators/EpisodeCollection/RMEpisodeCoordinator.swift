//
//  RMEpisodeCoordinator.swift
//  RickAndMortyUI
//
//  Created by Rafael Lucatto on 3/2/24.
//

import Foundation
import SwiftUI

enum RMEpisodePage: Identifiable, Hashable, Equatable {
    
    case episodeCollection(RMEpisodeCollectionViewModel)
    case episodeCharacter(RMCharacterViewModel)
    case episodeCharacterEpisodes(RMCharacterViewModel)
    
    var id: String {
        switch self {
        case .episodeCollection:
            return "episodeCollection"
        case .episodeCharacter:
            return "episodeCharacter"
        case .episodeCharacterEpisodes:
            return "episodeCharacterEpisodes"
        }
    }
    
    static func == (lhs: RMEpisodePage, rhs: RMEpisodePage) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}

enum RMEpisodeSheet: Identifiable, Hashable, Equatable {
    
    case pageChoosing(RMEpisodeCollectionViewModel)
    
    var id: String {
        switch self {
        case .pageChoosing:
            return "episodeCollection"
        }
    }
    
    static func == (lhs: RMEpisodeSheet, rhs: RMEpisodeSheet) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}

final class RMEpisodeCoordinator: ObservableObject {
    
    @Published var path: NavigationPath = NavigationPath()
    @Published var sheet: RMEpisodeSheet?
    @Published var page: RMEpisodePage?
    
    func push(_ page: RMEpisodePage) {
        path.append(page)
    }
    
    func present(_ sheet: RMEpisodeSheet) {
        self.sheet = sheet
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func dismissSheet() {
        sheet = nil
    }
    
    @ViewBuilder func build(page: RMEpisodePage) -> some View {
        switch page {
        case .episodeCollection(let viewModel):
            RMEpisodeCollectionView(viewModel: viewModel)
        case .episodeCharacter(let viewModel):
            RMCharacterView(coordinator: .episode, viewModel: viewModel)
        case .episodeCharacterEpisodes(let viewModel):
            RMCharacterEpisodeCollectionView(coordinatorType: .episode, viewModel: viewModel)
        }
    }
    
    @ViewBuilder func build(page: RMEpisodeSheet) -> some View {
        switch page {
        case .pageChoosing(let viewModel):
            RMEpisodePageChoosingView(viewModel: viewModel)
        }
    }
    
}
