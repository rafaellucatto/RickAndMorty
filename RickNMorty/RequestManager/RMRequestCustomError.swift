//
//  RMRequestCustomError.swift
//  RickNMorty
//
//  Created by Rafael Lucatto on 11/28/23.
//

import Foundation

enum RMRequestCustomError: Error {

    case badURL(url: String)
    case errorFromResponse(error: Error)
    case unableToDecodeObject(json: String)
    case unableToReadJSON(data: String)
    case emptyDataFromResponse

    var localizedDescription: String {
        switch self {
        case .badURL(let url):
            return "Unable to build URL from string: \(url)."
        case .errorFromResponse(let error):
            return "An error has occurred: \(error.localizedDescription)."
        case .unableToDecodeObject:
            return "Unable to decode object from json."
        case .unableToReadJSON:
            return "Unable to read JSON from request. It might be broken."
        case .emptyDataFromResponse:
            return "Unable to retrieve data from response."
        }
    }
    
}
