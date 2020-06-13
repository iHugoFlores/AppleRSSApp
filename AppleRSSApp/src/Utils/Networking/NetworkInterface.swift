//
//  NetworkInterface.swift
//  AppleRSSApp
//
//  Created by Hugo Flores Perez on 6/11/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import Foundation

protocol NetworkInterface {
    func getData(request: URLRequest, cacheEnabled: Bool, completion: @escaping ((NetworkResponse<Data?, NetworkError>) -> Void))
    func getCachedData(key: String) -> Data?
    func setCachedData(key: String, data: Data)
}
