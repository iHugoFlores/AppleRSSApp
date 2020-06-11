//
//  NetworkEngine.swift
//  AppleRSSApp
//
//  Created by Hugo Flores Perez on 6/11/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import Foundation

class NetworkEngine: NetworkInterface {
    func getData<Model>(request: URLRequest, completion: @escaping ((NetworkResponse<Model>) -> Void)) where Model : Decodable {
        URLSession.shared.dataTask(with: request) {
            completion(NetworkResponse(data: $0, response: $1, error: $2))
        }.resume()
    }
}
