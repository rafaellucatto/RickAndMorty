//
//  RMCharacterEpisodeCollectionView.swift
//  RickAndMortyUI
//
//  Created by Rafael Lucatto on 2/29/24.
//

import SwiftUI

struct RMCharacterEpisodeCollectionView<ViewModel: RMCharacterViewModelProtocol>: View {
    
    let coordinatorType: RMCoordinatorType
    
    @EnvironmentObject var characterCoordinator: RMCharacterCoordinator
    @EnvironmentObject var episodeCoordinator: RMEpisodeCoordinator
    @EnvironmentObject var locationCoordinator: RMLocationCoordinator
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        List {
            ForEach(0..<viewModel.episodes.count, id: \.self) { num in
                let parts: [String] = viewModel.episodes[num].components(separatedBy: " - ")
                HStack(alignment: .center, spacing: 0) {
                    Text(parts[0] + ":")
                        .font(.system(size: 16))
                        .frame(minWidth: 100, alignment: .leading)
                    Spacer()
                    Text(parts[1])
                        .font(.system(size: 16))
                        .bold()
                        .multilineTextAlignment(.trailing)
                }
                .listRowBackground(num % 2 == 0 ? Color.white : Color(uiColor: UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)))
                .listRowSeparator(.hidden)
            }
        }
        .navigationTitle("Episodes")
        .onAppear { Task { await viewModel.getEpisodes() }}
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    switch coordinatorType {
                    case .character:
                        characterCoordinator.pop()
                    case .episode:
                        episodeCoordinator.pop()
                    case .location:
                        locationCoordinator.pop()
                    }
                } label: {
                    HStack(alignment: .center, spacing: 4) {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                }
            }
        }
    }
}

//#Preview {
//    RMCharacterEpisodeCollectionView()
//}
