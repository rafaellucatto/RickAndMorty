//
//  ProgressViewModifier.swift
//  RickAndMortyUI
//
//  Created by Rafael Lucatto on 3/2/24.
//

import Foundation
import SwiftUI

struct ProgressViewModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .frame(width: (UIScreen.main.bounds.width / 3) - 12,
                   height: (UIScreen.main.bounds.width / 3) - 12,
                   alignment: .center)
            .background(Color.white)
            .clipShape(.rect(cornerRadius: 12))
            .shadow(color: .black, radius: 4)
    }
    
}
