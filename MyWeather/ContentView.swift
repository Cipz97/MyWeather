//
//  ContentView.swift
//  MyWeather
//
//  Created by Matteo Cipone on 15.10.21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color("WeatherColor")
                .ignoresSafeArea()
            VStack {
                SearchView()
                Spacer()
                WeatherView()
                Spacer()
                HStack {
                    WeatherViewBottom()
                    WeatherViewBottom()
                    WeatherViewBottom()
                }
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SearchView: View {
    var body: some View {
        HStack {
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Image(systemName: "paperplane.circle.fill")
                    .foregroundColor(.white)
                    .font(.system(size: 30))
            }
            TextField("Search", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/).textFieldStyle(.roundedBorder)
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.white)
                    .font(.system(size: 30))
            }
        }.padding()
    }
}

struct WeatherView: View {
    var body: some View {
        VStack() {
            Image(systemName: "cloud.fill")
                .font(.system(size: 120))
                .foregroundColor(.white)
            VStack {
                Text("19 C")
                Text("15.10.2021")
            }.font(.system(size: 30)).foregroundColor(.white)
            Text("Vienna")
                .font(.system(size: 35))
                .foregroundColor(.white)
        }.padding()
    }
}

struct WeatherViewBottom: View {
    var body: some View {
        VStack() {
            Image(systemName: "cloud.fill")
                .font(.system(size: 60))
                .foregroundColor(.white)
            VStack {
                Text("19 C")
                Text("15.10.2021")
            }.font(.system(size: 15)).foregroundColor(.white)
            Text("Vienna")
                .font(.system(size: 20))
                .foregroundColor(.white)
        }.padding(.horizontal)
    }
}
