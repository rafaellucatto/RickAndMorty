//
//  MockRMRequestManager.swift
//  RickAndMortyTests
//
//  Created by Rafael Lucatto on 7/2/23.
//

import Foundation
import XCTest

@testable import RickAndMorty

final class MockRMRequestManager: RMRequestManagerProtocol {

    var requestType: RequestType!

    var shouldReturnSuccess: Bool = true

    init() {}

    enum RequestType: String {
        case character = "CharacterCollectionModel"
        case episode = "EpisodeCollectionModel"
        case location = "LocationCollectionModel"
        case singleCharacter = "SingleCharacterModel"
        case singleEpisode = "SingleEpisodeModel"
    }

    func request(url: String,
                 httpMethod: RickAndMorty.RMHTTPMethod,
                 completionHandler: @escaping (Result<Data, RickAndMorty.RMRequestCustomError>) -> Void) {
        if shouldReturnSuccess {
            completionHandler(.success(Data("nothing here".utf8)))
            return
        }
        completionHandler(.failure(.emptyDataFromResponse))
    }

    func request<T>(url: String,
                    httpMethod: RickAndMorty.RMHTTPMethod,
                    object: T.Type,
                    completionHandler: @escaping (Result<T, RickAndMorty.RMRequestCustomError>) -> Void) where T: Decodable {
        if shouldReturnSuccess {
            do {
                switch T.self {
                case is RMEpisodeMainResponse.Type:
                    self.requestType = .episode
                case is RMCharacterResultsJson.Type:
                    self.requestType = .singleCharacter
                case is RMLocationEndpointJson.Type:
                    self.requestType = .location
                default:
                    self.requestType = .character
                }
                if let file: URL = Bundle(for: type(of: self)).url(forResource: self.requestType.rawValue, withExtension: "json") {
                    if let data: Data = try? Data(contentsOf: file) {
                        try completionHandler(.success(T(data: data)))
                        return
                    }
                    XCTFail("Unable to decode data.")
                }
                XCTFail("Unable to find file.")
            } catch {
                XCTFail("Unable to initialize object with Decodable extension. Error: \(error.localizedDescription)")
            }
        }
        completionHandler(.failure(.emptyDataFromResponse))
    }
}

extension Decodable {
    public init(data: Data, using decoder: JSONDecoder = JSONDecoder()) throws {
        self = try decoder.decode(Self.self, from: data)
    }
}
