//
//  Feed.swift
//  AppleRSSApp
//
//  Created by Hugo Flores Perez on 6/11/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import Foundation

struct MainResponse: Decodable {
    let feed: Feed
}

struct Feed: Decodable {
    let title: String
    let icon: String
    let results: [Result]
}

struct Result: Decodable {
    let artistName, releaseDate, name: String
    let copyright: String
    let artistUrl: String
    let artworkUrl100: String
    let genres: [Genre]
    let url: String
}

struct Genre: Decodable {
    let genreId, name: String
    let url: String
}
