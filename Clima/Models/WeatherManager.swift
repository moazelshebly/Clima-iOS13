//
//  WeatherManager.swift
//  Clima
//
//  Created by Moaz Elshebly on 08.04.20.
//

import UIKit

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}


struct WeatherManager {
    
    var weatherURL: String?
    var delegate: WeatherManagerDelegate?
    
    mutating func fetchWeather(_ city: String) {
        weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=7a9385b7affa1de5d9dff312df00e00f&units=metric&q=\(city)"
        performRequest(with: weatherURL!)
    }
    
    mutating func fetchWeather(lat: Double, lon: Double) {
        weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=7a9385b7affa1de5d9dff312df00e00f&units=metric&lat=\(lat)&lon=\(lon)"
        performRequest(with: weatherURL!)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJson(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJson(_ weatherData: Data) -> WeatherModel? {
        let decoder =  JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            
            return WeatherModel(cityName: decodedData.name, id: decodedData.weather[0].id, temperature: decodedData.main.temp)
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
