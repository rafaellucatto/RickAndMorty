//
//  RMCharacterView.swift
//  RickAndMortyUI
//
//  Created by Rafael Lucatto on 2/14/24.
//

import SwiftUI

struct RMCharacterView<ViewModel: RMCharacterViewModelProtocol>: View {
    
    private let coordinatorType: RMCoordinatorType
    
    @EnvironmentObject var characterCoordinator: RMCharacterCoordinator
    @EnvironmentObject var episodeCoordinator: RMEpisodeCoordinator
    @EnvironmentObject var locationCoordinator: RMLocationCoordinator
    
    @StateObject var viewModel: ViewModel
    
    init(coordinator: RMCoordinatorType, viewModel: ViewModel) {
        self.coordinatorType = coordinator
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        List {
            if let data: Data = viewModel.character.charImageData {
                Image.createImage(from: data)
                    .resizable()
                    .scaledToFit()
                    .clipShape(.rect(cornerRadius: 10))
                    .shadow(color: .black, radius: 4)
                    .listRowBackground(Color.clear)
            } else {
                AsyncImage(url: URL(string: viewModel.character.image)!) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(.rect(cornerRadius: 10))
                            .shadow(color: .black, radius: 4)
                            .listRowBackground(Color.clear)
                    case .failure:
                        AsyncImage(url: URL(string: viewModel.character.image)!) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(.rect(cornerRadius: 10))
                                    .shadow(color: .black, radius: 4)
                                    .listRowBackground(Color.clear)
                            default:
                                ProgressView()
                            }
                        }
                    default:
                        ProgressView()
                    }
                }.listRowBackground(Color.clear)
            }
            Section {
                ForEach(0..<RMCharacterInfo.allCases.count, id: \.self) { num in
                    RMCharacterInfo.allCases[num].makeView(for: viewModel.character)
                        .listRowBackground(num % 2 == 0 ? Color.white : Color(uiColor: UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)))
                        .listRowSeparator(.hidden)
                }
            } header: {
                Text("Info")
            }
            Button {
                guard let viewModel: RMCharacterViewModel = viewModel as? RMCharacterViewModel else { return }
                switch coordinatorType {
                case .character:
                    characterCoordinator.push(.characterEpisode(viewModel))
                case .episode:
                    episodeCoordinator.push(.episodeCharacterEpisodes(viewModel))
                case .location:
                    locationCoordinator.push(.locationCharacterEpisode(viewModel))
                }
            } label: {
                HStack(alignment: .center, spacing: 0) {
                    Text("Episodes")
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .foregroundStyle(.black)
            }
        }
        .navigationTitle(viewModel.character.name)
        .navigationBarTitleDisplayMode(.inline)
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
//    RMCharacterView()
//}
