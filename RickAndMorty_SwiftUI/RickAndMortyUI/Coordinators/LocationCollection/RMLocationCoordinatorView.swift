//
//  RMLocationCoordinatorView.swift
//  RickAndMortyUI
//
//  Created by Rafael Lucatto on 3/4/24.
//

import Foundation
import SwiftUI

struct RMLocationCoordinatorView: View {
    
    @StateObject private var coordinator: RMLocationCoordinator = RMLocationCoordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(page: .locationCollection(RMLocationCollectionViewModel()))
                .navigationDestination(for: RMLocationPage.self) { page in
                    coordinator.build(page: page)
                }
                .sheet(item: $coordinator.sheet) { sheet in
                    coordinator.build(page: sheet)
                }
        }
        .environmentObject(coordinator)
    }
    
}
