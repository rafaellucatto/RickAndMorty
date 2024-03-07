//
//  Image+Extension.swift
//  RickAndMortyUI
//
//  Created by Rafael Lucatto on 2/21/24.
//

import Foundation
import SwiftUI

extension Image {
    
    static func createImage(from data: Data?) -> Image {
        guard let data: Data = data else { return Image(systemName: "gear")}
    #if canImport(UIKit)
        let songArtwork: UIImage = UIImage(data: data) ?? UIImage()
        return Image(uiImage: songArtwork)
    #elseif canImport(AppKit)
        let songArtwork: NSImage = NSImage(data: data) ?? NSImage()
        return Image(nsImage: songArtwork)
    #else
        return Image(systemImage: "gear")
    #endif
    }
    
    func getModifier() -> some View {
        self
            .resizable()
            .frame(width: (UIScreen.main.bounds.width / 3) - 12, height: (UIScreen.main.bounds.width / 3) - 12, alignment: .center)
            .background(Color.white)
            .clipShape(.rect(cornerRadius: 12))
            .shadow(color: .black, radius: 4)
    }
    
}
