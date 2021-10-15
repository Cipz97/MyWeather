//
//  WeatherData.swift
//  MyWeather
//
//  Created by Matteo Cipone on 15.10.21.
//

import Foundation

struct WeatherData: Decodable {
    var name: String
    var weather: [Weather]
    var main: Main
    
}
struct Main: Decodable {
    var temp: Double
}

struct Weather: Decodable, Identifiable {
    var id: Int
    var description: String
    
}
