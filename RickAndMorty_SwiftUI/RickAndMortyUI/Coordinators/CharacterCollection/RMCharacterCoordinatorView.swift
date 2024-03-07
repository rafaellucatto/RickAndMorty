//
//  RMCharacterCoordinatorView.swift
//  RickAndMortyUI
//
//  Created by Rafael Lucatto on 3/2/24.
//

import SwiftUI

struct RMCharacterCoordinatorView: View {
    
    @StateObject private var coordinator: RMCharacterCoordinator = RMCharacterCoordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(page: .characterCollection(RMCharacterCollectionViewModel()))
                .navigationDestination(for: RMCharacterPage.self) { page in
                    coordinator.build(page: page)
                }
                .sheet(item: $coordinator.sheet) { sheet in
                    coordinator.build(page: sheet)
                }
        }
        .environmentObject(coordinator)
    }
}

#Preview {
    RMCharacterCoordinatorView()
}
