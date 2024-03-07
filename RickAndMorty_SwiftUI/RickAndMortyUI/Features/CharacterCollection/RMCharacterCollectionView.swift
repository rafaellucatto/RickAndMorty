//
//  RMCharacterCollectionView.swift
//  RickAndMortyUI
//
//  Created by Rafael Lucatto on 2/14/24.
//

import SwiftUI

struct RMCharacterCollectionView<ViewModel: RMCharacterCollectionViewModelProtocol>: View {
    
    @StateObject var viewModel: ViewModel
    
    @EnvironmentObject private var coordinator: RMCharacterCoordinator
    
    init(viewModel: ViewModel = RMCharacterCollectionViewModel()) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    private let gridItem: [GridItem] = [GridItem(spacing: 0, alignment: .center),
                                        GridItem(spacing: 0, alignment: .center),
                                        GridItem(spacing: 0, alignment: .center)]
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ScrollView(.vertical) {
                    LazyVGrid(columns: gridItem, alignment: .center, spacing: 8) {
                        ForEach(0..<viewModel.characters.count, id: \.self) { num in
                            if let url: URL = URL(string: viewModel.characters[num].image) {
                                Button {
                                    coordinator.push(.character(RMCharacterViewModel(character: viewModel.characters[num], api: RMCharacterViewModelApi())))
                                } label: {
                                    RMAsyncImage(url: url)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 4)
                }
            }
            .navigationTitle(viewModel.navBarTitle)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                Task { await viewModel.getFirstCharacters() }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        switch viewModel.menu {
                        case .onlyNext:
                            Button {
                                Task { await viewModel.getNextCharacters() }
                            } label: {
                                Label("Next page", systemImage: "arrow.uturn.right.circle")
                            }
                        case .onlyPrevious:
                            Button {
                                Task { await viewModel.getPreviousCharacters() }
                            } label: {
                                Label("Previous page", systemImage: "arrow.uturn.left.circle")
                            }
                        case .previousAndNext:
                            Button {
                                Task { await viewModel.getPreviousCharacters() }
                            } label: {
                                Label("Previous page", systemImage: "arrow.uturn.left.circle")
                            }
                            Button {
                                Task { await viewModel.getNextCharacters() }
                            } label: {
                                Label("Next page", systemImage: "arrow.uturn.right.circle")
                            }
                        }
                        Button {
                            guard let viewModel: RMCharacterCollectionViewModel = viewModel as? RMCharacterCollectionViewModel else { return }
                            coordinator.sheet = .pageChoosing(viewModel)
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
}

#Preview {
    RMCharacterCollectionView()
}

struct RMAsyncImage: View {
    
    let url: URL
    
    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .success(let image):
                image.getModifier()
            case .failure:
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let image):
                        image.getModifier()
                    case .failure:
                        EmptyView()
                    default:
                        VStack(alignment: .center, spacing: 0) {
                            ProgressView()
                        }
                        .modifier(ProgressViewModifier())
                    }
                }
            default:
                VStack(alignment: .center, spacing: 0) {
                    ProgressView()
                }
                .modifier(ProgressViewModifier())
            }
        }
    }
    
}
