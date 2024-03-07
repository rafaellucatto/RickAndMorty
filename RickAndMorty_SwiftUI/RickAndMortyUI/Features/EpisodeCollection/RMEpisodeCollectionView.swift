//
//  RMEpisodeCollectionView.swift
//  RickAndMortyUI
//
//  Created by Rafael Lucatto on 2/16/24.
//

import SwiftUI

struct RMEpisodeCollectionView<ViewModel: RMEpisodeCollectionViewModelProtocol>: View {
    
    @StateObject private var viewModel: ViewModel
    
    @State var shouldPresentEpisodeChoosingView: Bool = false
    
    @EnvironmentObject var coordinator: RMEpisodeCoordinator
    
    init(viewModel: ViewModel = RMEpisodeCollectionViewModel()) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            if viewModel.episodeCollection.isEmpty {
                RMEpisodeLoadingView(viewModel: self.viewModel)
            } else {
                VStack(alignment: .center, spacing: 0) {
                    ScrollView(.vertical) {
                        ForEach(0..<viewModel.episodeCollection.count, id: \.self) { num in
                            VStack(alignment: .center, spacing: 0) {
                                RMEpisodeTitleView(title: viewModel.episodeCollection[num].episode + " - " + viewModel.episodeCollection[num].name)
                                    .frame(maxWidth: .infinity)
                                ScrollView(.horizontal) {
                                    VStack(alignment: .center, spacing: 0) {
                                        LazyHGrid(rows: [GridItem(spacing: 6, alignment: .center), GridItem(spacing: 0, alignment: .center)],alignment: .center, spacing: 6) {
                                            ForEach(0..<viewModel.episodeCollection[num].listOfCharacters.count, id: \.self) { num2 in
                                                if let data: Data = viewModel.episodeCollection[num].listOfCharacters[num2].charImageData {
                                                    Button {
                                                        coordinator.push(.episodeCharacter(RMCharacterViewModel(character: viewModel.episodeCollection[num].listOfCharacters[num2])))
                                                    } label: {
                                                        Image.createImage(from: data).getModifier()
                                                    }
                                                }
                                            }
                                        }
                                        .scrollTargetLayout()
                                    }
                                    .padding(6)
                                }
                                .scrollTargetBehavior(.viewAligned(limitBehavior: .never))
                                .padding(.bottom, 10)
                            }
                            .background(Color(uiColor: UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1)))
                            .clipped()
                            .shadow(color: .black, radius: 4)
                        }
                    }
                }
                .navigationTitle(viewModel.navBarTitle)
                .navigationBarTitleDisplayMode(.inline)
                .background(Color(uiColor: UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)))
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Menu {
                            switch viewModel.menu {
                            case .onlyNext:
                                Button {
                                    Task { await viewModel.didTapNextPage() }
                                } label: {
                                    Label("Next page", systemImage: "arrow.uturn.right.circle")
                                }
                            case .onlyPrevious:
                                Button {
                                    Task { await viewModel.didTapPreviousPage() }
                                } label: {
                                    Label("Previous page", systemImage: "arrow.uturn.left.circle")
                                }
                            case .previousAndNext:
                                Button {
                                    Task { await viewModel.didTapPreviousPage() }
                                } label: {
                                    Label("Previous page", systemImage: "arrow.uturn.left.circle")
                                }
                                Button {
                                    Task { await viewModel.didTapNextPage() }
                                } label: {
                                    Label("Next page", systemImage: "arrow.uturn.right.circle")
                                }
                            }
                            Button {
                                guard let viewModel: RMEpisodeCollectionViewModel = self.viewModel as? RMEpisodeCollectionViewModel else { return }
                                coordinator.present(.pageChoosing(viewModel))
                            } label: {
                                Label("Search", systemImage: "magnifyingglass")
                            }
                        } label: {
                            Image(systemName: "slider.horizontal.3")
                        }
                    }
                }
            }
        }
        .onAppear {
            Task { await viewModel.getEpisodes() }
        }
    }
}

//#Preview {
//    RMEpisodeCollectionView()
//}
