//
//  RMLocationResidentCollectionView.swift
//  RickAndMortyUI
//
//  Created by Rafael Lucatto on 2/19/24.
//

import SwiftUI

struct RMLocationResidentCollectionView<ViewModel: RMLocationResidentCollectionViewModelProtocol>: View {
    
    @StateObject var viewModel: ViewModel
    
    @EnvironmentObject var coordinator: RMLocationCoordinator
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            if viewModel.characters.isEmpty {
                RMLocationCharacterCollectionLoadingView(viewModel: viewModel)
            } else {
                ScrollView(.vertical) {
                    LazyVGrid(columns: [GridItem(spacing: 4), GridItem(spacing: 4), GridItem(spacing: 0)],
                              alignment: .center,
                              spacing: 8) {
                        ForEach(0..<viewModel.characters.count, id: \.self) { num in
                            if viewModel.characters[num].charImageData != nil {
                                Button {
                                    coordinator.push(.locationCharacter(RMCharacterViewModel(character: viewModel.characters[num])))
                                } label: {
                                    Image.createImage(from: viewModel.characters[num].charImageData)
                                        .resizable()
                                        .frame(width: (UIScreen.main.bounds.width / 3) - 12, height: (UIScreen.main.bounds.width / 3) - 12, alignment: .center)
                                        .background(Color.white)
                                        .clipShape(.rect(cornerRadius: 12))
                                        .shadow(color: .black, radius: 4)
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 6)
                }
            }
        }
        .navigationTitle(viewModel.location)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { Task { await viewModel.getCharacters() }}
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    coordinator.pop()
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
//    RMLocationResidentCollectionView()
//}
