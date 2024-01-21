//
//  RMAlamofireManager.swift
//  RickNMorty
//
//  Created by Rafael Lucatto on 12/17/23.
//

import Alamofire
import Foundation

protocol RMAlamofireManagerProtocol {
    static var shared: Self? { get }
    
    func request<T: Decodable>(url: String, object: T.Type, completion: @escaping (Result<T, AFError>) -> Void)
    func requestData(url: String, completion: @escaping (Result<Data, AFError>) -> Void)
}

final class RMAlamofireManager: RMAlamofireManagerProtocol {
    
    private let afSession: Session
    
    private init() {
        self.afSession = Session(serverTrustManager: .init(evaluators: ["rickandmortyapi.com": PublicKeysTrustEvaluator()]))
    }
    
    static let shared: RMAlamofireManager? = ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil ? nil : RMAlamofireManager()
    
    func request<T: Decodable>(url: String, object: T.Type, completion: @escaping (Result<T, AFError>) -> Void) {
        afSession.request(url).responseDecodable(of: object) { response in
            print("AM | -----------------------------")
            print("AM | " + response.debugDescription.replacingOccurrences(of: "\n", with: "\nAM | "))
            if let error: AFError = response.error {
                completion(.failure(error))
            }
            guard let data: Data = response.data else {
                completion(.failure(.responseSerializationFailed(reason: .decodingFailed(error: RMRequestCustomError.emptyDataFromResponse))))
                return
            }
            guard let object: T = try? JSONDecoder().decode(T.self, from: data) else {
                guard let json: String = try? JSONSerialization.jsonObject(with: data) as? String else {
                    let strData: String = .init(decoding: data, as: UTF8.self)
                    completion(.failure(.responseSerializationFailed(reason: .decodingFailed(error: RMRequestCustomError.unableToReadJSON(data: strData)))))
                    return
                }
                completion(.failure(.responseSerializationFailed(reason: .decodingFailed(error: RMRequestCustomError.unableToDecodeObject(json: json)))))
                return
            }
            completion(.success(object))
        }
    }
    
    func requestData(url: String, completion: @escaping (Result<Data, AFError>) -> Void) {
        afSession.request(url).validate().responseData { response in
            print("AM | -----------------------------")
            print("AM | " + response.debugDescription.replacingOccurrences(of: "\n", with: "\nAM | "))
            if let error: AFError = response.error {
                completion(.failure(error))
                return
            }
            guard let data: Data = response.data else {
                completion(.failure(.responseSerializationFailed(reason: .decodingFailed(error: RMRequestCustomError.emptyDataFromResponse))))
                return
            }
            completion(.success(data))
        }
    }
    
}
