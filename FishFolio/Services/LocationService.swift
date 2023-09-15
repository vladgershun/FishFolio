//
//  LocationService.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/13/23.
//

import Foundation
import CoreLocation
  
class LocationService: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    let manager = CLLocationManager()

    @Published var location: CLLocationCoordinate2D?
    @Published var geoLocationName: String?

    override init() {
        super.init()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        manager.delegate = self
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
    }

    func getLocationName(latitude: Double, longitude: Double) async throws -> String {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        
        let places = try await geoCoder.reverseGeocodeLocation(location)
        return places.map { $0.inlandWater ?? $0.name ?? $0.description }.first ?? ""
    }
}
