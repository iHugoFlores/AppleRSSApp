//
//  NetworkResponse.swift
//  AppleRSSApp
//
//  Created by Hugo Flores Perez on 6/11/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import UIKit

public enum NetworkError: Error {
    case unexpectedError(Error)
    case jsonParsingError(Error)
    case serverError
    case unhandled
    case noResponseObject
    case ok
}

class NetworkResponse<Model> where Model: Decodable {
    var data: Model?
    var rawData: Data?
    var response: HTTPURLResponse?
    var error: NetworkError = .ok

    init(data: Data?, response: URLResponse?, error: Error?, raw: Bool = false) {
        if let error = error {
            self.error = .unexpectedError(error)
            return
        }
        guard let response = response as? HTTPURLResponse else {
            self.error = .noResponseObject
            return
        }
        self.response = response
        switch response.statusCode {
        case 200..<300: break
        case 300..<600: self.error = .serverError
        default: self.error = .unhandled
        }
        guard let data = data else { return }
        if !raw {
            self.rawData = data
            return
        }
        do {
            self.data = try JSONDecoder().decode(Model.self, from: data)
        } catch let error {
            self.error = .jsonParsingError(error)
        }
    }
}
