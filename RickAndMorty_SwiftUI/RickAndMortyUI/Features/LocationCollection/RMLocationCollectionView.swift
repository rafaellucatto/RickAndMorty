//
//  RMLocationCollectionView.swift
//  RickAndMortyUI
//
//  Created by Rafael Lucatto on 2/18/24.
//

import SwiftUI

struct RMLocationCollectionView<ViewModel: RMLocationCollectionViewModelProtocol>: View {
    
    @StateObject var viewModel: ViewModel
    
    @EnvironmentObject var coordinator: RMLocationCoordinator
    
    init(viewModel: ViewModel = RMLocationCollectionViewModel()) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(0..<viewModel.locations.count, id: \.self) { num in
                    RMLocationCardView(location: viewModel.locations[num], color: $viewModel.cardColor)
                }
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            }
            .listStyle(.plain)
            .navigationTitle(viewModel.navBarTitle)
            .navigationBarTitleDisplayMode(.inline)
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
                            guard let viewModel: RMLocationCollectionViewModel = self.viewModel as? RMLocationCollectionViewModel else { return }
                            coordinator.present(.pageChoosing(viewModel))
                        } label: {
                            Label("Search", systemImage: "magnifyingglass")
                        }
                        Button {
                            coordinator.present(.help(RMHelpViewModel(chosenColor: $viewModel.cardColor)))
                        } label: {
                            Label("Help", systemImage: "questionmark.circle")
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
        }
        .onAppear {
            Task { await viewModel.getFirstLocations() }
        }
    }
}

#Preview {
    RMLocationCollectionView()
}

extension RMLocation {
    
    static func stub(id: Int = 3,
                     name: String = "location name",
                     type: String = "loc type",
                     dimension: String = "loc dimension",
                     residents: [String] = ["1", "2", "3"],
                     url: String = "url3",
                     created: String = "May 17, 2017") -> RMLocation {
        
        return RMLocation(id: id,
                          name: name,
                          type: type,
                          dimension: dimension,
                          residents: residents,
                          url: url,
                          created: created)
    }
    
}
