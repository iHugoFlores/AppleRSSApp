//
//  JSONUtil.swift
//  AppleRSSAppTests
//
//  Created by Hugo Flores Perez on 6/12/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import Foundation

enum JSONUtilError: Error {
    case resourceNotFound
    case dataParsing(Error)
    case jsonParsing(Error)
}

enum JSONUtil {
    static func load(forBunle bundle: Bundle, resourceName: String) -> Result<Data, JSONUtilError> {
        let fileUrl = bundle.url(forResource: resourceName, withExtension: "json")
        guard let url = fileUrl else {
            return .failure(.resourceNotFound)
        }
        do {
            let data = try Data(contentsOf: url)
            return .success(data)
        } catch let error {
            return .failure(.dataParsing(error))
        }
    }
    
    static func loadJSON<T>(forBunle bundle: Bundle, resourceName: String) -> Result<T, JSONUtilError> where T: Decodable {
        let resultData = load(forBunle: bundle, resourceName: resourceName)
        switch resultData {
        case .success(let data):
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                return .success(decoded)
            } catch let error {
                return .failure(.jsonParsing(error))
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}
