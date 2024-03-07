//
//  RMHelpViewModel.swift
//  RickAndMortyUI
//
//  Created by Rafael Lucatto on 2/28/24.
//

import Foundation
import SwiftUI

protocol RMHelpViewModelProtocol: ObservableObject {
    var colors: [Color] { get }
    var chosenColor: Color { get set }
}

final class RMHelpViewModel: RMHelpViewModelProtocol {
    
    let colors: [Color] = [Color(uiColor: UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)), .black, .blue, .red, .orange, .green]
    
    @Binding var chosenColor: Color
    
    init(chosenColor: Binding<Color>) {
        self._chosenColor = chosenColor
    }
    
}
