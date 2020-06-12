//
//  NetworkInterface.swift
//  AppleRSSApp
//
//  Created by Hugo Flores Perez on 6/11/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import Foundation

protocol NetworkInterface {
    func getData<Model>(request: URLRequest, completion: @escaping ((NetworkResponse<Model>) -> Void))
    func getRawData(request: URLRequest, completion: @escaping ((NetworkResponse<Data>) -> Void))
}
