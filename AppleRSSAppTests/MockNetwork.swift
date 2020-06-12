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
    var rawData: Data?
    var response: HTTPURLResponse?
    var error: NetworkError = .ok

    func getData<Model>(request: URLRequest, completion: @escaping ((NetworkResponse<Model>) -> Void)) where Model : Decodable {
        let ntwResponse = NetworkResponse<Model>(data: rawData, response: response, error: error)
        completion(ntwResponse)
    }
    
    func getRawData(request: URLRequest, completion: @escaping ((NetworkResponse<Data>) -> Void)) {
        let ntwResponse = NetworkResponse<Data>(data: rawData, response: response, error: error, raw: true)
        completion(ntwResponse)
    }
}
