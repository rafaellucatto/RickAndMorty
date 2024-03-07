//
//  RMEpisodeCoordinatorView.swift
//  RickAndMortyUI
//
//  Created by Rafael Lucatto on 3/4/24.
//

import Foundation
import SwiftUI

struct RMEpisodeCoordinatorView: View {
    
    @StateObject private var coordinator: RMEpisodeCoordinator = RMEpisodeCoordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(page: .episodeCollection(RMEpisodeCollectionViewModel()))
                .navigationDestination(for: RMEpisodePage.self) { page in
                    coordinator.build(page: page)
                }
                .sheet(item: $coordinator.sheet) { sheet in
                    coordinator.build(page: sheet)
                }
        }
        .environmentObject(coordinator)
    }
    
}
