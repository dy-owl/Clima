//
//  WeatherData.swift
//  Clima
//
//  Created by Dmytro Yantsybaiev on 29.03.2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Float
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
