//
//  WeatherModel.swift
//  Clima
//
//  Created by Moaz Elshebly on 08.04.20.
//

import Foundation

struct WeatherModel {
    let cityName: String
    let id: Int
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch id {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "snow"
        case 800:
            return "sun.max"
        default:
            return "cloud"
        }
    }
}
