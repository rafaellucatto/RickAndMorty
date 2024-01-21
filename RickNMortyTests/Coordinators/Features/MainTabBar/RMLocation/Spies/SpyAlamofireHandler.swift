//
//  SpyAlamofireHandler.swift
//  RickNMortyTests
//
//  Created by Rafael Lucatto on 1/14/24.
//

import Alamofire
import Foundation

@testable import RickNMorty

final class SpyAlamofireHandler: RMAlamofireManagerProtocol {
    
    static var shared: SpyAlamofireHandler? = nil
    
    var requestGotCalled: Bool = false
    var requestDataGotCalled: Bool = false
    
    func request<T: Decodable>(url: String, object: T.Type, completion: @escaping (Result<T, Alamofire.AFError>) -> Void) {
        requestGotCalled = true
    }
    
    func requestData(url: String, completion: @escaping (Result<Data, Alamofire.AFError>) -> Void) {
        requestDataGotCalled = true
    }
    
}
