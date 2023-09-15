//
//  WeatherService.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/14/23.
//

import Foundation
import CoreLocation
import WeatherKit

protocol WeatherService {
    func getTemperature(location: CLLocation) async -> Weather?
}

struct WeatherManager: WeatherService {
    
    let service = WeatherKit.WeatherService.shared
    
    func getTemperature(location: CLLocation) async -> Weather? {
        var weather: Weather?
        
        do {
            weather = try await service.weather(for: location)

//            weather = try await service.weather(for: CLLocation(latitude: 45.707115, longitude: -122.656846))
        } catch {
            print("Could not get weather")
        }
        
        return weather
    }
}
