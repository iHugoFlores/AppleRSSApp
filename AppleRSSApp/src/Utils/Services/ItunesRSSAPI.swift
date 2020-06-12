//
//  ItunesRSSAPI.swift
//  AppleRSSApp
//
//  Created by Hugo Flores Perez on 6/11/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import UIKit

final class ItunesRSSAPI {
    private static let apiEndpoint = "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/50/explicit.json"

    private static var cachedImages = NSCache<NSString, NSData>()

    static func getFeed(interface: NetworkInterface, handler: @escaping ((NetworkResponse<MainResponse>) -> Void)) {
        guard let url = URL(string: apiEndpoint) else { fatalError("Endpoint URL error") }
        let request = URLRequest(url: url)
        interface.getData(request: request, completion: handler)
    }
    
    static func getAlbumImage(interface: NetworkInterface, url: String, handler: @escaping ((NetworkResponse<Data>) -> Void)) {
        if let cachedData = cachedImages.object(forKey: url as NSString) {
            handler(NetworkResponse(data: cachedData as Data))
            return
        }
        guard let urlObj = URL(string: url) else { fatalError("Invalid image URL") }
        let request = URLRequest(url: urlObj)
        interface.getRawData(request: request) { (response) in
            handler(response)
            if let rawData = response.rawData {
                self.cachedImages.setObject(rawData as NSData, forKey: url as NSString)
            }
        }
    }
}
