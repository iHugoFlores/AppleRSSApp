//
//  DateUtil.swift
//  AppleRSSApp
//
//  Created by Hugo Flores Perez on 6/11/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import UIKit

class DateUtil: NSObject {
    private static let mediumDateNoTimeFormatter: DateFormatter = {
        let formater = DateFormatter()
        formater.dateStyle = .medium
        formater.timeStyle = .none
        return formater
    }()

    private static let apiStringFormatter: DateFormatter = {
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd"
        return formater
    }()
    
    static func apiDateToMediumDate(_ apiDate: String) -> String {
        guard let date = apiStringFormatter.date(from: apiDate) else { return "" }
        return mediumDateNoTimeFormatter.string(from: date)
    }
}
