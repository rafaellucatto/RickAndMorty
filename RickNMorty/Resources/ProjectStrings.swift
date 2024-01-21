//
//  ProjectStrings.swift
//  RickNMorty
//
//  Created by Rafael Lucatto on 12/20/23.
//

import Foundation

enum K {
    enum Hero {
        static let characterCollectionCellId: String = "characterCollectionCellId"
    }
    enum Title {
        static let characters: String = String(localized: "characters")
        static let episodes: String = String(localized: "episodes")
        static let locations: String = String(localized: "locations")
    }
    enum CharDetail {
        static let episodes: String = String(localized: "charDetailEpisodes")
        static let genericInfo: String = String(localized: "charDetailGenericInfo")
        enum Info {
            static let id: String = String(localized: "charInfoId")
            static let name: String = String(localized: "charInfoName")
            static let created: String = String(localized: "charInfoCreated")
            static let gender: String = String(localized: "charInfoGender")
            static let location: String = String(localized: "charInfoLocation")
            static let origin: String = String(localized: "charInfoOrigin")
            static let species: String = String(localized: "charInfoSpecies")
            static let status: String = String(localized: "charInfoStatus")
            static let type: String = String(localized: "charInfoType")
        }
    }
    enum NavBar {
        static let nextPage: String = String(localized: "navNextPage")
        static let previousPage: String = String(localized: "navPreviousPage")
        static let choosePage: String = String(localized: "navChoosePage")
    }
}
