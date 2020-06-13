//
//  ItunesRSSAPI.swift
//  AppleRSSApp
//
//  Created by Hugo Flores Perez on 6/11/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import Foundation

enum ItunesRSSAPI {
    private static let apiEndpoint = "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/100/explicit.json"
    private static let urlRequest: URLRequest = {
        guard let url = URL(string: apiEndpoint) else { fatalError("Endpoint URL error") }
        return URLRequest(url: url)
    }()

    static func getFeed(interface: NetworkInterface, handler: @escaping ((NetworkResponse<MainResponse, NetworkError>) -> Void)) {
        interface.getData(request: urlRequest, cacheEnabled: false) { (result) in
            switch result {
            case .success(let data):
                do {
                    guard let data = data else { handler(.failure(.noDataForParsing)); return }
                    let decodedModel = try JSONDecoder().decode(MainResponse.self, from: data)
                    handler(.success(decodedModel))
                } catch let error {
                    handler(.failure(.jsonParsingError(error)))
                }
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
    
    static func getAlbumImage(interface: NetworkInterface, url: String, handler: @escaping ((NetworkResponse<Data?, NetworkError>) -> Void)) {
        guard let urlObj = URL(string: url) else { fatalError("Invalid image URL") }
        let request = URLRequest(url: urlObj)
        interface.getData(request: request, cacheEnabled: true, completion: handler)
    }
}
