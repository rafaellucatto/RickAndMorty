//
//  RMRequestManager.swift
//  RickAndMortyUI
//
//  Created by Rafael Lucatto on 2/14/24.
//

import Alamofire
import Combine
import Foundation

enum RMEndpoint: String {
    case characterCollection = "https://rickandmortyapi.com/api/character?page="
    case episodeCollection = "https://rickandmortyapi.com/api/episode?page="
    case locationCollection = "https://rickandmortyapi.com/api/location?page="
}

protocol RMRequestManagerProtocol {
    static var shared: Self? { get }
    func isConnectedToTheInternet() -> Bool
    func request<T: Decodable>(with url: String, for object: T.Type) async -> T
    func requestData(with url: String) async -> Data
}

final class RMRequestManager: RMRequestManagerProtocol {
    
    private let afSession: Session
    private let networkReachabilityManager: NetworkReachabilityManager?
    
    private init() {
        self.networkReachabilityManager = NetworkReachabilityManager()
        self.afSession = Session(serverTrustManager: ServerTrustManager(allHostsMustBeEvaluated: false, evaluators: ["*.rickandmortyapi.com.cer": PinnedCertificatesTrustEvaluator()]))
    }
    
    static let shared: RMRequestManager? = RMDevice.isRunningTests() ? nil : RMRequestManager()
    
    func isConnectedToTheInternet() -> Bool {
        return networkReachabilityManager?.isReachable ?? false
    }
    
    func request<T: Decodable>(with url: String, for object: T.Type) async -> T {
        return await withCheckedContinuation { continuation in
            afSession.request(url).responseDecodable(of: object) { response in
                print("AM | ------------------------")
                print("AM | " + response.debugDescription.replacingOccurrences(of: "\n", with: "\nAM | "))
                if let object: T = response.value {
                    continuation.resume(returning: object)
                }
            }
        }
    }
    
    func requestData(with url: String) async -> Data {
        return await withCheckedContinuation { continuation in
            afSession.request(url).responseData { response in
                print("AM | ------------------------")
                print("AM | " + response.debugDescription.replacingOccurrences(of: "\n", with: "\nAM | "))
                if let imageData: Data = response.value {
                    continuation.resume(returning: imageData)
                }
            }
        }
    }
    
}
