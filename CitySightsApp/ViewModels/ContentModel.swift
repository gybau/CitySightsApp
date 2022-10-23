//
//  ContentModel.swift
//  CitySightsApp
//
//  Created by Michał Ganiebny on 23/10/2022.
//

import Foundation
import CoreLocation

class ContentModel: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    var locationManager = CLLocationManager()
    
    override init() {
        
        // Init method of NSObject
        super.init()
        
        // Assign ContentModel as the location manager delegate
        locationManager.delegate = self
        
        // Request when in use authorization
        locationManager.requestWhenInUseAuthorization()
        
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if locationManager.authorizationStatus == .authorizedAlways ||
            locationManager.authorizationStatus == .authorizedWhenInUse {
            
            // We have permission
            // Start geolocating the user after receiving the authorization
            locationManager.startUpdatingLocation()
        } else if locationManager.authorizationStatus == .denied {
            
            // We don't have permission
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Gives us the location of the user
        print(locations.first ?? "no locations available")
        
        // TODO: Once we have the location, pass it into the YELP api
        
        // Stop requesting the location after we get it once
        locationManager.stopUpdatingLocation()
    }
}
