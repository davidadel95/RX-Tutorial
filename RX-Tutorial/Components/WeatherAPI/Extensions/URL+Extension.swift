//
//  URL+Extension.swift
//  RX-Tutorial
//
//  Created by David Adel on 08/04/2021.
//

import Foundation

extension URL {
    static func urlForWeatherAPI(city: String) -> URL? {
        return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=886705b4c1182eb1c69f28eb8c520e20")
    }
}
