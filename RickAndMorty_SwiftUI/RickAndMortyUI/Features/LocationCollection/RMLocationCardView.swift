//
//  RMLocationCardView.swift
//  RickAndMortyUI
//
//  Created by Rafael Lucatto on 2/18/24.
//

import SwiftUI

struct RMLocationCardView: View {
    
    let location: RMLocation
    let isHelpCard: Bool
    
    @EnvironmentObject var coordinator: RMLocationCoordinator
    
    @Binding var color: Color
    
    init(location: RMLocation, isHelpCard: Bool = false, color: Binding<Color>) {
        self.location = location
        self.isHelpCard = isHelpCard
        self._color = color
    }
    
    @State private var shouldPresentCharCollection: Bool = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            GeometryReader { geometry in
                VStack(alignment: .center, spacing: 0) {
                    VStack(alignment: .center, spacing: 0) {
                        VStack(alignment: .center, spacing: 0) {
                            Text(location.name)
                        }
                        .frame(width: geometry.size.width - 26, height: geometry.size.height / 5)
                        .background(Color.white)
                        .clipShape(.rect(cornerRadius: 18))
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height / 3)
                    GeometryReader { geometry2 in
                        HStack(alignment: .center, spacing: 0) {
                            VStack(alignment: .center, spacing: 0) {
                                VStack(alignment: .center, spacing: 0) {
                                    Text(isHelpCard ? "id" : location.id.description)
                                        .font(.system(size: 14))
                                        .multilineTextAlignment(.center)
                                }
                                .frame(width: (geometry2.size.width / 3) - 26, height: geometry.size.height / 3.5)
                                .background(Color.white)
                            }
                            .background(Color.white)
                            .clipShape(.rect(cornerRadius: 12))
                            .clipped()
                            .shadow(color: .black, radius: 0)
                            .padding(.horizontal)
                            .frame(width: geometry2.size.width/3, height: geometry.size.height)
                            VStack(alignment: .center, spacing: 0) {
                                VStack(alignment: .center, spacing: 0) {
                                    Text(location.dimension)
                                        .font(.system(size: location.dimension.count > 16 ? 14 : 16))
                                        .multilineTextAlignment(.center)
                                }
                                .frame(width: (geometry2.size.width / 3) - 26, height: geometry.size.height / 3.5)
                                .background(Color.white)
                            }
                            .background(Color.white)
                            .clipShape(.rect(cornerRadius: 12))
                            .clipped()
                            .shadow(color: .black, radius: 0)
                            .frame(width: geometry2.size.width/3, height: geometry.size.height)
                            VStack(alignment: .center, spacing: 0) {
                                VStack(alignment: .center, spacing: 0) {
                                    Text(location.type)
                                        .font(.system(size: location.type.count > 16 ? 14 : 16))
                                        .multilineTextAlignment(.center)
                                }
                                .frame(width: (geometry2.size.width / 3) - 26, height: geometry.size.height / 3.5)
                                .background(Color.white)
                            }
                            .background(Color.white)
                            .clipShape(.rect(cornerRadius: 12))
                            .clipped()
                            .shadow(color: .black, radius: 0)
                            .padding(.horizontal)
                            .frame(width: geometry2.size.width/3, height: geometry.size.height)
                        }
                        .frame(height: geometry2.size.height)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height / 3)
                    if location.residents.isEmpty {
                        HStack(alignment: .center, spacing: 0) {
                            Text(isHelpCard ? "location resident count" : "Residents: 0")
                            Spacer()
                            Image(systemName: "chevron.right").opacity(0)
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal)
                        .background(Color(uiColor: UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)))
                        .clipShape(.rect(cornerRadius: 12))
                        .clipped()
                        .padding(.horizontal)
                        .shadow(color: .black, radius: 1, x: 0, y: 2)
                        .frame(width: geometry.size.width, height: geometry.size.height / 3)
                    } else {
                        HStack(alignment: .center, spacing: 0) {
                            Text(isHelpCard ? "location resident count" : "Residents: " + location.residents.count.description)
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal)
                        .background(Color.white)
                        .clipShape(.rect(cornerRadius: 12))
                        .clipped()
                        .padding(.horizontal)
                        .shadow(color: .black, radius: 2, x: 0, y: 2)
                        .frame(width: geometry.size.width, height: geometry.size.height / 3)
                        .onTapGesture {
                            coordinator.push(.locationCharacterCollection(RMLocationResidentCollectionViewModel(urls: location.residents, location: location.name)))
                        }
                    }
                }
            }
        }
        .frame(height: 180)
        .background(LinearGradient(colors: [Color(uiColor: UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)), self.color],
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing))
        .clipShape(.rect(cornerRadius: 12))
        .clipped()
        .shadow(color: .black, radius: 2, x: 0, y: 2)
        .padding(.horizontal)
    }
}

//#Preview {
//    RMLocationCardView(location: .stub())
//}
