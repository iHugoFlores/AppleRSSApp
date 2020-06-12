//
//  Feed.swift
//  AppleRSSApp
//
//  Created by Hugo Flores Perez on 6/11/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import Foundation

struct MainResponse: Codable {
    let feed: Feed
}

struct Feed: Codable {
    let title: String
    let icon: String
    let results: [Album]
}

struct Album: Codable {
    let artistName, releaseDate, name: String
    let copyright: String
    let artistUrl: String
    let artworkUrl100: String
    let genres: [Genre]
    let url: String
}

struct Genre: Codable {
    let genreId, name: String
    let url: String
}
