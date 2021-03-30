//
//  WeatherManager.swift
//  Clima
//
//  Created by Dmytro Yantsybaiev on 29.03.2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?APPID=e6e09209eb9da8ef2e5d41eb59d761ef&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let cityWeatherURL = "\(weatherURL)&q=\(cityName)"
        performRequest(with: cityWeatherURL)
    }
    
    func performRequest(with cityWeatherURL: String) {
        //1. Create a URL
        if let url = URL(string: cityWeatherURL) {
            
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            //3. Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                } else {
                    if let safeData = data {
                        if let weather = parseJSON(safeData) {
                            delegate?.didUpdateWeather(self, weather: weather)
                        }
                    }
                }
            }
            
            //4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            
            let weather = WeatherModel(conditionID: id, cityName: name, temperature: temp)
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
    
    
}
