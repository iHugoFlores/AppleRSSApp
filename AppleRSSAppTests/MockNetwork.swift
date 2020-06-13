//
//  MockNetwork.swift
//  AppleRSSAppTests
//
//  Created by Hugo Flores Perez on 6/12/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import Foundation
@testable import AppleRSSApp

class MockNetwork: NetworkInterface {
    var data: Data?
    var error: NetworkError?

    func getData(request: URLRequest, cacheEnabled: Bool, completion: @escaping ((Result<Data?, NetworkError>) -> Void)) {
        if let data = data {
            completion(.success(data))
            return
        }
        if let error = error {
            completion(.failure(error))
            return
        }
        completion(.failure(.unexpected))
    }
    
    func getCachedData(key: String) -> Data? {
        return nil
    }
    
    func setCachedData(key: String, data: Data) {}
}
