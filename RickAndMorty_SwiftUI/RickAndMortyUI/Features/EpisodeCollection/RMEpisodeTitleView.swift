//
//  RMEpisodeTitleView.swift
//  RickAndMortyUI
//
//  Created by Rafael Lucatto on 2/16/24.
//

import SwiftUI

struct RMEpisodeTitleView: View {
    
    let title: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Spacer()
            Text(title)
                .font(.system(size: 16))
                .ignoresSafeArea()
                .frame(maxWidth: .infinity, minHeight: 30)
                .foregroundStyle(Color.black)
                .background(Color.white)
                .clipShape(.rect(cornerRadius: 8))
                .multilineTextAlignment(.center)
            Spacer()
        }
        .padding(.vertical, 10)
    }
}

#Preview {
    RMEpisodeTitleView(title: "teste")
}
