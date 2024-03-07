//
//  RMHelpView.swift
//  RickAndMortyUI
//
//  Created by Rafael Lucatto on 2/23/24.
//

import SwiftUI

struct RMHelpView<ViewModel: RMHelpViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        TabView {
            VStack(alignment: .center, spacing: 0) {
                Text("The location card fields are as follows:")
                    .padding()
                RMLocationCardView(location: .stub(id: 0, name: "name", type: "type", dimension: "dimension"), isHelpCard: true, color: $viewModel.chosenColor)
                Spacer()
            }
            VStack(alignment: .center, spacing: 0) {
                Spacer()
                Text("Choose location card color:")
                Spacer()
                LazyVGrid(columns: [GridItem(), GridItem()], alignment: .center, spacing: 10) {
                    ForEach(0..<viewModel.colors.count, id: \.self) { num in
                        Button {
                            viewModel.chosenColor = viewModel.colors[num]
                        } label: {
                            viewModel.colors[num]
                        }
                    }
                    .frame(width: 80, height: 40, alignment: .center)
                    .clipShape(.rect(cornerRadius: 16))
                    .shadow(color: .black, radius: 2, y: 2)
                }
                Spacer()
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .presentationDetents([.height(300)])
    }
    
}

//#Preview {
//    RMHelpView()
//}
