//
//  NetworkResponse.swift
//  AppleRSSApp
//
//  Created by Hugo Flores Perez on 6/11/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import UIKit

public enum NetworkError: Error {
    case requestError(Error)
    case noResponseError
    case serverError(HTTPURLResponse)
    case noDataForParsing
    case jsonParsingError(Error)
    case unexpected
}

typealias NetworkResponse = Result

extension NetworkResponse where Failure == NetworkError, Success == Data? {
    init(data: Data?, response: URLResponse?, error: Error?) {
        if let error = error {
            self = .failure(.requestError(error))
            return
        }
        guard let response = response as? HTTPURLResponse else {
            self = .failure(.noResponseError)
            return
        }
        if !(200..<300 ~= response.statusCode) {
            self = .failure(.serverError(response))
            return
        }
        self = .success(data)
    }
    
    init(data: Data?) {
        self = .success(data)
    }
}
