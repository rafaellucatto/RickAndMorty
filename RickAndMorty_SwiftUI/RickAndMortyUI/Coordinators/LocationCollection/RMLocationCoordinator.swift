//
//  RMLocationCoordinator.swift
//  RickAndMortyUI
//
//  Created by Rafael Lucatto on 3/4/24.
//

import Foundation
import SwiftUI

enum RMLocationSheet: Identifiable, Hashable, Equatable {
    
    case pageChoosing(RMLocationCollectionViewModel)
    case help(RMHelpViewModel)
    
    var id: String {
        return "locationPageChoosing"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: RMLocationSheet, rhs: RMLocationSheet) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
}

enum RMLocationPage: Identifiable, Hashable, Equatable {
    
    case locationCollection(RMLocationCollectionViewModel)
    case locationCharacterCollection(RMLocationResidentCollectionViewModel)
    case locationCharacter(RMCharacterViewModel)
    case locationCharacterEpisode(RMCharacterViewModel)
    
    var id: String {
        switch self {
        case .locationCollection:
            return "locationCollection"
        case .locationCharacterCollection:
            return "locationCharacterCollection"
        case .locationCharacter:
            return "locationCharacter"
        case .locationCharacterEpisode:
            return "locationCharacterEpisode"
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: RMLocationPage, rhs: RMLocationPage) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
}

final class RMLocationCoordinator: ObservableObject {
    
    @Published var path: NavigationPath = NavigationPath()
    @Published var sheet: RMLocationSheet?
    @Published var page: RMLocationPage?
    
    func push(_ page: RMLocationPage) {
        path.append(page)
    }
    
    func present(_ sheet: RMLocationSheet) {
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
    
    @ViewBuilder func build(page: RMLocationPage) -> some View {
        switch page {
        case .locationCollection(let viewModel):
            RMLocationCollectionView(viewModel: viewModel)
        case .locationCharacterCollection(let viewModel):
            RMLocationResidentCollectionView(viewModel: viewModel)
        case .locationCharacter(let viewModel):
            RMCharacterView(coordinator: .location, viewModel: viewModel)
        case .locationCharacterEpisode(let viewModel):
            RMCharacterEpisodeCollectionView(coordinatorType: .location, viewModel: viewModel)
        }
    }
    
    @ViewBuilder func build(page: RMLocationSheet) -> some View {
        switch page {
        case .pageChoosing(let viewModel):
            RMLocationPageChoosingView(viewModel: viewModel)
        case .help(let viewModel):
            RMHelpView(viewModel: viewModel)
        }
    }
    
}
