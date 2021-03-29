//
//  WeatherManager.swift
//  Clima
//
//  Created by Dmytro Yantsybaiev on 29.03.2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "http://api.openweathermap.org/data/2.5/weather?APPID=e6e09209eb9da8ef2e5d41eb59d761ef&units=metric"
    
    func fetchWeather(cityName: String) {
        let cityWeatherURL = "\(weatherURL)&q=\(cityName)"
        print(cityWeatherURL)
    }
}
