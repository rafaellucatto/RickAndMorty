//
//  RMRequestManager.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 6/30/23.
//

import Foundation

enum RMHTTPMethod: String {
    case get, post
}

enum RMRequestCustomError: Error {

    case badURL(url: String)
    case errorFromResponse(error: Error)
    case unableToDecodeObject(json: String)
    case unableToReadJSON
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

protocol RMRequestManagerProtocol {
    func request(url: String, httpMethod: RMHTTPMethod, completionHandler: @escaping (Result<Data, RMRequestCustomError>) -> Void)
    func request<T: Decodable>(url: String, httpMethod: RMHTTPMethod, object: T.Type, completionHandler: @escaping (Result<T, RMRequestCustomError>) -> Void)
}

final class RMRequestManager: RMRequestManagerProtocol {

    private init() {}

    static let shared: RMRequestManager = RMRequestManager()

    func request(url: String,
                 httpMethod: RMHTTPMethod = .get,
                 completionHandler: @escaping (Result<Data, RMRequestCustomError>) -> Void) {
        guard let url: URL = URL(string: url) else {
            completionHandler(.failure(RMRequestCustomError.badURL(url: url)))
            print(RMRequestCustomError.badURL(url: url).localizedDescription)
            return
        }
        var urlRequest: URLRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        URLSession.shared.dataTask(with: urlRequest) { data, urlResponse, error in
            if let error: Error = error {
                completionHandler(.failure(RMRequestCustomError.errorFromResponse(error: error)))
                return
            }
            guard let data: Data = data else  {
                completionHandler(.failure(RMRequestCustomError.emptyDataFromResponse))
                return
            }
            completionHandler(.success(data))
        }.resume()
    }

    func request<T: Decodable>(url: String,
                               httpMethod: RMHTTPMethod = .get,
                               object: T.Type,
                               completionHandler: @escaping (Result<T, RMRequestCustomError>) -> Void) {
        guard let url: URL = URL(string: url) else {
            completionHandler(.failure(RMRequestCustomError.badURL(url: url)))
            print(RMRequestCustomError.badURL(url: url).localizedDescription)
            return
        }
        var urlRequest: URLRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        URLSession.shared.dataTask(with: urlRequest) { data, urlResponse, error in
            if let error: Error = error {
                completionHandler(.failure(RMRequestCustomError.errorFromResponse(error: error)))
                return
            }
            guard let data: Data = data else  {
                completionHandler(.failure(RMRequestCustomError.emptyDataFromResponse))
                return
            }
            guard let object: T = try? JSONDecoder().decode(T.self, from: data) else {
                guard let json: String = try? JSONSerialization.jsonObject(with: data) as? String else {
                    completionHandler(.failure(RMRequestCustomError.unableToReadJSON))
                    return
                }
                completionHandler(.failure(RMRequestCustomError.unableToDecodeObject(json: json)))
                return
            }
            completionHandler(.success(object))
        }.resume()
    }
}
