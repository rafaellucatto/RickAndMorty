//
//  Coordinator.swift
//  RickAndMortyUI
//
//  Created by Rafael Lucatto on 2/29/24.
//

import Foundation
import SwiftUI

enum RMCharacterPage: Identifiable, Hashable, Equatable {
    
    case characterCollection(RMCharacterCollectionViewModel)
    case character(RMCharacterViewModel)
    case characterEpisode(RMCharacterViewModel)
    
    var id: String {
        switch self {
        case .characterCollection:
            return "characterCollectionPage"
        case .character:
            return "characterPage"
        case .characterEpisode:
            return "characterEpisodePage"
        }
    }
    
    static func == (lhs: RMCharacterPage, rhs: RMCharacterPage) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}

enum RMCharacterSheet: Identifiable, Hashable, Equatable {
    
    case pageChoosing(RMCharacterCollectionViewModel)
    
    var id: String {
        return "characterChoosingPage"
    }
    
    static func == (lhs: RMCharacterSheet, rhs: RMCharacterSheet) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}

final class RMCharacterCoordinator: ObservableObject {
    
    @Published var path: NavigationPath = NavigationPath()
    @Published var sheet: RMCharacterSheet?
    @Published var page: RMCharacterPage?
    
    func push(_ page: RMCharacterPage) {
        path.append(page)
    }
    
    func present(_ sheet: RMCharacterSheet) {
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
    
    @ViewBuilder func build(page: RMCharacterPage) -> some View {
        switch page {
        case .characterCollection(let viewModel):
            RMCharacterCollectionView(viewModel: viewModel)
        case .character(let viewModel):
            RMCharacterView(coordinator: .character, viewModel: viewModel)
        case .characterEpisode(let viewModel):
            RMCharacterEpisodeCollectionView(coordinatorType: .character, viewModel: viewModel)
        }
    }
    
    @ViewBuilder func build(page: RMCharacterSheet) -> some View {
        switch page {
        case .pageChoosing(let viewModel):
            RMCharacterPageChoosingView(viewModel: viewModel)
        }
    }
    
}
