//
//  WeatherManager.swift
//  MyWeather
//
//  Created by Matteo Cipone on 15.10.21.
//

import Foundation
import SwiftUI
import CoreLocation

class WeatherManager: ObservableObject {
    
    @Published var weatherModel = WeatherModel(conditionId: 800, cityName: "Vienna", temperature: 0.0)
    
    
    func fetchCityName(with location: String) {
        let url = "https://api.openweathermap.org/data/2.5/weather?q=\(location)&units=metric&appid=\(K.apiKey)"
        performRequest(url)
    }
    func fetchCurrentLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&units=metric&appid=\(K.apiKey)"
        performRequest(url)
    }
    private func performRequest(_ url: String) {
        if let safeUrl = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: safeUrl) { data, response, error in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let decodedData = try decoder.decode(WeatherData.self, from: safeData)
                            DispatchQueue.main.async {
                                self.weatherModel.cityName = decodedData.name
                                self.weatherModel.conditionId = decodedData.weather[0].id
                                self.weatherModel.temperature = decodedData.main.temp
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
