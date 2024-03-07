//
//  RMCharacterInfo.swift
//  RickAndMortyUI
//
//  Created by Rafael Lucatto on 2/16/24.
//

import Foundation
import SwiftUI

enum RMCharacterInfo: String, CaseIterable {
    
    case id, name, created, status, type, location, gender, origin, species
    
    @ViewBuilder
    func makeView(for character: RMCharacter) -> some View {
        let info: String = switch self {
        case .id:
            character.id.description
        case .name:
            character.name
        case .created:
            character.created.fixDateFormat()
        case .status:
            character.status
        case .type:
            character.type.isEmpty ? "unknown" : character.type
        case .location:
            character.location.name
        case .gender:
            character.gender
        case .origin:
            character.origin.name
        case .species:
            character.species
        }
        HStack {
            Text(self.rawValue.capitalized + ":")
                .font(.system(size: 16))
                .frame(width: 100, alignment: .leading)
            Spacer()
            Text(info)
                .foregroundStyle(info == "unknown" ? Color(uiColor: UIColor(
                    red: 0.7,
                    green: 0.7,
                    blue: 0.7,
                    alpha: 1)
                ) : Color(uiColor: UIColor(
                    red: 0.25,
                    green: 0.25,
                    blue: 0.25,
                    alpha: 1))
                )
                .font(.system(size: 16))
                .bold()
                .multilineTextAlignment(.trailing)
        }
    }
}

