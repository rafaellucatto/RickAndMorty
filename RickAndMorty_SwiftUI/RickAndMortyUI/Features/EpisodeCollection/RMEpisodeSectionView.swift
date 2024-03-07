//
//  RMEpisodeSectionView.swift
//  RickAndMortyUI
//
//  Created by Rafael Lucatto on 2/16/24.
//

import SwiftUI

struct RMEpisodeSectionView<ViewModel: RMEpisodeCollectionViewModelProtocol>: View {
    
    @StateObject var viewModel: ViewModel
    
    @State var num: Int
    
    @EnvironmentObject var coordinator: RMEpisodeCoordinator
    
    var body: some View {
        ScrollView(.horizontal) {
            VStack(alignment: .center, spacing: 0) {
                LazyHGrid(rows: [GridItem(spacing: 6, alignment: .center), GridItem(spacing: 0, alignment: .center)],alignment: .center, spacing: 6) {
                    ForEach(0..<viewModel.episodeCollection[num].listOfCharacters.count, id: \.self) { num2 in
                        if let data: Data = viewModel.episodeCollection[num].listOfCharacters[num2].charImageData {
                            Button {
                                coordinator.push(.episodeCharacter(RMCharacterViewModel(character: viewModel.episodeCollection[num].listOfCharacters[num2])))
                            } label: {
                                Image.createImage(from: data)
                                    .resizable()
                                    .frame(width: (UIScreen.main.bounds.width / 3) - 12, height: (UIScreen.main.bounds.width / 3) - 12, alignment: .center)
                                    .background(Color.white)
                                    .clipShape(.rect(cornerRadius: 12))
                                    .clipped()
                                    .shadow(color: .black, radius: 2.8)
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
}

//#Preview {
//    RMEpisodeSectionView()
//}
