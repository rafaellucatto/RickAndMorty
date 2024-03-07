//
//  ContentView.swift
//  RickAndMortyUI
//
//  Created by Rafael Lucatto on 2/14/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            RMCharacterCoordinatorView()
                .tabItem {
                    Label("Characters", systemImage: "person.3.sequence")
                }
            RMEpisodeCoordinatorView()
                .tabItem {
                    Label("Episodes", systemImage: "tv")
                }
            RMLocationCoordinatorView()
                .tabItem {
                    Label("Locations", systemImage: "globe.americas")
                }
        }
    }
}

#Preview {
    ContentView()
}
