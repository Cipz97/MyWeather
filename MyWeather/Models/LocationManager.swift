//
//  LocationManager.swift
//  MyWeather
//
//  Created by Matteo Cipone on 16.10.21.
//

import Foundation
import CoreLocation


class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager = CLLocationManager()
    @Published var latitude: CLLocationDegrees = 0.0
    @Published var longitude: CLLocationDegrees = 0.0
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func checkIfLocationServiceIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.requestLocation()
        }
    }
    private func checkLocationAuthorization() {

            switch locationManager.authorizationStatus {
                    
                case .notDetermined:
                    locationManager.requestWhenInUseAuthorization()
                case .restricted:
                    print("Your location is restricted")
                case .denied:
                    print("You have denied this app location permissions. Go into settings to change it")
                case .authorizedAlways, .authorizedWhenInUse:
                    if let lat = locationManager.location?.coordinate.latitude, let lon = locationManager.location?.coordinate.longitude {
                        latitude = lat
                        longitude = lon
                    }
                @unknown default:
                    print("unknown")
            }
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            latitude = location.coordinate.latitude
            longitude = location.coordinate.longitude
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Something went wrong: \(error.localizedDescription)")
    }
}
