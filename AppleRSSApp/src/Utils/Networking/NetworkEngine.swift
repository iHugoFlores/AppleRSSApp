//
//  NetworkEngine.swift
//  AppleRSSApp
//
//  Created by Hugo Flores Perez on 6/11/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import Foundation

class NetworkEngine: NetworkInterface {
    private var cachedImages = NSCache<NSString, NSData>()

    func getData(request: URLRequest, cacheEnabled: Bool, completion: @escaping ((NetworkResponse<Data?, NetworkError>) -> Void)) {
        
        if cacheEnabled, let url = request.url, let cachedData = getCachedData(key: url.absoluteString) {
            completion(NetworkResponse(data: cachedData))
            return
        }

        URLSession.shared.dataTask(with: request) {[weak self] in
            completion(NetworkResponse(data: $0, response: $1, error: $2))
            if cacheEnabled, let url = request.url {
                guard let data = $0 else { return }
                self?.setCachedData(key: url.absoluteString, data: data)
            }
        }.resume()
    }
    
    func getCachedData(key: String) -> Data? {
        return cachedImages.object(forKey: key as NSString) as Data?
    }
    
    func setCachedData(key: String, data: Data) {
        cachedImages.setObject(data as NSData, forKey: key as NSString)
    }
}
