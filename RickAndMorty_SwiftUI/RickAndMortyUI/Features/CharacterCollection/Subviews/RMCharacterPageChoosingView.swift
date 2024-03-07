//
//  RMCharacterPageChoosingView.swift
//  RickAndMortyUI
//
//  Created by Rafael Lucatto on 2/22/24.
//

import SwiftUI

struct RMCharacterPageChoosingView<ViewModel: RMCharacterCollectionViewModelProtocol>: View {
    
    @State var chosenPage: Int = 1
    
    @EnvironmentObject var coordinator: RMCharacterCoordinator
    
    let pageLimit: Int
    let buttonColor: Color = .blue
    
    @ObservedObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
        self.pageLimit = viewModel.lastPage
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            VStack(alignment: .center, spacing: 0) {
                HStack(alignment: .center, spacing: 0) {
                    Spacer()
                    Text("Page number")
                        .frame(width: 110, height: 50)
                    Spacer()
                    Picker("Chosen Page", selection: $chosenPage) {
                        ForEach(1...pageLimit, id: \.self) { num in
                            Text(num.description)
                        }
                    }
                    .frame(width: 110, height: 50)
                    Spacer()
                }
                .frame(width: UIScreen.main.bounds.width / 1.2)
                Divider()
                    .padding(.horizontal)
                HStack(alignment: .center, spacing: 0) {
                    Spacer()
                    Button {
                        coordinator.sheet = nil
                    } label: {
                        Text("Dismiss")
                            .foregroundStyle(buttonColor)
                    }
                    .frame(width: 90, height: 40)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8).stroke(buttonColor, lineWidth: 1)
                    }
                    .frame(width: 110, height: 60)
                    Spacer()
                    Button {
                        Task { await viewModel.getCustomPage(with: chosenPage) }
                        coordinator.sheet = nil
                    } label: {
                        Text("Choose")
                            .foregroundStyle(Color.white)
                    }
                    .frame(width: 90, height: 40)
                    .background(buttonColor)
                    .clipShape(.rect(cornerRadius: 8))
                    .frame(width: 110, height: 60)
                    Spacer()
                }
                .frame(width: UIScreen.main.bounds.width / 1.2, height: 60)
            }
            .frame(width: UIScreen.main.bounds.width / 1.2)
            .background(Color.white)
            .clipShape(.rect(cornerRadius: 10))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(uiColor: UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)))
        .presentationDetents([.height(150)])
    }
}

//#Preview {
//    RMCharacterPageChoosingView(pageLimit: 47)
//}
