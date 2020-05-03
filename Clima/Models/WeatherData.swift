//
//  WeatherData.swift
//  Clima
//
//  Created by Moaz Elshebly on 08.04.20.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
}
