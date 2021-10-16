//
//  ContentView.swift
//  MyWeather
//
//  Created by Matteo Cipone on 15.10.21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var locationManager = LocationManager()
    @ObservedObject var weatherManager = WeatherManager()
    var body: some View {
        ZStack {
            Color("WeatherColor")
                .ignoresSafeArea()
            VStack {
                SearchView(weatherManager: weatherManager)
                Spacer()
                WeatherView(condition: weatherManager.weatherModel.conditionName, temp: weatherManager.weatherModel.temperatureString, cityName: weatherManager.weatherModel.cityName)
                Spacer()
            }
        }.onAppear {
            locationManager.checkIfLocationServiceIsEnabled()
            weatherManager.fetchCurrentLocation(latitude: locationManager.latitude, longitude: locationManager.longitude)
            print(locationManager.latitude)
            print(locationManager.longitude)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SearchView: View {
    @ObservedObject var locationManager = LocationManager()
    var weatherManager: WeatherManager
    @State var location: String = ""
    var body: some View {
        HStack {
            Button(action: {
                weatherManager.fetchCurrentLocation(latitude: locationManager.latitude, longitude: locationManager.longitude)
            }) {
                Image(systemName: "paperplane.circle.fill")
                    .foregroundColor(.white)
                    .font(.system(size: 30))
            }
            TextField("Search", text: $location, onCommit: {
                weatherManager.fetchCityName(with: location)
            })
                .textFieldStyle(.roundedBorder)
                .keyboardType(.webSearch)
                
            Button(action: {
                weatherManager.fetchCityName(with: location)
            }) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.white)
                    .font(.system(size: 30))
            }
        }.padding()
    }
}

struct WeatherView: View {
    var condition: String
    var temp: String
    var cityName: String
    var body: some View {
        VStack() {
            Image(systemName: condition)
                .font(.system(size: 120))
                .foregroundColor(.white)
            VStack {
                Text("\(temp) °C")
            }.font(.system(size: 30)).foregroundColor(.white)
            Text(cityName)
                .font(.system(size: 35))
                .foregroundColor(.white)
        }.padding()
    }
}

